data ← •file.Lines "../../samples/2020/day8.txt"
# data ↩ •file.Lines "../../samples/2020/day8_alt.txt"
data ↩ •file.Lines "../../inputs/2020/day8.txt"

Log ← {
	msg‿val ← 𝕩
	•Show msg‿val
	val
}


SplitBy ← (+`∘=⊔⊢)

Parse ← {
	"nop"‿val: 1‿0;
	"acc"‿val: 1‿val;
	"jmp"‿val: val‿0
}

limit ← 1_000_000

PartOne ← {
	acc ← 0
	idx ← 0
	all_idxs ← ⟨⟩
	insts ← {•ParseFloat⌾(1⊸⊑) (('+'⊸≠/⊢)' '⊸≠/⊢)¨ ' 'SplitBy 𝕩}¨ 𝕩
	∘‿1⥊ insts

	iterations ← 0

	{ 𝕩
		inst ← idx⊑ insts
		offset‿to_add ← Parse inst
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
	} Parse ⊑ insts
	acc
}

PartTwo ← {
	𝕩
}


•Show "part1"‿(PartOne data)
# PartTwo data

•Show "done"
