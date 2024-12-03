data ← •file.Lines "../../samples/2024/day2.txt"
# data ↩ •file.Lines "../../samples/2024/day2_alt.txt"
data ↩ •file.Lines "../../inputs/2024/day2.txt"


Log ← {msg𝕊val:
	•Show msg‿val
	val
}

verbose ← 0
CLog ← {msg𝕊val:
	{verbose ? •Show msg‿val ; @}
	val
}

# turns "1 2 3" into ⟨1 2 3⟩
Parse ← (' '⊸≠(•ParseFloat∘/)⊢)¨ ((+`∘(' '⊸=))(⊔)⊢)

# •Show∘Parse¨ 10↑500↓ data
# •Exit 0

SparsePick ← {𝕩⊸(/˜)˘ ≠⌜˜↕ ≠𝕩}

PartOne ← {𝕊lines:
		parsed ← Parse¨ lines
		"Parsed"Log parsed

		"sorted?" Log sorted ← ((∨≡⊢)⌈(∧≡⊢))¨ parsed
		"equals?" Log equals ← (¯1⊸↓)∘ ((≠´)¨)∘((¯1⊸⊑⊸« )⋈˜¨⊢)¨ parsed
		"diffs? " Log diffs ← (¯1⊸↓)∘((((3⊸(≤˜))⌊(1⊸(≥˜)))∘|-´)¨((¯1⊸⊑⊸« )⋈˜¨⊢))¨ parsed


		IsValid ←	(⌊´ · ⌊´¨ ⥊¨)
		•Show "sorted"‿"equals"‿"diffs"
		•Show total← +´ (IsValid∘∾)¨ (sorted⋈¨equals⋈¨diffs)
		•Show (1⊸⊑)¨ (sorted‿equals‿diffs)
		# •Show IsValid (1⊑sorted)‿(1⊑equals)‿(1⊑diffs)

		# •Show       ⊑parsed
		# •Show (¯1⊸⊑⊸« ) ⊑parsed
		# foo ← ⊑parsed

		total
}

PartTwo ← {𝕊lines:
		parsed ← Parse¨ lines
		# "Parsed"Log parsed


		Run ← {func𝕊line:
			# •Out 50/"-"
			( (Func )˘ SparsePick)line
			}

		IsSorted ← ((∨≡⊢)⌈(∧≡⊢))
		# IsSamed ← ⌊´ ∘ (≠´¨) ∘ (¯1⊸↓) ∘ (¯1⊸⊑⊸« ⋈˜¨ ⊢)
		IsValidDiff ←	⌊´ ∘ (¯1⊸↓) ∘ (((3⊸(≤˜)⌊1⊸(≥˜))∘|-´)¨ (¯1⊸⊑⊸« ⋈˜¨ ⊢))

		# line ← "line" Log ⟨8, 11, 14, 16, 15⟩
		# # line ← "line" Log 5⊑ parsed
		# short_sorted ← "isSorted" Log isSorted Run line
		# # "isSamed" Log isSamed Run line
		# short_diff ← "isValidDiff" Log isValidDiff Run line
		# # "is samed" Log IsSamed ⟨8,6,4,4,1⟩
		# # "short dubs" Log (≠¨⊔)¨ ⊑ <⍉⟨short_sorted,short_diff⟩
		# "short dubs" Log ⌈´¨ 2=(+)˝ ⊑ <⍉⟨short_sorted,short_diff⟩
		# •Exit 0

		# verbose ↩ 0
		# "sorted?" Log is_sorteds ← (isSorted⊸Run ) line
		# "same ?" Log is_same ← (isSamed⊸Run) line
		# verbose ↩ 1
		# "diffs? " Log is_diff_valids ← (isValidDiff⊸Run) line

		verbose ↩ 0
		is_sorteds ← isSorted(Run ¨) parsed
		# is_same ← isSamed(Run¨) parsed
		is_diff_valids ← isValidDiff(Run¨) parsed

		num ← ≠parsed
		"Parsed"Log num↑ parsed
		•Show "sorted"‿"diffs"
		# "paired"⊸Log¨ paired← (num↑parsed)⊸(⋈¨) (⌊´¨⋈¨⊢) "dubs"⊸Log˘ num↑ <˘⍉[is_sorteds,is_diff_valids]
		# total← +´ ("sing"⊸Log ∘ 2⊸= (+˝))˘ "trips" Log num↑ <˘⍉[is_sorteds,is_diff_valids]
		total← +´ ("sing"⊸Log  {⌈´¨ 2=(+)˝𝕩} ⊑)˘ "trips" Log num↑ <˘⍉[is_sorteds,is_diff_valids]

		total
}

# RunProcessing ← +´
# •Show line ← Parse ⊑data
# # •Show  Parse ⊑data
# •Show 13∊ RunProcessing˘ SparsePick line

# "part 1: " Log (PartOne data)
"part 2: " Log (PartTwo data)
