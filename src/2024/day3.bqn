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

allowed_chars ← mul∾",)"∾digits

# •Show [1,2,3,2,4]
# •Show [1,2,2, 2,3,2,2,2,4]


Find ← {chars𝕊input:
	chars⍷input ∾ (0˘ (↕ -⟜1∘≠)chars)

}

PartOne ← {𝕊lines:
		PerLine ← {𝕊line:
			paddings ← ( (+⟜(↕4))˘ / mul Find line)
			mul_mask ← ⌈˝ { "mul(" Find line}˘ paddings
			MakeValid ← ((⊑∘(mul⊸⍷)∘•Show¨)/⊢) ((4⊸≤∘≠¨)/⊢)
			mul_part ← MakeValid  mul_mask+`⊸⊔line

			end_mask ← (/ ")"⊸Find)¨ MakeValid mul_mask+`⊸⊔line
			e_w_e ← (((0≠≠¨)⊑¨∘/⊢) end_mask) #ends without empties
			lengths ← (((0≠≠¨) end_mask )/ mul_part)
			grabbed ←  ((⌊´ allowed_chars⊸(∊˜) )¨/⊢) (e_w_e 4⊸↓∘↑¨ lengths)
			splitcomma ← ','(((⊢-˜+`×¬)∘=)⊔⊢)¨ grabbed
			parsed ← (•ParseFloat¨ )¨ splitcomma

			Range ← (1⊸≤∧1000⊸>)
			valids_mask ← (⌊´ Range¨)¨ parsed
			valids ← valids_mask/ parsed
			mul_res ← ×´¨ valids
			res ← +´ mul_res

			res
		}

		+´ ( PerLine)¨ lines
}

PartTwo ← {𝕊lines:
		PerLine ← {𝕊line:
			paddings ← ( (+⟜(↕4))˘ / mul Find line)
			mul_mask ← ⌈˝ { "mul(" Find line}˘ paddings
			MakeValid ← ((⊑∘(mul⊸⍷)∘•Show¨)/⊢) ((4⊸≤∘≠¨)/⊢)
			mul_part ← MakeValid  mul_mask+`⊸⊔line

			end_mask ← (/ ")"⊸Find)¨ MakeValid mul_mask+`⊸⊔line
			e_w_e ← (((0≠≠¨)⊑¨∘/⊢) end_mask) #ends without empties
			lengths ← (((0≠≠¨) end_mask )/ mul_part)
			grabbed ←  ((⌊´ allowed_chars⊸(∊˜) )¨/⊢) (e_w_e 4⊸↓∘↑¨ lengths)
			splitcomma ← ','(((⊢-˜+`×¬)∘=)⊔⊢)¨ grabbed
			parsed ← (•ParseFloat¨ )¨ splitcomma

			Range ← (1⊸≤∧1000⊸>)
			valids_mask ← (⌊´ Range¨)¨ parsed
			valids ← valids_mask/ parsed
			mul_res ← ×´¨ valids
			res ← +´ mul_res

			res
		}

		+´ ( PerLine)¨ lines
}

val ← "mul(2,4)%&mul[3,7]!@^do_not_"
•Show line ← ⊑data

"FIND" Log val ⍷ line

"part 1: " Log PartOne data
# "Part 1 is wrong!"!472= "part 1: " Log PartOne data
# "Part 2 is wrong!"!520= "part 2: " Log PartTwo data
