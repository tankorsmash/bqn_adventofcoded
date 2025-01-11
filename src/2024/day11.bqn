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
	known_stones ← ⟨⟩

	# lines ↩ ⋈"125 17"

	Save ← {stone𝕊resulting_stones:
		stone memo.Set resulting_stones
		known_stones ↩ known_stones∾stone
	}

	Next ← {
		𝕊stone: memo.Has stone ? {
			memo.Get stone
		};
		𝕊stone: 0=2⊸|≠ repr←•Repr stone ? {
			len ← ÷⟜2≠  repr
			!⟨⟩≡≢stone

			stone⊸Save⊸⊢ (len⊸↑•ParseFloat¨∘⋈len⊸↓) repr
		};
		𝕊stone: {
			stone⊸Save⊸⊢ ⟨stone × 2024⟩
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

	known_paths ← ⟨⟩
	BuildKnownPaths ← {
		firsts ← ⊑¨𝕩
		is_old ← firsts∊known_stones
		old_paths ← is_old/𝕩
		known_paths ↩ old_paths∾known_paths

		not_old← (¬is_old)/𝕩
		∾((Next˘∘⊑)∾¨<)¨  not_old
	}

	# "stones" RLog stones
	iterations ← 25
	unfinished ← BuildKnownPaths⍟25 "stones" RLog ⋈¨stones
	"known_paths"⊸RLog¨ known_paths
	# "unfinished"⊸Rlog ≠unfinished

	FindPathsContaining ← {𝕊max_range‿old_path: max_range > 0? {

			stone ← ⊑old_path
			FindRange ← {𝕊path:
				leftmost‿range ← (⊑⋈(¯1⊸⊑·/stone⊸=))path
			}
			AdjRange ← {𝕊new_path:
				leftmost‿range ← FindRange new_path
				diff ← max_range⌊range
				new_range ← (max_range-diff)

				new_range‿((diff↑new_path)∾(old_path))
			}

			res ← AdjRange¨ ((0⊸≠≠)·/·stone⊸=˜1⊸↓)¨⊸/ known_paths
			res

		}; 𝕊max_range‿stone: ⟨max_range‿stone⟩
	}

	# •Show table ← ⌽˘ 14↑ > (⌈´≠¨)⊸(↑¨)known_paths
	# •Show {
	# 	n ←𝕨≠𝕩
	# 	•Show n×𝕩
	# 	𝕨
	# }˝ table

	# •Show maxes ← ≠∘•Fmt¨ ( ⌈)˝ table
		# max_length { »⍟(𝕨⊸-≠𝕩) 𝕨⊸↑𝕩} maxes

	# •Exit 0

	•Out ""
	paired_stones ← •Show iterations⊸(⋈⟜⋈¨)stones
  "len"⊸Log ≠ {(•Show∘≠⊸⊢)∘∾FindPathsContaining¨}⍟5 paired_stones #⟨25‿⟨125⟩⟩
	•Out ""

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

PartTwoAlt ← {𝕊lines:
	memo ← ⟨0⟩ •Hashmap ⟨⟨1⟩⟩

	Save ← {stone𝕊resulting_stones:
		stone memo.Set resulting_stones
		# known_stones ↩ known_stones∾stone
	}


	Incr ← {𝕩} #{𝕊stone: iters ↩ iters∾stone}
	Next ← {
		𝕊stone: memo.Has stone ? {
			memo.Get stone
		};
		0: Incr 0⋄0⊸Save⊸⊢⟨1⟩;
		𝕊stone: 0=2⊸|≠•Repr stone ?

			# "stone" Rlog stone
			!⟨⟩≡≢stone
			Incr stone
			len ← ÷⟜2≠  repr ← •Repr  stone
			stone⊸Save⊸⊢(•ParseFloat len↑repr)‿(•ParseFloat len↓repr)
		;
		𝕊stone: Incr stone⋄stone⊸Save⊸⊢⟨stone × 2024⟩
	}


	stones ←  •ParseFloat¨ ((' '⊸≠))⊸/¨ (+`' '⊸=)⊸⊔ ⊑lines
	unique_stones ← ⍷ res ← (∾ Next¨)⍟25 stones



	FuncTwo ← { 𝕊is:
		paths ← ⟨⋈is⟩

		Func ← {𝕊stone:
			res ← ∾ Next¨ stone
			paths ↩ paths∾ (<(res))
			res
		}
		Func⍟25 ⋈is
		paths
	}

	unique_paths ← FuncTwo¨ stones∾unique_stones
	FindPath ← {𝕊stone:
		res ← (/·stone⊸= ⊑∘⊑¨)⊸⊏unique_paths
	}

	•Out 50/"-"
	# "values" Rlog ∧⍷ ls
	# "counts" Rlog ≠¨ (0≠≠¨)⊸/ ⊔ ls

	New ← (((⊑¨·⊔⊐)⊸⊏) ⋈¨ (≠¨·⊔⊐))
	ToMap ← ⍉·  >· New · ∾((¯1⊑⊑)∘FindPath)¨
	Find ← {k𝕊map: (/k=⊏)⊸⊑⟜(1⊸⊏) map}
	# •Show ⊔⊐ ∾((¯1⊑⊑)∘FindPath)¨ ⋈125
	# •Exit 0
	maps ← ⋈⟜ToMap¨ unique_stones

	# "paired"⊸Rlog  paired
	paired ← ToMap ⋈125
	•Show 0 Find paired

	"keys" RLog ⊏ paired



	res
	•Out "done"

	ls ← ∾((¯1⊑⊑)∘FindPath)¨ ⋈125
	rs ← ∾((¯1⊑⊑)∘FindPath)¨ ⋈17
	ls +○≠ rs
}

SolutionValidator ← {part‿expected𝕊answer:

	max_length ← expected ⌈○(≠•Fmt)  answer
	err_msg ← ("
Part "∾(•Fmt part)∾" is wrong!"∾"
Expected: "∾({»⍟(max_length⊸-≠𝕩) max_length⊸↑𝕩} •Fmt expected)∾"
  Actual: "∾({»⍟(max_length⊸-≠𝕩) max_length⊸↑𝕩} •Fmt answer))∾"
"
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
# 2‿55312 SolutionValidator PartTwo data
2‿55312 SolutionValidator PartTwoAlt data

# •Show ⊔⊐ ∧10‿2‿2‿3‿5‿9
# •Show (⊑¨·⊔⊐)⊸⊏ ∧10‿2‿2‿3‿5‿9
# •Show (≠¨·⊔⊐) ∧10‿2‿2‿3‿5‿9
# •Show (((⊑¨·⊔⊐)⊸⊏) ⋈¨ (≠¨·⊔⊐)) ∧10‿2‿2‿3‿5‿9
# •Show ((∧⍷)⋈¨(≠¨· (0≠≠¨)⊸/ ⊔))10‿2‿2‿3‿5‿9
#
# input
# 2‿??? SolutionValidator PartTwo data
