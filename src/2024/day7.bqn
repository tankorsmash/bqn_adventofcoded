data ← •file.Lines "../../samples/2024/day7.txt"
# data ↩ •file.Lines "../../samples/2024/day7_alt.txt"
# data ↩ •file.Lines "../../inputs/2024/day7.txt"


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

Id ← ⊢

PartOne ← {𝕊lines:
	Parse ← {𝕊line:
		raw_target‿raw_parts ← (+`':'⊸=¨)⊸⊔line
		target ← •ParseFloat raw_target
		parts ← •ParseFloat∘(1⊸↓)¨ 1↓ (+`' '⊸=¨)⊸⊔  1↓raw_parts

		target‿parts
	}

	parsed ← Parse¨ lines
	IsCalibrated ← {𝕊target‿parts:
		all_ops ← ⥊ (+‿×)∾⌜⍟(2-˜≠parts) (+‿×)
		"parsed"⊸Log¨ target‿parts
		# ops_grid ← ⥊⋈⌜˜ops
		# "ops_grid"⊸Log ops_grid
		"all_ops"⊸Log all_ops

		ApplyAllFuncs ← {𝕊funcs:
			•Out "--- Foo "∾50/"-"
			# "type funcs" Log •Type funcs
			# "dims/rank funcs " RLog =funcs
			# "funcs" Log funcs
			# "type funcs" RLog =funcs

			Apply ← {li‿lv𝕊ri‿rv:
				op ← ri⊑ ⥊>funcs
				"op" RLog op
				res ← lv Op rv
				"res"⊸RLog res
				li‿res
			}

			final_idx‿total ← Apply´ ⌽ ↕∘≠⊸(⋈¨)parts
			"total"⊸Log total

			# "res" Log •Bqn •Fmt ⌽ ∾ funcs≍˜¨ parts

		}

		totals ← ApplyAllFuncs˘ all_ops
		•Show totals
		is_valid ← ⌈´ target=totals
	}
	# IsCalibrated entry ← 1⊑ parsed
	+´⊑¨∘((IsCalibrated¨)⊸/) parsed
	# Run¨ parsed



	# •Show ({𝕊l‿r:
	# 	# "l, r" Log l‿r
	# 	{l 𝕏 r}¨ ops
	# })˘ windowed ← 2↕parts
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
