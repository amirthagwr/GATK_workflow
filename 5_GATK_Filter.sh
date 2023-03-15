#!/bin/bash
#SBATCH --job-name=GATK_Filtration
#SBATCH --partition=standard
#SBATCH -c 2
#SBATCH --mem 15g
#SBATCH -t 4:30:00
#SBATCH -o GATK_filt_output.o%j
#SBATCH -e GATK_filt_error.e%j


module load java
module load nixpkgs/16.09
module load gatk/4.1.2.0

refpath=home/hpcxxxx/reference_files/hg19/chr22
cd $PWD

mkdir GATK_Filter

for file in $(ls variant_Calls/); do
filename=${file:0:7}
java -jar $EBROOTGATK/gatk-package-4.1.2.0-local.jar VariantFiltration \
-R /global/home/sa103025/Testing_Ass5/human.g1k.v37.chr22.fa \
--variant variant_Calls/${filename}.sort.rmdup.bam.vcf \
-O GATK_Filter/${filename}.sort.rmdup.bam.filter.vcf \
--filter-expression "QD < 2.0" \
--filter-expression "FS > 200.0" \
--filter-expression "MQ < 40.0" \
--filter-name "QDFilter" \
--filter-name "FSFilter" \
--filter-name "MQFilter"
done
