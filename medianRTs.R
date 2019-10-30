#CogControl median RT data

#setting directory - in files, click "more" --> set as working directory
setwd("~/Dropbox/research/Holistic Processing/CogControl/CogControl/Pilot Data/FlankerData")

#loading in multiple files
FileNames<-list.files()
AllData<-data.frame()
for(j in FileNames){
  temp<-read.table(j,header=FALSE,sep="\t")
  fname<-rep(j,dim(temp)[1])  #includes filenames
  temp<-cbind(temp,fname) #attaches filenames
  print(j)
  AllData<-rbind(AllData,temp)
}

#add headers
heads<-c("sub","trial","task","target","distractor","cong","stim","corr","rt","resp","acc")
names(AllData)<-heads

#print item data
#setwd("~/Desktop")
#write.table(AllData, "AllData_out.txt",sep="\t",quote=FALSE,row.names=FALSE)

#correct trials only (for RT analysis)
AllData<-AllData[AllData$acc==1,]

#analysis using aggregate
#aggregate(DV~IV1*IV2,data,function)
M<-aggregate(rt~sub*task*cong,AllData,median)

#save output
#setwd("~/Desktop")
#write.table(M,"Stroop_out.txt",sep="\t",quote=FALSE,row.names=FALSE)

#test reshaping data from long to wide; row var, cat var, value
#library(reshape2)
#t<-dcast(M, sub~task*cong,value.var="rt")
#write.table(t,"Stroop_MedRT_wideout",sep="\t",quote=FALSE,row.names=FALSE)

#add variable for even/odd
split<-AllData$trial %% 2
AllData<-cbind(AllData,split)
S<-aggregate(rt~sub*task*split*cong,AllData,median)

#save output
setwd("~/Desktop")
library(reshape2)
t<-dcast(S, sub~task*split*cong,value.var="rt")
write.table(t,"Flanker_SplitHalf_wideout",sep="\t",quote=FALSE,row.names=FALSE)









