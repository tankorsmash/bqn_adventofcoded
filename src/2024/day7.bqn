data ← •file.Lines "../../samples/2024/day7.txt"
# data ↩ •file.Lines "../../samples/2024/day7_alt.txt"
# data ↩ •file.Lines "../../inputs/2024/day7.txt"


Log ← {msg𝕊val:
	•Show (<msg)∾val
	val
}
RLog ← {msg𝕊val:
	•Show (msg)⋈val
	val
}


PartOne ← {𝕊lines:
	Parse ← {𝕊line:
		raw_target‿raw_parts ← (+`':'⊸=¨)⊸⊔line
		target ← •ParseFloat raw_target
		parts ← •ParseFloat∘(1⊸↓)¨ 1↓ (+`' '⊸=¨)⊸⊔  1↓raw_parts

		target‿parts
	}

	•Show Parse¨ lines
}

PartTwo ← {𝕊lines:
	∞
}

SolutionValidator ← {part‿expected𝕊answer:
	err_msg ← ("Part "∾(•Fmt part)∾" is wrong! Got instead: "∾(•Fmt answer))
	err_msg!(expected= answer)
	•Show "Correctly solved Part "∾(•Fmt part)∾": "∾(•Fmt answer)
}

AtLeastPartialSolutionValidator ← {part‿expected𝕊answer:
	err_msg ← ("Part "∾(•Fmt part)∾" is too low! Got instead: "∾(•Fmt answer))
	•Show expected‿answer
	"expected is < answer" Log expected<answer
	err_msg!(expected< answer)
	•Show "Correctly solved Part "∾(•Fmt part)∾": "∾(•Fmt answer)
}

AtMostPartialSolutionValidator ← {part‿expected𝕊answer:
	err_msg ← ("Part "∾(•Fmt part)∾" is too hight! Got instead: "∾(•Fmt answer))
	•Show expected‿answer
	"expected is > answer" Log expected>answer
	err_msg!(expected< answer)
	•Show "Correctly solved Part "∾(•Fmt part)∾": "∾(•Fmt answer)
}

# "part 1: " Log PartOne data
# "part 2: " Log PartTwo data
1‿3749 SolutionValidator PartOne data
# 2‿??? SolutionValidator PartTwo data
