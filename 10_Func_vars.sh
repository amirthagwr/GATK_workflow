#!/bin/bash
#SBATCH --job-name=Functional_Variants_VCF
#SBATCH --partition=standard
#SBATCH -c 2
#SBATCH --mem 6g
#SBATCH -t 1:30:00
#SBATCH -o func_vars_output.o%j
#SBATCH -e func_vars_error.e%j


module load java
module load snpeff/5.0

java -jar $EBROOTGATK/snpEff/SnpSift.jar \
filter "(countVariant()<7)&((ANN[*].IMPACT has 'HIGH')|(ANN[*].IMPACT has 'MODERATE')|(ANN[*].IMPACT has 'LOW')|(ANN[*].EFFECT has 'MODIFIER'))" /global/home/sa103025/Testing_Ass5/merged_all_variants.snpeff.vcf > functionalVariants.vcf
