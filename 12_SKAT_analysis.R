library(SKAT)
library(qqman)

###Skat Analysis
##Perform the below functions on each SNP dataset to be analyzed

#Phenotype file
fam <- read.table("SKAT_input_file.fam", header = F)

#plink binary format files
File.Bed <- "./SKAT_input_file.bed"
File.Bim <- "./SKAT_input_file.bim"
File.Fam <- "./SKAT_input_file.fam"
File.SetID <- "./uniqueGenes.SetID"
File.SSD <-"./SSD.SSD"
File.Info <- "./SSD.Info"

Generate_SSD_SetID(File.Bed, File.Bim, File.Fam, File.SetID, File.SSD, File.Info)

FAM<-Read_Plink_FAM(File.Fam, Is.binary=TRUE)
y<-FAM$Phenotype

SSD.INFO<-Open_SSD(File.SSD, File.Info)
SSD.INFO$nSample
SSD.INFO$nSets

obj<-SKAT_Null_Model(y ~ 1, out_type="D")

#Rare and Common weighted the same 
out<-SKAT.SSD.All(SSD.INFO, obj, weights.beta=c(0.5,0.5))

#adjust p-values with FDR
out$results$FDR_P<-p.adjust(out$results$P.value, method = 'fdr', n=length(out$results$SetID))
out$results

#Rare and Common weighted differently
out2 <- SKAT_CommonRare.SSD.All(SSD.INFO, obj, weights.beta.rare=c(1,25), weights.beta.common=c(0.5,0.5))

#adjust p-values with FDR
out2$results$FDR_P<-p.adjust(out2$results$P.value, method = 'fdr', n=length(out2$results$SetID))
out2$results

Close_SSD()


###Q-Q Plots

#Create Q-Q plot for first SKAT model
pdf("QQ_plot.pdf")
p <-out$results
qq(p$P.value, main='Q-Q Plot')
dev.off()

#Create Q-Q plot for second SKAT model
pdf("QQ_plot.pdf")
p2 <-out2$results
qq(p2$P.value, main='Q-Q Plot')
dev.off()
