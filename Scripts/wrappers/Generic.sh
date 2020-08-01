#!/bin/bash

AUTHOR="vsarwal"

# PURPOSE OF THE SCRIPT
# Runs name_of_software

# THE COMMAND LINE INTERFACE OF THE WRAPPER SCRIPT
# $tool $reference $input $outdir
# |	  mandatory part 	 |

if [ $# -lt 3 ]
then
echo "***************************************************"
echo "Script was written for project : Best practices for conducting benchmarking in the most comprehensive and reproducible ways"
echo "This script was written by Varuni Sarwal"
echo "***************************************************"
echo ""
echo "1 <reference> - .fa: Reference chromosome"
echo "2 <input> - .bam"
echo "3 <outdir> - dir to save the output"
echo "--------------------------------------------"
exit 1
fi



# mandatory part
reference=$1
input=$2
outdir=$3
toolName=name_of_software
toolPath= #insert full path to tool

filename=$(basename $input)


# STEP 0 - create output directory if it does not exist

mkdir $outdir

# RUN TOOL: nameoftool

now="$(date)"

logfile=${outdir}/report_${toolName}.${filename}.log
echo "START" > $logfile
echo $toolPath > $logfile

printf "%s --- RUNNING %s\n" "$now" $toolName >> $logfile

#run the command
res1=$(date +%s.%N)


#example: echo "$toolPath -f $reference -o $outdir/${toolName}.${filename}.bp -b $input >> $logfile 2>&1" >> $logfile

#example: $toolPath -f $reference -o $outdir/${toolName}.${filename}.bp -b $input >> $logfile 2>&1
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