#!/bin/bash

AUTHOR="rlittman"

###############################################
##########   The main template script #########
###############################################



# PURPOSE OF THE SCRIPT
# Runs gasv

# THE COMMAND LINE INTERFACE OF THE WRAPPER SCRIPT
# $tool $reference $input $outdir
# |	  mandatory part 	 |

if [ $# -lt 2 ]
then
echo "***************************************************"
echo "Script was written for project : Best practices for conducting benchmarking in the most comprehensive and reproducible ways"
echo "This script was written by Russell Littman"
echo "***************************************************"

echo ""
echo "1 <input> - .bam: bamfile"
echo "2 <outdir> - dir to save the output"
echo "--------------------------------------------"
exit 1
fi



# mandatory part
input=$1
outdir=$2
toolName="gasv"
toolPath="/u/home/r/rlittman/project-zarlab/install/gasv/bin"
#path only to the bin because we need two commands from there


filename=$(basename $input)


# STEP 0 - create output directory if it does not exist

mkdir $outdir
cd $outdir
# ----------------------------------------------------


# RUN TOOL: gasv

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
echo "java -Xms512m -Xmx2048m -jar ${toolPath}/BAMToGASV.jar $input >> $logfile 2>&1" >> $logfile
java -Xms512m -Xmx2048m -jar ${toolPath}/BAMToGASV.jar $input >> $logfile 2>&1
echo "java -jar ${toolPath}/GASV.jar --batch ${input}.gasv.in >> $logfile 2>&1" >> $logfile
java -jar ${toolPath}/GASV.jar --batch ${input}.gasv.in >> $logfile 2>&1
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
