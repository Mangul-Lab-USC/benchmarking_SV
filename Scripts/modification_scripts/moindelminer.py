# This script is used to convert the output of clever into the standard vcf format!!
import sys
f=open(sys.argv[1],"r")
lines=f.readlines()
software_result=[]
for x in lines:
        if x.startswith('19'):
                software_result.append(x.split())
f.close()
bmark = [0] * (len(software_result))
f1 = open(sys.argv[2],'w')
f1.write('##fileformat=VCFv4.2\n##INFO=<ID=SVTYPE,Number=1,Type=String,Description="Type of structural variant detected">\n##INFO=<ID=SVLEN,Number=1,Type=Integer,Description="Length of structural variant">\n##INFO=<ID=END,Number=1,Type=Integer,Description="End position of structural variant">\n#CHROM POS     ID     REF    ALT     QUAL  FILTER  INFO\n')
for j in range(len(software_result)):
    if(software_result[j][0]=='19' and software_result[j][7].split(";")[0]=="DELETION"):
      f1.write('19    ')
      f1.write(software_result[j][1])
      f1.write(' .      .      <DEL>   .      ')
      f1.write(software_result[j][6])
      f1.write('   SVTYPE=DEL;SVLEN=')
      # f1.write(' .      .      <DEL>  .      PASS   SVTYPE=DEL;SVLEN=')
      f1.write( str ( int(software_result[j][3])+1-int(software_result[j][4]) ) )
      f1.write(";END=")
      f1.write(software_result[j][7].split(";")[3].split("=")[1] )
      f1.write('\n')
      
f1.close()
