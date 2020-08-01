#!/bin/bash


################################################################
##########          The main template script          ##########
################################################################

toolName="indelMINER"
toolPath="/u/home/b/btstatz/project-zarlab/install/indelMINER/src/indelminer"

# STEPS OF THE SCRIPT
# 1) prepare input if necessary
# 2) run the tool
# 3) transform output if necessary
# 4) compress output


# THE COMMAND LINE INTERFACE OF THE WRAPPER SCRIPT
# $tool $input1 $input2 $outdir $kmers $others
# |      mandatory part       | | extra part |
# <---------------------------> <------------>




if [ $# -lt 3 ]
then
echo "------------------------------------- "
echo "1 <reference>  - .fasta"
echo "2 <alignments> - .bam"
echo "3 <outdir>     - output directory"
echo "--------------------------------------"
exit 1
fi



# mandatory part
reference=$1
alignments=$2
outdir=$3

# extra part (tool specific)


# STEP 0 - create output directory if it does not exist

mkdir -p $outdir
pwd=$PWD
cd $outdir
outdir=$PWD
cd $pwd


filename=$(basename $alignments .bam)




logfile=${outdir}/report_${toolName}_${filename}.log





# -----------------------------------------------------

echo "START" >> $logfile

# STEP 1 - prepare input if necessary (ATTENTION: TOOL SPECIFIC PART!)


# -----------------------------------





# STEP 2 - run the tool (ATTENTION: TOOL SPECIFIC PART!)

now="$(date)"
printf "%s --- RUNNING %s\n" "$now" $toolName >> $logfile

# run the command
res1=$(date +%s.%N)




$toolPath $reference sample=$alignments > ${outdir}/${toolName}_${filename}.vcf 2>>$logfile
res2=$(date +%s.%N)
dt=$(echo "$res2 - $res1" | bc)
dd=$(echo "$dt/86400" | bc)
dt2=$(echo "$dt-86400*$dd" | bc)
dh=$(echo "$dt2/3600" | bc)
dt3=$(echo "$dt2-3600*$dh" | bc)
dm=$(echo "$dt3/60" | bc)
ds=$(echo "$dt3-60*$dm" | bc)
now="$(date)"
printf "%s --- TOTAL RUNTIME: %d:%02d:%02d:%02.4f\n" "$now" $dd $dh $dm $ds >> $logfile

now="$(date)"
printf "%s --- FINISHED RUNNING %s %s\n" "$now" $toolName >> $logfile

# ---------------------

# STEP 3 - transform output if necessary (ATTENTION: TOOL SPECIFIC PART!)

# --------------------------------------

printf "DONE" >> $logfile



