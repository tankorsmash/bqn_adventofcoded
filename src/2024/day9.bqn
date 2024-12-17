data ← •file.Lines "../../samples/2024/day9.txt"
# data ↩ •file.Lines "../../samples/2024/day9_alt.txt"
# data ↩ •file.Lines "../../inputs/2024/day9.txt"

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
	raw_data_config ← ↑‿2⥊(•ParseFloat ⋈)¨ ⊑ lines
	"data_config" RLog data_config ← (↕≠)⊸(⥊⊸⋈˘)  raw_data_config

	SwapBoth ←{str𝕊last_dig_idx‿first_space_idx:
		swapped_str ← (last_dig_idx⊑str)⌾(first_space_idx⊸⊑) str
		 '.'⌾(last_dig_idx⊸⊑) swapped_str
	}

	Render ← {⟨idx⟩‿(size‿space):
		chr ← @+(48 + idx)
		datum ← size⥊chr
		padding ← space⥊('.')
		datum∾padding
	}
  first_rendered ← ∾ <∘Render˘ data_config
	# "first_rendered" RLog first_rendered


	# rendered ↩ "123..."
	GetIndices ← ((¯1⊸⊑·/¬)⋈ ⊑∘/)∘('.'⊸=)

	Iter ← {𝕊rendered:
		last_dig_idx‿first_space_idx ← GetIndices rendered
		next_rendered ← rendered SwapBoth last_dig_idx‿first_space_idx
		# "new_rendered" RLog next_rendered
	}
	Cond ← {𝕊next_rendered:
		last_dig_idx‿first_space_idx ← GetIndices next_rendered
		greater_than ← last_dig_idx>first_space_idx
		# "greater than?" RLog greater_than
	}
	final_rendered ← Iter •_while_ Cond first_rendered
	# "final_rendered" RLog final_rendered

	+´ ×´˘ (↕≠)⊸(≍˘) •ParseFloat∘⋈¨ ('.'⊸≠)⊸/final_rendered
	# TODO: if last_dig > first_space then we are done moving around
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


# "part 1: " Log PartOne data
# "part 2: " Log PartTwo data

# sample
1‿1928 SolutionValidator PartOne data
# input
# 1‿??? SolutionValidator PartOne data

# sample
# 2‿??? SolutionValidator PartTwo data
# input
# 2‿??? SolutionValidator PartTwo data
