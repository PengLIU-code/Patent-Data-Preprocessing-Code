# Test loading RData file for 1980
load("/home/bld/bld_data/pengliu/cor_1980.RData")
expect_true(exists("cor"))