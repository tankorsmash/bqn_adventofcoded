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

# turns ⟨1 2 3 4⟩ into ⟨ ⟨1 2 3⟩ ⟨1 2 4⟩ ⟨1 3 4⟩ ⟨2 3 4⟩ ⟩
SparsePick ← {𝕩⊸(/˜)˘ ≠⌜˜↕ ≠𝕩}

PartOne ← {𝕊lines:
		parsed ← Parse¨ lines

		sorted ← ((∨≡⊢)⌈(∧≡⊢))¨ parsed
		equals ← ¯1⊸↓ ∘ (≠´¨)∘(¯1⊸⊑⊸« ⋈˜ ¨⊢)¨ parsed
		diffs ← ¯1⊸↓ ∘ (((≤⟜3 ⌊ ≥⟜1)∘|-´)¨ ¯1⊸⊑⊸« ⋈˜¨ ⊢)¨ parsed

		IsValid ←	(⌊´ · ⌊´¨ ⥊¨)
		total← +´ (IsValid∘∾)¨ (sorted⋈¨equals⋈¨diffs)
		(1⊸⊑)¨ sorted‿equals‿diffs

		total
}

PartTwo ← {𝕊lines:
		parsed ← Parse¨ lines


		Run ← {func𝕊line:
			Func˘ SparsePick line
		}

		IsSorted ← ((∨≡⊢)⌈(∧≡⊢))
		IsValidDiff ←	⌊´ ∘ (¯1⊸↓) ∘ (((≤⟜3 ⌊ ≥⟜1)∘| -´)¨ (¯1⊸⊑⊸« ⋈˜¨ ⊢))

		verbose ↩ 0
		is_sorteds ← isSorted Run¨ parsed
		is_diff_valids ← isValidDiff Run¨ parsed

		num ← ≠parsed
		num↑ parsed
		total← +´ ( ⌈´¨ · 2⊸=∘+˝ ⊑)˘ num↑ <˘⍉[is_sorteds, is_diff_valids]

		total
}


"Part 1 is wrong!"!472= "part 1: " Log PartOne data
"Part 2 is wrong!"!520= "part 2: " Log PartTwo data
