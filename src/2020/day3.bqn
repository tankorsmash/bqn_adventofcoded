data ← •file.Lines "../../samples/2020/day3.txt"
# data ← •file.Lines "../../inputs/2020/day3.txt"

# numbers ← •ParseFloat¨ data


entry_length ←(≠⊑data)
# array ← entry_length‿↑ ⥊ data
array ← data

indices ← ↕≠ array

GetTreePart1 ← {
	x_offset ← 3
	y_offset ← 1
	idx ← 𝕩

	x ← entry_length|idx×x_offset
	y ← idx×y_offset

	y_row ← ⊑y ⊏array
	'#'= x⊑ y_row
}

Part1 ← {
	+´ GetTreePart1¨ 𝕩
}
# •Show Part1 indices


GetTreePart2 ← {
	# •Show •Repr 𝕩
	(x_offset‿y_offset)‿indices ← 𝕩
	 # •Show ⟨"x_offset", x_offset, "y_offset", y_offset, "idx", indices⟩

	 +´{
		 idx ← 𝕩
		 x ← entry_length|idx×x_offset
		 y ← idx×y_offset

		 y_row ← ⊑y ⊏array
		 '#'= x⊑ y_row
	 }¨indices
}

Part2 ← {
	idxs ← 𝕩
	# dirs ← ⟨3‿1, 1‿1, 5‿1, 7‿1, 1‿2⟩
	# joined ← {(<idxs)∾˜(<𝕩)}¨dirs 
	dirs_without_2 ← ⟨3‿1, 1‿1, 5‿1, 7‿1, 1‿2⟩
	joined ← {(<(⌊y÷˜≠idxs)↑idxs)∾˜(<x‿y←𝕩)}¨dirs_without_2
	×´ GetTreePart2¨ joined
}
•Show Part2 1↓indices


# •Show GetTreePart1 0
# •Show GetTreePart1 1
# •Show GetTreePart1 2
# •Show GetTreePart1 3
# •Show GetTreePart1 4
