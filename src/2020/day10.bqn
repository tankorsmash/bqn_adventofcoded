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
	•Show 4↑𝕩
	# (»∧𝕩)∾¨(∧𝕩)
	# indices and (up to) the previous three indices
	•Show 1↕ (¯1⊸+(⍷∘(𝕩⊸(∊˜)/⊢)0⊸⌈∘⌽∘-)(↕3˙))⊸(⋈˜)¨∧𝕩
	•Show ∧𝕩
	•Show 190∊𝕩

	#TODO: go through all the possible combinations backwards
}

•Show "part 1: "‿(PartOne data)
•Show "part 2: "‿(PartTwo data)
