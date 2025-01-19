data ← •file.Lines "../../samples/2024/day12.txt"
# data ↩ •file.Lines "../../samples/2024/day12_alt.txt"
# data ↩ •file.Lines "../../inputs/2024/day12.txt"

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
	•Out˘ garden← >lines
	•Out "--"
	unique_chars ← ⍷ ∾lines

	•Show mapped ← ((garden⊸=)⊸(⋈˜))¨unique_chars

	char‿plot ← 2⊑mapped
	"plot" Log char‿plot


	CheckArr ← {𝕊arr:
		 •Out ""
		# "arr" RLog arr

		shr ← +´ ((1⊸«)∘(»⊸≠))⊸× arr
		# "shr" RLog shr
		shl ← +´ ((1⊸»)∘((≠⟜«)))⊸× arr
		# "shl" RLog shl
		 shr + shl
	}

	# "rows"⊸RLog rows ← CheckArr 0‿0‿1‿0
	# "row2"⊸RLog row2 ← CheckArr 0‿0‿1‿1
	# "row3"⊸RLog row3 ← CheckArr 0‿0‿0‿1

	"rows"⊸RLog rows ← CheckArr˘   plot
	"cols"⊸RLog cols ← CheckArr˘ ⍉ plot
	# "eql"⊸RLog eql ← ('B'⊸=) first_col
	123
}

PartTwo ← {𝕊lines:
	∞
}

SolutionValidator ← {part‿expected𝕊answer:
	max_length ← expected ⌈○(≠•Fmt)  answer
	err_msg ← ("
Part "∾(•Fmt part)∾" is wrong!"∾"
Expected: "∾({»⍟(max_length⊸-≠𝕩) max_length⊸↑𝕩} •Fmt expected)∾"
  Actual: "∾({»⍟(max_length⊸-≠𝕩) max_length⊸↑𝕩} •Fmt answer))∾"
"
	err_msg!(expected= answer)
	•Show "Correctly solved Part "∾(•Fmt part)∾": "∾(•Fmt answer)
}

AtLeastPartialSolutionValidator ← {part‿expected𝕊answer:
	err_msg ← ("Part "∾(•Fmt part)∾" is too low! Got instead: "∾(•Fmt answer))
	err_msg!(expected≥ answer)
	•Show "Correctly solved Part "∾(•Fmt part)∾": "∾(•Fmt answer)
}

AtMostPartialSolutionValidator ← {part‿expected𝕊answer:
	err_msg ← ("Part "∾(•Fmt part)∾" is too high! Got instead: "∾(•Fmt answer))
	err_msg!(expected< answer)
	•Show "Correctly solved Part "∾(•Fmt part)∾": "∾(•Fmt answer)
}


# "part 1: " Log PartOne data
# "part 2: " Log PartTwo data

# sample
1‿140 SolutionValidator PartOne data
# input
# 1‿??? SolutionValidator PartOne data

# sample
# 2‿??? SolutionValidator PartTwo data
# input
# 2‿??? SolutionValidator PartTwo data
