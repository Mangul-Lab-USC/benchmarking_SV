#!/bin/bash
#!/bin/bash

AUTHOR="rlittman"

###############################################
##########   The main template script #########
###############################################



# PURPOSE OF THE SCRIPT
# Runs matchclips

# THE COMMAND LINE INTERFACE OF THE WRAPPER SCRIPT
# $tool $reference $input $outdir $chromOfInterest
# |       mandatory part         |

if [ $# -lt 4 ]
then
echo "***************************************************"
echo "Script was written for project : Best practices for conducting benchmarking in the most comprehensive and reproducible ways"
echo "This script was written by Russell Littman"
echo "***************************************************"

echo ""
echo "1 <reference> - .fa: Reference chromosome"
echo "2 <input> - .bam"
echo "3 <outdir> - dir to save the output"
echo "4 <chromOfInterest>- #just a number"
echo "--------------------------------------------"
exit 1
fi


# mandatory part
toolName='rdxplorer'
toolPath='/u/home/m/mdistler/project-jflint/rdxplorer/rdxplorer/rdxplorer.py'




##### these parameters were changed


path2bam=$2
reference=$1
wrkgdir=$3
chromOfInterest='19'

#### Other parameters as default

gender='F'
hg='hg19'
winSize=100
baseCopy=2
filter=10
sumWithZero=True
debug=True
delete=True

BEFORE=`date '+%s'`

python ${toolPath} ${path2bam} ${reference} ${wrkgdir} ${chromOfInterest} ${gender} ${hg} ${winSize} ${baseCopy} ${filter} ${sumWithZero} ${debug} ${delete}

AFTER=`date '+%s'`
TIME=$(($AFTER - $BEFORE))
echo "Doing this took $TIME seconds "
echo "DONE."

##### these parameters were changed


path2bam='/u/home/m/mdistler/test/mouse0.1/more0.1sub/AKR_J.chr19.10p.2_sorted.bam'
reference='/u/home/m/mdistler/project-zarlab/mouseBAM/chr19_new.fa'
wrkgdir='/u/home/m/mdistler/project-jflint/rdxplorer/moresub/sub0.1_2/akr'
chromOfInterest='19'

#### Other parameters as default

gender='F'
hg='hg19'
winSize=100
baseCopy=2
filter=10
sumWithZero=True
debug=True
delete=True

BEFORE=`date '+%s'`

python rdxplorer.py ${path2bam} ${reference} ${wrkgdir} ${chromOfInterest} ${gender} ${hg} ${winSize} ${baseCopy} ${filter} ${sumWithZero} ${debug} ${delete}

AFTER=`date '+%s'`
TIME=$(($AFTER - $BEFORE))
echo "Doing this took $TIME seconds "
echo "DONE."


##### these parameters were changed


path2bam='/u/home/m/mdistler/test/mouse0.1/more0.1sub/BALBCJ.chr19.10p.2_sorted.bam'
reference='/u/home/m/mdistler/project-zarlab/mouseBAM/chr19_new.fa'
wrkgdir='/u/home/m/mdistler/project-jflint/rdxplorer/moresub/sub0.1_2/balb'
chromOfInterest='19'

#### Other parameters as default

gender='F'
hg='hg19'
winSize=100
baseCopy=2
filter=10
sumWithZero=True
debug=True
delete=True

BEFORE=`date '+%s'`

python rdxplorer.py ${path2bam} ${reference} ${wrkgdir} ${chromOfInterest} ${gender} ${hg} ${winSize} ${baseCopy} ${filter} ${sumWithZero} ${debug} ${delete}

AFTER=`date '+%s'`
TIME=$(($AFTER - $BEFORE))
echo "Doing this took $TIME seconds "
echo "DONE."


##### these parameters were changed


path2bam='/u/home/m/mdistler/test/mouse0.1/more0.1sub/C3H_HeJ.chr19.10p.2_sorted.bam'
reference='/u/home/m/mdistler/project-zarlab/mouseBAM/chr19_new.fa'
wrkgdir='/u/home/m/mdistler/project-jflint/rdxplorer/moresub/sub0.1_2/c3h'
chromOfInterest='19'

#### Other parameters as default

gender='F'
hg='hg19'
winSize=100
baseCopy=2
filter=10
sumWithZero=True
debug=True
delete=True

BEFORE=`date '+%s'`

python rdxplorer.py ${path2bam} ${reference} ${wrkgdir} ${chromOfInterest} ${gender} ${hg} ${winSize} ${baseCopy} ${filter} ${sumWithZero} ${debug} ${delete}

AFTER=`date '+%s'`
TIME=$(($AFTER - $BEFORE))
echo "Doing this took $TIME seconds "
echo "DONE."


##### these parameters were changed


path2bam='/u/home/m/mdistler/test/mouse0.1/more0.1sub/C57BL_6NJ.chr19.10p.2_sorted.bam'
reference='/u/home/m/mdistler/project-zarlab/mouseBAM/chr19_new.fa'
wrkgdir='/u/home/m/mdistler/project-jflint/rdxplorer/moresub/sub0.1_2/c57'
chromOfInterest='19'

#### Other parameters as default

gender='F'
hg='hg19'
winSize=100
baseCopy=2
filter=10
sumWithZero=True
debug=True
delete=True

BEFORE=`date '+%s'`

python rdxplorer.py ${path2bam} ${reference} ${wrkgdir} ${chromOfInterest} ${gender} ${hg} ${winSize} ${baseCopy} ${filter} ${sumWithZero} ${debug} ${delete}

AFTER=`date '+%s'`
TIME=$(($AFTER - $BEFORE))
echo "Doing this took $TIME seconds "
echo "DONE."

##### these parameters were changed


path2bam='/u/home/m/mdistler/test/mouse0.1/more0.1sub/CBA_J.chr19.10p.2_sorted.bam'
reference='/u/home/m/mdistler/project-zarlab/mouseBAM/chr19_new.fa'
wrkgdir='/u/home/m/mdistler/project-jflint/rdxplorer/moresub/sub0.1_2/cba'
chromOfInterest='19'

#### Other parameters as default

gender='F'
hg='hg19'
winSize=100
baseCopy=2
filter=10
sumWithZero=True
debug=True
delete=True

BEFORE=`date '+%s'`

python rdxplorer.py ${path2bam} ${reference} ${wrkgdir} ${chromOfInterest} ${gender} ${hg} ${winSize} ${baseCopy} ${filter} ${sumWithZero} ${debug} ${delete}

AFTER=`date '+%s'`
TIME=$(($AFTER - $BEFORE))
echo "Doing this took $TIME seconds "
echo "DONE."

##### these parameters were changed


path2bam='/u/home/m/mdistler/test/mouse0.1/more0.1sub/DBA_2J.chr19.10p.2_sorted.bam'
reference='/u/home/m/mdistler/project-zarlab/mouseBAM/chr19_new.fa'
wrkgdir='/u/home/m/mdistler/project-jflint/rdxplorer/moresub/sub0.1_2/dba'
chromOfInterest='19'

#### Other parameters as default

gender='F'
hg='hg19'
winSize=100
baseCopy=2
filter=10
sumWithZero=True
debug=True
delete=True

BEFORE=`date '+%s'`

python rdxplorer.py ${path2bam} ${reference} ${wrkgdir} ${chromOfInterest} ${gender} ${hg} ${winSize} ${baseCopy} ${filter} ${sumWithZero} ${debug} ${delete}

AFTER=`date '+%s'`
TIME=$(($AFTER - $BEFORE))
echo "Doing this took $TIME seconds "
echo "DONE."

##### these parameters were changed


path2bam='/u/home/m/mdistler/test/mouse0.1/more0.1sub/LP_J.chr19.10p.2_sorted.bam'
reference='/u/home/m/mdistler/project-zarlab/mouseBAM/chr19_new.fa'
wrkgdir='/u/home/m/mdistler/project-jflint/rdxplorer/moresub/sub0.1_2/lpj'
chromOfInterest='19'

#### Other parameters as default

gender='F'
hg='hg19'
winSize=100
baseCopy=2
filter=10
sumWithZero=True
debug=True
delete=True

BEFORE=`date '+%s'`

python rdxplorer.py ${path2bam} ${reference} ${wrkgdir} ${chromOfInterest} ${gender} ${hg} ${winSize} ${baseCopy} ${filter} ${sumWithZero} ${debug} ${delete}

AFTER=`date '+%s'`
TIME=$(($AFTER - $BEFORE))
echo "Doing this took $TIME seconds "
echo "DONE."
