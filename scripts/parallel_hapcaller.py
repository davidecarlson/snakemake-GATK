#!/usr/bin/env python

import glob
import os
import subprocess
import multiprocessing
import argparse
from Bio import SeqIO 

parser = argparse.ArgumentParser(description="Parallelize HaplotypeCaller across scaffold intervals")

parser.add_argument('--bam', required=True, help='path to input bam file', action='store')
parser.add_argument('--reference', required=True, help='path to reference genome in fasta format', action='store')
parser.add_argument('--outdir', required=True, help='path to output directory to write vcfs', action='store')
parser.add_argument('--threads', required=True, help='number of threads to use', action='store')

args=parser.parse_args()

bam = args.bam
ref = args.reference
outdir = args.outdir
threads = int(args.threads)

sample = os.path.split(bam)[1].split('.')[0]
#print(sample)

# get list of fasta headers

intervals = []

for record in SeqIO.parse(ref, "fasta"):
    intervals.append(record.id)

#print(intervals)
# function to run haplotypcaller with intervals
#scaled back HmmPair threads to 1 per interval

def hapcaller(interval):
    print("Running HaplotypeCaller on each interval")
    output = outdir + "/" + interval + ".g.vcf.gz"
    subprocess.run(args=['/home/progs/gatk-4.1.6.0/gatk', 'HaplotypeCaller', '--native-pair-hmm-threads', '1', '-R', ref, '-I', bam, '--emit-ref-confidence',
    'GVCF', '-L', interval, '-O', output])

# Parallelize across intervals with multiprocessing

p = multiprocessing.Pool(processes=threads)

for interval in intervals:
    p.apply_async(hapcaller, [interval])

p.close()
p.join() # Wait for all child processes to close.
