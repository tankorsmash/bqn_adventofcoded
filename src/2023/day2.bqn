data ← •file.Lines "../../samples/2023/day2.txt"
# data ↩ •file.Lines "../../samples/2023/day2_alt.txt"
# data ↩ •file.Lines "../../inputs/2023/day2.txt"


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

		res ← {
			bar ← ((0≠≠¨)/⊢)¨  𝕩
			(•ParseFloat ⌾(0⊸⊑)  (' '⊸≠/⊢)¨)¨ bar
			}¨  ⊑ bags_of_games
		•Show¨ res
		•Out 50/"-"
	}

	•Show ⊑𝕩
	# foo ← (⊑𝕩)
	ParseRow¨ 1↑𝕩

}

PartTwo ← {
	𝕩
}

(PartOne data)
# •Show "part 1: "‿(PartOne data)
# •Show "part 2: "‿(PartTwo data)
