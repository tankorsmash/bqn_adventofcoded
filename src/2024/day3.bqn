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


mul    ← "mul("     # 1
digits ← @+48 + ↕10 # 2
com    ← ','        # 3
end    ← ')'        # 4

allowed_chars ← mul∾",)"∾digits

Find ← {chars𝕊input:
	chars⍷input ∾ (0˘ (↕ -⟜1∘≠)chars)
}

PartOne ← {𝕊lines:
		PerLine ← {𝕊line:
			MakeValid ← (⊑∘(mul⊸⍷)¨/⊢) (4⊸≤∘≠¨/⊢)
			mul_part ← MakeValid  (mul⊸Find +`⊸⊔⊢)line

			end_mask ← (/ ")"⊸Find)¨ mul_part
			lengths ← ((0≠≠¨) end_mask )/ mul_part
			e_wo_e ← ((0≠≠¨) ⊑¨∘/⊢) end_mask # ends without empties
			grabbed ←  ((⌊´ allowed_chars⊸(∊˜) )¨/⊢) e_wo_e (4↓↑)¨ lengths
			splitcomma ← ','(((⊢-˜+`×¬)∘=)⊔⊢)¨ grabbed
			parsed ← •ParseFloat¨¨ splitcomma

			Range ← 1⊸≤ ∧ 1000⊸>
			valids_mask ← (⌊´ Range¨)¨ parsed
			valids ← valids_mask/parsed
			mul_res ← ×´¨ valids
			res ← +´ mul_res

			res
		}

		+´ ( PerLine)¨ lines
}

PartTwo ← {𝕊lines:

	do ← "do()"
	dont ← "don't()"


	PerLine ← {𝕊line:
		dos← / do ⍷ line
		donts← / dont ⍷ line

		MakeValid ← ((⊑∘(mul⊸⍷)¨)/⊢) ((4⊸≤∘≠¨)/⊢)
		mul_part ← MakeValid  (mul⊸Find +`⊸⊔⊢)line
		cmd_idx ← ∾´ line⊸(/∘⍷˜)¨ mul_part
		joined ← mul_part ∾˘˜ cmd_idx

		BuildEnableMask ← {doing𝕊idx:
			 # idk why ⊑ is needed, since idx is a unit
			 in_dos ← ⊑ idx∊dos
			 in_donts ← ⊑ idx∊donts

			 { in_dos ? 1 ; in_donts ? 0 ; doing}
		}

		enabled_mask_idx ←  / 1(BuildEnableMask)` ↕ ≠line

		cmds ←  ∾´ (/ ⍷⟜line)¨ mul_part
		enabled_cmds ← (cmds∊enabled_mask_idx)/⊢ cmds

		end_mask ← (/ ")"⊸Find)¨ MakeValid mul_part
		valid_ends_mul_parts ← ((0⊸≠∘≠¨ end_mask )/ mul_part)
		valid_joined ←         (/⊏⌽⍉joined       ∊ valid_ends_mul_parts) ⊏joined
		enabled_valid_joined ← (/⊏⍉ valid_joined ∊ enabled_cmds)         ⊏valid_joined
		to_parse ← 1⊏˘ enabled_valid_joined

		ranges ←  ⊑¨ (/ ")"⊸Find)¨  to_parse
		grabbed ←  ((⌊´ allowed_chars⊸(∊˜) )¨/⊢) ranges((≠mul)⊸↓∘↑¨)to_parse

		splitcomma ← ','(((⊢-˜+`×¬)=)⊔⊢)¨ grabbed
		parsed ← •ParseFloat¨¨ splitcomma

		Range ← (1⊸≤∧1000⊸>)
		valids_mask ← ⌊´∘(Range¨)¨ parsed
		valids ← valids_mask/ parsed
		mul_res ← ×´¨ valids
		res ← +´ mul_res

		res
	}

	PerLine ∾ lines
}



"Part 1 is wrong!"!165225049= "part 1: " Log PartOne data
"Part 2 is wrong!"!108830766= "part 2: " Log PartTwo data
