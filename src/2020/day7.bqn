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

# find which character is a digit character
IsNonNumericChar ← {
	nums ← '0'+↕10
	res ← >¬⌈˝ nums= 𝕩
}
# •Show IsNonNumericChar <"99i 2 am 55 years old"

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
	JoinFunc ← ParseAllNumbers∾(<∘DropLeadingSpace IsNonNumericChar∘</⊢)
	children ← (JoinFunc DropLeadingSpace)¨ comma_mask Split raw_children
	container‿children
}


# which bags can eventually contain a shiny gold bag?
PartOne ← {
	bags ← ParseBagNew¨ 𝕩

	ConcatChildren ← {
		container‿children ← 𝕩
		((<container)⊸∾∘<)¨ children

	}
	•Show ∾⥊˘ (>ConcatChildren)¨ bags
}


PartOne data

# •Show ParseBagNew ⊑ data



# ParseAllNumbers "29 men 1 can, 0 parents"

