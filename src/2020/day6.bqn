# data ← •file.Lines "../../samples/2020/day6.txt"
data ← •file.Lines "../../inputs/2020/day6.txt"

UniqueChars ← {
	joined ← ∾´𝕩
	(∊/⊢) joined
}

PartOne ← {
	+´ ≠¨ UniqueChars¨ 𝕩
}

mask ← 0=≠∘>˘ data
rows ← +` mask
grouped_data ←  (¯1¨⌾(mask⊸/)rows)⊔data
•Show PartOne grouped_data
