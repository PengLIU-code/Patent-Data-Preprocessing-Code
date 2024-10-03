library(lsa)
library(dplyr) # 加载 dplyr 包

patent_cpc_data <- read.csv("/home/bld/bld_data/pengliu/Graph data/Patent relation/patent_Gen_new/patent_cpc_data.csv")
years<-seq(1980,2022,1)
for (year in years){
  
  data<-patent_cpc_data%>%filter(year_issue>=year-5 & year_issue<=year-1)%>%
    group_by(permno,cpc_g2)%>%
    mutate(number=n())%>%
    select(cpc_g2,permno,number)%>%ungroup()%>%
    distinct(permno,cpc_g2,.keep_all = T)
  
  
  permno<-data%>%distinct(permno)%>%arrange(permno)
  cpc_g2<-data%>%distinct(cpc_g2)%>%filter(cpc_g2!="NA")
  
  
  
  data_year<-merge(cpc_g2,permno,all=T)%>%arrange(permno,cpc_g2)%>%left_join(data,by=c("permno","cpc_g2"))
  
  for (i in 1:nrow(data_year)){
    if (is.na(data_year$number[i])) {data_year$number[i]<-0}
  }
  
  data_year_reshape<-reshape(data_year,direction = "wide",idvar = "cpc_g2",timevar="permno")
  
  data_sum<-colSums(data_year_reshape[,2:ncol(data_year_reshape)])
  
  data_year_share<-data_year_reshape[,2:ncol(data_year_reshape)]
  
  for (i in 1:nrow(data_year_reshape)){
    data_year_share[i,]<-data_year_reshape[i,2:ncol(data_year_reshape)]/data_sum
  }
  
  S = t(data_year_share) %*% as.matrix(data_year_share)
  
  cos.sim.2 <- function(ix) { 
    i <- ix[1] 
    j <- ix[2] 
    return( S[i,j]/sqrt(S[i,i]*S[j,j]) ) 
  }
  
  n<-ncol(data_year_share)
  cmb <- expand.grid(i=1:n, j=1:n) 
  cor<- matrix(apply(cmb,1,cos.sim.2),n,n)
  
  colnames(cor)<-as.matrix(permno)
  rownames(cor)<-as.matrix(permno)
  
  filename<-paste("cor_",year,".RData",sep="")
  save(cor,file = filename)
}
