data ← •file.Lines "../../samples/2020/day5.txt"
# data ← •file.Lines "../../inputs/2020/day5.txt"

SplitBy ← (+`∘=⊔⊢)
# •Show ' 'SplitBy "a b c   d"

RemoveSpaces ← (' '⊸≠)⊸/


PerLetter ← {
	⟨val⟩ 𝕊𝕩  :
		⟨val⟩
	;
	𝕨𝕊𝕩 :
		range ← >𝕨
		letter ← 𝕩
		half ← 2÷˜≠range
		result ← { ('F'=letter) ∨ ('L'=letter) ? half↑range ; half↓range }
		result
}

•Show "all chars"‿(⊑data)
•Show  {
	first_five_chars ← •Show 7↑ >𝕩
	row ← (<↕128) PerLetter˜´ ⌽first_five_chars
	last_three_chars ← •Show 7↓ >𝕩
	seat ← (<↕8) PerLetter˜´ ⌽last_three_chars
	row‿seat
	} ⊑data
