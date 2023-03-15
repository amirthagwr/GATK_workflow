#!/bin/bash
#SBATCH --job-name=index
#SBATCH --partition=standard
#SBATCH -c 1
#SBATCH --mem 5g
#SBATCH -t 30:00
#SBATCH -o index_output.o%j
#SBATCH -e index_error.e%j


module load samtools

cd $PWD #current directory with all the scripts


for file in $(ls RemoveDups/); do
filename=${file:0:7}
samtools index RemoveDups/${filename}.sort.rmdup.bam 
done
