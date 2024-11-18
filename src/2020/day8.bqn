data ← •file.Lines "../../samples/2020/day8.txt"
# data ↩ •file.Lines "../../samples/2020/day8_alt.txt"
data ↩ •file.Lines "../../inputs/2020/day8.txt"

Log ← {
	msg‿val ← 𝕩
	•Show msg‿val
	val
}


SplitBy ← (+`∘=⊔⊢)

limit ← 1_000

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


# SafeTake ← {count𝕊arr: (count⌊≠arr)↑arr}
SafeTake ← (⌊⟜≠↑⊢)
# •Show 20(⌊⟜≠↑)↕10

PartTwo ← {

	raw_insts ← {•ParseFloat⌾(1⊸⊑) (('+'⊸≠/⊢)' '⊸≠/⊢)¨ ' 'SplitBy 𝕩}¨ 𝕩

	# •Show (0 ⊸ParseTwo )¨10 SafeTake raw_insts 
	Iter ← {𝕊to_swap_idx:
		acc ← 0
		idx ← 0
		seen_idxs ← ⟨⟩

		insts ← {i‿pair:
			(i=to_swap_idx)ParseTwo pair
		}¨ (↕∘≠⋈¨⊢)raw_insts

		# •Show ∘‿1⥊ insts

		iterations ← 0

		Loop ← {
			𝕩
			idx⊑ insts
		}

		Cond ← {𝕊offset‿to_add:

			iterations ↩ iterations+1

			new_idx ← idx+offset

			already_processed ← 1= ( +´ ⥊ new_idx∊seen_idxs)
			within_limit ← iterations > limit
			{ (new_idx = ≠insts) ∨ within_limit ∨ already_processed ?
				# •Show "done"‿idx
				idx ↩ new_idx
				acc ↩ acc+to_add
				seen_idxs ↩ seen_idxs∾ idx
				0 ;

				# •Show "iter"‿idx‿acc‿offset‿to_add
				idx ↩ new_idx
				acc ↩ acc+to_add
				seen_idxs ↩ seen_idxs∾ idx
				1
			}
		}
		Loop •_while_ Cond   ⊑ insts
		[⟨"idx","acc", "iterations"⟩
		  ⟨idx,  acc,   iterations ⟩]
	}

	to_swap_idxs ←  /(<"acc")≢˘ >⊏¨ raw_insts
	{𝕊to_swap_idx:
		res←Iter to_swap_idx
		# •Show "res"‿res
		res
	}¨ to_swap_idxs
}


# •Show "part1"‿(PartOne data)
•Show ⊑ ({+´(≠data)=1⊏𝕩}¨/⊢) (PartTwo data)

•Show "done"
