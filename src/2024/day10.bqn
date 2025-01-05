data ← •file.Lines "../../samples/2024/day10.txt"
data ↩ •file.Lines "../../samples/2024/day10_alt.txt"
# data ↩ •file.Lines "../../inputs/2024/day10.txt"

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

	nbors ← {⌊⊸≠÷⟜2↕≠𝕩}⊸/⥊ ⋈⌜˜ ¯1‿0‿1
	"nbors" RLog nbors
	MaxB ← (<⟜width)⊸⌊⟜(<⟜height)
	MinB ← (≥⟜0)⊸⌊⟜(≥⟜0)
	FindN ← {(MinB⌊MaxB)´¨⊸/ (𝕩⊸≢¨)⊸/ ⥊ 𝕩⊸+¨˘ nbors}
	"findn" RLog  FindN 0‿0
	coords ← ⋈⌜˜ ↕width
	# "coords" RLog coords

	heads_idx ← (/0=⥊)grid
	"heads_idx" RLog heads_idx
	head_coords ← heads_idx⊏⥊coords
	"head coords" RLog head_coords
	"grid" RLog grid
  Iter ← {step𝕊coord:

		•Out 50/"-"
		"coord" RLog coord
		next_ids ← LIdx¨ FindN coord
		(step+1)‿({((step+1)⊸=) 𝕩⊏⥊grid}⊸/ next_ids)
	}

	n_step‿n_idxs ← 0‿(0)
	"iter res" RLog n_step‿n_idxs ↩ n_step Iter LCoords ⊑ n_idxs
	"iter res" RLog n_step‿n_idxs ↩ n_step Iter LCoords ⊑ n_idxs
	"iter res" RLog n_step‿n_idxs ↩ n_step Iter LCoords ⊑ n_idxs
	"iter res" RLog n_step‿n_idxs ↩ n_step Iter LCoords ⊑ n_idxs
	"iter res" RLog n_step‿n_idxs ↩ n_step Iter LCoords ⊑ n_idxs
	"iter res" RLog n_step‿n_idxs ↩ n_step Iter LCoords ⊑ n_idxs
	"iter res" RLog n_step‿n_idxs ↩ n_step Iter LCoords ⊑ n_idxs
	"iter res" RLog n_step‿n_idxs ↩ n_step Iter LCoords ⊑ n_idxs
	"iter res" RLog n_step‿n_idxs ↩ n_step Iter LCoords ⊑ n_idxs

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

"part 1: " RLog PartOne data
# "part 2: " Log PartTwo data

# sample
# 1‿??? SolutionValidator PartOne data
# input
# 1‿??? SolutionValidator PartOne data

# sample
# 2‿??? SolutionValidator PartTwo data
# input
# 2‿??? SolutionValidator PartTwo data
