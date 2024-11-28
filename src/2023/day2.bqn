data ← •file.Lines "../../samples/2023/day2.txt"
# data ↩ •file.Lines "../../samples/2023/day2_alt.txt"
data ↩ •file.Lines "../../inputs/2023/day2.txt"



limits ← [
	⟨"red", "green", "blue"⟩,
	[12,13,14],
]
# •Show limits

Lookup ← {𝕊key:
	((<key) ⍷ ⊏limits) / 1⊏limits
}
# •Show Lookup "blue"

Log ← {
	msg‿val ← 𝕩
	•Show msg‿val
	val
}

SplitBy ← {char𝕊str:
	((+` char⊸=)⊔⊢) str
	}

PartOne ← {

	ParseRow ← {𝕊row:
		mask←':'= row
		grouped_mask ← +` mask
		games ← 2↓¨ 1↓grouped_mask⊔row

		# •Show ⊑games
		bags_of_games ← {
			single_games ← (';'⊸≠/⊢)¨ ';'⊸SplitBy𝕩
			bags ← (','⊸SplitBy)¨ single_games
			((0≠≠¨)/⊢)¨¨ (( (','⊸≠/⊢)¨ (' '⊸SplitBy))¨)¨ bags
		}¨  games

		# •Show bags_of_games

		grabs ← {
			bar ← ((0≠≠¨)/⊢)¨  𝕩
			(•ParseFloat ⌾(0⊸⊑)  (' '⊸≠/⊢)¨)¨ bar
			}¨  ⊑ bags_of_games
		grabs
	}

	# foo ← (⊑𝕩)
	parsed_games ← ParseRow¨ 𝕩


	IsGrabValid ← {𝕊bags:
		# Log "grabbed bags"‿bags

		grab_valids ← {𝕊count‿color:
			# Log "count"‿count
			# Log "color"‿color
			# Log "max"‿(Lookup color)
			(count ≤ Lookup color)
		}¨ bags

		⌊´ grab_valids

	}

	#train
	# (f1 f3 f2) some_val
	# (f1 some_val) f3 (f2 some_val)
	wins ← ∾ (⌊´ IsGrabValid¨)¨ parsed_games
	game_ids ← ((1+·↕≠)) wins
	# •Show¨ ((1+·↕≠)⋈¨⊢) (⌊´ IsGrabValid¨)¨ parsed_games
	+´ wins/game_ids


}

PartTwo ← {
	𝕩
}

•Show "part 1: "‿(PartOne data)
# •Show "part 2: "‿(PartTwo data)
