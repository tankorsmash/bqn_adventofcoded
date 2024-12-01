data ← •file.Lines "../../samples/2024/day1.txt"
num_len ← 1
# data ↩ •file.Lines "../../samples/2024/day1_alt.txt"
data ↩ •file.Lines "../../inputs/2024/day1.txt"
num_len ↩ 5


spacing ← 3

Log ← {msg𝕊val:
	•Show msg‿val
	val
}

PartOne ← {𝕊lines:

	line ←  ⊑lines
	Pf ← •ParseFloat
	nums ← ((Pf  num_len⊸↑)⋈(Pf (-num_len)⊸↑))¨ lines
	•Show "nums: "‿nums

	# "lines" Log lines
	# "nums" Log nums
	sorted_nums ←  ∘‿2⥊ ((∧⊏˘)∾˘(∧1⊸⊏˘)) ∘‿2⥊∾nums
	sorted_nums
	+´ |∘-˜´˘ sorted_nums
}

PartTwo ← {𝕊lines:

	line ←  ⊑lines
	Pf ← •ParseFloat
	nums ← ((Pf  num_len⊸↑)⋈(Pf (-num_len)⊸↑))¨ lines
	•Show "nums: "‿nums

	# "lines" Log lines
	# "nums" Log nums
	lefts ←>⊏¨ nums
	rights ←>1⊏¨ nums

	fl ← ⊑lefts
	+´ {𝕩 × +´ 𝕩 = rights}¨ lefts
}

# •Show (-1)↑ 2⊑data

•Out 50/"-"

# "part 1: "Log (PartOne data)
"part 2: "Log (PartTwo data)
