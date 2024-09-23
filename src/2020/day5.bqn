data ← •file.Lines "../../samples/2020/day5.txt"
# data ← •file.Lines "../../inputs/2020/day5.txt"

SplitBy ← (+`∘=⊔⊢)
# •Show ' 'SplitBy "a b c   d"

RemoveSpaces ← (' '⊸≠)⊸/


PerLetter ← {
	⟨val⟩ 𝕊𝕩  :
		•Show "---- handling single value"
		# •Show "---- done handling single value"
		⟨val⟩
	;
	𝕨𝕊𝕩 :

		# •Show 𝕨‿"handling many values"‿𝕩
		# •Show "handling many values"
		range ← >𝕨
		letter ← 𝕩
		# •Show range‿letter
		half ← 2÷˜≠range
		# •Show "half"‿half
		result ← { ('F'=letter) ∨ ('L'=letter) ? half↑range ; half↓range }
		result
}


•Show "all chars"‿(⊑data)
•Show  {
	first_five_chars ← •Show 7↑ >𝕩
	(<↕128) PerLetter˜´ ⌽first_five_chars
	} ⊑data
