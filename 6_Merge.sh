#!/bin/bash
#SBATCH --job-name=Merge_VCFs
#SBATCH --partition=standard
#SBATCH -c 1
#SBATCH --mem 128g
#SBATCH -t 1:30:00
#SBATCH -o Merge_output.o%j
#SBATCH -e Merge_error.e%j


module load tabix/0.2.6
module load bcftools
module load vcftools

cd $PWD

mkdir Final_merged

for file in $(ls GATK_Filter/*.vcf); do bgzip ${file}; done 
for file in $(ls GATK_Filter/*.vcf.gz); do tabix ${file} ; done 
vcf-merge GATK_Filter/*.vcf.gz > Final_merged/merged_all_variants2.vcf
