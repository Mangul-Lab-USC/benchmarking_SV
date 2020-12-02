#!/bin/bash

AUTHOR="rlittman"

###############################################
##########   The main template script #########
###############################################



# PURPOSE OF THE SCRIPT
# Runs matchclips

# THE COMMAND LINE INTERFACE OF THE WRAPPER SCRIPT
# $tool $reference $input $outdir $chromOfInterest
# |	  mandatory part 	 |

if [ $# -lt 1 ]
then
echo "***************************************************"
echo "Script was written for project : Best practices for conducting benchmarking in the most comprehensive and reproducible ways"
echo "This script was written by Russell Littman"
echo "***************************************************"

echo ""
echo "1 <reference> - .fa: Reference chromosome"
echo "2 <input> - .bam"
echo "3 <outdir> - dir to save the output"
echo "4 <chromOfInterest>- #just a number"
echo "--------------------------------------------"
exit 1
fi



# mandatory part
reference=/u/scratch/r/ramayyal/reference_genome/chr19.fa 
input=$1
filename=$(basename $input)
outdir=/u/scratch/r/ramayyal/cpu_stats/rdxplorer/${filename}
chromOfInterest=19
toolName='rdxplorer'
toolPath='/u/home/m/mdistler/project-jflint/rdxplorer/rdxplorer/rdxplorer.py'

## These parameters may be kept default. See readme for rdxplorer for explanation

gender='F'
hg='hg19'
winSize=100
baseCopy=2
filter=10
sumWithZero=True
debug=True
delete=True

#filename=$(basename $input)


# STEP 0 - create output directory if it does not exist

mkdir -p $outdir

# ----------------------------------------------------


# RUN TOOL: matchclips

now="$(date)"

logfile=${outdir}/report_${toolName}.${filename}.log
echo "START" > $logfile
echo $toolPath > $logfile

printf "%s --- RUNNING %s\n" "$now" $toolName >> $logfile

#run the command
res1=$(date +%s.%N)

echo "python $toolPath $input $reference $outdir $chromOfInterest $gender $hg $winSize $baseCopy $filter $sumWithZero $debug $delete >> $logfile 2>&1" >> $logfile

python $toolPath $input $reference $outdir $chromOfInterest $gender $hg $winSize $baseCopy $filter $sumWithZero $debug $delete >> $logfile 2>&1

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
