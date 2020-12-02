#!/bin/bash

AUTHOR="ramayyal"

###############################################
##########   The main template script #########
###############################################



# PURPOSE OF THE SCRIPT
# Runs mistrvar

# THE COMMAND LINE INTERFACE OF THE WRAPPER SCRIPT
# $tool $input
# |       mandatory part         |

if [ $# -lt 1]
then
echo "***************************************************"
echo "Script was written for project : Best practices for conducting benchmarking in the most comprehensive and reproducible ways"
echo "This script was written by Ram Ayyala"
echo "***************************************************"
echo ""
echo "1 <input> - .bam"
echo "--------------------------------------------"
exit 1
fi

. /u/local/Modules/default/init/modules.sh && module load python/3.6.1 && module load samtools

# mandatory part
input=$1
toolName=mistrvar
toolPath=/u/home/r/ramayyal/Tools/mistrvar/pipeline/mistrvar.py
filename=$(basename $input)
# ----------------------------------------------------


# RUN TOOL: lumpyexpress

now="$(date)"

logfile=report_${toolName}.${filename}.log
echo "START" > $logfile
echo $toolPath > $logfile

printf "%s --- RUNNING %s\n" "$now" $toolName >> $logfile

#run the command
res1=$(date +%s.%N)
#insert full command to run here
###################
#example: echo "$toolPath -f $reference -o $outdir/${toolName}.${filename}.bp -b $input >> $logfile 2>&1" >> $logfile
#example: $toolPath -f $reference -o $outdir/${toolName}.${filename}.bp -b $input >> $logfile 2>&1
echo "python3 ${toolPath} \
	-p ${filename} \
	-r /u/scratch/r/ramayyal/reference_genome/full_bams/mouseBAM/chr19.fa \
	--files alignment=${input}"

python3 ${toolPath} \
	-p ${filename} \
	-r /u/scratch/r/ramayyal/reference_genome/mouse_chr19/chr19.fa \
	--files alignment=${input}
echo "awk 'NR<12 {print$0}' $filename/${filename}.vcf| cat >> $filename/${toolName}.${filename}.modified.vcf" >> $logfile
awk 'NR<12 {print$0}' $filename/${filename}.vcf| cat >> $filename/${toolName}.${filename}.modified.vcf
echo "grep "DEL" $filename/${filename}.vcf | awk 'NR>11 {split($8,a,"="); split($8,b,";");print "19"" "$2" ""."" ""."" ""<DEL>"" ""."" "$7" "b[1]" ""SVLEN="a[3]-$2" "b[2]}' | cat >> $filename/${toolName}.${filename}.modified.vcf" >>$logfile
grep "DEL" $filename/${filename}.vcf | awk 'NR>11 {split($8,a,"="); split($8,b,";");print "19""   "$2"   "".""   "".""   ""<DEL>""   "".""   "$7"   "b[1]";""SVLEN="a[3]-$2";"b[2]}' | cat >> $filename/${toolName}.${filename}.modified.vcf
########################
res2=$(date +%s.%N)
dt=$(echo "res2-res1" | bc)
dd=$(echo "$dt/86400" | bc)
dt2=$(echo "dt-8600*dd" | bc)
dh=$(echo "dt2/3600" | bc)
dt3=$(echo "dt2-3600*$dh" | bc)
dm=$(echo "dt3/60" | bc)
ds=$(echo "dt3-60*$dm" | bc)
now="$(date)"
printf "%s --- TOTAL RUNTIME: %d:%02d:%02d:%02.4f\n" "$now" $dd $dh $dm $ds >> $logfile

now="$(date)"
printf "%s --- FINISHED RUNNING %s %s\n" "$now" "$toolName" >> $logfile

# ----------------------------


printf "DONE" >> $logfile
mv $logfile $outdir