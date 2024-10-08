data ← •file.Lines "../../samples/2020/day7.txt"
# data ↩ •file.Lines "../../inputs/2020/day7.txt"

SplitBy ← (+`∘=⊔⊢)

# from bqncrate
FindInString ← {∊⟜𝕩⌾<𝕨}

# remove substring from string
StripSubstring ← {
	full_find ← 𝕨(≢∘⊢↑⍷)𝕩
	sub_range ← ↕≠𝕨
	full_range ← ↕≠𝕩

	# characters not in the substring
	mask ← full_range ¬∘∊⥊ (sub_range⊸+)˘ full_find/full_range
	mask/𝕩
}

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

# find which character is a digit character
IsNonNumericChar ← {
	nums ← '0'+↕10
	res ← >¬⌈˝ nums= 𝕩
}
# •Show IsNonNumericChar <"99i 2 am 55 years old"


TryToParseBags ← {
	split ← (IsNonNumericChar <∘⊔ >)˘ 𝕩
	#FIXME: contains all the numbers pulled together, so 1 bags and 2 bags
	# becomes 12 bags
	nums ← ((•Parsefloat⎊0 )⌾⊑)¨ split
	StripBags ← " bags"⊸StripSubstring
	StripBags∘('.'⊸≠/⊢)⌾(1⊸⊑)¨ nums
}

TryToParseBags data

MarkAllowed ← {
	full_find ← 𝕨(≢∘⊢↑⍷)𝕩
	sub_range ← ↕≠𝕨
	full_range ← ↕≠𝕩

	# characters not in the substring
	mask ← full_range ¬∘∊⥊ (sub_range⊸+)˘ full_find/full_range
}


ParseAllNumbers ← {
	# 1s where a digit is found
	mask ← (¬IsNonNumericChar < 𝕩)
	# start index and end index of each number within the string
	bounds ← ∘‿2⥊/0 (∾≠∾˜) mask
	# the start index plus its offset
	join ← (⊏∾-˜´)˘bounds
	# each index in the string a digit is at
	idxs ← (<↕∘(1⊸⊑)+˘⊑)˘join
	# pull out each char at each index, and parse the whole number
	parsed ←(•ParseFloat ⊏⟜𝕩 )¨idxs
	parsed
}

ParseBagNew ← {
	# mostly from bqnrate, splits on mask 𝕨
	Split ← ((0⊸≠∘≠¨)/⊢)((⊢-˜+`×¬)⊸⊔)

	# run many precleaners on the input
	preclean ← 𝕩 StripSubstring´ ⟨".", " bag", " bags"⟩

	mask ← ¬" contain " MarkAllowed preclean
	container‿raw_children← (mask) Split preclean

	comma_mask ← ¬ "," MarkAllowed raw_children
	# •Show comma_mask

	DropLeadingSpace ← ((' '=⊏)↓⊢)
	JoinFunc ← (ParseAllNumbers)∾(<(DropLeadingSpace (IsNonNumericChar<)/⊢))
	children ← (JoinFunc DropLeadingSpace)¨ comma_mask Split raw_children
	container‿children
}




•Show ParseBagNew ⊑ data



# ParseAllNumbers "29 men 1 can, 0 parents"

