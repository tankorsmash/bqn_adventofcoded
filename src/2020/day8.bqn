data ← •file.Lines "../../samples/2020/day8.txt"
# data ↩ •file.Lines "../../samples/2020/day8_alt.txt"
# data ↩ •file.Lines "../../inputs/2020/day8.txt"

Log ← {
	msg‿val ← 𝕩
	•Show msg‿val
	val
}


SplitBy ← (+`∘=⊔⊢)

Process ← {
	"nop"‿val: 0‿0;
	"acc"‿val: 1‿val;
	"jmp"‿val: val‿0
}

PartOne ← {
	acc ← 0
	idx ← 0
	insts ← (•ParseFloat )⌾(1⊸⊑)¨ ('+'⊸≠/⊢)¨¨ (' '⊸≠/⊢)¨¨ ' 'SplitBy¨ 𝕩
	•Show  ∘‿1⥊ insts
}

PartTwo ← {
	𝕩
}


•Show  ⟨"hello", "123"⟩

•Show PartOne data
# PartTwo data
