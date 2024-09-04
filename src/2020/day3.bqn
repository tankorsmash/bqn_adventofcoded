# data ← •file.Lines "../../samples/2020/day3.txt"
data ← •file.Lines "../../inputs/2020/day3.txt"

# numbers ← •ParseFloat¨ data


entry_length ←(≠⊑data)
# array ← entry_length‿↑ ⥊ data
array ← data

indices ← ↕≠ array

GetTree ← {
	x ← entry_length|𝕩×3
	y ← 𝕩×1

	y_row ← ⊑y ⊏array
	'#'= x⊑ y_row
}

Part1 ← {
	+´ GetTree¨ 𝕩
}
# •Show 2 | 5
•Show Part1 indices
# •Show getTree2
# •Show {𝕩 ⊏ array}¨ indices
# •Show indices
# •Show (entry_length | 2) × 3

# •Show 0⊏data
# •Show ⊑(1×3)⊏array

# •Show GetTree 0
# •Show GetTree 1
# •Show GetTree 2
# •Show GetTree 3
# •Show GetTree 4


# •Show 10 (-+-) 5
# •Show 10 -+- 5

