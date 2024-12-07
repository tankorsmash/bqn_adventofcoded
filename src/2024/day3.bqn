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

bad ← "mul(3,4]   )"
PartOne ← {𝕊lines:
		PerLine ← {𝕊line: 
		# line ← "xmul(2000,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,500))"
		"line" Log line
		paddings ← ( (+⟜(↕4))˘ / mul Find line)
		mul_match ← mul Find line
		mul_mask ←   ⌈˝ { "mul(" Find line}˘ paddings
		mul_part ← mul_mask+`⊸⊔line
		end_mask ← (/ ")"⊸Find)¨ mul_mask+`⊸⊔line
		foo ← (((0≠≠¨)⊑¨∘/⊢) end_mask)
		lengths ← (((0≠≠¨) end_mask )/ mul_part)
		"grabbed" Log grabbed ← foo 4⊸↓∘↑¨ lengths
		"splitcomma" Log splitcomma ← ','(•ParseFloat¨ ((⊢-˜+`×¬)∘=)⊔⊢)¨ grabbed
		Range ← (1⊸≤∧1000⊸>)
		"Valids mask" Log valids_mask ← (⌊´ Range¨)¨ splitcomma
		"Valid" Log valids ← valids_mask/ splitcomma
		"mul res" Log mul_res ← ×´¨ valids_mask/ splitcomma
		res ← +´ mul_res

		# takes 1 2 3 2 4 and says 'valid'
		# takes 2 3 4 and says 'invalid'
		#
		# TODO: break up adjacent mul() calls
		# TODO: dont grab two right parens in a row
		ValidateMask ← {𝕊mask:
			"mask" Log mask
			# starts with 1
			begin ← 1= ⊏mask
			# only has 4 1s (FRAGILE!)
			ones ← 4= +´1=mask
			# only has 1 4
			four ← 1= +´4=mask
			# 2-6 2s
			sixes ← 6≥ +´2=mask
			twos ← 2≤ +´2=mask
			# ends with 4
			end ← 4= ¯1⊏mask

			"res" Log [
				⟨"begin", "ones","four","twos", "sixes","end"⟩,
				[begin, ones,four,twos, sixes,end]
				]
			𝕩
		}

		res
		}

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
