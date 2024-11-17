data ← •file.Lines "../../samples/2020/day8.txt"
# data ↩ •file.Lines "../../samples/2020/day8_alt.txt"
# data ↩ •file.Lines "../../inputs/2020/day8.txt"

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

PartOne ← {
	acc ← 0
	idx ← 0
	all_idxs ← ⟨⟩
	insts ← {•ParseFloat⌾(1⊸⊑) (('+'⊸≠/⊢)' '⊸≠/⊢)¨ ' 'SplitBy 𝕩}¨ 𝕩
	•Show  ∘‿1⥊ insts

	i ← 0

	{ 𝕩
		offset‿to_add ← Parse idx⊑ insts
		# •Show "acc"‿acc
		Log "offset, to add"‿(offset‿(to_add))
	}•_while_{𝕊offset‿to_add:

		i ↩ i+1

		# •Show idx‿acc
		# •Delay 0.25

		exists ← 1= ( +´ ⥊ (idx+offset)∊all_idxs)
		{ ((i> 1_000_000) ∨ exists) ?
			0 ;

			idx ↩ (idx+offset)
			acc ↩ acc+to_add
			all_idxs ↩ all_idxs∾ idx
			1
		}
	} 1‿0
	acc
}

PartTwo ← {
	𝕩
}


•Show "part1"‿(PartOne data)
# PartTwo data

•Show "done"
