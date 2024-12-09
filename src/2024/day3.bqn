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

mul    ← "mul("     # 1
digits ← @+48 + ↕10 # 2
com    ← ','        # 3
end    ← ')'        # 4

allowed_chars ← mul∾",)"∾digits

Find ← {chars𝕊input:
	chars⍷input ∾ (0˘ (↕ -⟜1∘≠)chars)
}

MakeValid ← (⊑∘(mul⊸⍷)¨/⊢) (4⊸≤∘≠¨/⊢)

PartOne ← {𝕊lines:
		PerLine ← {𝕊line:
			"line" Log line
			mul_part ← MakeValid  (mul⊸Find +`⊸⊔⊢)line

			"mul_part"⊸Log¨ mul_part
			•Out 50/"-"

			end_idxs ← (/ ")"⊸Find)¨ mul_part
			"end_idxs"⊸Log¨ end_idxs
			•Out 50/"-"

			raw_parts ← ((0≠≠¨) end_idxs )/ mul_part
			"raw_parts"⊸Log¨ raw_parts
			•Out 50/"-"
			ranges_until_empty  ← ((0≠≠¨) ⊑¨∘/ ⊢) end_idxs # ends without empties

			 # "end_idxs" Log end_idxs
			 # "raw_parts" Log raw_parts
			 "ranges_until_empty" Log ranges_until_empty
			raw_grabbed ← ranges_until_empty (4↓↑)¨ raw_parts
			"raw_grabbed" Log raw_grabbed
			grabbed ←  ((⌊´ allowed_chars⊸(∊˜) )¨/⊢) raw_grabbed
			"grabbed" Log grabbed
			splitcomma ← ','(((⊢-˜+`×¬)∘=)⊔⊢)¨ grabbed
			"splitted" Log splitcomma
			parsed ← •ParseFloat¨¨ splitcomma
			"parsed" Log parsed

			Range ← 1⊸≤ ∧ 1000⊸>
			valids_mask ← (⌊´ Range¨)¨ parsed
			valids ← valids_mask/parsed
			"valids" Log valids
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
		"line" Log line

		mul_part ← MakeValid  (mul⊸Find +`⊸⊔⊢)line
		cmd_idx ← ∾´ line⊸(/∘⍷˜)¨ mul_part
		"cmd_idx"⊸Log¨ cmd_idx
		joined ← mul_part ∾˘˜ cmd_idx
		•Show joined

		BuildEnableMask ← {doing𝕊idx:
			 # idk why ⊑ is needed, since idx is a unit
			 in_dos ← ⊑ idx∊dos
			 in_donts ← ⊑ idx∊donts

			 { in_dos ? 1 ; in_donts ? 0 ; doing}
		}

		enabled_mask_idx ←  / 1(BuildEnableMask)` ↕ ≠line
		"enabled_mask_idx" Log enabled_mask_idx

		cmds ←  ∾´ (/ ⍷⟜line)¨ mul_part
		"cmds" Log cmds
		enabled_cmds ← (cmds∊enabled_mask_idx)/⊢ cmds

		end_mask ← (/ ")"⊸Find)¨ MakeValid mul_part
		valid_ends_mul_parts ← ((0⊸≠∘≠¨ end_mask )/ mul_part)
		"tran"Log ⊏⌽⍉joined
		"pick" Log 1⊸⊏˘ joined
		valid_joined ←         (/⊏⌽⍉joined       ∊ valid_ends_mul_parts) ⊏joined
		enabled_valid_joined ← (/⊏⍉ valid_joined ∊ enabled_cmds)         ⊏valid_joined
		to_parse ← 1⊏˘ enabled_valid_joined
		"to_parse" Log to_parse

		ranges ←  ⊑¨ (/ ")"⊸Find)¨  to_parse
		"ranges" Log ranges
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



# "Part 1 is wrong!"!161= "part 1: " Log PartOne data
# "Part 2 is wrong!"!48= "part 2: " Log PartTwo data
"Part 1 is wrong!"!165225049= "part 1: " Log PartOne data
"Part 2 is wrong!"!108830766= "part 2: " Log PartTwo data
