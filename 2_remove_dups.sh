#!/bin/bash
#SBATCH --job-name=remove_dups
#SBATCH --partition=standard
#SBATCH -c 1
#SBATCH --mem 5g
#SBATCH -t 30:00
#SBATCH -o rmdups_output.o%j
#SBATCH -e rmdups_error.e%j


module load samtools

cd $PWD

mkdir RemoveDups

for file in $(ls /global/home/sa103025/Testing_Ass5/SortedBams/); do
filename=${file:0:7}
samtools rmdup \
-s SortedBams/${filename}.sort.bam RemoveDups/${filename}.sort.rmdup.bam 
done
