data ← •file.Lines "../../samples/2020/day6.txt"
# data ← •file.Lines "../../inputs/2020/day6.txt"

SplitBy ← (+`∘=⊔⊢)


UniqueChars ← {
	joined ← ∾´𝕩
	(∊/⊢) joined
}

PartOne ← {
	UniqueChars¨ 𝕩
}

# •Show data
mask ← 0=≠∘>˘ data
rows ← +` mask
# •Show "mask"‿mask
# •Show "rows"‿rows

grouped_data ←  (¯1¨⌾(mask⊸/)rows)⊔data
•Show PartOne grouped_data
