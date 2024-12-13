data ← •file.Lines "../../samples/2024/day4.txt"
# data ↩ •file.Lines "../../samples/2024/day4_alt.txt"
data ↩ •file.Lines "../../inputs/2024/day4.txt"


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
	•Out 50/"-"
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
	CountXmas ← (+´(>mas)⊸⍷)

	PerWindow ← {𝕊idx‿window:

		FindA ← {
			mases ← (1+ · / mas⊸⍷)¨∾¨ (<∘/⟜>˘)⟜window¨ 𝕩
			samses ← (1+ · / sam⊸⍷)¨∾¨ (<∘/⟜>˘)⟜window¨ 𝕩
			mases∧∘∾¨samses
		}
		RightShift ← {»⍟𝕩 (len⥊1)⌾(0‿0⊸⍉)  0⌜˜ len⥊1}
		LeftShift ← {«⍟𝕩 (len⥊1)⌾(0‿0⊸⍉)  0⌜˜ len⥊1}

		len ← ≠window
		r_idxs ← (⌽ RightShift˘  ↕len)∾(LeftShift˘  1↓↕len)
		rres  ← FindA r_idxs

		rr_idxs ←  ⌽( ⌽⍉⌽¨ RightShift˘  ↕len)∾(⌽⍉⌽¨ LeftShift˘  1↓↕len)
		rrres ← FindA rr_idxs

		 valid ←  ⊑ ⌊´ ≠¨ a_pos ← 2⊏ (rres∾˘rrres)
	}


	grid ← >˘ lines
	windows ← ∾˝ 3‿3↕grid

	+´ PerWindow˘ ((↕∘≠)⋈˘⊢)windows
	# •Show PerWindow 123‿(56⊏windows)
}

•Out 50/"-"

SolutionValidator ← {part‿expected𝕊answer:
	err_msg ← ("Part "∾part∾" is wrong! Got instead: "∾(•Fmt answer))
	err_msg!expected= answer
	•Show "Part "∾(•Fmt part)∾": "∾(•Fmt answer)
}


# "part 1: " Log PartOne data
# "part 2: " Log PartTwo data
1‿2530 SolutionValidator PartOne data
2‿1921 SolutionValidator PartTwo data
