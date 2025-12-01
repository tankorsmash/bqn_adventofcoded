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

# step, stone -> value
cache ← ⟨⟩ •Hashmap ⟨⟩
CacheIt ← {step‿stone𝕊value:
	step‿stone cache.Set value
}

pows ← 10⋆ •Show ↕16
evens ← 0⌾⊑ 0=2|↕16
rests ← 0⌾⊑ ¬evens
•Show 10⊸(⋆⁼)500

•Show¨ +´∘⊑¨ { ns𝕊vs:
  lens ← pows⍋vs
  rn‿rv ← ∾¨<˘⍉>⟨
    {ns←(lens=0)/ns ⋄ ⟨ns, 1¨ns⟩}
    {ns‿vs‿ls: ⟨ns∾ns, ((ls÷2)⊏pows) (| ∾ ⌊∘÷˜) vs⟩} (lens⊏evens)⊸/¨ ns‿vs‿lens
    2024⊸×⌾(1⊸⊑) (lens⊏rests)⊸/¨ ns‿vs
  ⟩
  g ← ⊐ rv
  ⟨+´¨ g ⊔ rn, (∊g)/rv⟩
}´⍟(⋈25) 1¨⊸⋈ ⟨0, 27, 5409930, 828979, 4471, 3, 68524, 170⟩

