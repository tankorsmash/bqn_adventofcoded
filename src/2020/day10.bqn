data ← •file.Lines "../../samples/2020/day10.txt"
data ↩ •file.Lines "../../samples/2020/day10_alt.txt"
data ↩ •file.Lines "../../inputs/2020/day10.txt"

data ↩ 0∾ •ParseFloat¨ data

Log ← {
	msg‿val ← 𝕩
	•Show msg‿val
	val
}

PartOne ← {
	•Show (∧𝕩)
	•Show ones‿threes ← 1‿3⊏ ⊔ (»∧𝕩)-˜´∘∾¨(∧𝕩)
	(Log "ones"‿(≠ones))×(Log "threes"‿ (1+≠threes))
}

PartTwo ← {
	𝕩
}

•Show "part 1: "‿(PartOne data)
# •Show "part 2: "‿(PartTwo data)

