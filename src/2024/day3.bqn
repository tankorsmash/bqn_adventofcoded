data ← •file.Lines "../../samples/2024/day3.txt"
# data ↩ •file.Lines "../../samples/2024/day3_alt.txt"
data ↩ •file.Lines "../../inputs/2024/day3.txt"


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
			# line ← "xmul(2000,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,500))"
			# •Show ≠line
			# "line" Log line (("))))"⊸∾)∘(104⊸↑)∘(100⊸↓))↩
			# "line" Log line (104⊸↑)↩
			# "line" Log line
			paddings ← ( (+⟜(↕4))˘ / mul Find line)
			mul_mask ← ⌈˝ { "mul(" Find line}˘ paddings
			•Out 50/"-"
			MakeValid ← ((⊑∘(mul⊸⍷)¨)/⊢) ((0≠≠¨)/⊢)
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

		# •Show PerLine 2⊑lines
		+´ ( PerLine)¨ lines
}

PartTwo ← {𝕊lines:
 ≠lines
}

# # input ← [1,1,1,1,2,4,1,1,1,1, 9, 100, 4]
# # "input" Log input
# "input" Log ⊑data
#
# input ← ( ⊑data)
# mulres ← "mul(" Find input
#
# "mulres" Log mulres
# "group " Log mulres+`⊸⊔input
# # "input" Log ⌈˝ ⍷⟜(20↑ ⊑data)˘ "mul(,)"∾digits

"part 1: " Log PartOne data

# "Part 1 is wrong!"!472= "part 1: " Log PartOne data
# "Part 2 is wrong!"!520= "part 2: " Log PartTwo data
