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

	lines ↩ ⋈"4523 0"

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
			# "stone" RLog stone
			!⟨⟩≡≢stone

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


	#      ⌜-------------------------------------⌝
	# 0 -> 1 -> 2024 -> 20 24 -> 2 0 2 4 -> 4028 1 4028 8096
	# 0 -> 1 -> 2024 -> 20 -> 2 -> 4028 -> 40 -> 4
	#                                         -> 0
	#                                      28 -> 2
	#                                         -> 8 -> 16192 -> 32772608 -> 3277 -> 32 -> 2
	#                                                                                 -> 3 -> 6072 -> 60
	#                                                                                              -> 72
	#                                                                           -> 77 -> 7
	#                                                                                 -> 7
	#                                                                   -> 2608
	#											    0 -> 1
	#										24 -> 2 -> 4028
	#                         4 -> 8096

	start ← •Monotime @
	stones ←  •ParseFloat¨ ((' '⊸≠))⊸/¨ (+`' '⊸=)⊸⊔ ⊑lines
	PairORIG ← ∾(Next˘⊸(⋈¨)∘⊑¨)
	Pair ← {∾ {𝕊s:
			nums ← (Next˘∘⊑∘("s"⊸Rlog)) s
			"nums" Rlog nums∾¨(<s)
		}¨  𝕩}
	"final"⊸Rlog¨ Pair⍟4 "stones" RLog ⋈¨stones
	# 45‿4523
	# 23‿4523
	# 1‿0

	•Show (↕≠)•Show 11‿22‿33
	•Show (↕≠"abc")⊸(∾˘)"abc"

	•Exit 0
	iterations ← "iterations" Log 1
	res ←  (∾ Next¨)⍟iterations stones
	"iters" Log (≠iters)‿(≠⍷iters)
	end ← •Monotime @
	"elapsed" Log end-start

	"res"Log res
	≠res
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
