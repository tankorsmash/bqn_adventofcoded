data ← •file.Lines "../../samples/2024/day5.txt"
# data ↩ •file.Lines "../../samples/2024/day5_alt.txt"
data ↩ •file.Lines "../../inputs/2024/day5.txt"


Log ← {msg𝕊val:
	•Show msg‿val
	val
}

PartOne ← {𝕊lines:
	# "lines"⊸Log¨ lines
	raw_rules‿raw_updates ← ((0⊸≠)∘≠¨/⊢)¨ (+`∘(0⊸=)∘(≠¨)⊔⊢) lines

	Parse ←  {char𝕊input:
			(•ParseFloat¨ · (char⊸≠/⊢)¨ ((+`(char⊸=))⊔⊢) ) input
	}

	parsed_rules ← '|'⊸Parse¨ raw_rules
	# "parsed_rules"⊸Log  parsed_rules
	rules ← '|'⊸Parse¨ raw_rules
	updates ← ','⊸Parse¨ raw_updates

	ValidateUpdates ← {𝕊update:
		# rule ← 14⊑rules
		# # rule ↩ ⟨61, 53⟩
		# "rule"⊸Log rule

		# "rules"⊸Log¨ rules
		present ← ({⌊´ (𝕩⊸∊)update}¨/⊢)rules
		validated_rules ← {(∧≡⊢) ∾˝/˘ (update⊸(⍷˘))˘ 𝕩}¨present
		⌊´ validated_rules
	}

	validated_updates ← (ValidateUpdates¨/⊢) updates
	# "validated_updates"⊸Log¨  validated_updates
	mids ← >((⌊·2⊸(÷˜)≠)⊏⊢)¨ validated_updates
	+´ mids
}

PartTwo ← {𝕊lines:
	# "lines"⊸Log¨ lines
	raw_rules‿raw_updates ← ((0⊸≠)∘≠¨/⊢)¨ (+`∘(0⊸=)∘(≠¨)⊔⊢) lines

	Parse ←  {char𝕊input:
			(•ParseFloat¨ · (char⊸≠/⊢)¨ ((+`(char⊸=))⊔⊢) ) input
	}

	parsed_rules ← '|'⊸Parse¨ raw_rules
	# "parsed_rules"⊸Log  parsed_rules
	rules ← '|'⊸Parse¨ raw_rules
	updates ← ','⊸Parse¨ raw_updates

	# "rules"⊸Log rules
	sorted_rules ← ∧ rules

	ValidateUpdates ← {𝕊update:
		present ← ({⌊´ (𝕩⊸∊)update}¨/⊢)rules
		validated_rules ← {(∧≡⊢) ∾˝/˘ (update⊸(⍷˘))˘ 𝕩}¨present
		⌊´ validated_rules
	}

	CorrectUpdates ← {𝕊update:
		sorted_present ← ∧({⌊´ (𝕩⊸∊)update}¨/⊢)rules

		res← ⊑¨((⍋≠¨)⊏⊢)(⊐⊔⊢)(1⊸⊑¨) sorted_present
		first←update (¬∘∊⊑∘/⊣) res
		actual ← first∾res
		# "expected" Log  "97,75,47,61,53"
		# "expected" Log  "61,29,13"
		# "expected" Log  "97,75,47,29,13"
		# validated_rules ← {(∧≡⊢) ∾˝/˘ (update⊸(⍷˘))˘ 𝕩}¨present
		# ⌊´ validated_rules

		actual
	}

	invalidate_updates ← (¬∘(ValidateUpdates¨)/⊢) updates
	# •Show CorrectUpdates 0⊑invalidate_updates
	corrected← CorrectUpdates¨ invalidate_updates
	# "corrected"⊸Log¨  corrected
	mids ← >((⌊·2⊸(÷˜)≠)⊏⊢)¨ corrected
	+´ mids
}

SolutionValidator ← {part‿expected𝕊answer:
	err_msg ← ("Part "∾(•Fmt part)∾" is wrong! Got instead: "∾(•Fmt answer))
	err_msg!(expected= answer)
	•Show "Correctly solved Part "∾(•Fmt part)∾": "∾(•Fmt answer)
}

# "part 1: " Log PartOne data
# "part 2: " Log PartTwo data
# 1‿5329 SolutionValidator PartOne data
2‿5833 SolutionValidator PartTwo data

