data ← •file.Lines "../../samples/2020/day6.txt"
# data ← •file.Lines "../../inputs/2020/day6.txt"

SplitBy ← (+`∘=⊔⊢)

•Show data
•Show 50/"-"
mask ← 0=≠∘>˘ data
rows ← +` 0=≠∘>˘ data
•Show "mask"‿mask
•Show "rows"‿rows

# •Show (¬mask)/data
# •Show (¬mask)/data

n ← ↕5
m ← [100, 200, 300, 400, 500]


# x0¨⌾(b1⊸/)y1
•Show (¯1¨⌾(mask⊸/)rows)⊔data

# •Show (¬mask)/data

•Show n⌈(m×2=n)
neg_mask ←¯1×mask
•Show rows ⌊neg_mask
