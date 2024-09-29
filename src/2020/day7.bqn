data ← •file.Lines "../../samples/2020/day7.txt"
# data ← •file.Lines "../../inputs/2020/day7.txt"

SplitBy ← (+`∘=⊔⊢)

# from bqncrate
FindInString ← {∊⟜𝕩⌾<𝕨}

ParseBagLine ← {
	𝕩

	# line ← "this is my pop tains"
	line ← •Show ((≠𝕩) ⌊ 100)↑𝕩

	# •Show ⍉[line,line]
	to_remove ← " contain "
	mask ← 1⌈(≠to_remove)×(to_remove⍷line)
	# •Show (¬1≠(mask/mask))/line

	bags ← "bags"

	prefix_len ← (/to_remove⍷line)
	suffix_len ← (≠to_remove)+prefix_len

	StripCommas ← {
		raw_bag ← 𝕩
		starts_with_comma ←  ','=⊏raw_bag
		without_comma ← (starts_with_comma × 1)↓raw_bag

		starts_with_space ←  ' '=⊏without_comma
		(starts_with_space × 1)↓without_comma
	}

	# •Show prefix_len↑line
	•Show raw_contained_bags ← StripCommas¨ ',' SplitBy ¯1↓(suffix_len)↓line
	# •Show "is a 'no other bags' bag?"‿(∊⟜raw_contained_bags⌾<"no other bags")
	is_no_other ← "no other bags"∊raw_contained_bags
	# •Show "is a 'no other bags' bag?"‿("no other bags" FindInString raw_contained_bags)
	# •Show [ "no other bags" ]∊raw_contained_bags

	•Show 50/"-"
	# •Show (+`' '=line)⊔line
}

ParseBagLine¨ data
