#!/bin/bash
if [ $# -lt 3 ]
then
echo "enter the right number of inputs"
fi
reference=$1
input=$2
outdir=$3
toolName=delly
toolPath=/u/home/m/mdistler/project-jflint/DELLY/delly_v0.7.3_linux_x86_64bit
filename=$(basename $input)

mkdir -p $outdir
pwd=$PWD
cd $outdir
outdir=$PWD
cd $pwd
#----------------------------------------------------------------------------------------------
now="$(date)"
logfile=report_${toolName}.${filename}.log
echo "START" > $logfile
echo $toolPath > $logfile
printf "%s --- RUNNING %s\n" "$now" $toolName >> $logfile
res1=$(date +%s.%N)
echo "$toolPath -t DEL -g $reference -o $outdir/${toolName}.${filename}.output.bcf $input >>$logfile 2>&1 " >> $logfile
$toolPath -t DEL -g $reference -o $outdir/${toolName}.${filename}.output.bcf $input >>$logfile 2>&1
#---------------------------------------------------------------------------------------------------------------------------
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
