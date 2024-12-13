data ← •file.Lines "../../samples/2024/day5.txt"
# data ↩ •file.Lines "../../samples/2024/day5_alt.txt"
# data ↩ •file.Lines "../../inputs/2024/day5.txt"


Log ← {msg𝕊val:
	•Show msg‿val
	val
}

PartOne ← {𝕊lines:
	lines
}

PartTwo ← {𝕊lines:
	lines
}

SolutionValidator ← {part‿expected𝕊answer:
	err_msg ← ("Part "∾(•Fmt part)∾" is wrong! Got instead: "∾(•Fmt answer))
	err_msg!(expected= answer)
	•Show "Part "∾(•Fmt part)∾": "∾(•Fmt answer)
}

"part 1: " Log PartOne data
# "part 2: " Log PartTwo data
# 1‿2530 SolutionValidator PartOne data
# 2‿1921 SolutionValidator PartTwo data

