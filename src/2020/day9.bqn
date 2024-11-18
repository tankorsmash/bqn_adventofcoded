data ← •file.Lines "../../samples/2020/day9.txt"
pre_len ← 5
# data ↩ •file.Lines "../../samples/2020/day9_alt.txt"
# data ↩ •file.Lines "../../inputs/2020/day9.txt"
# pre_len ↩ 25

data ↩ •ParseFloat¨ data

Log ← {
	msg‿val ← 𝕩
	•Show msg‿val
	val
}

# •Show 0⊏((<2⊸↕)⋈¨⊢)⟨"a", "b", "c", "d", "e", "f"⟩
•Show  (1↓«d)⋈˜˘2↕ d←⟨"a", "b", "c", "d", "e", "f"⟩
PartOne ← {
	𝕩
	# pre_len↓ (pre_len↕𝕩)
	# 𝕩 ⋈˘ (pre_len↕𝕩)
}

PartTwo ← {
	𝕩
}


•Show "part 1: " PartOne data
