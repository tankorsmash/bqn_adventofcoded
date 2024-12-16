data ← •file.Lines "../../samples/2024/day8.txt"
# data ↩ •file.Lines "../../samples/2024/day8_alt.txt"
data ↩ •file.Lines "../../inputs/2024/day8.txt"

# dyadic show but returns paired args
DShow ← {•Show 𝕨‿𝕩⋄ 𝕩}

Log ← {msg𝕊val:
	•Show (<msg)∾val
	val
}
RLog ← {msg𝕊val:
	•Show (msg)⋈val
	val
}

IdxToRowCol ← {board𝕊idx:
	rows‿cols ← ≢ board
	row ← ⌊ idx÷rows
	col ← rows|idx
	row‿col
}

PartOne ← {𝕊lines:
	freqs ← '.'⊸≠⊸/⍷∾lines

	antennae ← / '.'⊸≠∾lines
	ant_coords ← (>lines)⊸IdxToRowCol¨ antennae

	FindAnts ← {𝕊char:
		char_idxs ← /∘(char⊸=) ∾lines
		coords ← (>lines)⊸IdxToRowCol¨ char_idxs
		rows‿cols ← shape ←≢>˘lines

		raw_pairs ←  ≍⌜˜ coords
		# •Out 50/"-"

		# nonempty pairs of coords
		pairs ← (0⊸≠≠¨)⊸/˘ (≢˝¨)⊸(/¨) raw_pairs
		((-˝)+⊏) pair ← ⊑ pairs
		all_antinodes ← ((-˝)+⊏)¨ pairs
		WithinBounds ← {𝕊antinode:
			maxes ← ≤˝ >shape⋈   antinode
			mins ← >˝ >(0‿0)⋈   antinode

			¬ ⌈´ (maxes)∾(mins)
		}
		bounded ← (WithinBounds¨)⊸/ ⥊all_antinodes
		# no_collision ← (ant_coords⊸(¬∘∊˜))⊸/ bounded
		bounded
	}

	≠ ⍷∾ FindAnts¨ freqs
}

PartTwo ← {𝕊lines:
	freqs ← '.'⊸≠⊸/⍷∾lines

	FindAnts ← {𝕊char:
		char_idxs ← /∘(char⊸=) ∾lines
		coords ← (>lines)⊸IdxToRowCol¨ char_idxs
		rows‿cols ← shape ←≢>˘lines

		raw_pairs ←  ≍⌜˜ coords

		# nonempty pairs of coords
		pairs ← (0⊸≠≠¨)⊸/˘ (≢˝¨)⊸(/¨) raw_pairs
		# hacky solve for 50 repeats in a row, instead of doing it smartly
		all_antinodes ←  ⥊ ∾˘ {((-˝)+⍟𝕩⊏)¨ pairs} ↕50

		WithinBounds ← {𝕊antinode:
			maxes ← ≤˝ >shape⋈ antinode
			mins  ← >˝ >(0‿0)⋈ antinode

			¬ ⌈´ maxes∾mins
		}
		bounded ← (WithinBounds¨)⊸/ all_antinodes
		bounded
	}

	antennae ← / '.'⊸≠∾lines
	ant_coords ← >∘lines⊸IdxToRowCol¨ antennae

	≠ ⍷ ant_coords∾ ∾FindAnts¨ freqs
}

SolutionValidator ← {part‿expected𝕊answer:
	err_msg ← ("Part "∾(•Fmt part)∾" is wrong! Expected: " ∾ (•Fmt expected )∾ ", got: "∾(•Fmt answer))
	err_msg!(expected= answer)
	•Show "Correctly solved Part "∾(•Fmt part)∾": "∾(•Fmt answer)
}

AtLeastPartialSolutionValidator ← {part‿expected𝕊answer:
	err_msg ← ("Part "∾(•Fmt part)∾" is too low! Got instead: "∾(•Fmt answer))
	err_msg!(expected< answer)
	•Show "Correctly solved Part "∾(•Fmt part)∾": "∾(•Fmt answer)
}

AtMostPartialSolutionValidator ← {part‿expected𝕊answer:
	err_msg ← ("Part "∾(•Fmt part)∾" is too high! Got instead: "∾(•Fmt answer))
	err_msg!(expected< answer)
	•Show "Correctly solved Part "∾(•Fmt part)∾": "∾(•Fmt answer)
}

# "part 1: " Log PartOne data
# "part 2: " Log PartTwo data

# sample
# 1‿14 SolutionValidator PartOne data
# input
1‿367 SolutionValidator PartOne data

# sample
# 2‿34 SolutionValidator PartTwo data
# input
2‿1285 SolutionValidator PartTwo data
