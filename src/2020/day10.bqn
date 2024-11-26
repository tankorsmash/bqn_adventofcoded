data ← •file.Lines "../../samples/2020/day10.txt"
# data ↩ •file.Lines "../../samples/2020/day10_alt.txt"
# data ↩ •file.Lines "../../inputs/2020/day10.txt"

data ↩ (3+⌈´)⊸∾ 0∾ •ParseFloat¨ data

Log ← {
	msg‿val ← 𝕩
	•Show msg‿val
	val
}

PartOne ← {
	•Show (∧𝕩)
	•Show ones‿threes ← 1‿3⊏ ⊔ (»∧𝕩)-˜´∘∾¨(∧𝕩)
	(Log "ones"‿(≠ones))×(Log "threes"‿ (≠threes))
}

PartTwo ← {
	•Show "data id"‿(5↑𝕩)
	# indices and (up to) the previous three indices
	•Show table_prev ← ⊑˘ 1↕ (¯1⊸+(⍷∘(𝕩⊸(∊˜)/⊢)0⊸⌈∘⌽∘-)(↕3˙))⊸(⋈˜)¨∧𝕩
	•Show table_next ← ⊑˘ 1↕ (1⊸+(⍷∘(𝕩⊸(∊˜)/⊢)0⊸⌈∘+)(↕3˙))⊸(⋈˜)¨∧𝕩
	•Show "diffs"‿(1⊸≠⊸/≠¨1⊏˘table_prev)

	•Show ∧𝕩

	#TODO: go through all the possible combinations backwards
}

# •Show "part 1: "‿(PartOne data)
•Show "part 2: "‿(PartTwo data)
