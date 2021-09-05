from recover_xls_data import *

###
# Let's start with the generic stuff
###
ws = read_worksheet(workbook="vendas-combustiveis-m3.xlsx", worksheet="Plan1")
# nms = pivot_names(ws)  # only used to check which ones we're working with
# print(nms)

###
# Sales of oil derivative fuels by UF and product - Tabela dinâmica1 -> index 3
###
pvt_cache = ws._pivots[3].cache
df1_aux = df_pivot(pvt_cache)
df1 = df1_aux[0]
dict_d = df1_aux[1]
Table1 = remap(df1, dict_d)
ex1 = build_schema(Table1)

###
# Sales of diesel by UF and type - Tabela dinâmica3 -> index 1
###
pvt_cache2 = ws._pivots[1].cache
df2_aux = df_pivot(pvt_cache2)
df2 = df2_aux[0]
dict_d2 = df2_aux[1]
Table2 = remap(df2, dict_d2)
ex2 = build_schema(Table2)


