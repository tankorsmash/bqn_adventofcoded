data ← •file.Lines "../../samples/2024/day6.txt"
# data ↩ •file.Lines "../../samples/2024/day6_alt.txt"
# data ↩ •file.Lines "../../inputs/2024/day6.txt"


Log ← {msg𝕊val:
	•Show msg‿val
	val
}


chars ← "^>v<"
RotateGuard ← {𝕊char:
	new_char ← ((≠chars)|1+˜/char⍷chars)⊏chars
	⊑new_char
}
Turn90 ← ⌽˘1⊸⍉

IdxToRowCol ← {board𝕊idx:
	rows‿cols ← ≢ board
	row ← 1+cols|idx
	col ← idx - row × rows
	row‿col
}

PartOne ← {𝕊lines:

	char ← '>'
	# •Show RotateGuard char

	# "lines"⊸Log¨ lines

	input ← 5‿5⥊ @+97 + ↕26
	input ↩ >˘ lines
	"orig input" Log input
	joined← ((↕≠){y𝕊line: ((↕≠line)⋈¨˜y)⋈¨line }˘⊢)input
	# "joined coords"⊸Log 0⊑¨ Turn90 joined
	# "joined char"⊸Log 1⊑¨ Turn90 joined
	first_row‿first_col ← ((⊑·/ ≠¨)⋈(⊑∘(≠¨∾∘/⊢)))  <∘/˘ {⌈´∾˘chars⊸∊⋈ 1⊑𝕩}¨ joined
	"first row,col" Log first_row‿first_col
	# •Exit 0

	# in: (board, prev input) out: (rotated board, next input)
	Iter ← {obj_row‿obj_col𝕊prev_board:
		input ↩ Turn90 prev_board

		obj ← obj_row‿obj_col
		"obj"⊸Log obj

		# "input coords"⊸Log 0⊑¨ input
		"rotated (unchanged guard)"⊸Log 1⊑¨ input

		"elm_idx" Log elm_idx ← ⊑(/(obj⊸≡)∘⊑¨) ⥊ input
		"row,col" Log row‿col ← input IdxToRowCol elm_idx
		"rotated row,col" Log row‿col
		"grabbed" Log grabbed ← row‿col⊑input
		rotated ← RotateGuard⌾(1⊸⊑∘(row‿col⊸⊑)) input
		"rotated" Log 1⊑¨ rotated
		row_pairs ← row⊏rotated
		"row_chars" Log row_chars←1⊑¨ row_pairs

		!'>'=char #sanity check
		char_idx ← ⊑ /char=row_chars
		hash_idxs ←  >/'#'=row_chars

		next_hash_idx ← ⊑((char_idx⊸<)¨/⊢) hash_idxs
		range ← (char_idx+↕ next_hash_idx-char_idx)⊏row_pairs

		"next_obj" Log next_obj ← ⊑ (row‿(1-˜next_hash_idx))⊑input

		next_obj‿input
	}

	(first_row‿first_col)Iter joined

	∞
}

PartTwo ← {𝕊lines:
	lines
}

SolutionValidator ← {part‿expected𝕊answer:
	err_msg ← ("Part "∾(•Fmt part)∾" is wrong! Got instead: "∾(•Fmt answer))
	err_msg!(expected= answer)
	•Show "Correctly solved Part "∾(•Fmt part)∾": "∾(•Fmt answer)
}

"part 1: " Log PartOne data
# "part 2: " Log PartTwo data
# 1‿5329 SolutionValidator PartOne data
# 2‿5833 SolutionValidator PartTwo data

