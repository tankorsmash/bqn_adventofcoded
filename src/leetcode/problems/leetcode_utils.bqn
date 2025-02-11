newline ← @+10
SolutionValidator ⇐ {expected𝕊answer:

	max_length ← expected ⌈○(≠•Fmt)  answer
	err_msg ← ("Wrong!
Expected: "∾newline∾({»⍟(max_length⊸-≠𝕩) max_length⊸↑𝕩} •Fmt expected)∾"
  Actual: "∾newline∾({»⍟(max_length⊸-≠𝕩) max_length⊸↑𝕩} •Fmt answer))∾"
"
	err_msg!(expected≡ answer)
	•Show "Correctly solved: "∾(•Fmt answer)
}

# dyadic show but returns paired args
DShow ⇐ {•Show 𝕨‿𝕩⋄ 𝕩}

Log ⇐ {msg𝕊val:
	•Show (<msg)∾val
	val
}
RLog ⇐ {msg𝕊val:
	•Show (msg)⋈val
	val
}

