data ← •file.Lines "../../samples/2020/day1.txt"
# data ← •file.Lines "../../inputs/2020/day1.txt"

numbers ← •ParseFloat¨ data

Logic ← {
	# takes a list of numbers and groups it with itself
	pairs ← ⥊(<⟨⟩) <⊸∾⌜´ 𝕩

	# sums the pairs and checks if they are equal to 2020
	sums ← 2020= (+´)¨ pairs

	# finds the index of the first pair that sums to 2020
	first_pair_idx ← ⊑sums⊐1

	# finds the first pair that sums to 2020
	first_pair ← first_pair_idx⊑pairs

	# returns the product of the first pair that sums to 2020
	(×´ first_pair)
}

Part1 ← {
	Logic 2⥊⟨𝕏⟩
}

Part2 ← {
	Logic 3⥊⟨𝕏⟩
}


•Show "part1: " Part1 numbers
•Show "part2: " Part2 numbers
