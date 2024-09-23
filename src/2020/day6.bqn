data ← •file.Lines "../../samples/2020/day6.txt"
# data ← •file.Lines "../../inputs/2020/day6.txt"

SplitBy ← (+`∘=⊔⊢)

# •Show data
mask ← 0=≠∘>˘ data
rows ← +` mask
# •Show "mask"‿mask
# •Show "rows"‿rows

grouped_data ←  (¯1¨⌾(mask⊸/)rows)⊔data
•Show grouped_data

# •Show (¬mask)/data
# •Show (¬mask)/data

# x0¨⌾(b1⊸/)y1











