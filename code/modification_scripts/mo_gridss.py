import sys
f=open(sys.argv[1],"r")
lines=f.readlines()
software_result=[]
for x in lines:
        if x.startswith('19'):
                software_result.append(x.split())
f.close()
f3=open(sys.argv[2], "w")
f3.write('##fileformat=VCFv4.2\n##INFO=<ID=SVTYPE,Number=1,Type=String,Description="Type of structural variant detected">\n##INFO=<ID=SVLEN,Number=1,Type=Integer,Description="Length of structural variant">\n##INFO=<ID=END,Number=1,Type=Integer,Description="End position of structural variant">\n#CHROM POS     ID     REF    ALT     QUAL  FILTER  INFO\n')
for i in range(len(software_result)): 
    if(software_result[j][3].endswith('o') and software_result[j][7].split(";")[48].split("=").split(" ")[1] == "DEL"):
		length= int( (software_result[j][46].split(";")[1]).split("=")[1] )
		start=software_result[j][1]
		f3.write('19      ')
		f3.write(start)
		f3.write(' .      .      <DEL>  .      PASS   SVTYPE=DEL;SVLEN=')
		f3.write(str(-length) )
		f3.write(";END=")
		f3.write(start-length+1)
		f3.write("       TP")
		f3.write('\n')