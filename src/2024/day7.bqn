data ← •file.Lines "../../samples/2024/day7.txt"
# data ↩ •file.Lines "../../samples/2024/day7_alt.txt"
data ↩ •file.Lines "../../inputs/2024/day7.txt"


# dyadic show but returns paired args
DShow ← {•Show 𝕨‿𝕩⋄ 𝕩}

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

	IsCalibrated ← {𝕊target‿parts:
		Apply ← {left_op‿lv𝕊right_op‿rv:
			res ← lv RightOp rv
			left_op‿res
		}

		ApplyAllFuncs ← {𝕊funcs:

			final_idx‿total ← Apply´ ⌽ (funcs ∾ {⊢})⊸(⋈¨)parts
			total
		}

		root_ops ← +‿×
		all_ops ← >˘ ⥊ root_ops∾⌜⍟(2-˜≠parts) root_ops
		totals ← ApplyAllFuncs˘ all_ops
		is_valid ← ⌈´ target=totals
	}

	parsed ← Parse¨ lines
	+´⊑¨ IsCalibrated¨⊸/ parsed
}

PartTwo ← {𝕊lines:
	Parse ← {𝕊line:
		raw_target‿raw_parts ← (+`':'⊸=¨)⊸⊔line
		target ← •ParseFloat raw_target
		parts ← •ParseFloat∘(1⊸↓)¨ 1↓ (+`' '⊸=¨)⊸⊔  1↓raw_parts

		target‿parts
	}

	IsCalibrated ← {𝕊target‿parts:
		Apply ← {left_op‿lv𝕊right_op‿rv:
			res ← lv RightOp rv
			left_op‿res
		}

		ApplyAllFuncs ← {𝕊funcs:
			final_idx‿total ← Apply´ ⌽ (funcs ∾ {⊢})⊸(⋈¨)parts
			total
		}

		Concat ← {
			left_str ← •Repr 𝕨
			right_str ← •Repr 𝕩
			•ParseFloat left_str∾˜right_str
		}
		root_ops ← +‿×‿concat
		all_ops ← >˘ ⥊ root_ops∾⌜⍟(2-˜≠parts) root_ops
		totals ← ApplyAllFuncs˘ all_ops
		is_valid ← ⌈´ target=totals
	}

	parsed ← Parse¨ lines
	+´⊑¨ IsCalibrated¨⊸/ parsed
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

# 1‿3749 SolutionValidator PartOne data
# 1‿4998764814652 SolutionValidator PartOne data

# 2‿11387 SolutionValidator PartTwo data
2‿37598910447546 SolutionValidator PartTwo data
