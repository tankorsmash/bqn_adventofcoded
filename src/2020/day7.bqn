data ← •file.Lines "../../samples/2020/day7.txt"
# data ← •file.Lines "../../inputs/2020/day7.txt"

SplitBy ← (+`∘=⊔⊢)

ParseBagLine ← {
	𝕩
	# line ← "this is my pop tains"
	line ← 30↑𝕩

	# •Show ⍉[line,line]
	to_remove ← " contain "
	mask ← 1⌈(≠to_remove)×(to_remove⍷line)
	•Show (¬1≠(mask/mask))/line
	# •Show line
}

ParseBagLine¨ data

