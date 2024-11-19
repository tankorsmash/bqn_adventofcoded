data ← •file.Lines "../../samples/2020/day10.txt"
# data ↩ •file.Lines "../../samples/2020/day10_alt.txt"
data ↩ •file.Lines "../../inputs/2020/day10.txt"

data ↩ •ParseFloat¨ data

Log ← {
	msg‿val ← 𝕩
	•Show msg‿val
	val
}

PartOne ← {
	𝕩
}

PartTwo ← {
	𝕩
}

•Show "part 1: "‿(PartOne data)
# •Show "part 2: "‿(PartTwo data)

