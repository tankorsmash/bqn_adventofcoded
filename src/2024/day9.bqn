data ← •file.Lines "../../samples/2024/day9.txt"
# data ↩ •file.Lines "../../samples/2024/day9_alt.txt"
data ↩ •file.Lines "../../inputs/2024/day9.txt"

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
TRLog ← {msg𝕊val:
	•Show (msg)⋈(30⊸↑val)
	val
}

# returns 1 if the arg is a simple number/char
IsSimple ← {𝕊val:
	⟨⟨⟩,0⟩≡(≢⋈≡)val
}

PartOne ← {𝕊lines:
	raw_data_config ← ↑‿2⥊(•ParseFloat ⋈)¨ ⊑ lines
	data_config ← (↕≠)⊸(⥊⊸⋈˘)  raw_data_config
	# "data_config" RLog data_config ← (↕≠)⊸(⥊⊸⋈˘)  raw_data_config

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
	# parsed ← (•ParseFloat⎊•Show)∘⋈¨ ('.'⊸≠)⊸/final_rendered
	parsed ← (-⟜(@+48)∘⊑)∘⋈¨ ('.'⊸≠)⊸/final_rendered
	+´ ×´˘ (↕≠)⊸(≍˘) parsed
}

PartTwo ← {𝕊lines:
	raw_data_config ← ↑‿2⥊ •ParseFloat∘⋈¨ ⊑ lines
	data_config ← (↕≠)⊸(⥊⊸⋈˘)  raw_data_config
	# "data_config" RLog data_config ← (↕≠)⊸(⥊⊸⋈˘)  raw_data_config

	SwapBoth ←{str𝕊orig_idx‿dest_idx:
		swapped_str ← (orig_idx⊑str)⌾(dest_idx⊸⊑) str
		 '.'⌾(orig_idx⊸⊑) swapped_str
	}

	Render ← {⟨idx⟩‿(size‿space):
		chr ← @+(48 + idx)
		datum ← size⥊chr
		padding ← space⥊('.')
		datum∾padding
	}
  first_rendered ← ∾ <∘Render˘ data_config
	unique_chars ← '.'⊸≠⊸/⍷first_rendered
	# "unique chars" RLog unique_chars


	# rendered ↩ "123..."
	GetIndices ← ((¯1⊸⊑·/¬)⋈ ⊑∘/)∘('.'⊸=)
	GroupedCounts ← {char𝕊y:
		foo ← ≠⟜«y
		indices ← /1»foo
		counts ← (≠y)(«-⊢) indices
		chars ← indices⊏y
		(char⊸=∘⊑¨⊸/) ∾¨´ chars‿counts‿indices
	}

	FormatTime ← ⥊ 6↑ •Fmt

	all_times ← ⟨⟩

	Iter ← {dig𝕊rendered:
		start ←	•MonoTime @
		times ← ⟨⟩
		TD ← {msg𝕊𝕩:
			time ← 1000×(•MonoTime @) - start
			prev ← (1⊸⊑ ¯1⊸⊑)⎊time times
			delta ← time - prev
			# msg RLog (FormatTime  time)‿(FormatTime delta)
			times ∾⟜(<msg‿time‿delta)↩
		}
		!IsSimple dig
		"1st" TD @
		# "dig" Log dig
		# "rendered" RLog rendered
		all_spaces ←  > '.'GroupedCounts rendered
		"grp" TD @
		# "all_spaces (chr, num, idx)" RLog all_spaces
		# "target" Log target ← dig GroupedCounts rendered
		digits_idx ← / dig⊸=¨rendered
		# "digits_idx" RLog digits_idx
		# •Show digits ← dig⊸=¨⊸/rendered
		# "info " RLog info ←  (<≢all_spaces)‿(<≠all_spaces)‿ (<≡all_spaces)
		"dig" TD @
		CheckCount ← (≠digits_idx)⊸≤1⊸⊑
		CheckStart ← {𝕊chr‿num‿idx: idx < ⊑digits_idx}
		# pot_addrs ← (/(CheckCount)˘)⊸⊏ all_spaces
		pot_addrs ← (/ (CheckCount ∧ CheckStart)˘)⊸⊏ all_spaces
		# "pot_pos" RLog  pot_pos
		pot_idxs ← (< · ↕⊸+´1⊸↓)˘pot_addrs
		"2nd" TD @

		# •Exit 0

		# •Show pot_idxs
		new_rendered ← { 0≠≠pot_idxs
		?
			range ← (≠digits_idx)↑⊑ pot_idxs
			# "range" RLog range
			pairs ← digits_idx ⋈¨ range
			# "pairs" RLog pairs

			next_rendered ← rendered SwapBoth˜´ pairs
			# (dig∾": new_rendered") TRLog next_rendered
			next_rendered

			"3 a" TD @
			next_rendered
		;
			# (dig∾":     rendered") TRLog rendered
			"3 b" TD @
			rendered
		}


		all_times ∾⟜(<times)↩


		new_rendered
	}
	# final_rendered ← Iter •_while_ Cond first_rendered

	# final_rendered ← (first_rendered Iter 0⊑ unique_chars) Iter 1⊑ unique_chars
	final_rendered ← (first_rendered Iter´ unique_chars)

	# •Show {𝕊msg‿time‿diff: msg‿(FormatTime diff)}¨ ∾⥊all_times

	# parsed ← •Show (-⟜(@+48))¨ •Show ('.'⊸≠)⊸/final_rendered
	# parsed ← •Show ((-⟜(@+48)•Show)⌾1⊸⊑)¨ •Show ('.'⊸≠1⊸⊑¨)⊸(/) (↕≠)⊸(⋈¨)final_rendered
	foo ← ('.'⊸≠1⊸⊑¨)⊸(/) (↕≠)⊸(⋈¨)final_rendered
	parsed ← ((-⟜(@+48))⌾(1⊸⊑) )¨ foo
	+´ ×´¨ parsed
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
# 1‿1928 SolutionValidator PartOne data
# input
# 1‿6398252054886 SolutionValidator PartOne data

all_start ←	•MonoTime @
# sample
# 2‿2858 SolutionValidator PartTwo data
# input
2‿6415666220005 SolutionValidator PartTwo data
all_end ←	•MonoTime @

"total time" RLog all_end-all_start
