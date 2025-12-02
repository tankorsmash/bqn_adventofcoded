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
	# •Show (msg)⋈val
	val
}
"x"Rlog x←"1"
"d"Rlog d← "121212"
# "x"Rlog x←"12"
# "d"Rlog d← "121212"
# "x"Rlog x←"abc"
# "d"Rlog d← "abcabc"
F ← {d𝕊x: 
"len x"Rlog ≠ x
"mask" Rlog mask←∾⟜((-⟜1≠x)⥊0)⍟{ 1<  ≠x} "prem" Rlog x⍷d
"expe" Rlog expected← (1⌾⊑(≠x)⥊0)⥊˜( (≠x)×(≠d)÷(≠x))
"is valid?" Rlog mask≡ expected
}
# "121212" F "12"



PartOne ← {𝕊lines:
	"data"RLog data
	ranges←•ParseFloat⚇1 (1⊸↓⌾(1⊸⊑))¨ (+`'-'⊸=)⊸⊔¨ (','⊸≠)⊸/¨ (+`','⊸=)⊸⊔ data
	+´ •ParseFloat¨ ((÷⟜1∘≠¨)(↑≡↓)¨⊢)⊸/ (0=2|≠¨)⊸/ •Repr¨ ∾ {𝕨+↕ 𝕨¬˜𝕩}´¨ ranges
}

PartTwo ← {𝕊lines:
	"data"RLog data
	ranges←•ParseFloat⚇1 (1⊸↓⌾(1⊸⊑))¨ (+`'-'⊸=)⊸⊔¨ (','⊸≠)⊸/¨ (+`','⊸=)⊸⊔ data
	nums ← ∾ {𝕨+↕ 𝕨¬˜𝕩}´¨ ranges
	# •Show¨ {0≠≠ {r←+´𝕩⍷d⋄((≠d)=r×≠𝕩)}¨⊸/ ((⌊÷⟜2≠d)⊸≥ ≠¨)⊸/ 1↓↑ d←•Repr 𝕩}¨⊸/ nums
	# •Show {0≠≠ {r←"r"Rlog +´"mask"Rlog𝕩⍷d⋄("valid" Rlog (≠d)=r× "len x"Rlog ≠𝕩)}¨⊸/ •Show ((⌊÷⟜2≠d)⊸≥ ≠¨)⊸/ 1↓↑ •Show d←•Repr 𝕩}¨ ⋈565659
	+´ {0≠≠ d⊸F¨⊸/ ((⌊÷⟜2≠d)⊸≥ ≠¨)⊸/ 1↓↑ d←•Repr 𝕩}¨⊸/ nums

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
"part 2: " Log PartTwo data

# sample
# 1‿29940924880 SolutionValidator PartOne data
# input
# 1‿??? SolutionValidator PartOne data

# too high: 18363057543840
# sample
# 2‿??? SolutionValidator PartTwo data
# input
# 2‿??? SolutionValidator PartTwo data
