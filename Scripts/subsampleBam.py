import csv
import sys
import argparse
from collections import Counter
import numpy
import pysam
import random

ap = argparse.ArgumentParser()
ap.add_argument('inBam', help='inBam')
ap.add_argument('outBam', help='outBam')
ap.add_argument('fraction', help='fraction')

args = ap.parse_args()




samfile = pysam.AlignmentFile(args.inBam) # Change me




#output = pysam.AlignmentFile(args.outBam, "wb", template=bam) # Change me
fraction = float(args.fraction)


reads_read1_primary_alignment=set()

for read in samfile.fetch():

    if read.is_read1:
        if not read.is_secondary or read.is_unmapped:
            if random.random() < fraction:
                reads_read1_primary_alignment.add(read.query_name)


samfile.close()



print "Number of PE reads selected", len(reads_read1_primary_alignment)


samfile = pysam.AlignmentFile(args.inBam) # Change me
output = pysam.AlignmentFile(args.outBam, "wb", template=samfile) # Change me



for read in samfile.fetch():
    if read.query_name in reads_read1_primary_alignment:
        output.write(read)
samfile.close()
output.close()


print "done!"
