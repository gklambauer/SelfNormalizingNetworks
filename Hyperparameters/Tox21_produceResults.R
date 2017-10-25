setwd("Tox21")
library(data.table)
library(xtable)

finalTable <- c()
layers <- c(2,3,4,6,8,16,32)

### SELU
ff <- list.files(pattern="SELU_\\d")
#layers <- unique(xx$V6)
perfMatrix <- matrix(NA, nrow=length(layers),ncol=length(ff))
rownames(perfMatrix) <- layers
colnames(perfMatrix) <- paste0("replicate",1:length(ff))
perfMatrix <- round(perfMatrix,10)

for (i in 1:length(ff)){
    xx <- fread(ff[i],header=FALSE, stringsAsFactors=FALSE,data.table=FALSE)
    xx <- xx[order(xx$V6,-xx$V30),]
    if (any(xx$V20 == 0)) browser()
        
    for (j in 1:length(layers)){
           xxS <- xx[xx$V6==layers[j], ]
           perfMatrix[j,i] <- xxS$V32[1]
    }
}
        
finalTable <- rbind(finalTable,paste(format(apply(perfMatrix*100,1,mean),digits=3), '\\pm', format(apply(perfMatrix*100,1,sd),digits=1) ) )

rownames(finalTable) <- c("SELU")
colnames(finalTable) <- layers


xtable(finalTable)



