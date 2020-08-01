#AUTHOR="Varuni Sarwal"
#THIS SCRIPT IS USED TO COMPARE THE NONDEL VCF PRODUCED BY THE TOOL WITH THE NONDEL GOLD STANDARD AND PRODUCE A CUSTOM VCF. THE FORMAT OF THE
#CUSTOM VCF IS THE SAME AS AN ORDINARY VCF, EXCEPT THAT IT CONTAINS AN EXTRA COLUMN WITH A FLAG: TN
# Multiple GS TN's can be mapped to one tool TN, we will take the sum of all the TN's in the range
import sys
f=open(sys.argv[2],"r")
lines=f.readlines()
software_result=[]
for x in lines:
        if x.startswith('19'):
                software_result.append(x.split())
f.close()
f2=open(sys.argv[3] ,"r")
lines=f2.readlines()
gold_Standard=[]
for x in lines:
        if x.startswith('19'):
                gold_Standard.append(x.split())
f2.close()
# int gold_start,software_start,gold_end,software_end;
TN = 0
FN = 0
t = sys.argv[1]
f3=open(sys.argv[4], "w")
f3.write('##fileformat=VCFv4.2\n##INFO=<ID=SVTYPE,Number=1,Type=String,Description="Type        of      structural      variant detected">\n#INFO=<ID=SVLEN,Number=1,Type=Integer,Description="Length      of      structural      variant">\n##INFO=<ID=SVLEN,Number=1,Type=Integer,Description="Length      of      structural      variant">\n##INFO=<ID=END,Number=1,Type=Integer,Description="End   position        of      structural      variant">\n##INFO=<ID=FLAG,Number=1,Type=String,Description="TP and FP">\n')
# f3.write('##fileformat=VCFv4.2\n##INFO=<ID=SVTYPE,Number=1,Type=String,Description="Type of structural variant detected">\n##INFO=<ID=SVLEN,Number=1,Type=Integer,Description="Length of structural variant">\n##INFO=<ID=END,Number=1,Type=Integer,Description="End position of structural variant">\n#CHROM POS     ID     REF    ALT     QUAL  FILTER  INFO\n')

for j in range(len(software_result)): 
    for i in range(len(gold_Standard)):
        gold_start=int(gold_Standard[i][1])
        software_start=int(software_result[j][1])
        gold_end=int((gold_Standard[i][7].split(";")[2]).split("=")[1])
        software_end=int((software_result[j][7].split(";")[2]).split("=")[1])
        if( (gold_start > software_start) and (gold_end<software_end) ): #gold deletion is a subset of software deletion, increment
            TN += 1
            f3.write('19	')
            f3.write(str(software_start))
            f3.write(' .      .      <DEL>  .      PASS   SVTYPE=DEL;SVLEN=')
            f3.write((software_result[j][7].split(";")[1]).split("=")[1]) 
            f3.write(";END=")
            f3.write(str(software_end))
            f3.write(";FLAG=TN")
            f3.write('\n')
        elif (abs(gold_start-software_start)<int(t) and abs(gold_end-software_end)<int(t)): #undetected start posn match!
            TN += 1
            f3.write('19	')
            f3.write(str(software_start))
            f3.write(' .      .      <DEL>  .      PASS   SVTYPE=DEL;SVLEN=')
            f3.write((software_result[j][7].split(";")[1]).split("=")[1])
            f3.write(";END=")
            f3.write(str(software_end))
            f3.write(";FLAG=TN")
            f3.write('\n')
        else: # Now, this must be a miss!
            FN += 1 # we don't really care about this value for non deletions
f3.close()


