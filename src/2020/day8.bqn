data ← •file.Lines "../../samples/2020/day8.txt"
# data ↩ •file.Lines "../../samples/2020/day8_alt.txt"
# data ↩ •file.Lines "../../inputs/2020/day8.txt"

Log ← {
	msg‿val ← 𝕩
	•Show msg‿val
	val
}


SplitBy ← (+`∘=⊔⊢)

limit ← 1_000_0

PartOne ← {
	ParseOne ← {
		"nop"‿val: 1‿0;
		"acc"‿val: 1‿val;
		"jmp"‿val: val‿0
	}

	acc ← 0
	idx ← 0
	all_idxs ← ⟨⟩
	insts ← {•ParseFloat⌾(1⊸⊑) (('+'⊸≠/⊢)' '⊸≠/⊢)¨ ' 'SplitBy 𝕩}¨ 𝕩
	∘‿1⥊ insts

	iterations ← 0

	{ 𝕩
		inst ← idx⊑ insts
		offset‿to_add ← ParseOne inst
		# •Show "acc"‿acc
		# Log "offset, to add"‿(offset‿(to_add))
		(offset‿(to_add))
	}•_while_{𝕊offset‿to_add:

		iterations ↩ iterations+1

		new_idx ← idx+offset

		# •Delay 0.25


		already_processed ← 1= ( +´ ⥊ new_idx∊all_idxs)
		{ ((iterations> limit) ∨ already_processed) ?
			0 ;

			idx ↩ new_idx
			acc ↩ acc+to_add
			all_idxs ↩ all_idxs∾ idx
			1
		}
	} ParseOne ⊑ insts
	acc
}

ParseTwo ← {
	swap𝕊"nop"‿val: {¬swap ? 1‿0 ; val‿0};
	swap𝕊"acc"‿val: 1‿val;
	swap𝕊"jmp"‿val: {¬swap ? val‿0 ; 1‿0}
}


PartTwo ← {

	insts ← {•ParseFloat⌾(1⊸⊑) (('+'⊸≠/⊢)' '⊸≠/⊢)¨ ' 'SplitBy 𝕩}¨ 𝕩

	Iter ← {𝕊to_swap_idx:
		acc ← 0
		idx ← 0
		all_idxs ← ⟨⟩
		∘‿1⥊ insts

		iterations ← 0

		Loop ← {
			𝕩
			offset‿to_add ← (idx = to_swap_idx)ParseTwo idx⊑ insts
		}
		Cond ← {𝕊offset‿to_add:

			iterations ↩ iterations+1

			new_idx ← idx+offset

			already_processed ← 1= ( +´ ⥊ new_idx∊all_idxs)
			within_limit ← iterations > limit
			{ (new_idx = ≠insts) ∨ within_limit ?

				0 ;

				idx ↩ new_idx
				acc ↩ acc+to_add
				all_idxs ↩ all_idxs∾ idx
				1
			}
		}
		Loop •_while_ Cond 0 ParseTwo ⊑ insts
		acc
	}

	to_swap_idxs ←  /(<"acc")≢˘ >⊏¨ insts
	# to_swap_idx ← ⊑ to_swap_idxs
	# Iter⎊⊢ to_swap_idx
	{
		res←Iter 𝕩
		•Show "res"‿res
		res
	}¨ to_swap_idxs
}


# •Show "part1"‿(PartOne data)
•Show "part2"‿(PartTwo data)

•Show "done"
