data ← •file.Lines "../../samples/2020/day7.txt"
# data ↩ •file.Lines "../../samples/2020/day7_alt.txt"
# data ↩ •file.Lines "../../inputs/2020/day7.txt"

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
	# •Out  ∾´ ⥊ ∾´ ((num/"-")‿(𝕩)‿(num/"-"))
	𝕩
	•Out  ∾´ ⥊ ∾´ ((num/"-")‿(•Repr 𝕩)‿(num/"-"))
}

PartOne ← {
	parent_child_pairs ← BreakIntoParentChildPairs 𝕩
	# •Show parent_child_pairs


	all_found_bags ← ⟨⟩

	containing_target ← ⟨⟩

	FindBags ← {

		target ← 𝕩
		# •Show 50/"-"
		# •Show "target"‿target

		bags_containing_target_mask ← (target⊸∊1⊸⊑)˘ parent_child_pairs
		# •Show ≢ bags_containing_target_mask

		containing_target ↩ ⊏˘ bags_containing_target_mask/parent_child_pairs
		# •Show "containing_target"‿containing_target

		found_new_containers ← (0≠≠ containing_target)
		{ found_new_containers ?
			{ all_found_bags ↩ ⍷all_found_bags ∾ containing_target}
			; 0
		}
		containing_target
	}
	new_bags ← ⟨"shiny gold", "shiny gold"⟩
	# new_bags ↩ FindBags˘ new_bags
	# new_bags ↩ ⍷ ⥊ FindBags˘ new_bags
	# new_bags ↩ ⍷ ⥊ FindBags˘ new_bags

	Massage ← {
		found ←  FindBags 𝕩
		# •Show "massaged"‿(≠found)‿found
		found
	}

	Body ← {
		# •Show "to finds"‿𝕩
		raw_new_bags ← ((<∘Massage)˘) 𝕩

		# •Show¨ raw_new_bags
		new_bags ↩ ⍷∘({ "shape"‿(≢𝕩)}⊢⊢) (∾⥊) raw_new_bags

		# •Show "new_bags"‿(≢new_bags)‿(new_bags)
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
	# •Show parent_child_pairs
	parent_scores ← (null∾˜ 0⊸⊏)˘ parent_child_pairs
	# •Show "scores"‿parent_scores

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


	ScaleValue ← {
		value ← 𝕨
		# scale the number of bags by the value
		(⊏∾(value⊸× 0⊑·> 1⊸⊏) )𝕩
	}

	ScaleTargetByValue ← {
		value ← 𝕨
		target ← 𝕩
		# •Show "target:"‿target

		mask ← (target≡·1⊸⊑1⊸⊑)˘ parent_child_pairs
		found_targets ← (mask/parent_child_pairs)
		res ← value ScaleValue ˘ found_targets
		•Show ["target"‿target, "res"‿res]
		# •Show ⟨"shape"‿(≢res), "depth"‿(≡res), "len"‿(≠res), "rank"‿(=res)⟩

		res
	}

	# Iter ← {
	# 	new_targets_and_values ← ∾ ((0≠≠¨)/⊢) <∘(1⊸⊑ ScaleTargetByValue ⊑)˘ 𝕩
	# 	res ← > Gather new_targets_and_values
  #
	# 	•Show "res"‿res
	# }


	targets ← ⟨"shiny gold"⟩
	# •Show (⊐⟜targets⊸⊏)˝ ⍉parent_child_pairs

	•Show ∘‿1⥊(1⊏⍉parent_child_pairs) ⊏˜(⊢/↕∘≠)(⊏⍉parent_child_pairs)∊ targets
	# •Show (⊢/↕∘≠)•Show (targets⊸∊ •Show )¨ ⟨"abc","def", 123⟩

	# •Show 32 -˜ (<'t')
	vowels ← "aeiou"

	RemVow ← ((¬ vowels⊸(∊˜))/⊢)
	Shorten ← {𝕊word:
		⍷((32⊸(-˜)⊏)∾((1⊸⊏∾¯1⊸⊏)∘RemVow))word
	}
	•Show ↑‿1⥊((Shorten(' '⊸≠)/⊢)¨ ((+` ' '⊸=)⊔⊢))¨⍷⊏˘ parent_child_pairs


	# new_targets_and_values ←  Iter targets_and_values
	# •Show "new1"‿(new_targets_and_values)
	# •Show 50/"-"


	Iter ← {𝕊target :
		(((/(target⊸≡)¨)·⊏⍉)(⥊1⊏·⍉⊏)⊢) parent_child_pairs
	}

	•Show matches ← Iter "shiny gold"
	 •Show ∾{count‿bag← >𝕩⋄< count/(⋈bag)}˘ matches

	# new_targets_and_values ↩ Iter new_targets_and_values
	# •Show "new2"‿(new_targets_and_values)
	# # •Show 50/"-"

	# new_targets_and_values ↩ Iter new_targets_and_values
	# •Show "new3"‿(new_targets_and_values)
	# # •Show 50/"-"

	# new_targets_and_values ↩ Iter new_targets_and_values
	# •Show "new4"‿(new_targets_and_values)
	# # •Show 50/"-"

	# new_targets_and_values ↩ Iter new_targets_and_values
	# •Show "new5"‿(new_targets_and_values)
	# # •Show 50/"-"

	# new_targets_and_values ↩ Iter new_targets_and_values
	# •Show "new6"‿(new_targets_and_values)
	# # •Show 50/"-"

	# new_targets_and_values ↩ Iter new_targets_and_values
	# •Show "new7"‿(new_targets_and_values)
	# # •Show 50/"-"

}

# PartOne data
PartTwo data
