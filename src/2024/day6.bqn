data ← •file.Lines "../../samples/2024/day6.txt"
# data ↩ •file.Lines "../../samples/2024/day6_alt.txt"
# data ↩ •file.Lines "../../inputs/2024/day6.txt"


Log ← {msg𝕊val:
	•Show msg‿val
	val
}


chars ← "^>v<"
RotateGuard ← {𝕊char:
	new_char ← ((≠chars)|1+˜/char⍷chars)⊏chars
	⊑new_char
}

PartOne ← {𝕊lines:

	char ← ">"
	•Show RotateGuard char

	# "lines"⊸Log¨ lines

	input ← 5‿5⥊ @+97 + ↕26
	input ↩ >˘ lines
	•Show input
	Turn90 ← ⌽˘1⊸⍉
	input ↩ Turn90 input

	row‿col ← ((⊑·/ ≠¨)⋈(⊑∘(≠¨∾∘/⊢))) raw_cols ← <∘/˘ {⌈´∾˘chars⊸∊⋈𝕩}¨ input
	•Show RotateGuard ⌾ (row‿col⊸⊑) input
	lines
}

PartTwo ← {𝕊lines:
	lines
}

SolutionValidator ← {part‿expected𝕊answer:
	err_msg ← ("Part "∾(•Fmt part)∾" is wrong! Got instead: "∾(•Fmt answer))
	err_msg!(expected= answer)
	•Show "Correctly solved Part "∾(•Fmt part)∾": "∾(•Fmt answer)
}

"part 1: " Log PartOne data
# "part 2: " Log PartTwo data
# 1‿5329 SolutionValidator PartOne data
# 2‿5833 SolutionValidator PartTwo data

