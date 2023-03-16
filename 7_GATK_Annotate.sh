#!/bin/bash
#SBATCH --job-name=GATK_Annotate
#SBATCH --partition=standard
#SBATCH -c 2
#SBATCH --mem 15g
#SBATCH -t 4:30:00
#SBATCH -o GATK_anno2_output.o%j
#SBATCH -e GATK_anno2_error.e%j


module load java
module load nixpkgs/16.09
module load gatk/4.1.2.0

cd $PWD

mkdir Final_merged
refpath=home/hpcxxxx/reference_files/hg19/chr22

java -jar $EBROOTGATK/gatk-package-4.1.2.0-local.jar VariantAnnotator \
-R ${refpath}/human.g1k.v37.chr22.fa \
--dbsnp ${refpath}/dbsnp_135.b37.chr22.vcf.gz \
--variant Final_merged/merged_all_variants2.vcf \
-O Final_merged/merged_all_variants2.dbsnp.vcf
