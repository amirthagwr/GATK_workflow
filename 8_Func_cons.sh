#!/bin/bash
#SBATCH --job-name=Functional_Consequences2
#SBATCH --partition=standard
#SBATCH -c 1
#SBATCH --mem 8g
#SBATCH -t 30:00
#SBATCH -o Func_cons2_output.o%j
#SBATCH -e Func_cons2_error.e%j


module load java
module load StdEnv/2020
module load snpeff/5.0

java -jar $EBROOTSNPEFF/snpEff.jar -c $EBROOTSNPEFF/snpEff.config -v -no-intergenic -i vcf -o vcf hg19 Final_merged/merged_all_variants2.dbsnp.vcf > Final_merged/merged_all_variants2.dbsnp.snpeff.vcf  
