data ← •file.Lines "../../samples/2023/day3.txt"
# data ↩ •file.Lines "../../samples/2023/day3_alt.txt"
# data ↩ •file.Lines "../../inputs/2023/day3.txt"



digits← '0'+(↕10)

Log ← {msg𝕊val:
	•Show msg‿val
	val
}

PartOne ← {𝕊lines:
 PerLine ← {𝕊line:
		is_digit ← ∨´˘ (≠line)‿∘⥊∾( digits⊸=)¨ line
		not_digits ← ¬ ∨´˘ (≠line)‿∘⥊∾( digits⊸=)¨ line
		not_dot ← ¬ ∨´˘ (≠line)‿∘⥊∾( "."⊸=)¨ line
		res ← is_digit ⌈ 9⊸×¨ not_digits ∧ not_dot
		•Show line
		"res" Log res
		"«  " Log (9⊸=«res)⌈(9⊸=»res)
		
		res
	}
#  •Show∘PerLine¨ lines
#  •Show∘PerLine 4⊑ lines
 •Show +`1 = PerLine  "617*....12"
}

PartTwo ← {𝕊lines:

	lines
}

"input"⊸Log¨ data
•Out 50/"-"
# # line ← ⟨1,1,1,9,0,1,1,1,0,0 ⟩
# line ← 4⊑data
# "line"Log line
# •Show (9⊸=«line)
# •Show (9⊸=»line)
# •Show  ∨´˘ (≠line)‿∘⥊∾(digits⊸=)¨ line
•Show "part 1: "‿(PartOne data)
# •Show "part 2: "‿(PartTwo data)
