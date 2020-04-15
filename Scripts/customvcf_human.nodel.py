#AUTHOR="Varuni Sarwal"
#THIS SCRIPT IS USED TO COMPARE THE NONDEL VCF PRODUCED BY THE TOOL WITH THE NONDEL GOLD STANDARD AND PRODUCE A CUSTOM VCF. THE FORMAT OF THE
#CUSTOM VCF IS THE SAME AS AN ORDINARY VCF, EXCEPT THAT IT CONTAINS AN EXTRA COLUMN WITH A FLAG: TN
import sys
f=open(sys.argv[2],"r")
lines=f.readlines()
software_result=[]
for x in lines:
        if (x[0].isdigit() or x[0]=="Y" or x[0]=="X"):
                software_result.append(x.split())
f.close()
f2=open(sys.argv[3] ,"r")
lines=f2.readlines()
gold_Standard=[]
for x in lines:
        if (x[0].isdigit() or x[0]=="Y" or x[0]=="X"):
                gold_Standard.append(x.split())
f2.close()
TN = 0
FN = 0
t = sys.argv[1]
bmark = [0] * (len(software_result)) # Used to track the start posns
emark = [0] * (len(software_result)) #Used to track the end posns
f3=open(sys.argv[4], "w")
f3.write('##fileformat=VCFv4.2\n##INFO=<ID=SVTYPE,Number=1,Type=String,Description="Type of structural variant detected">\n##INFO=<ID=SVLEN,Number=1,Type=Integer,Description="Length of structural variant">\n##INFO=<ID=END,Number=1,Type=Integer,Description="End position of structural variant">\n#CHROM POS     ID     REF    ALT     QUAL  FILTER  INFO\n')
for i in range(len(gold_Standard)): 
    for j in range(len(software_result)):
      if(software_result[j][0]==gold_Standard[i][0]): #to make sure that the chromosome number matches
        if(abs(int(gold_Standard[i][1])-int(software_result[j][1]) )<int(t) and bmark[j]==1): # Our software has already detected this. NOT a miss!!
                TN += 0
        if(abs(int((gold_Standard[i][7].split(";")[2]).split("=")[1])-int((software_result[j][7].split(";")[2]).split("=")[1]))<int(t) and emark[j]==1): # Our software has already detected this. NOT a miss!!
                TN += 0
        if(abs(int(gold_Standard[i][1])-int(software_result[j][1]))<int(t) and bmark[j]==0 and abs(int((gold_Standard[i][7].split(";")[2]).split("=")[1])-int((software_result[j][7].split(";")[2]).split("=")[1]))<int(t) and emark[j]==0): #undetected start posn match!
                TN += 1
                f3.write(software_result[j][0])
                f3.write("	")
                f3.write(software_result[j][1])
                f3.write(' .      .      <DEL>  .      PASS   SVTYPE=DEL;SVLEN=')
                f3.write(str(int( (software_result[j][7].split(";")[1]).split("=")[1])) )
                f3.write(";END=")
                f3.write((software_result[j][7].split(";")[2]).split("=")[1])
                f3.write("       TN")
                f3.write('\n')
                bmark[j]=1
                emark[j]=1
                break
    else: # Now, this must be a miss!
       FN += 1
f3.close()


