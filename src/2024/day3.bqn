data ← •file.Lines "../../samples/2024/day3.txt"
# data ↩ •file.Lines "../../samples/2024/day3_alt.txt"
# data ↩ •file.Lines "../../inputs/2024/day3.txt"


Log ← {msg𝕊val:
	•Show msg‿val
	val
}

verbose ← 0
CLog ← {msg𝕊val:
	{verbose ? •Show msg‿val ; @}
	val
}


mul ← "mul(" #1
digits ← @+48 + ↕10 #2
com ← ',' #3
end ← ')' #4

# •Show [1,2,3,2,4]
# •Show [1,2,2, 2,3,2,2,2,4]


Find ← {chars𝕊input:
	chars⍷input ∾ (0˘ (↕ -⟜1∘≠)chars)

}

bad ← "mul(3,4]   )"
PartOne ← {𝕊lines:
		line ← ⊑lines
		"line" Log line
		paddings ← ( (+⟜(↕4))˘ / "mul(" Find line)
		mulm ←   ⌈˝ {1˘⌾((𝕩)⊸⊏) ("mul(" Find line)}˘ paddings
		digm ← 2× digits∊˜ line
		comm ← 3×"," Find line
		endm ← 4×")" Find line
		"comb" Log comb ← (mulm + digm + comm + endm)

		"com2" Log com2 ← 0≠ comb
		First ← »⊸<
		Last ← >⟜«
		both ← ∘‿2⥊ / (First ⌈ Last ) com2
		"bot2"⊸Log¨ bot2 ← {𝕩 +<·↕𝕨 ¬𝕩}˜´˘ ∘‿2⥊ / (First ⌈ Last ) com2
		"pick" Log pick ← (("line"Log line)⊸(⊏˜) •Show)¨ bot2
		≠lines
}

PartTwo ← {𝕊lines:
 ≠lines
}

"part 1: " Log PartOne data
# "Part 1 is wrong!"!472= "part 1: " Log PartOne data
# "Part 2 is wrong!"!520= "part 2: " Log PartTwo data
