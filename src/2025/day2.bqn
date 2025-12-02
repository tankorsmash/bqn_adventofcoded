cursor_eraseline ← 1⊑ •Sh "tput"‿"el" #fetch strings once
•Out cursor_eraseline ∾ 1⊑ •Sh "tput"‿"rmam" #disable linewrap, but only if you print it (I think)

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
	# "data"RLog data
	ranges←•ParseFloat⚇1 (1⊸↓⌾(1⊸⊑))¨ (+`'-'⊸=)⊸⊔¨ (','⊸≠)⊸/¨ (+`','⊸=)⊸⊔ data
	+´ •ParseFloat¨ ((÷⟜1∘≠¨)(↑≡↓)¨⊢)⊸/ (0=2|≠¨)⊸/ •Repr¨ ∾ {𝕨+↕ 𝕨¬˜𝕩}´¨ ranges
}

PartTwo ← {𝕊lines:
	F ← {d𝕊x:
		len ← ≠x
		mask←∾⟜((-⟜1 len)⥊0)⍟{ 1<  len} x⍷d
		expected← (1⌾⊑(len)⥊0)⥊˜len×(≠d)÷len
		mask≡expected
	}

	# "data"RLog data
	ranges←•ParseFloat⚇1 (1⊸↓⌾(1⊸⊑))¨ (+`'-'⊸=)⊸⊔¨ (','⊸≠)⊸/¨ (+`','⊸=)⊸⊔ data
	•Show "ranges"
	nums ← ∾ {𝕨+↕ 𝕨¬˜𝕩}´¨ ranges
	"max nums" RLog ⌈´ nums
	•Show "nums"
	res ← +´ {0≠≠ d⊸F¨⊸/ ((⌊÷⟜2≠d)⊸≥ ≠¨)⊸/ 1↓↑ d←•Repr 𝕩}¨⊸/ nums
	•Show "res"
	res

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
# 1‿29940924880 SolutionValidator PartOne data
# input
# 1‿??? SolutionValidator PartOne data

# too high: 18363057543840
# sample
# 2‿4174379265 SolutionValidator PartTwo data
# input
2‿48631958998 SolutionValidator PartTwo data
