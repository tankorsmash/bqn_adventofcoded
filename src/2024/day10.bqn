data ← •file.Lines "../../samples/2024/day10.txt"
# data ↩ •file.Lines "../../samples/2024/day10_alt.txt"
data ↩ •file.Lines "../../inputs/2024/day10.txt"

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

# returns 1 if the arg is a simple number/char
IsSimple ← {𝕊val:
	⟨⟨⟩,0⟩≡(≢⋈≡)val
}

PartOne ← {𝕊lines:
	height ← ⊑≢lines
	width ← ≠⊑lines
	width‿height
	grid ← > •ParseFloat∘≍ ¨¨ lines

	LIdx ← {𝕊row‿col:
		row+height×col
	}

	LCoords ← {𝕊idx:
		row ← ⌊ idx÷height
		col ← height|idx
		col‿row
	}
	# •Show LCoords 4
	# •Exit 0

	nbors ← {⌊⊸≠÷⟜2↕≠𝕩}⊸/⥊ ⋈⌜˜ ¯1‿0‿1
	"nbors" RLog nbors
	MaxB ← (<⟜width)⊸⌊⟜(<⟜height)
	MinB ← (≥⟜0)⊸⌊⟜(≥⟜0)
	FindN ← {(MinB⌊MaxB)´¨⊸/ (𝕩⊸≢¨)⊸/ ⥊ 𝕩⊸+¨˘ nbors}
	"findn" RLog  FindN 0‿0
	coords ← ⋈˜⌜˜ ↕width
	# "coords" RLog coords

  Iter ← {𝕊step‿coord:
		# "step" RLog step
		# "coord" RLog coord
		!IsSimple step

		# •Out 50/"-"
		pot_next_ids ← LIdx¨ FindN coord
		next_idxs ← ({((step+1)⊸=) 𝕩⊏⥊grid}⊸/ pot_next_ids)
		# "next_idxs" RLog next_idxs
		next_coords ← LCoords¨ next_idxs
		next_step ← step+1

		res ← ((next_step⊸⋈))¨˘ next_coords
		# "res" RLog res
		res
		# next_coords
	}

	heads_idx ← (/0=⥊)grid
	# "heads_idx" RLog heads_idx
	head_coords ← heads_idx⊏⥊coords
	"head coords" RLog head_coords
	"grid" RLog grid
	"heads" RLog  heads ← 0⋈¨head_coords

	# s1‿c1 ← ⊑ heads
	# •Show s1‿c1
  #
	# nexts ← ⋈s1‿c1
	# "initial nexts" RLog nexts
	Loop ← {𝕊head:
		"Iter res" RLog nexts← (⍷ ∘ ∾´∘(Iter¨)⍟9) head
		≠⍷nexts
	}
	+´ Loop∘⋈¨ heads
}

PartTwo ← {𝕊lines:
	∞
}

SolutionValidator ← {part‿expected𝕊answer:
	err_msg ← ("Part "∾(•Fmt part)∾" is wrong! Got instead: "∾(•Fmt answer))
	err_msg!(expected= answer)
	•Show "Correctly solved Part "∾(•Fmt part)∾": "∾(•Fmt answer)
}

AtLeastPartialSolutionValidator ← {part‿expected𝕊answer:
	err_msg ← ("Part "∾(•Fmt part)∾" is too low! Got instead: "∾(•Fmt answer))
	err_msg!(expected≥ answer)
	•Show "Correctly solved Part "∾(•Fmt part)∾": "∾(•Fmt answer)
}

AtMostPartialSolutionValidator ← {part‿expected𝕊answer:
	err_msg ← ("Part "∾(•Fmt part)∾" is too high! Got instead: "∾(•Fmt answer))
	err_msg!(expected< answer)
	•Show "Correctly solved Part "∾(•Fmt part)∾": "∾(•Fmt answer)
}

# "part 1: " RLog PartOne data
# "part 2: " Log PartTwo data

# sample
# 1‿36 SolutionValidator PartOne data
# input
1‿674 SolutionValidator PartOne data

# sample
# 2‿??? SolutionValidator PartTwo data
# input
# 2‿??? SolutionValidator PartTwo data
