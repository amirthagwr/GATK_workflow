#!/bin/bash
#SBATCH --job-name=Convert_VCFs
#SBATCH --partition=standard
#SBATCH -c 2
#SBATCH --mem 6g
#SBATCH -t 1:30:00
#SBATCH -o conv_vcfs_output.o%j
#SBATCH -e conv_vcfs_error.e%j


module load plink/1.9b_4.1-x86_64

cd Final_merged/

plink --vcf merged_all_variants.snpeff.vcf --1 --pheno phenofile.ped --mpheno 4 --allow-no-sex --make-bed --out SKAT_input_file

