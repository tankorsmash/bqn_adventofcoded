cursor_eraseline ← 1⊑ •Sh "tput"‿"el" #fetch strings once
•Out cursor_eraseline ∾ 1⊑ •Sh "tput"‿"rmam" #disable linewrap, but only if you print it (I think)

data ← •file.Lines "../../samples/2025/day1.txt"
data ↩ •file.Lines "../../inputs/2025/day1.txt"

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
	starting_value ← 50
	ns ← •ParseFloat¨ (' '⊸≠)⊸/¨ {' '¨⌾(('R'⊸=𝕩)⊸/) '-'¨⌾(('L'⊸=𝕩)⊸/)𝕩}¨ data
	+´ 0= •Show starting_value (100⊸|∘+)` ns
}

PartTwo ← {𝕊lines:
	starting_value ← "starts   " RLog ⋈50
	"inputs" Rlog ns ← •ParseFloat¨ (' '⊸≠)⊸/¨ {' '¨⌾(('R'⊸=𝕩)⊸/) '-'¨⌾(('L'⊸=𝕩)⊸/)𝕩}¨ data
	# starting_value ← "starts   " RLog ⋈3
	# "inputs" Rlog ns ← ¯10‿7‿5
	Rotate ← {vals𝕊dir:
	 # val + dir

	 # "dir" RLog dir
	 # "val" RLog vals
	 vals∾ 1↓ 100| ( ¯1⊑ vals) + (×dir)×↕|dir
	}
	+´ are_zero← 0= "rotated" Rlog starting_value Rotate˜´ ⌽ ns
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
	err_msg!expected<answer
	•Show "Correctly solved Part "∾(•Fmt part)∾": "∾(•Fmt answer)
}

AtMostPartialSolutionValidator ← {part‿expected𝕊answer:
	err_msg ← ("Part "∾(•Fmt part)∾" is too high! Got instead: "∾(•Fmt answer))
	err_msg!expected> answer
	•Show "Correctly solved Part "∾(•Fmt part)∾": "∾(•Fmt answer)
}


"part 1: " Log PartOne data
# "part 2: " Log PartTwo data

# sample
# 1‿??? SolutionValidator PartOne data
# input
# 1‿??? SolutionValidator PartOne data

# sample
# 2‿6 SolutionValidator PartTwo data
2‿6620 AtLeastPartialSolutionValidator PartTwo data
# too low: 6620
# close: 6658
# too high: 6706
# input
# 2‿??? SolutionValidator PartTwo data
