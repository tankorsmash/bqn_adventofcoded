data ← •file.Lines "../../samples/2023/day1.txt"
# data ↩ •file.Lines "../../samples/2023/day1_alt.txt"
data ↩ •file.Lines "../../inputs/2023/day1.txt"


Log ← {
	msg‿val ← 𝕩
	•Show msg‿val
	val
}

PartOne ← {
	raw_nums← ((•ParseFloat ⋈)⎊⟨⟩)¨¨ 𝕩
	# nums ← (∾ •Show )⎊{(•CurrentError @) ∾" - ERR: "∾(•Fmt •Repr 𝕩)}¨raw_nums
	nums ← (∾  )⎊⊢¨raw_nums
	# •Show¨ nums
	pairs← {⊏∾¯1⊸⊏}¨nums
	+´(•ParseFloat∘∾´∘(•Fmt¨)¨)˘ pairs
	# last←⊏⌽⥊((•ParseFloat ⋈)⎊⟨⟩)¨¨ 𝕩
	# •Show first‿last
}

PartTwo ← {
	𝕩
}

•Show "part 1: "‿(PartOne data)
# •Show "part 2: "‿(PartTwo data)
