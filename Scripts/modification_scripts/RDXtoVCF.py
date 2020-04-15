#! /usr/bin/evn python

import sys
import os

RDX_input = open(sys.argv[1], "r")
VCF_output = open(sys.argv[2], "w")

header_lines = "##fileformat=VCFv4.2\n\
##source=RDX\n\
##INFO=<ID=SVTYPE,Number=1,Type=String,Description=\"Type of structural variant detected\">\n\
##INFO=<ID=SVLEN,Number=1,Type=Integer,Description=\"Length of structural variant\">\n\
##INFO=<ID=END,Number=1,Type=Integer,Description=\"End position of structural variant\">\n\
#CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\n"

VCF_output.write(header_lines)

for line in RDX_input.readlines():
    if "segStart" not in line: # making sure it's not a header line
        line = line.split()
        chromosome = line[7]
        start = line[8]
        end = line[9]
        length = abs(int(line[3]))

        sv_type = line[2]

        if (sv_type == "1"):
            sv_type = "DEL"
        elif (sv_type == "2"):
            sv_type = "NONE"
        elif (sv_type == "3"):
            sv_type = "DUP"
        else:
            sv_type = "UNKNOWN"

        vcf_line = chromosome + "\t" + start + "\t.\t.\t.\t.\tPASS\tSVTYPE=" + sv_type + ";SVLEN=" + str(length) + ";END=" + str(end) + "\n"

        VCF_output.write(vcf_line)

RDX_input.close()
VCF_output.close()
