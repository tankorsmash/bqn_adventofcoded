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
	knowns ← ⟨⟩
	# •Show memo

	# lines ↩ ⋈"125 17"

	# Incr ← ⊢
	# Incr ← {𝕊stone: iters ↩ iters∾stone}
	Save ← {stone𝕊val:
		stone memo.Set val
		knowns ↩ knowns∾stone
	}
	Next ← {
		𝕊stone: { has← memo.Has stone }? {
			memo.Get stone
		};
		0: 0 Save 1 ⋄⟨1⟩;
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
	# PairORIG ← ∾(Next˘⊸(⋈¨)∘⊑¨)
	Foo ← {𝕊s:
		nums ← (Next˘∘⊑) s
		res ← nums∾¨(<s)
		# "res" Rlog res
		# "news" Rlog news ← ⊑¨res

		res
	}

	known_paths ← ⟨⟩
	Pair ← {
		firsts ← ⊑¨𝕩
		is_old ← firsts∊knowns
		old_paths ← is_old/𝕩
		known_paths ↩ old_paths∾known_paths

		not_old← (¬is_old)/𝕩
		∾Foo¨  not_old
	}
	# •Show 1= 1∊↕10
	# •Exit 0
	"stones" RLog stones
	iterations ← 25
	unfinished ← Pair⍟25 "stones" RLog ⋈¨stones
	"unfinished"⊸Rlog ≠unfinished
	"known_paths" RLog ≠known_paths

	# •Show ((1⊸=)×(0⊸≠≠))¨(⌈´∾)⊸=(/stone⊸=)¨ known_paths
	FindPathsContaining ← {𝕊max_range‿stone: max_range > 0? {
			FindRange ← {𝕊path:leftmost‿num ← (⊑⋈(⊑·/stone⊸=))path}
			AdjRange ← {
				leftmost‿num← FindRange 𝕩
				leftmost‿(max_range-num)
			}
			AdjRange¨ (1⊸⊑∘FindRange¨)⊸/ ((0⊸≠≠)·/stone⊸=˜)¨⊸/ known_paths
		}; 𝕊max_range‿stone: ⟨stone⟩
	}
	# •Show¨ known_paths

  # "len"⊸RLog ≠ ∾FindPathsContaining¨ ⟨iterations‿125,iterations‿17⟩
  # "len"⊸RLog ≠∾FindPathsContaining¨ ⟨iterations‿125⟩
  "len"⊸RLog ≠ ∾ FindPathsContaining¨ ⟨iterations‿125⟩

	123


	# •Exit 0
	# iterations ← "iterations" Log 1
	# res ←  (∾ Next¨)⍟iterations stones
	# "iters" Log (≠iters)‿(≠⍷iters)
	# end ← •Monotime @
	# "elapsed" Log end-start
  #
	# "res"Log res
	# ≠res
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
