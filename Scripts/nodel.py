#AUTHOR="Varuni Sarwal"
# This script is used to convert the output of tools into non-deletion regions in order to calcualte TN's!!
import sys
# def usage():
#   sys.exit('USAGE: python3 nodel.py deletion.vcf nondel.vcf')
# if(len(sys.argv) != 2):
#     # print(len(sys.argsv))
#     usage()
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
f1.write('19      ')
f1.write("0      ")
f1.write(' .      .      <DEL>  .      PASS   SVTYPE=DEL;SVLEN=')
f1.write(software_result[0][1]) 
f1.write(";END=")
f1.write( software_result[0][1])
f1.write('\n')
j=0
for j in range(len(software_result)-1):
  len=int(software_result[j+1][1])-int( (software_result[j][7].split(";")[2]).split("=")[1]); #merge overlapping deletion
  if(software_result[j][0]=='19' and (len>0)):
      f1.write('19      ')
      f1.write((software_result[j][7].split(";")[2]).split("=")[1] )
      f1.write(' .      .      <DEL>  .      PASS   SVTYPE=DEL;SVLEN=')
      f1.write(str(len) ) 
      f1.write(";END=")
      f1.write( software_result[j+1][1])
      f1.write('\n')
  else:
        j=j+1;
#if the file has only one element
if(j==0): 

 f1.write('19      ')
 f1.write((software_result[0][7].split(";")[2]).split("=")[1])
 f1.write(' .      .      <DEL>  .      PASS   SVTYPE=DEL;SVLEN=')
 f1.write( str(61431566-int((software_result[0][7].split(";")[2]).split("=")[1]) ) )
 f1.write(";END=")
 f1.write("61431566")
 f1.write('\n')

else:

 f1.write('19      ')
 f1.write((software_result[j+1][7].split(";")[2]).split("=")[1])
 f1.write(' .      .      <DEL>  .      PASS   SVTYPE=DEL;SVLEN=')
 f1.write( str(61431566-int((software_result[j+1][7].split(";")[2]).split("=")[1]) ) )
 f1.write(";END=")
 f1.write("61431566")
 f1.write('\n')

      
f1.close()

