data ← •file.Lines "../../samples/2023/day2.txt"
# data ↩ •file.Lines "../../samples/2023/day2_alt.txt"
data ↩ •file.Lines "../../inputs/2023/day2.txt"



limits ← [
	⟨"red", "green", "blue"⟩,
	[12,13,14],
]

Lookup ← {𝕊key:
	((<key) ⍷ ⊏limits) / 1⊏limits
}

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

		bags_of_games ← {
			single_games ← (';'⊸≠/⊢)¨ ';'⊸SplitBy𝕩
			bags ← (','⊸SplitBy)¨ single_games
			((0≠≠¨)/⊢)¨¨ (( (','⊸≠/⊢)¨ (' '⊸SplitBy))¨)¨ bags
		}¨  games

		grabs ← {
			bar ← ((0≠≠¨)/⊢)¨  𝕩
			(•ParseFloat ⌾(0⊸⊑)  (' '⊸≠/⊢)¨)¨ bar
			}¨  ⊑ bags_of_games
		grabs
	}

	parsed_games ← ParseRow¨ 𝕩


	IsGrabValid ← {𝕊bags:

		grab_valids ← {𝕊count‿color:
			(count ≤ Lookup color)
		}¨ bags

		⌊´ grab_valids

	}

	wins ← ∾ (⌊´ IsGrabValid¨)¨ parsed_games
	game_ids ← ((1+·↕≠)) wins
	+´ wins/game_ids


}

PartTwo ← {
	𝕩
}

•Show "part 1: "‿(PartOne data)
# •Show "part 2: "‿(PartTwo data)
