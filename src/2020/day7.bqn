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

# ParseBagLine¨ data

# data ↩ ⟨"2 dark red bags", "4 bright white bags","5 muted yellow bags."⟩
# •Show data

# Moves numbers to the start of the list
SplitNumbers ← {
	nums ← '0'+↕10
	res ← >¬⌈˝ nums= 𝕩
}


TryToParseBags ← {
	split ← (SplitNumbers <∘⊔ >)˘ 𝕩
	#FIXME: contains all the numbers pulled together, so 1 bags and 2 bags
	# becomes 12 bags
	nums ← ((•Parsefloat⎊0 )⌾⊑)¨ split
	StripBags ← " bags"⊸StripSubstring
	StripBags∘('.'⊸≠/⊢)⌾(1⊸⊑)¨ nums
}
res ← TryToParseBags data
# •Show¨ res

MarkAllowed ← {
	full_find ← 𝕨(≢∘⊢↑⍷)𝕩
	sub_range ← ↕≠𝕨
	full_range ← ↕≠𝕩

	# characters not in the substring
	mask ← full_range ¬∘∊⥊ (sub_range⊸+)˘ full_find/full_range
}



ParseBagNew ← {
	# mostly from bqnrate, splits on mask 𝕨
	Split ← ((0⊸≠∘≠¨)/⊢)((⊢-˜+`×¬)⊸⊔)

	# run many precleaners on the input
	preclean ← 𝕩 StripSubstring´ ⟨".", " bags", " bag"⟩

	mask ← ¬" contain " MarkAllowed preclean
	container‿raw_children← (mask) Split preclean

	comma_mask ← ¬ "," MarkAllowed raw_children
	•Show comma_mask

	DropLeadingSpace ← ((' '=⊏)↓⊢)
	children ← DropLeadingSpace¨ (comma_mask) Split raw_children
	container‿children
}
•Show ParseBagNew ⊑ data



ParseAllNumbers ← {
	# 1s where a digit is found
	mask ← (¬SplitNumbers < 𝕩)
	# start index and end index of each number within the string
	bounds ← ∘‿2⥊/0 (∾≠∾˜) mask
	# the start index plus its offset
	•Show "join"‿(join ← (⊏∾-˜´)˘bounds)
	# each index in the string a digit is at
	•Show "idxs"‿(idxs ← (<↕∘(1⊸⊑)+˘⊑)˘join)
	# pull out each char at each index, and parse the whole number
	parsed ←(•ParseFloat ⊏⟜𝕩 )¨idxs
	parsed
}
# ParseAllNumbers "29 men 1 can, 0 parents"

# •Show a←(≠"strings")↕"lots of strings"
# •Show b←("strings")⍷"lots of strings"


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

