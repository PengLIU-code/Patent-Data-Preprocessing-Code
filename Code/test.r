
# 逐个检查从1980到2022年的数据中是否存在空值？
# 循环从1980年到2022年
for(year in 1980:2022) {
  # 构建文件路径
  file_path <- sprintf("/home/bld/bld_data/pengliu/Graph data/Patent relation/patent_kg/cor_%d.RData", year)
  
  # 尝试加载文件，如果文件不存在则跳过
  if(file.exists(file_path)) {
    load(file_path)
    
    # 检查并打印是否存在NA值以及数据的维度
    cat(sprintf("Year %d: NA count = %d, Dimensions = ", year, sum(is.na(cor))), dim(cor), "\n")
  } else {
    cat(sprintf("Year %d: File does not exist\n", year))
  }
}