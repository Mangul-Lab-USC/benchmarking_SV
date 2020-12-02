. /u/local/Modules/default/init/modules.sh && module load samtools && module load perl && module load blat
input=$1
filename=$(basename $input)
extractPath=/u/home/m/mdistler/project-jflint/crest/extractSClip.pl
reference=/u/home/m/mdistler/project-zarlab/mouseBAM/chr19_new.fa
#2bit=/u/home/m/mdistler/project-zarlab/mouseBAM/chr19_new.2bit
outdir=$/u/scratch/m/mdistler/crest_output
CREST=/u/home/m/mdistler/project-jflint/crest/newCREST.pl
# STEP 0 - create output directory if it does not exist

#mkdir $outdir
#mkdir $outdir

# ----------------------------------------------------


# RUN TOOL: DELLY

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

#echo "perl $extractPath -i $input --ref_genome $reference -r 19 >> $logfile 2>&1" >> $logfile
perl /u/home/m/mdistler/project-jflint/crest/extractSClip.pl -i ${input} --ref_genome ${reference} -r 19 
gfServer -canStop start localhost 3503 /u/home/m/mdistler/project-zarlab/mouseBAM/chr19_new.2bit &
#echo "${filename}.19.cover"
perl /u/home/m/mdistler/project-jflint/crest/newCREST.pl -f ${filename}.19.cover -d /u/scratch/r/ramayyal/reference_genome/mouse_chr19/${filename} --ref_genome ${reference} -t /u/home/m/mdistler/project-zarlab/mouseBAM/chr19_new.2bit 
#perl ./newCREST.pl -f ${filename}.19.cover -d ${filename} --ref_genome ${reference} -t /u/home/m/mdistler/project-zarlab/mouseBAM/chr19_new.2bit

#mv ${filename}.19.cover /u/scratch/m/mdistler/crest_output 
#mv ${filename}.predSV.txt /u/scratch/m/mdistler/crest_output
grep DEL ${filename}.predSV.txt | awk '{print $19"    "$20"     "".""      "".""       ""<DEL>""      "".""     ""PASS""     ""SVTYPE=DEL;SVLEN="$23-$20";END="$23}' > ${filename}.predSV.vcf
mv ${filename}* /u/scratch/m/mdistler/crest_output
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
mv $logfile $outdir

