#!/usr/bin/env python

import glob
import os
import subprocess
import argparse

parser = argparse.ArgumentParser(description="Combine GVCFs from multiple intervals with bcftools")

parser.add_argument('--indir', required=True, help='path to input directory containing vcfs', action='store')
parser.add_argument('--output', required=True, help='path to output vcf file', action='store')

args=parser.parse_args()

indir = args.indir
output = args.output

vcfs = glob.glob(indir + "*.g.vcf.gz")

inputs = " ".join((f) for f in vcfs)
print(inputs)

temp_dir = indir + '/temp'
#print(vcfs)

#with open(indir + "vcflist.list", "w") as filehandle:
#   for listitem in vcfs:
#        filehandle.write('%s\n' % listitem)

subprocess.run(args=['bcftools', 'concat', '--threads', '10', inputs])
#subprocess.run(args=['bcftools', 'sort',  '-m', '15G', '-T', temp_dir, '-Oz', '-o', output, 'elata.temp.g.vcf.gz'])




#inputs = "\n".join("I={}".format(f) for f in vcfs)
#inputs = "\n".join(format(f) for f in vcfs)

#print(inputs)

#f = open(indir + "vcflist.list", "w")
#f.write(inputs + "\n")
#f.close

#outvcf = 'O=' + output

#command = 'picard MergeVcfs ' + inputs + outvcf
#print(command)
#invcfs = 'I=' + indir + 'vcflist.list'


#print(invcfs)
#print(dictionary)
#print(outvcf)

#subprocess.run(args=['picard', 'MergeVcfs', invcfs, outvcf])
