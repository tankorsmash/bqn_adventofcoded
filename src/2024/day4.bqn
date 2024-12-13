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



•Out 50/"-"

PartOne ← {𝕊lines:
	xmas ← "XMAS"
	•Out "orig"
	# (•Show )¨ lines
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
		"LR total" Log +´ CountXmas¨     lines
		"RL total" Log +´ CountXmas¨ ⌽¨  lines
		"TB total" Log +´ CountXmas˘   ⍉>lines
		"BT total" Log +´ CountXmas˘ ⌽˘⍉>lines

		"DI total" Log +´ CountXmas¨    lres∾rres
		"ID total" Log +´ CountXmas¨ ⌽¨ lres∾rres
		"DR total" Log +´ CountXmas¨    rlres∾rrres
		"RD total" Log +´ CountXmas¨ ⌽¨ rlres∾rrres
	]
	# "BT total"⊸Log˘ (((>xmas)⊸⍷)∘⍉)˘ ⌽>lines
	# •Out 50/"-"
	•Show +´ res
}

PartTwo ← {𝕊lines:
	mas ← "MAS"
	sam ← "SAM"
	•Out "orig"
	# (•Show )¨ lines
	•Out 50/"-"
	CountXmas ← (+´(>mas)⊸⍷)

	# lines ↩ 5‿5⥊ >lines
	# "lines"Log lines

	PerWindow ← {𝕊idx‿window:
		# "idx" Log ⊑idx
		# "window" Log window

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

		# •Show r_idxs
		# •Show rr_idxs

		# "rres" Log rres
		# "rrres" Log rrres

		 valid ←  ⊑ ⌊´ ≠¨ a_pos ← 2⊏ (rres∾˘rrres)
		# "valid cross" Log valid

	}


	# # grid ← 5‿5⥊ @+97 + ↕26
	# •Show ≢data
	grid ← >˘ lines
	# "grid" Log grid
	windows ← ∾˝ 3‿3↕grid
	# "windows" Log windows

	+´ PerWindow˘ ((↕∘≠)⋈˘⊢)windows
	# •Show PerWindow 123‿(56⊏windows)
	# •Show PerWindow 10⊏windows

	# window ← lines

}

# •Show input ← "zMASyMASaMASMAS"
# •Show rres ← 1+ / "MAS"⍷input
# •Show rev_input ← "zMbSyMAScMASMAS"
# •Show lres ← 1+ / "MAS"⍷rev_input

# •Out 50/"-"
# •Show /˜ lres ∊ rres
# •Show /˜ lres ∊˜ rres
# •Out 5/"-"
# •Show lres /∘∊  rres
# •Show lres /∘(∊˜) rres
# •Show ≠⊑lres ((/˜∊)⋈(/˜∊˜)) rres
•Out 50/"-"

#  •Show¨ 0⌜˜ 5↑100⥊1

SolutionValidator ← {expected𝕊answer:
	err_msg ← ("Part 2 is wrong! Got instead: "∾(•Fmt answer))
	err_msg!expected= answer
	•Show "Part 2: "∾(•Fmt answer)
}


# "part 1: " Log PartOne data
# "part 2: " Log PartTwo data
# {((<"Part 1 is wrong! Got:")∾𝕩)!2530= 𝕩}"part 1: " Log PartOne data
1921 SolutionValidator PartTwo data
