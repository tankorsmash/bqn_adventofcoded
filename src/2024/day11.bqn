data ← •file.Lines "../../samples/2024/day11.txt"
# data ↩ •file.Lines "../../samples/2024/day11_alt.txt"
# data ↩ •file.Lines "../../inputs/2024/day11.txt"



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

iters ← ⟨⟩
PartOne ← {𝕊lines:
	Incr ← {𝕩} #{𝕊stone: iters ↩ iters∾stone}
	Next ← {
		0: Incr 0⋄⟨1⟩;
		𝕊stone: 0=2⊸|≠•Repr stone ?
			Incr stone
			len ← ÷⟜2≠  repr ← •Repr  stone
			(•ParseFloat len↑repr)‿(•ParseFloat len↓repr)
		;
		𝕊stone: Incr stone⋄⟨stone × 2024⟩
	}

	stones ←  •ParseFloat¨ ((' '⊸≠))⊸/¨ (+`' '⊸=)⊸⊔ ⊑lines
	res ← ≠ (∾ Next¨)⍟25 stones
	"iters" Log (≠iters)‿(≠⍷iters)

	res

}

PartTwo ← {𝕊lines:
	memo ← ⟨0⟩ •Hashmap ⟨⟨1⟩⟩
	•Show memo

	# Incr ← ⊢
	# Incr ← {𝕊stone: iters ↩ iters∾stone}
	Save ← {stone𝕊val:
		stone memo.Set val
	}
	Next ← {
		𝕊stone: { has← memo.Has stone }? {
			memo.Get stone
		};
		# 0: Incr 0⋄⟨1⟩;
		𝕊stone: 0=2⊸|≠ repr←•Repr stone ?
			# Incr stone
			len ← ÷⟜2≠  repr
			res ← (•ParseFloat len↑repr)‿(•ParseFloat len↓repr)
			# "split" RLog res
			stone Save res
			res
		;
		𝕊stone: {
			# Incr stone
			res ← ⟨stone × 2024⟩
			# "default" RLog res
			stone Save res
			res
			}
	}


	start ← •Monotime @
	stones ←  •ParseFloat¨ ((' '⊸≠))⊸/¨ (+`' '⊸=)⊸⊔ ⊑lines
	iterations ← "iterations" Log 25
	res ← ≠ (∾ Next¨)⍟iterations stones
	"iters" Log (≠iters)‿(≠⍷iters)
	end ← •Monotime @
	"elapsed" Log end-start

	res
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
# "part 2: " Log PartTwo  data

# sample
# 1‿55312 SolutionValidator PartOne data
# input
# 1‿194482 SolutionValidator PartOne data

# sample
# 2‿??? SolutionValidator PartTwo data
2‿55312 SolutionValidator PartTwo data
# input
# 2‿??? SolutionValidator PartTwo data