•Exit 0
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
		𝕊stone: memo.Has stone ? { memo.Get stone };

		0: Incr 0⋄0⊸Save⊸⊢⟨1⟩;

		𝕊stone: 0=2⊸|≠ repr ← •Repr stone ? {
			!⟨⟩≡≢stone
			Incr stone
			len ← ÷⟜2≠  repr
			stone⊸Save⊸⊢ len(↑⋈○•ParseFloat↓)repr
		};

		𝕊stone: Incr stone⋄stone⊸Save⊸⊢⟨stone × 2024⟩
	}


	stones ←  •ParseFloat¨ (' '⊸≠)⊸/¨ (+`' '⊸=)⊸⊔ ⊑lines
	known_stones ← ⟨⟩

	NewIter ← {
		𝕊paths‿⟨⟩: {
			# •Out 50/"E"
			# •Show (<"EMPTY")
			< paths ∾ <⟨⟩
		};
		𝕊paths‿stone: ⊑ stone ∊ known_stones ? {
			new_path ← ⋈stone

			new_paths ←(stone⊸∾˜¨ paths) ∾ (<new_path)
			res ← < new_paths 
		};
		𝕊paths‿stone: {
			# •Out 50/"N"
			# "paths" RLog paths
			# "stone" RLog (stone)
			known_stones ∾⟜stone ↩

			new_path ← ⋈stone
			new_paths ←(stone⊸∾˜¨ paths) ∾ (<new_path)
			new_stones ← Next stone
			res ← Unify ⟨<new_paths, new_stones⟩
			# "res " RLog res
			# res: [Path[], Stone]
		};
		𝕊arg: {
			arg
		};
		𝕊arg: {
			•Show "no match"
			•Show arg
			"Pattern matching failed" !0
		}
	}

	Unify ← {𝕊paths‿new_stones:
		# •Show paths
		# •Show new_stones
		res ← (paths) ∾⌜ new_stones
		# "unify"⊸RLog¨ res
	}
	•Show¨  (∾ ∘(NewIter¨))⍟2 ⟨⟩⊸⋈¨0‿0‿1


	# •Show stones
	unique_stones ← ⍷ { res ← ∾ Next¨ 𝕩 ⋄ •Show∘•Show (≠⍷res)‿(≠res)⋄ res}⍟50 stones
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
2‿55312 SolutionValidator PartTwoAlt data

# 2‿(232454128072351) AtLeastPartialSolutionValidator PartTwoAlt data

# •Show ∾¨ ⥊ ((< 10+↕5)‿(< 100+↕5))∾⌜ "ab"


# Next ← ×⟜2024

# •Show Unify ⟨⟨⟨1⟩⟩,20‿24⟩
# •Show (<↕3) ∾(<↕3) ∾ <↕3

# input
# 2‿??? SolutionValidator PartTwo data

memo ← ⟨⟩ •Hashmap ⟨⟩
Save ← {stone𝕊resulting_stones:
	stone memo.Set resulting_stones
# known_stones ↩ known_stones∾stone
}
NextStone ← {
	𝕊stone: memo.Has stone ? { memo.Get stone };

	0: 0⊸Save⊸⊢⟨1⟩;

	𝕊stone: 0=2⊸|≠ repr ← •Repr stone ? {
		!⟨⟩≡≢stone
		len ← ÷⟜2≠  repr
		stone⊸Save⊸⊢ len(↑⋈○•ParseFloat↓)repr
	};

	𝕊stone: stone⊸Save⊸⊢⟨stone × 2024⟩
}

Next ← {steps_left𝕊stone:
	{
		steps_left -↩ (stone ≤  4)
		steps_left -↩ 2×(stone >  4)
		steps_left ≤0 ? ⟨1⟩ ;
		stone = 0 ? ⟨1⟩ ;
		{
		 new_stones ←	∾´ ⥊ NextStone¨ 𝕩
		 •Show ≠ new_stones
		 new_stones}⍟(3⌊steps_left) stone
	}
}


# •Show 3 Next 1
# •Show NextStone 1
AddXToY ← {x𝕊y: x + y}

# {{•Out (•Fmt ≠)⊸(∾⟜" "⊸∾)⟜(80⊸↑•Fmt)}⊸⊢  ∾NextStone¨ 𝕩}⍟40 ≍1004
"starting" Rlog first_stone ← 368
known_stones ← ⟨first_stone⟩
known_paths ← ⟨first_stone‿⟨⟩⟩

pwrs ← 2⊸⋆ 1+↕20
# "stones" Rlog stones ← ⟨131, 22, 1000, 10120⟩
# "are pwr2" Rlog ⊏⟜stones / ∊⟜pwrs ≠∘•Repr¨ (stones)
# "are not pwr2" Rlog ⊏⟜stones / ¬ ∊⟜pwrs ≠∘•Repr¨ (stones)

i ← 0
# stones ← ⟨0,27,5409930, 828979, 4471, 3, 68524, 170  ⟩
stones ← ⟨2⟩
total_steps ← 5

# 30 ScoreDigits 1
# 4 + 4 + 4 + 4 + 4...
ScoreDigits ← {
	current_step𝕊1:
		# TODO handle less than 4 steps
		#...

		# else:
		4
}

ds ← ⟨⟩ #degrading_stones
sd ← ⟨⟩ #single digits
AddAndPrune ← {current_step𝕊stone:
	new_stones ← NextStone stone
	# unk_stones ← (new_stones (¬∘∊ (⍷∘/) ⊣) known_stones)
	# known_stones ∾↩ unk_stones
	# "i"Rlog i
	ds ↩ ds ∾⋈ current_step⋈(	⊏⟜new_stones / ∊⟜pwrs ≠∘•Repr¨ (new_stones))
	# sd ↩  "valid" Rlog (<⟜10)⊸/ new_stones
	# gt9 ← "gt 9" Rlog  (>⟜9)⊸/ new_stones
	# "unk" RLog unk_stones
	# unk_stones
  ⊏⟜new_stones / ¬ ∊⟜pwrs ≠∘•Repr¨ (new_stones)
	new_stones
}

res ← {
	i↩0
	•Show {
		i 1⊸+↩
		•Show { (≠𝕩)‿(𝕩)}⊸⊢  ∾  (i⊸AddAndPrune)¨ 𝕩 }⍟total_steps 𝕩
}¨ stones
"res" RLog res
# "known stones" RLog ≠ known_stones

"ds1"Rlog >ds
# "ds"⊸Rlog¨ ∾1⊑¨¨ ⊑¨⊸⊔ ds

# 12340131
# 1234 131
# 12 34 265144
# 1 2 3 4 265 144
# x x x x 536360 291456
# x x x x 536 360 291 456
# x x x x 1084864 728640 588984 922944
# x x x x 2195764736 728 640 588 984 922 944
# x x x x 2195764736 1473472 1295360 1190112 1991616 1866128 1910656




# •Show "Start"
# steps ← 35
# stone ← 9
# "result" Rlog ≠ res← steps Next stone
•Show "done"

# •Show table ← >2024⊸×⊸(⋈˜)¨ ↕10
# # •Show > (↕10) ⋈¨ (1⊑˘ table) × 1⌈(1×2024⊸×⍟⊢)¨ ≥⟜5⊑˘ table
# •Show adj_table ← {×⟜2024⌾(1⊸⊏˘∘((≥⟜5  ⊑˘𝕩)⊸/))𝕩}  table
# •Show {•Show 𝕨-𝕩⋄𝕩}`•ParseFloat∘↑´˘ >{ 2÷˜≠¨ }⊸⋈˘ •Repr¨ (4↓  1⊸⊑˘) adj_table


