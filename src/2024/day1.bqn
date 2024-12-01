data ← •file.Lines "../../samples/2024/day1.txt"
num_len ← 1


Log ← {msg𝕊val:
	•Show msg‿val
	val
}

Parse ← {𝕊lines:
	Pf ← •ParseFloat
	nums ← ((Pf  num_len⊸↑)⋈(Pf (-num_len)⊸↑))¨ lines
}

PartOne ← {𝕊lines:
	sorted_nums ←  ∘‿2⥊ (∧∘(⊏˘)∾˘∧∘(1⊸⊏˘)) ∘‿2⥊∾ Parse lines
	+´ |∘-˜´˘ sorted_nums
}

PartTwo ← {𝕊lines:
	nums ← Parse lines
	right_nums ← >1⊏¨ nums
	+´ {𝕩 × +´ right_nums⊸=𝕩}¨ >⊏¨ nums
}

"part 1: "Log (PartOne data)
"part 2: "Log (PartTwo data)
