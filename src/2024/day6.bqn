data ← •file.Lines "../../samples/2024/day6.txt"
# data ↩ •file.Lines "../../samples/2024/day6_alt.txt"
data ↩ •file.Lines "../../inputs/2024/day6.txt"


Log ← {msg𝕊val:
	•Show (<msg)∾val
	val
}
RLog ← {msg𝕊val:
	•Show (msg)⋈val
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
	row ← ⌊ idx÷rows
	col ← rows|idx
	row‿col
}
# •Show "IdxToRowCol"⊸Log (>˘ data) IdxToRowCol 24

PartOne ← {𝕊lines:

	char ← '>'
	# •Show RotateGuard char

	# "lines"⊸Log¨ lines

	input ← 5‿5⥊ @+97 + ↕26
	# •Show Turn90⁼ Turn90⍟1 input
	# •Exit 0
	input ↩ >˘ lines
	input ↩ (('.'⊸=◶⊢‿'○')¨)⌾⥊ input
	# "orig input" Log input
	Joiner ← {y𝕊line: ((↕≠line)⋈¨˜y)⋈¨line}
	joined← ((↕≠) Joiner˘ ⊢)input
	rows‿cols ← ≢joined
	# "joined coords"⊸Log 0⊑¨ Turn90 joined
	# "joined char"⊸Log 1⊑¨ joined
	first_row‿first_col ← ((⊑·/ ≠¨)⋈(⊑∘(≠¨∾∘/⊢)))  <∘/˘ {⌈´∾˘chars⊸∊⋈ 1⊑𝕩}¨ joined
	first_obj ← first_row‿first_col
	"first row,col" Log first_row‿first_col
	# •Exit 0

	state ← ⟨⟩

	# in: (board, prev input) out: (rotated board, next input)
	Iter ← {𝕊(obj_row‿obj_col)‿prev_board:
		# •Out (25/"-") ∾ "Iter" ∾ (25/"-")
		input ↩ Turn90 prev_board

		obj ← obj_row‿obj_col
		# "obj"⊸Log obj

		# "rotated (unchanged guard)"⊸Log 1⊑¨ input

		elm_idx ← ⊑(/(obj⊸≡)∘⊑¨) ⥊ input
		row‿col ← input IdxToRowCol elm_idx
		grabbed ← ∾ row‿col⊑input
		row_pairs ← row⊏input
		row_chars←1⊑¨ row_pairs

		!'>'=char #sanity check
		char_idx ← col
		hash_idxs ←  >/'#'=row_chars

		next_hashes ← ((char_idx⊸<)¨/⊢) hash_idxs
		no_more_next ← 0=≠next_hashes

		{ no_more_next ?
			# •Out "donezo"
			range ← (char_idx+↕ cols-char_idx)⊏row_pairs
			new_state ← <∘⊑˘>range
			state ↩ state∾new_state
			@
		;
			# •Out "THERE IS MORE"
			next_hash_idx ← ⊑next_hashes
			range ← (char_idx+↕ next_hash_idx-char_idx)⊏row_pairs
			new_state ← <∘⊑˘>range

			next_obj ← ⊑ (row‿(1-˜next_hash_idx))⊑input
			# •Show Turn90⁼ Turn90 1⊸⊑¨input
			state ↩ state∾new_state

			next_obj‿(Turn90⍟2 input)
		}
	}


	Iter•_while_(@⊸≢) first_obj‿joined

	RiskyParse ← •Bqn
	term_width ← RiskyParse 1⊑ •SH ⟨"tput", "cols"⟩
	•Out term_width/"-"

	"state" Log ≠ ⍷ ∧ state

}

