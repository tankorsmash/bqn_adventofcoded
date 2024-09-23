# data ← •file.Lines "../../samples/2020/day5.txt"
data ← •file.Lines "../../inputs/2020/day5.txt"

SplitBy ← (+`∘=⊔⊢)
# •Show ' 'SplitBy "a b c   d"

RemoveSpaces ← (' '⊸≠)⊸/


PerLetter ← {
	⟨val⟩ 𝕊𝕩  :
		⟨val⟩
	;
	𝕨𝕊𝕩 :
		range ← >𝕨
		letter ← 𝕩
		half ← 2÷˜≠range
		result ← { ('F'=letter) ∨ ('L'=letter) ? half↑range ; half↓range }
		result
}
seat_ids ← {
	first_five_chars ← 7↑ >𝕩
	row ← (<↕128) PerLetter˜´ ⌽first_five_chars

	last_three_chars ← 7↓ >𝕩
	seat ← (<↕8) PerLetter˜´ ⌽last_three_chars
	(row × 8)+seat
}˘ data

part_one ← ⌈´ ⥊seat_ids
# •Show part_one

sorted_seat_ids ← ∧⥊ seat_ids

min_seat_id←0⊑sorted_seat_ids # eg 47
max_seat_id←¯1⊑sorted_seat_ids # eg 354
all_seats ← min_seat_id+ ↕¬˜´ min_seat_id‿max_seat_id # [47, 48, 49, ..., 354]
valid_seats ← (all_seats ∊ sorted_seat_ids) # [0, 0, 0, ..., 1, 0, ..., 0]
•Show part_two ← (¬valid_seats)/all_seats
