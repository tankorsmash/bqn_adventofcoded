data ← •file.Lines "../../samples/2020/day7.txt"
# data ↩ •file.Lines "../../inputs/2020/day7.txt"

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
	raw_contained_bags ← StripCommas¨ ',' SplitBy ¯1↓(suffix_len)↓line
	# •Show "is a 'no other bags' bag?"‿(∊⟜raw_contained_bags⌾<"no other bags")
	•Show¨ only_bags ← ("no other bags"⊸≢¨/⊣)raw_contained_bags
	# •Show "is a 'no other bags' bag?"‿("no other bags" FindInString raw_contained_bags)
	# •Show [ "no other bags" ]∊raw_contained_bags

	•Show 50/"-"
	# •Show (+`' '=line)⊔line
}

# ParseBagLine¨ data

# data ↩ ⟨"2 dark red bags", "4 bright white bags","5 muted yellow bags."⟩
# •Show data
nums ← '0'+↕10

# Moves numbers to the start of the list
SplitNumbers ← {
	res ← > ¬⌈˝ nums⊸= 𝕩
}

# Removes the word "bags" from the body of a string, as many times as it exists
StripBags ← {
	𝕩
	# •Show "𝕩"‿𝕩
	to_strip ← " bags"
	# •Show ≠( 1≠/˜1⌈ to_strip ((1⊸-∘≠⊣)×⍷)𝕩)
	# •Show "len"‿(≠𝕩)

	# because ⍷ is always less than the to_strip, we need to append 1s
	# to make sure we dont accidentally remove the last chars
	padding ← (1˘↕(1-˜≠to_strip))
	# •Show to_strip ({1-˜≠to_strip}⊸×∘⍷)𝕩
	# •Show to_strip (1-˜≠to_strip)⊸×∘⍷𝕩
	# •Show "𝕩"‿𝕩
	# •Show "≠𝕩"‿(≠𝕩)
	# •Show "to_strip ⍷ 𝕩"‿(to_strip ⍷ 𝕩)
	mask← to_strip (≠to_strip)⊸×∘⍷𝕩
	# •Show "≠to_strip"‿(≠to_strip)
	# •Show "≠to_strip"‿(≠to_strip)
	# •Show ≠'0'+mask
	final_mask ← (≠𝕩)↑(1¨)/˜padding∾(1⌈ mask)
	# •Show ≠'0'+final_mask
	# •Show "final_mask" ‿(final_mask)
	# •Show "≠final_mask"‿(≠final_mask)
	# •Show " "
	res ← (final_mask/⊢)𝕩
	res
}


# res← {StripBags ('.'⊸≠/⊢)}⌾(1⊸⊑)¨ (((•Parsefloat⎊0) )⌾(⊑))¨ (SplitNumbers <∘⊔ >)˘ data
res← {
	split ← (SplitNumbers <∘⊔ >)˘ 𝕩
	#FIXME: contains all the numbers pulled together, so 1 bags and 2 bags
	# becomes 12 bags
	nums ← ((•Parsefloat⎊0 )⌾⊑)¨ split
	StripBags∘('.'⊸≠/⊢)⌾(1⊸⊑)¨ nums
} data
•Show¨ data
•Show¨ res


# •Show a←(≠"strings")↕"lots of strings"
# •Show b←("strings")⍷"lots of strings"

# MakePerson ← {
#  ⟨"John", 𝕩, "123 Main St."⟩
# }
#
# names ← ⟨"Mike", "John", "Sally"⟩
# ages ← ⟨23, 45, 32⟩
# addresses ← ⟨"123 Main St.", "456 Elm St.", "789 Oak St."⟩
#
# •Show names
# •Show ((<"John")∊names)⊏ages

