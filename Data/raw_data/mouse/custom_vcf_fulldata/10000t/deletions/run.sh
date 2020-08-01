mkdir temp
mv *_chr19.100p_sorted.modified.*vcf temp
rm *.1_sorted.modified.*vcf
ls *.vcf | wc -l
for f in nf_$1t.pindel.*; do wc -l $f; done