PartTwo ← {𝕊lines:

	char ← '>'
	# •Show RotateGuard char

	# "lines"⊸Log¨ lines

	input ← 5‿5⥊ @+97 + ↕26
	# •Show Turn90⁼ Turn90⍟1 input
	# •Exit 0
	input ↩ >˘ lines
	input ↩ (('.'⊸=◶⊢‿'○')¨)⌾⥊ input
	# "orig input" Log input
	Joiner ← {y𝕊line: ((↕≠line)⋈¨˜y)⋈¨line}
	input_with_obj← ((↕≠) Joiner˘ ⊢)input
	rows‿cols ← ≢input_with_obj
	# "joined coords"⊸Log 0⊑¨ Turn90 joined
	# "joined char"⊸Log 1⊑¨ joined
	first_row‿first_col ← ((⊑·/ ≠¨)⋈(⊑∘(≠¨∾∘/⊢)))  <∘/˘ {⌈´∾˘chars⊸∊⋈ 1⊑𝕩}¨ input_with_obj
	first_obj ← first_row‿first_col
	"first row,col" Log first_row‿first_col
	# •Exit 0

	# in: (board, prev input) out: (rotated board, next input)
	Iter ← {𝕊(obj_row‿obj_col)‿prev_board:
		degrees ← 90×4|turns
		# •Out (25/"-") ∾ "Iter degrees: " ∾ (•Fmt degrees) ∾ (25/"-")
		input ↩ Turn90 prev_board

		obj ← obj_row‿obj_col
		# "obj"⊸Log obj

		# "rotated (unchanged guard)"⊸Log 1⊑¨ input

		elm_idx ← ⊑(/(obj⊸≡)∘⊑¨) ⥊ input
		row‿col ← input IdxToRowCol elm_idx
		grabbed ← ∾ row‿col⊑input
		row_pairs ← row⊏input
		row_chars←1⊑¨ row_pairs

		!'>'=char #sanity check
		char_idx ← col
		hash_idxs ←  >/'#'=row_chars

		next_hashes ← ((char_idx⊸<)¨/⊢) hash_idxs
		no_more_next ← 0=≠next_hashes

		res ← { no_more_next ?
			# •Out "donezo"
			range ← (char_idx+↕ cols-char_idx)⊏row_pairs
			new_steps ← <∘(degrees⊸⋈)∘⊑˘>range
			overlapping_steps ← new_steps∊steps
			any_overlap ← ⌈´ overlapping_steps

			{ any_overlap ?
				# •Out "looping on last"
				"loop"
			;
				steps ↩ steps∾new_steps
				@
			}
		;
			next_hash_idx ← ⊑next_hashes
			range ← (char_idx+↕ next_hash_idx-char_idx)⊏row_pairs
			new_steps ← <∘(degrees⊸⋈)∘⊑˘>range

			overlapping_steps ← new_steps∊steps
			any_overlap ← ⌈´ overlapping_steps

			{ any_overlap ?
				# •Out "looping in first"
				"loop"
			;

				next_obj ← ⊑ (row‿(1-˜next_hash_idx))⊑input
				# •Show Turn90⁼ Turn90 1⊸⊑¨input
				steps ↩ steps∾new_steps

				next_obj‿(Turn90⍟2 input)
			}
		}

		turns 1⊸+↩
		res
	}




	RiskyParse ← •Bqn
	term_width ← RiskyParse 1⊑ •SH ⟨"tput", "cols"⟩
	•Out term_width/"-"

	steps ← ⟨⟩
	turns ← 0
	Iter•_while_(@⊸≢) first_obj‿input_with_obj

	"orig_steps"⊸Log orig_steps ← steps
	"num orig_steps" Log ≠orig_steps
	# "turns" Log turns

	all_to_remove ← •Show ⍷ 1⊸⊑¨ orig_steps
	•Out term_width/"!"

	tries ← 0

	TryWithObstacle ← {𝕊to_remove:
		tries 1⊸+↩
		"tries" Log tries
		# add obstacle to input for this iteration
		input ← (to_remove⊸≡∘⊑)◶⊢‿('#'⌾(1⊸⊑))¨ ⌾⥊  input_with_obj
		# "input" RLog 1⊸⊑¨input

		steps ↩ ⟨⟩
		turns ↩ 0
		# "first_obj" Log  first_obj
		Iter•_while_{
			is_done ← (@⊸≡)𝕩
			is_looping ← ("loop"⊸≡)𝕩

			# "is_done" Log is_done
			is_looping
			 continue ← (0=is_done) ⌊ (0=is_looping)

			 continue
			 continue

			} first_obj‿input

	}
		to_remove ← ⊑all_to_remove
		# TryWithObstacle to_remove

	results ← TryWithObstacle¨ all_to_remove
	loops ← ("loop"⊸≡)¨ results
	"len loops" Log +´ loops



}

SolutionValidator ← {part‿expected𝕊answer:
	err_msg ← ("Part "∾(•Fmt part)∾" is wrong! Got instead: "∾(•Fmt answer))
	err_msg!(expected= answer)
	•Show "Correctly solved Part "∾(•Fmt part)∾": "∾(•Fmt answer)
}

PartialSolutionValidator ← {part‿expected𝕊answer:
	err_msg ← ("Part "∾(•Fmt part)∾" is too low! Got instead: "∾(•Fmt answer))
	•Show expected‿answer
	"expected is < answer" Log expected<answer
	err_msg!(expected< answer)
	•Show "Correctly solved Part "∾(•Fmt part)∾": "∾(•Fmt answer)
}

foo ← ⟨@, @, "loop", @⟩
"foo" Log foo

•Show +´ ("loop"⊸≡ •Show)¨foo


# "part 1: " Log PartOne data
# "part 2: " Log PartTwo data
# 1‿4752 SolutionValidator PartOne data
# 2‿6 SolutionValidator PartTwo data
2‿1720 PartialSolutionValidator PartTwo data
