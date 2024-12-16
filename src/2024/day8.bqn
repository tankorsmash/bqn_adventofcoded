data ← •file.Lines "../../samples/2024/day8.txt"
# data ↩ •file.Lines "../../samples/2024/day8_alt.txt"
# data ↩ •file.Lines "../../inputs/2024/day8.txt"

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
	"ant_coords" Log ant_coords ← (>lines)⊸IdxToRowCol¨ antennae
	•Out 50/"-"

	FindAnts ← {𝕊char:
		char_idxs ← /∘(char⊸=) ∾lines
		"coords" Log coords ← (>lines)⊸IdxToRowCol¨ char_idxs
		"rows,cols" RLog rows‿cols ← shape ←≢>˘lines

		raw_pairs ←  ≍⌜˜ coords
		•Out 50/"-"
		# nonempty pairs of coords
		•Show pairs ← (0⊸≠≠¨)⊸/˘ (≢˝¨)⊸(/¨) raw_pairs
		((-˝)+⊏) pair ← ⊑ pairs
		all_antinodes ← ((-˝)+⊏)¨ pairs
		WithinBounds ← {𝕊antinode:
			maxes ← <˝ >shape⋈   antinode
			mins ← >˝ >(0‿0)⋈   antinode

			¬ ⌈´ (maxes)∾(mins)
		}
		•Show  ≠ (ant_coords⊸(¬∘∊˜))⊸/ (WithinBounds¨)⊸/ ⥊all_antinodes
	}
	char ← 0⊑freqs
	# FindAnts char
	+´ FindAnts¨ freqs
}

PartTwo ← {𝕊lines:
	∞
}

SolutionValidator ← {part‿expected𝕊answer:
	err_msg ← ("Part "∾(•Fmt part)∾" is wrong! Expected: " ∾ (•Fmt expected )∾ ", got: "∾(•Fmt answer))
	err_msg!(expected= answer)
	•Show "Correctly solved Part "∾(•Fmt part)∾": "∾(•Fmt answer)
}

AtLeastPartialSolutionValidator ← {part‿expected𝕊answer:
	err_msg ← ("Part "∾(•Fmt part)∾" is too low! Got instead: "∾(•Fmt answer))
	•Show expected‿answer
	"expected is < answer" Log expected<answer
	err_msg!(expected< answer)
	•Show "Correctly solved Part "∾(•Fmt part)∾": "∾(•Fmt answer)
}

AtMostPartialSolutionValidator ← {part‿expected𝕊answer:
	err_msg ← ("Part "∾(•Fmt part)∾" is too hight! Got instead: "∾(•Fmt answer))
	•Show expected‿answer
	"expected is > answer" Log expected>answer
	err_msg!(expected< answer)
	•Show "Correctly solved Part "∾(•Fmt part)∾": "∾(•Fmt answer)
}

# "part 1: " Log PartOne data
# "part 2: " Log PartTwo data

# sample
1‿14 SolutionValidator PartOne data
# input
# 1‿??? SolutionValidator PartOne data

# sample
# 2‿??? SolutionValidator PartTwo data
# input
# 2‿??? SolutionValidator PartTwo data
