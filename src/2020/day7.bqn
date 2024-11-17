data ← •file.Lines "../../samples/2020/day7.txt"
data ↩ •file.Lines "../../samples/2020/day7_alt.txt"
data ↩ •file.Lines "../../inputs/2020/day7.txt"

Log ← {
	msg‿val ← 𝕩
	•Show msg‿val
	val
}


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
	Gather ← +`(×⎊•Show)¬
	Split ← ((0⊸≠∘≠¨)/⊢)((⊢-˜Gather)⊸⊔)

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
BreakIntoParentChildPairs ← {
	bags ← ParseBagNew¨ 𝕩

	ConcatChildren ← {
		container‿children ← 𝕩
		((<container)⊸∾∘<)¨ children

	}
	parent_child_pairs ← ∾⥊˘ (>ConcatChildren)¨ bags
	parent_child_pairs
}

Sep ← {
	num ← 10
	𝕩
	•Out  ∾´ ⥊ ∾´ ((num/"-")‿(•Repr 𝕩)‿(num/"-"))
}

PartOne ← {
	parent_child_pairs ← BreakIntoParentChildPairs 𝕩

	all_found_bags ← ⟨⟩

	containing_target ← ⟨⟩

	FindBags ← {

		target ← 𝕩

		bags_containing_target_mask ← (target⊸∊1⊸⊑)˘ parent_child_pairs

		containing_target ↩ ⊏˘ bags_containing_target_mask/parent_child_pairs

		found_new_containers ← (0≠≠ containing_target)
		{ found_new_containers ?
			{ all_found_bags ↩ ⍷all_found_bags ∾ containing_target}
			; 0
		}
		containing_target
	}
	new_bags ← ⟨"shiny gold", "shiny gold"⟩

	Massage ← {
		found ←  FindBags 𝕩
		found
	}

	Body ← {
		raw_new_bags ← ((<∘Massage)˘) 𝕩

		new_bags ↩ ⍷∘({ "shape"‿(≢𝕩)}⊢⊢) (∾⥊) raw_new_bags

		new_bags
	}

	Condition ← {
		𝕩
		# •Show "loop check"
		res ← 0≠≠ new_bags
		res
	}
	Body •_while_ Condition new_bags

	all_found_bags
	•Show ≠all_found_bags

}

Gather ← {∧((⊏⊏)∾(+´1⊏⍉))¨ ((⊐⊏˘)⊔⊢) 𝕩}
null ← @+0

PartTwo ← {
	parent_child_pairs ← BreakIntoParentChildPairs 𝕩
	parent_scores ← (null∾˜ 0⊸⊏)˘ parent_child_pairs

	# normalize the no other bags to 0 value
	NormalizeNoOther ← {
		bag_name‿· ← 𝕩
		((⋈"no other")≡(1⊑𝕩))
		? ⟨bag_name, 0⋈"no other"⟩
		; 𝕩
	}
	parent_child_pairs ↩ NormalizeNoOther˘ parent_child_pairs
	•Show parent_child_pairs


	total_contained ← 0


	targets ← ⟨"shiny gold"⟩
	# •Show (⊐⟜targets⊸⊏)˝ ⍉parent_child_pairs

	•Show ∘‿1⥊(1⊏⍉parent_child_pairs) ⊏˜(⊢/↕∘≠)(⊏⍉parent_child_pairs)∊ targets
	vowels ← "aeiou"

	# RemVow ← ((¬ vowels⊸(∊˜))/⊢)
  #
	# Shorten ← {𝕊word:
	# 	•Show word
	# 	⍷((32⊸(-˜)⊏)∾((1⊸⊏∾¯1⊸⊏)∘RemVow))word
	# }
	# •Show ↑‿1⥊((Shorten(' '⊸≠)/⊢)¨ ((+` ' '⊸=)⊔⊢))¨⍷⊏˘ parent_child_pairs


	old_targets ← ⟨⟩
	total_children ← 1
	Iter ← {𝕊target :
		old_targets ↩ old_targets∾(<target)
		matches ← (((/(target⊸≡)¨)·⊏⍉)(⥊1⊏·⍉⊏)⊢) parent_child_pairs
		total_children ↩ total_children + (≠matches)
		matches
	}
	SplitIter ← {
		count‿bag← 𝕩
		⥊ count/(⋈bag)
	}

	targets ↩ {
		∾ ⥊ SplitIter¨ · ∾´ Iter¨ 𝕩}•_while_(0≠≠) targets

	# •Show old_targets
	•Show "solution:"‿(1-˜ ≠old_targets)


}

# PartOne data
PartTwo data
