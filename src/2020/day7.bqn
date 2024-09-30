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
	((padding∾˜ ¬ 1≠/˜1⌈ to_strip ((1⊸-˜∘≠⊣)×⍷)𝕩)/⊢)𝕩
}

# qwe ← " bags"
# •Show [1]∾(0˘↕(1-˜≠qwe))

(•Show)¨  {StripBags ('.'⊸≠/⊢)1⊸↓𝕩}⌾(1⊸⊑)¨ (((•Parsefloat⎊0) )⌾(⊑))¨ (SplitNumbers <∘⊔ >)˘ data

# •Show [3, 3, 3]/"abc"

# text ← "cake is cake. yet, cake is not cake!"
# text ↩ "cake"
# •Show  "cake"⍷text
# •Show  "masked len:"‿(≠ "cake"⍷text)
# •Show  text
# •Show  "text len:"‿(≠text)
#
# •Show 50/"-"
# •Show "cake" ⍷ "cake! i am cake."
# •Show "⟨1 0 0 0 0 0 0 0 0 0 0 1 0⟩"

# •Show ((∞⊸≠↕∘≠)/⊣) ↕10

# •Show (<(¬+´∘(nums⊸=) ))˘ data


# text ← "hello mr bags, how are you?"
# •Show StripBags text

# arr ← ⟨⟨123, "a b c"⟩, ⟨456, "d e f"⟩⟩
# •Show (1⊸↓)⌾(1⊸⊑)¨ arr
