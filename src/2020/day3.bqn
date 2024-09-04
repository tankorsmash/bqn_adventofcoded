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
# •Show 2 | 5
•Show Part1 indices
# •Show getTree2
# •Show {𝕩 ⊏ array}¨ indices
# •Show indices
# •Show (entry_length | 2) × 3

# •Show 0⊏data
# •Show ⊑(1×3)⊏array

# •Show GetTreePart1 0
# •Show GetTreePart1 1
# •Show GetTreePart1 2
# •Show GetTreePart1 3
# •Show GetTreePart1 4


# •Show 10 (-+-) 5
# •Show 10 -+- 5

