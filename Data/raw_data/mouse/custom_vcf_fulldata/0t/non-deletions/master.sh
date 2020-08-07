#!/bin/bash

rm -fr nf_*
ls *vcf >samples.txt

while read line
do

#echo $line
cat ../../../header_vcf.txt >nf_${line}
sed 's/FP/;FLAG=FP/' ${line} | grep FP | awk '{print $1"\t"$2"\t"$3"\t"$4"\t"$5"\t"$6"\t"$7"\t"$8$9}' >>nf_${line} 
sed 's/TP/;FLAG=TP/' ${line} | grep TP | awk '{print $1"\t"$2"\t"$3"\t"$4"\t"$5"\t"$6"\t"$7"\t"$8$9}' >>nf_${line} 
sed 's/TN/;FLAG=TN/' ${line} | grep TN | awk '{print $1"\t"$2"\t"$3"\t"$4"\t"$5"\t"$6"\t"$7"\t"$8$9}' >>nf_${line}

done<samples.txt
