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
		is_digit ← ∨´˘ (≠line)‿∘⥊∾ digits⊸=¨ line
		not_digits ← ¬ ∨´˘ (≠line)‿∘⥊∾ digits⊸=¨ line
		not_dot ← ¬ ∨´˘ (≠line)‿∘⥊∾ "."⊸=¨ line
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

# •Show (↕≠)⊸(⋈˜¨˘)↕∘≠˘ >⟨".+.", "2..", "3.."⟩
offsets ← ⥊ 1-˜ (↕≠)⊸(⋈˜¨˘)↕∘≠˘ 3‿3⥊↕3
# •Show offsets
num ← ≠data
coords ← ⋈¨ ⥊ (↕≠)⊸(⋈˜¨˘)↕∘≠˘ num‿num⥊↕num
# •Show coords
paired ← (∾ data)⋈¨ coords

Foo ← {𝕊char‿coord:
	 char‿coord
	 adj← ((offsets˘⊸+) coord)⊑  >data
	 symbols ← (¬ digits⊸(∊˜))⊸/ ('.'⊸≠)¨⊸/ ⍷∧ ⥊ >data
	 ⌈´˘ (symbols⊸(∊˜))  adj
}
"res1" Log Foo 40⊑ paired

max ← ≠data
FindSymbol ← {𝕊char‿coord:
	 adj←  ((((1-˜max)⊸⌊0⊸⌈¨)¨· (offsets˘⊸+) coord)⊸⊑)  >data
	 symbols ←  (¬ digits⊸(∊˜))⊸/ ('.'⊸≠)¨⊸/ ⍷∧ ⥊ >data
	 ⌈´˘ (symbols⊸(∊˜))  adj
}

# •Show ⟨⟨0‿4⟩,⟨1‿5⟩, ⟨19999‿9999⟩⟩˘⊸+⟨⟨2‿4⟩⟩⊸⊑⎊["."] >data
"res" Log FindSymbol (3+(max×0))⊑ paired

# "part 1: "‿(PartOne data)
# •Show "part 2: "‿(PartTwo data)
