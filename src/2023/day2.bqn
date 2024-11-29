data ← •file.Lines "../../samples/2023/day2.txt"
# data ↩ •file.Lines "../../samples/2023/day2_alt.txt"
# data ↩ •file.Lines "../../inputs/2023/day2.txt"



limits ← [
	⟨"red", "green", "blue"⟩,
	[12,13,14],
]

Lookup ← {𝕊key:
	((<key) ⍷ ⊏limits) / 1⊏limits
}

Log ← {msg𝕊val:
	•Show msg‿val
	val
}

SplitBy ← {char𝕊str:
	((+` char⊸=)⊔⊢) str
	}

Remove ← {char𝕊str:
	(char⊸≠/⊢)str
	}


PartOne ← {𝕊lines:

	ParseRow ← {𝕊row:
		games ← 2↓¨ 1↓  ':'SplitBy row

		bags_of_games ← {𝕊game:
			bags ← (','⊸SplitBy ';'⊸Remove)¨ ';'SplitBy  game
			((0≠≠¨)/⊢)¨ (','⊸Remove)¨ ∘ (' '⊸SplitBy)¨¨ bags
		}¨  games

		((•ParseFloat ⌾(0⊸⊑)  ' '⊸Remove¨)¨ ((0≠≠¨)/⊢)¨ )¨  ⊑ bags_of_games
	}

	+´ (⊢/(1+·↕≠))∾ ⌊´∘((⌊´ (⊑ ≤⟜Lookup 1⊸⊑)¨)¨)¨ ParseRow¨ lines
}

PartTwo ← {𝕊lines:

	ParseRow ← {𝕊row:
		games ← 2↓¨ 1↓  ':'SplitBy row

		bags_of_games ← {𝕊game:
			bags ←  ∾ (','⊸SplitBy ';'⊸Remove)¨ ';'SplitBy  game
			((0≠≠¨)/⊢)¨ (','⊸Remove )¨ ∘ (' '⊸SplitBy )¨ bags
		}¨  games

		Parse ← ((•ParseFloat⌾(0⊸⊑) ' '⊸Remove¨ ) ((0≠≠¨)/⊢)¨ )
		res ← (((⊏limits)⊸⊐ 1⊸⊑¨)⊔⊑¨)¨ Parse¨¨   bags_of_games
		(×´ ⌈´¨)¨ res
	}
	+´  ParseRow¨ lines
}

# •Show "part 1: "‿(PartOne data)
•Show "part 2: "‿(PartTwo data)
