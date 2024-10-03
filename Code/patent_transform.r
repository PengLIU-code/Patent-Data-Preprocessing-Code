
# 同样的，将循环将 1980-2022年的数据转换成csv格式并保存
for (i in 1980:2022) {
  load(paste0('/home/bld/bld_data/pengliu/Graph data/Patent relation/patent_Gen_new/cor_', i, '.RData'))
  cor <- as.data.frame(cor)
  write.csv(cor, file = paste0('/home/bld/bld_data/pengliu/Graph data/Patent relation/patent_table2/cor_', i, '.csv'), row.names = TRUE)
}
