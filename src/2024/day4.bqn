data ← •file.Lines "../../samples/2024/day4.txt"
# data ↩ •file.Lines "../../samples/2024/day4_alt.txt"
# data ↩ •file.Lines "../../inputs/2024/day4.txt"


Log ← {msg𝕊val:
	•Show msg‿val
	val
}

verbose ← 0
CLog ← {msg𝕊val:
	{verbose ? •Show msg‿val ; @}
	val
}

PartOne ← {𝕊lines:
	xmas ← "XMAS"
	CountXmas ← (+´(>xmas)⊸⍷)

	len ← ≠lines
	r_idxs ← {(»⍟𝕩 {𝕩⌾(0‿0⊸⍉)0⌜˜𝕩} len⥊1)}˘  ↕len
	rres ← ∾¨ {𝕩{𝕨<∘/(>𝕩)}˘lines}¨ r_idxs
	l_idxs ← {(«⍟𝕩 {𝕩⌾(0‿0⊸⍉)0⌜˜𝕩} len⥊1)}˘  1↓↕len
	lres ← ∾¨ {𝕩{𝕨<∘/(>𝕩)}˘lines}¨ l_idxs

	rr_idxs ← ⌽⍉⌽¨ {(»⍟𝕩 {𝕩⌾(0‿0⊸⍉)0⌜˜𝕩} len⥊1)}˘  ↕len
	rrres ← ∾¨ {𝕩{𝕨<∘/(>𝕩)}˘lines}¨ rr_idxs
	rl_idxs ← ⌽⍉⌽¨ {(«⍟𝕩 {𝕩⌾(0‿0⊸⍉)0⌜˜𝕩} len⥊1)}˘  1↓↕len
	rlres ← ∾¨ {𝕩{𝕨<∘/(>𝕩)}˘lines}¨ rl_idxs

	res ← [
		lr ← +´ CountXmas¨     lines
		rl ← +´ CountXmas¨ ⌽¨  lines
		tb ← +´ CountXmas˘   ⍉>lines
		bt ← +´ CountXmas˘ ⌽˘⍉>lines

		di ← +´ CountXmas¨    lres∾rres
		id ← +´ CountXmas¨ ⌽¨ lres∾rres
		dr ← +´ CountXmas¨    rlres∾rrres
		rd ← +´ CountXmas¨ ⌽¨ rlres∾rrres
	]

	+´ res
}

PartTwo ← {𝕊lines:
	mas ← "MAS"
	sam ← "SAM"

	len ← 3

	 # grids of Id Matrixes on an angle
	rightShift ← {»⍟𝕩 (len⥊1)⌾(0‿0⊸⍉) 0⌜˜ len⥊1}˘   ↕ len
	leftShift ←  {«⍟𝕩 (len⥊1)⌾(0‿0⊸⍉) 0⌜˜ len⥊1}˘ 1↓↕ len

	diag_idxs ←      (  ⌽  rightShift)∾(     leftShift)
	rev_diag_idxs ←  (⌽⍉⌽¨ rightShift)∾(⌽⍉⌽¨ leftShift)

	PerWindow ← {𝕊idx‿window:

		FindA ← {
			(1+ · / mas⊸⍷⌈sam⊸⍷)¨ ∾¨ (<∘/⟜>˘)⟜window¨ 𝕩
		}
		found_matches  ← FindA  diag_idxs
		found_rev_matches ← FindA rev_diag_idxs

		valid ←  ⊑ ⌊´ ≠¨ a_pos ← 2⊏ •Show (found_matches∾˘found_rev_matches)
	}

	grid ← >˘ lines
	windows ← ∾˝ len‿len↕grid

	# for i, val in enumerate(windows): print(val)
	+´ PerWindow˘ ((↕∘≠)⋈˘⊢)windows
	 # •Show PerWindow 123‿(56⊏windows)
}

SolutionValidator ← {part‿expected𝕊answer:
	err_msg ← ("Part "∾(•Fmt part)∾" is wrong! Got instead: "∾(•Fmt answer))
	err_msg!(expected= answer)
	•Show "Part "∾(•Fmt part)∾": "∾(•Fmt answer)
}

# •Show ⌽⍉⌽˘ 5‿5⥊  •Show @+97 + ↕26

•Show (5⥊'z')⌾(0‿0⊸⍉) 5‿5⥊ @+97 + ↕26

# "part 1: " Log PartOne data
# "part 2: " Log PartTwo data
# 1‿2530 SolutionValidator PartOne data
# 2‿1921 SolutionValidator PartTwo data

