#CHROM  POS     ID      REF     ALT     QUAL    FILTER  INFO    FORMAT  A_J
#chr19   3205654 .       CGGCCGCTGGGCCGCTGGGCCGCTGGGCCGCTGGGCCGCTGGGCCGCTGGGCCGCTG       C       28      PASS    NS=1;SVTYPE=DEL;SVLEN=-56       GT:PG:GQ:PI:OV:DP:AD:PDP:PAD:LASCORE:LAREFSPAN:LARANCH:LALANCH:LAREFGC:LAALTGC:LAALTSEQLEN:NUMASM:US:DS:UC:DC:UDC:UCC:DDC:DCC:UMO:DMO:UXO:DXO:NR:
import sys
f=open(sys.argv[1],"r")
lines=f.readlines()
software_result=[]
for x in lines:
        if x.startswith('chr19'):
                software_result.append(x.split())
f3=open(sys.argv[2], "w")
f3.write('##fileformat=VCFv4.2\n##INFO=<ID=SVTYPE,Number=1,Type=String,Description="Type of structural variant detected">\n##INFO=<ID=SVLEN,Number=1,Type=Integer,Description="Length of structural variant">\n##INFO=<ID=END,Number=1,Type=Integer,Description="End position of structural variant">\n#CHROM	POS	ID	REF	ALT	QUAL	FILTER	INFO\n')
for i in range(len(software_result)):
      if((software_result[i][7].split(";")[1]).split("=")[1]=="DEL"):
        len = -int((software_result[i][7].split(";")[2]).split("=")[1])
        start=software_result[i][1]
        f3.write('19	')
        f3.write(start)
        f3.write('	.	.	<DEL>	.	PASS	SVTYPE=DEL;SVLEN=')
        f3.write(str(len) )
        f3.write(";END=")
        f3.write(str(int(start)+len))
        f3.write('\n')
