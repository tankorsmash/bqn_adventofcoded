data ← •file.Lines "../../samples/2025/day2.txt"
# data ↩ •file.Lines "../../samples/2025/day2_alt.txt"
data ↩ •file.Lines "../../inputs/2025/day2.txt"
data ↩ ∾data

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
	"data"RLog data
	# (•Show∘(•ParseFloat¨))¨ (1⊸↓⌾(1⊸⊑))¨ (+`'-'⊸=)⊸⊔¨ (','⊸≠)⊸/¨ (+`','⊸=)⊸⊔ data
	"ranges" Rlog 4‿↑⥊ ranges←•ParseFloat⚇1 (1⊸↓⌾(1⊸⊑))¨ (+`'-'⊸=)⊸⊔¨ (','⊸≠)⊸/¨ (+`','⊸=)⊸⊔ data
	•Show +´ •ParseFloat¨ ((÷⟜2∘≠¨)(↑≡↓)¨⊢)⊸/ (0=2|≠¨)⊸/ •Repr¨ ∾ {𝕨+↕ 𝕨¬˜𝕩}´¨ ranges
	•Show "ASD"
	•Exit 0
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


"part 1: " Log PartOne data
# "part 2: " Log PartTwo data

# sample
# 1‿??? SolutionValidator PartOne data
# input
# 1‿??? SolutionValidator PartOne data

# sample
# 2‿??? SolutionValidator PartTwo data
# input
# 2‿??? SolutionValidator PartTwo data
