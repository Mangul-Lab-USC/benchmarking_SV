#!/bin/bash

export SV_DIR=/u/home/m/mdistler/project-jflint/genomestrip/svtoolkit
SV_TMPDIR=/u/home/m/mdistler/project-jflint/genomestrip/svtoolkit/more_sub/sub0.8_10/tmpdir

inputType=bam
if [ ! -z "$1" ]; then
    inputType="$1"
fi
. /u/local/Modules/default/init/modules.sh && module load R && module load samtools && module load java/1.8.0_77
input=$1
filename=$(basename $input)
runDir=/u/home/m/mdistler/project-jflint/genomestrip/svtoolkit/more_sub/sub0.4_10
genotypes=${filename}.genotypes.vcf
sites=${filename}.discovery.vcf

# These executables must be on your path.
which java > /dev/null || exit 1
which Rscript > /dev/null || exit 1
which samtools > /dev/null || exit 1

# For SVAltAlign, you must use the version of bwa compatible with Genome STRiP.
export PATH=${SV_DIR}/bwa:${PATH}
export LD_LIBRARY_PATH=${SV_DIR}/bwa:${LD_LIBRARY_PATH}

mx="-Xmx4g"
classpath="${SV_DIR}/lib/SVToolkit.jar:${SV_DIR}/lib/gatk/GenomeAnalysisTK.jar:${SV_DIR}/lib/gatk/Queue.jar"

mkdir -p ${runDir}/logs || exit 1
mkdir -p ${runDir}/metadata || exit 1

# Display version information.
java -cp ${classpath} ${mx} -jar ${SV_DIR}/lib/SVToolkit.jar

# Run preprocessing.
# For large scale use, you should use -reduceInsertSizeDistributions, but this is too slow for the installation test.
# The method employed by -computeGCProfiles requires a GC mask and is currently only supported for human genomes.
java -cp ${classpath} ${mx} \
    org.broadinstitute.gatk.queue.QCommandLine \
    -S ${SV_DIR}/qscript/SVPreprocess.q \
    -S ${SV_DIR}/qscript/SVQScript.q \
    -gatk ${SV_DIR}/lib/gatk/GenomeAnalysisTK.jar \
    --disableJobReport \
    -cp ${classpath} \
    -configFile ${SV_DIR}/conf/genstrip_parameters.txt \
    -tempDir ${SV_TMPDIR} \
    -R ~/project-zarlab/mouseBAM/chr19_new.fa \
    -runDirectory ${runDir} \
    -md ${runDir}/metadata \
    -ploidyMapFile ~/project-jflint/mouseBAM/chr19.ploidymap.txt \
    -reduceInsertSizeDistributions true \
    -computeGCProfiles false \
    -computeReadCounts true \
    -jobLogDir ${runDir}/logs \
    -I ${input} \
    -genderMapFile /u/home/m/mdistler/project-jflint/genomestrip/svtoolkit/gender.map \
    -run \
    || exit 1

# Run discovery.
java -cp ${classpath} ${mx} \
    org.broadinstitute.gatk.queue.QCommandLine \
    -S ${SV_DIR}/qscript/SVDiscovery.q \
    -S ${SV_DIR}/qscript/SVQScript.q \
    -gatk ${SV_DIR}/lib/gatk/GenomeAnalysisTK.jar \
    --disableJobReport \
    -cp ${classpath} \
    -configFile ${SV_DIR}/conf/genstrip_parameters.txt \
    -tempDir ${SV_TMPDIR} \
    -R ~/project-zarlab/mouseBAM/chr19_new.fa \
    -genderMapFile /u/home/m/mdistler/project-jflint/genomestrip/svtoolkit/installtest/gender.map \
    -runDirectory ${runDir} \
    -md ${runDir}/metadata \
    -disableGATKTraversal \
    -jobLogDir ${runDir}/logs \
    -L 19:1-61431566  \
    -minimumSize 100 \
    -maximumSize 1000000 \
    -suppressVCFCommandLines \
     -I ${input} \
    -O ${sites} \
    -run \
    || exit 1

# Run genotyping on the discovered sites.
java -cp ${classpath} ${mx} \
    org.broadinstitute.gatk.queue.QCommandLine \
    -S ${SV_DIR}/qscript/SVGenotyper.q \
    -S ${SV_DIR}/qscript/SVQScript.q \
    -gatk ${SV_DIR}/lib/gatk/GenomeAnalysisTK.jar \
    --disableJobReport \
    -cp ${classpath} \
    -configFile ${SV_DIR}/conf/genstrip_parameters.txt \
    -tempDir ${SV_TMPDIR} \
    -R ~/project-zarlab/mouseBAM/chr19_new.fa \
    -genderMapFile /u/home/m/mdistler/project-jflint/genomestrip/svtoolkit/installtest/gender.map \
    -runDirectory ${runDir} \
    -md ${runDir}/metadata \
    -disableGATKTraversal \
    -jobLogDir ${runDir}/logs \
     -I ${input} \
    -vcf ${sites} \
    -O ${genotypes} \
    -run \
    || exit 1

(grep -v ^##fileDate= ${genotypes} | grep -v ^##source= | grep -v ^##contig= | grep -v ^##reference= | diff -q - benchmark/${genotypes}) \
    || { echo "Error: test results do not match benchmark data"; exit 1; }

mv /u/scratch/m/mdistler/single_sample/etc/${filename}.unfiltered.vcf /u/scratch/m/mdistler/single_sample/unfiltered
grep '<DEL>' /u/scratch/m/mdistler/single_sample/unfiltered/${filename}.unfiltered.vcf | awk 'NR>1 {split($8,a,";");split(a[3],b,"=");print $1 "    " $2 "    "".""    "".""     "$5"    "".""    ""PASS""    ""SVTYPE=DEL;SVLEN="b[2]-$2";"a[3]}' > /u/scratch/m/mdistler/single_sample/filtered/${filename}.filtered.vcf
