data ← •file.Lines "../../samples/2024/day12.txt"
data ↩ •file.Lines "../../samples/2024/day12_alt.txt"
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

	mapped ← ((garden⊸=)⊸(⋈˜))¨unique_chars


	CheckArrPeri ← {𝕊arr:
		 # •Out ""
		# "arr" RLog arr

		shr ← ((1⊸«)∘(»⊸≠))⊸× arr
		"shr" RLog shr
		shl ← ((1⊸»)∘(«⊸≠))⊸× arr
		# "shl" RLog shl
		 shr +○(+´) shl
	}

	CheckArrGrouping ← {𝕊arr:
		 # •Out ""
		# "arr" RLog arr

		# if shifted(val) == 1 and val == 1
		# shr ← ((1⊸«)∘(»⊸≠))⊸× arr
		shr ← (1⊸= »)⊸× arr
		"grp shr" RLog shr
		shl ← (1⊸= «)⊸× arr
		# "shl" RLog shl
		 shr ⌈ shl
	}

	# Perimeter ← {𝕊plot:
	# 	# "rows"⊸RLog rows ← CheckArr 0‿0‿1‿0
	# 	# "row2"⊸RLog row2 ← CheckArr 0‿0‿1‿1
	# 	# "row3"⊸RLog row3 ← CheckArr 0‿0‿0‿1
  #
	# 	 •Out "rows RRR"
	# 	rows ← CheckArrPeri˘   plot
	# 	 •Out "cols CCC"
	# 	cols ← CheckArrPeri˘ ⍉ plot
  #
	# 	rows +○(+´) cols
	# }
	Group ← {𝕊plot:
		# "rows"⊸RLog rows ← CheckArr 0‿0‿1‿0
		# "row2"⊸RLog row2 ← CheckArr 0‿0‿1‿1
		# "row3"⊸RLog row3 ← CheckArr 0‿0‿0‿1

		 •Out "rows RRR"
		rows ← CheckArrGrouping˘   plot
		# "rows" Rlog rows
		 •Out "cols CCC"
		cols ← ⍉ CheckArrGrouping˘ ⍉ plot
		# "cols" Rlog cols

		group ← rows ⌈ cols
		"group" RLog group
		group
	}
	Area ← {𝕊char‿plot:
		area ← +´ +´˘ plot
		"area" RLog area
		area
	}

	•Show mapped

	# char‿plot ← 2⊑mapped
	# "plot" Log char‿plot

	# •Show Perimeter plot

	# "peris" RLog peris ← (Perimeter 1⊸⊑)¨ mapped
	# "peris" RLog peris ← (Group 1⊸⊑)¨ mapped
	peris ← (Group 1⊸⊑) 0⊑ mapped
	peris2 ← (Group 1⊸⊑) 1⊑ mapped
	areas ← (Area)¨ mapped

	+´ peris×areas

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


•Out 50/"-"
•Show ⥊ '.'=¨ ["M.S",".A.","M.S"] 
•Out 50/"-"

l←  ⟨⟨1,2,3,10⟩,⟨100,13,12,10⟩,⟨0,2,3, 10⟩⟩
# •Show {•Show -˝˘ •Show 2↕𝕩}¨l
d← >"SEMAsdsd"‿"gAZB5S5S"‿"SCMsSdAd"‿"1233fMfM"
# b ← (-↕≠d) ⌽˘ {𝕩∾' '¨𝕩}˘ d
# c ← (↕≠d) ⌽˘ {𝕩∾' '¨𝕩}˘ d
# # •Show d
r←((⍉∘⌽)⍟(↕4) d)
•Show {+´⥊ ∧´ {𝕩↑˜¨<⌊´≢¨𝕩} (2==)¨⊸/⥊ ["M.S",".A.","M.S"] {'.'𝕊𝕩:1; 𝕨=𝕩}¨ •Show ↓⟜𝕩¨ ↕3‿3} •Show 2⊑ r

# sample
# 1‿140 SolutionValidator PartOne data
# input
# 1‿??? SolutionValidator PartOne data

# sample
# 2‿??? SolutionValidator PartTwo data
# input
# 2‿??? SolutionValidator PartTwo data
