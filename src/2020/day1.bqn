data ← •file.Lines "../../samples/2020/day1.txt"
# data ← •file.Lines "../../inputs/2020/day1.txt"

numbers ← •ParseFloat¨ data

Part1 ← {
	pairs ← ⥊(<⟨⟩) <⊸∾⌜´ 𝕏‿𝕏
	sums ← 2020= (+´)¨ pairs
	first_pair_idx ← ⊑sums⊐1
	first_pair ← first_pair_idx⊑pairs
	•Show (×´ first_pair)
}

Part2 ← {
	pairs ← ⥊(<⟨⟩) <⊸∾⌜´ 𝕏‿𝕏‿𝕏
	sums ← 2020= (+´)¨ pairs
	first_pair_idx ← ⊑sums⊐1
	first_pair ← first_pair_idx⊑pairs
	•Show (×´ first_pair)
}


Part1 numbers
Part2 numbers
