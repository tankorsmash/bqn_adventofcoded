data ← •file.Lines "../../samples/2023/day3.txt"
# data ↩ •file.Lines "../../samples/2023/day3_alt.txt"
# data ↩ •file.Lines "../../inputs/2023/day3.txt"



digits← '0'+(↕10)

Log ← {msg𝕊val:
	•Show msg‿val
	val
}

PartOne ← {𝕊lines:
 # asdasd
 PerLine ← {𝕊line:
		is_digit ← ∨´˘ (≠line)‿∘⥊∾( digits⊸=)¨ line
		not_digits ← ¬ ∨´˘ (≠line)‿∘⥊∾( digits⊸=)¨ line
		not_dot ← ¬ ∨´˘ (≠line)‿∘⥊∾( "."⊸=)¨ line
		mask ← is_digit ⌈ 9⊸×¨ not_digits ∧ not_dot
		# •Show line
		mask
		shift ← (9⊸=«mask)⌈(9⊸=»mask)
		ones ← /1=mask
		valid ← (ones⊏shift)/ones
		zero2 ← (valid⊸(∊˜))˘ ↕≠mask

	}
#  •Show∘PerLine¨ lines
#  •Out 50 /"-"
#  •Show∘PerLine˘ >lines
#  •Out 50 /"-"
 horz ← PerLine˘  >lines
 vert ← ⍉⁼ PerLine˘ ⍉>lines
 •Show horz ⌈ vert
#  •Show∘PerLine 4⊑ lines
#  •Show +`1 = PerLine  "617*....12"
#  •Show +`1 = PerLine  3⊑¨ lines
}

PartTwo ← {𝕊lines:

	lines
}

"input"⊸Log¨ data
•Out 50/"-"

#alpha
# •Show ⍉3‿3⥊"abcdefghi"
"part 1: "‿(PartOne data)
# •Show "part 2: "‿(PartTwo data)
