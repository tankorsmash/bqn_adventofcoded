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
	xmas ← "MAS"
	•Out "orig"
	# (•Show )¨ lines
	•Out 50/"-"
	CountXmas ← (+´(>xmas)⊸⍷)
	lines ↩ 5‿5⥊ >lines
	•Show lines

	len ← ≠lines
	r_idxs ← {(»⍟𝕩 {𝕩⌾(0‿0⊸⍉)0⌜˜𝕩} len⥊1)}˘  ↕len
	rres ← (1+ · / xmas⊸⍷)¨ ∾¨ {𝕩 {𝕨 <∘/(>𝕩)}˘lines}¨ r_idxs
	l_idxs ← {(«⍟𝕩 {𝕩⌾(0‿0⊸⍉)0⌜˜𝕩} len⥊1)}˘  1↓↕len
	lres ← (1+ · / xmas⊸⍷)¨∾¨ {𝕩{𝕨<∘/(>𝕩)}˘lines}¨ l_idxs

	rr_idxs ← ⌽⍉⌽¨ {(»⍟𝕩 {𝕩⌾(0‿0⊸⍉)0⌜˜𝕩} len⥊1)}˘  ↕len
	rrres ← (1+ · / xmas⊸⍷)¨∾¨ {𝕩{𝕨<∘/(>𝕩)}˘lines}¨ rr_idxs
	rl_idxs ← ⌽⍉⌽¨ {(«⍟𝕩 {𝕩⌾(0‿0⊸⍉)0⌜˜𝕩} len⥊1)}˘  1↓↕len
	rlres ← (1+ · / xmas⊸⍷)¨∾¨ {𝕩{𝕨<∘/(>𝕩)}˘lines}¨ rl_idxs
	•Show r_idxs
	•Show l_idxs

	•Show (lres∾rres) 
	•Show (rlres∾rrres) 

	res ← [

		"reg" Log  ≠1⊑(lres∾rres) ((/˜∊)⋈(/˜∊˜)) (rlres∾rrres)
		# "rev" Log  ≠⊑rlres ((/˜∊)⋈(/˜∊˜)) rrres
	]
	# "BT total"⊸Log˘ (((>xmas)⊸⍷)∘⍉)˘ ⌽>lines
	# •Out 50/"-"
	•Show +´ res
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

# "part 1: " Log PartOne data
# {((<"Part 1 is wrong! Got:")∾𝕩)!2530= 𝕩}"part 1: " Log PartOne data
"Part 2 is wrong!"!9= "part 2: " Log PartTwo data
