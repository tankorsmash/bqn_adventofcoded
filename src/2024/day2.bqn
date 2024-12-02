data ← •file.Lines "../../samples/2024/day2.txt"
# data ↩ •file.Lines "../../samples/2024/day2_alt.txt"
data ↩ •file.Lines "../../inputs/2024/day2.txt"

Log ← {msg𝕊val:
	•Show msg‿val
	val
}

# turns "1 2 3" into ⟨1 2 3⟩
Parse ← (' '⊸≠(•ParseFloat∘/)⊢)¨ ((+`∘(' '⊸=))(⊔)⊢)

PartOne ← {𝕊lines:
		parsed ← Parse¨ lines
		parsed

		sorted ← ((∨≡⊢)⌈(∧≡⊢))¨ parsed
		equals ← (¯1⊸↓)∘ ((≠´)¨)∘((¯1⊸⊑⊸« )⋈˜¨⊢)¨ parsed
		diffs ← (¯1⊸↓)∘((((3⊸(≤˜))⌊(1⊸(≥˜)))∘|-´)¨((¯1⊸⊑⊸« )⋈˜¨⊢))¨ parsed


		IsValid ←	(⌊´ · ⌊´¨ ⥊¨)
		# •Show "sorted"‿"equals"‿"diffs"
		•Show total← +´ (IsValid∘∾)¨ (sorted⋈¨equals⋈¨diffs)
		# •Show (1⊸⊑)¨ (sorted‿equals‿diffs)
		# •Show IsValid (1⊑sorted)‿(1⊑equals)‿(1⊑diffs)

		# •Show       ⊑parsed
		# •Show (¯1⊸⊑⊸« ) ⊑parsed
		# foo ← ⊑parsed

		total
}

PartTwo ← {𝕊lines:
	lines
}

•Out 50/"-"
"part 1: " Log (PartOne data)
# "part 2: " Log (PartTwo data)
