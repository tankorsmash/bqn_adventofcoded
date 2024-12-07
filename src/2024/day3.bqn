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

bad ← "mul(3,4]   )"
PartOne ← {𝕊lines:
		PerLine ← {𝕊line: 
			# line ← "xmul(2000,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,500))"
			"line" Log line 100⊸↑↩
			paddings ← ( (+⟜(↕4))˘ / mul Find line)
			mul_match ← mul Find line
			mul_mask ←   ⌈˝ { "mul(" Find line}˘ paddings
			mul_part ← mul_mask+`⊸⊔line
			end_mask ← (/ ")"⊸Find)¨ mul_mask+`⊸⊔line
			idk ← (((0≠≠¨)⊑¨∘/⊢) end_mask)
			lengths ← (((0≠≠¨) end_mask )/ mul_part)
			"grabbed" Log grabbed ←  ((⌊´ allowed_chars⊸(∊˜))¨/⊢) (idk 4⊸↓∘↑¨ lengths)
			splitcomma ← ','(((⊢-˜+`×¬)∘=)⊔⊢)¨ grabbed
			"parsed" Log parsed ← (•ParseFloat¨ )¨ splitcomma
			Range ← (1⊸≤∧1000⊸>)
			"Valids mask" Log valids_mask ← (⌊´ Range¨)¨ parsed
			"Valid" Log valids ← valids_mask/ parsed
			"mul res" Log mul_res ← ×´¨ valids
			res ← +´ mul_res

			res
		}

		# +´ PerLine ⊑lines
		+´ PerLine¨ lines
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
