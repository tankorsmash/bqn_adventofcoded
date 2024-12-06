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
		line ← 41↑ ⊑lines
		"line" Log line
		paddings ← •Show ( (+⟜(↕4))˘ / "mul(" Find line)
		"mul(" Log mulm ←   ⌈˝ {1˘⌾((𝕩)⊸⊏) ("mul(" Find line)}˘ paddings
		"digs" Log digm ← 2× digits∊˜ line
		" ,  " Log comm ← 3×"," Find line
		"   )" Log endm ← 4×")" Find line
		"comb" Log (mulm + digm + comm + endm)
		≠lines
}

PartTwo ← {𝕊lines:
 ≠lines
}

•Show digits ∊˜ "mul(3,4)"

"part 1: " Log PartOne data
# "Part 1 is wrong!"!472= "part 1: " Log PartOne data
# "Part 2 is wrong!"!520= "part 2: " Log PartTwo data
