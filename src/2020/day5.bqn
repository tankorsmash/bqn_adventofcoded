data ← •file.Lines "../../samples/2020/day5.txt"
# data ← •file.Lines "../../inputs/2020/day5.txt"

SplitBy ← (+`∘=⊔⊢)
# •Show ' 'SplitBy "a b c   d"

RemoveSpaces ← (' '⊸≠)⊸/


PerLetter ← {
	sum ← 𝕨
	letter ← 𝕩
	# •Show sum‿letter
	half ← 2÷˜≠sum
	•Show { 'F'=letter ? half↑sum ; half↓sum }
}


•Show (<↕128) PerLetter` ⊑data

