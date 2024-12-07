data ← •file.Lines "../../samples/2024/day3.txt"
data ↩ •file.Lines "../../samples/2024/day3_alt.txt"
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

	do ← "do()"
	dont ← "don't"
	•Show 90↑ line ← ⊑data


	PerLine ← {𝕊line:
		"FIND DO" Log dos← / do ⍷ line
		"FIND≠DO" Log donts← / dont ⍷ line

		paddings ← ( (+⟜(↕4))˘ / mul Find line)
		mul_mask ← ⌈˝ { "mul(" Find line}˘ paddings
		MakeValid ← ((⊑∘(mul⊸⍷)¨)/⊢) ((4⊸≤∘≠¨)/⊢)
		mul_part ← MakeValid  mul_mask+`⊸⊔line

		"""python
		is_doing = 1
		res = []
		for i in range(len(line)):
			if is_new_do(line[i]):
				is_doing = 1
			if is_new_dont(line[i]):
				is_doing = 0
			res.append(is_doing)
		"""

		# 0-10
		# donts: [3]
		# dos: [0, 6] # 0 is do by default
		# mults: 2, 9
		# do status: [1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1]
		"dos2" Log dos2 ←   ⟨ 5, 13, 18, 20 ⟩
		"donts2" Log donts2 ← ⟨ 2,  9, 15, 22, 24 ⟩
		EnableMask ← {doing𝕊idx:
			 # idk why ⊑ is needed, since idx is a unit
			 in_dos ← ⊑ idx∊dos2,
			 in_donts ← ⊑ idx∊donts2,

			 { in_dos ? 1 ; in_donts ? 0 ; doing}
		}

		•Show [
			↕ ⌈´ dos2∾donts2,
			1(EnableMask)`↕ ⌈´ dos2∾donts2
			]



		# "cmds" Log cmds ←  (/ ⍷⟜line)¨ mul_part




		•Exit 1

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

# "part 1: " Log PartOne data
"part 2: " Log PartTwo data

# "Part 1 is wrong!"!472= "part 1: " Log PartOne data
# "Part 2 is wrong!"!520= "part 2: " Log PartTwo data
