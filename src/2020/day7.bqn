data ← •file.Lines "../../samples/2020/day7.txt"
# data ← •file.Lines "../../inputs/2020/day7.txt"

SplitBy ← (+`∘=⊔⊢)

ParseBagLine ← {
	𝕩
	# line ← "this is my pop tains"
	line ← (≠𝕩 ∘ ⌊ 80)↑𝕩

	# •Show ⍉[line,line]
	to_remove ← " contain "
	mask ← 1⌈(≠to_remove)×(to_remove⍷line)
	# •Show (¬1≠(mask/mask))/line

	prefix_len ← (/to_remove⍷line)
	suffix_len ← (≠to_remove)+prefix_len

	•Show prefix_len↑line
	•Show suffix ← ¯1↓suffix_len↓line

	•Show 80/"-"
	# •Show (+`' '=line)⊔line
}

ParseBagLine¨ data

