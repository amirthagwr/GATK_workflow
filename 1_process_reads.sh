#!/bin/bash
#SBATCH --job-name=process_reads
#SBATCH --partition=standard
#SBATCH -c 4
#SBATCH --mem 5g
#SBATCH -t 2:00:00
#SBATCH -o process_output.o%j
#SBATCH -e process_error.e%j


module load samtools

cd $PWD

for file in $(ls /global/scratch/hpcxxxx/ngs/BamFiles/); do
filename=${file:0:7}
samtools sort \
--threads 4 \
-m 5G \
-T /${filename}.sort \
${file} \
-o /global/home/sa103025/Testing_Ass5/SortedBams/${filename}.sort.bam 
done
