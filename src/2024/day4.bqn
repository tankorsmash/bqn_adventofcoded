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


xmas ← "XMAS"

•Show xmas⍷"abcXMASdef"
•Out 50/"-"

PartOne ← {𝕊lines:
	•Out "orig"
	(•Show ⍉)¨ lines
	CountXmas ← (+´(>xmas)⊸⍷)
	"LR total" Log +´ CountXmas¨     lines
	"RL total" Log +´ CountXmas¨ ⌽¨  lines
	"TB total" Log +´ CountXmas˘   ⍉>lines
	"BT total"⊸Log +´ CountXmas˘ ⌽˘⍉>lines
	•Out 50/"-"
	# "BT total"⊸Log˘ (((>xmas)⊸⍷)∘⍉)˘ ⌽>lines
	# •Out 50/"-"
	≠lines
}

PartTwo ← {𝕊lines:
	lines
}

# •Show¨ ⊢ data
# •Out 50/"-"
# •Show ⌽>data
∾˝
input ← ⟨"XBC1", "DMF2", "HIA3", "KXMS"⟩
# input ↩ data
•Show input
len ← ≠input
# •Show (</)˘ »⍟1 {𝕩⌾(0‿0⊸⍉)0⌜˜𝕩} 3⥊1
r_idxs ← {(»⍟𝕩 {𝕩⌾(0‿0⊸⍉)0⌜˜𝕩} len⥊1)}˘ "rlens" Log ↕len
"rres" Log rres ← ∾¨ {𝕩{𝕨<∘/(>𝕩)}˘(input)}¨ r_idxs
l_idxs ← {(«⍟𝕩 {𝕩⌾(0‿0⊸⍉)0⌜˜𝕩} len⥊1)}˘ "llens" Log 1↓↕len
"lres" Log lres ← ∾¨ {𝕩{𝕨<∘/(>𝕩)}˘(input)}¨ l_idxs
CountXmas ← (+´(>xmas)⊸⍷)
"both" Log lres∾rres
"count" Log CountXmas¨ lres∾rres
"rev both" Log ⌽¨ lres∾rres
"rev count" Log CountXmas¨ ⌽¨ lres∾rres

# "Part 1 is wrong!"!18= "part 1: " Log PartOne data
# "Part 2 is wrong!"!6= "part 2: " Log PartTwo data
