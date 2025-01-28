data ← •file.Lines "../../samples/2024/day11.txt"
# data ↩ •file.Lines "../../samples/2024/day11_alt.txt"
data ↩ •file.Lines "../../inputs/2024/day11.txt"



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
	known_stones ← ⟨⟩

	NewIter ← {
		𝕊paths‿⟨⟩: {
			•Out 50/"E"
			•Show (<"EMPTY")
			< paths ∾ <⟨⟩
		};
		𝕊paths‿stone: ∧´ ⥊stone ∊ known_stones ? {
			•Out 50/"Y"
			"paths" RLog paths
			"stone" RLog (stone)
			new_path ← ⋈stone

			new_paths ←(stone⊸∾˜¨ paths) ∾ (<new_path)
			res ← < new_paths  ∾ <⟨⟩
			# "res is known" RLog res
			# res: [Path[], Stone]
		};
		𝕊paths‿stone: {
			•Out 50/"N"
			"paths" RLog paths
			"stone" RLog (stone)
			known_stones ∾⟜stone ↩

			new_path ← ⋈stone
			new_paths ←(stone⊸∾˜¨ paths) ∾ (<new_path)
			new_stones ← Next stone
			res ← Unify ⟨<new_paths, new_stones⟩
			# "res " RLog res
			# res: [Path[], Stone]
		};
		𝕊arg: {
			•Show "no match"
			•Show arg
			"Pattern matching failed" !0
		}
	}

	Unify ← {𝕊paths‿new_stones:
		•Show paths
		•Show new_stones
		res ← (paths) ∾⌜ new_stones
		"unify"⊸RLog¨ res
	}
	•Show¨  ("Iter"⊸RLog¨ ∘ ∾ ∘(NewIter¨))⍟2 ⟨⟩⊸⋈¨0‿0‿1
	•Exit 0


	# •Show stones
	unique_stones ← ⍷ { res ← ∾ Next¨ 𝕩 ⋄ •Show (≠⍷res)‿(≠res)⋄ res}⍟50 stones
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

	all_stones ← ⍷ stones ∾ unique_stones
	unique_paths ← FuncTwo¨ all_stones
	FindPath ← {𝕊stone:
		res ← (/·stone⊸= ⊑∘⊑¨)⊸⊏unique_paths
	}

	•Out 50/"-"
	# "values" Rlog ∧⍷ ls
	# "counts" Rlog ≠¨ (0≠≠¨)⊸/ ⊔ ls

	New ← (((⊑¨·⊔⊐)⊸⊏) ⋈¨ (≠¨·⊔⊐))
	ToMap ← ⍉·  >· New · ∾((¯1⊑⊑)∘FindPath)¨
	Find ← {k𝕊map: (/k=⊏)⊸⊑⟜(1⊸⊏) map}⎊[⟨⟩,⟨⟩]
	# •Show ⊔⊐ ∾((¯1⊑⊑)∘FindPath)¨ ⋈125
	# •Exit 0
	maps ← ⍉ > ⋈⟜ToMap¨ all_stones
	paired ← (⊑stones) Find  maps
	# paired ← (17) Find  maps

	# •Show 20 Find paired

	all_vals ← all_stones ({key𝕊m: sum← +´∘(1⊸⊏) key Find m⋄ key‿sum}¨)  <maps
	# "all_vals" RLog  all_vals
	keys ← 0⊏paired
	# "keys" RLog keys
	# vals ← keys ({key𝕊m: sum← (1⊸⊏) key Find m⋄ key‿sum}¨)  <maps
	memo2 ← ⟨0⟩ •Hashmap ⟨⟨1⟩⟩

	Save2 ← {stone𝕊resulting_stones:
		stone memo2.Set resulting_stones
		# known_stones ↩ known_stones∾stone
	}

	i ← 0
	Iter ← {
			steps𝕊stone: steps ≤ 75 ?
					i 1⊸+↩

					(0⊸=100⊸|)◶⊢‿•Show
					res ← stone Find  maps
					first_keys ←  ⊏ res
					first_mults ← 1⊏ res
					# get first children
					# "first_keys" RLog first_keys

					# get 1st children of 1st children
					# second_children ← first_keys Find¨  <maps
					# "second_children" RLog second_children
					# "2nd shape" RLog (≢) second_children

					first_vals ← (steps+25)⊸Iter¨ first_keys

					+´ first_mults × first_vals

			; 𝕨𝕊stone: memo2.Has stone ? {
				memo2.Get stone
			}

			; steps𝕊stone: {
				res ← stone Find  maps
				first_keys ←  ⊏ res
				first_mults ← 1⊏ res
				stone⊸Save⟜⊢  r ← +´ first_mults
				r
			}
	}
	# "multipliers" RLog multipliers ← ((0⊸(⊏˘))) paired
	# •Show ⍷ stones∾unique_stones

	res ← +´ 0 Iter¨ stones



# # 0  flips
# 1 -> 3 3
#
# # 1	flips
# 3 -> 5 5 2 2
# 3 -> 5 5 2 2
#
# # 2 flips
# 5 -> 7 7
# 5 -> 7 7
# 2 -> 4 4
# 2 -> 4 4


qwe ← "
1    3        6    5    2
2 2  4 4 1    7    6 6  3
3 3  5 5 2 2  8 8  7 7  4 4
"

	# 125 maps to 0,1,2
	#             5,6,7

	# 0 maps to   2,3,4
	#						  7,8,9

	# 2 maps to   4,5,6
	#						  9,2,1


	•Out "done"
	res

	# ls ← ∾((¯1⊑⊑)∘FindPath)¨ ⋈125
	# rs ← ∾((¯1⊑⊑)∘FindPath)¨ ⋈17
	# ls +○≠ rs
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
	err_msg!(expected< answer)
	•Show "Correctly solved Part "∾(•Fmt part)∾": "∾(•Fmt answer)
}

AtMostPartialSolutionValidator ← {part‿expected𝕊answer:
	err_msg ← ("Part "∾(•Fmt part)∾" is too high! Got instead: "∾(•Fmt answer))
	err_msg!(expected> answer)
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
# 2‿55312 SolutionValidator PartTwoAlt data

2‿(232454128072351) AtLeastPartialSolutionValidator PartTwoAlt data

# •Show ∾¨ ⥊ ((< 10+↕5)‿(< 100+↕5))∾⌜ "ab"


# Next ← ×⟜2024

# •Show Unify ⟨⟨⟨1⟩⟩,20‿24⟩
# •Show (<↕3) ∾(<↕3) ∾ <↕3

# input
# 2‿??? SolutionValidator PartTwo data
