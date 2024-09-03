data ← •file.Lines "../../samples/2020/day3.txt"
# data ← •file.Lines "../../inputs/2020/day3.txt"

# numbers ← •ParseFloat¨ data

Split ←{
	MinusSelf ← -˜
	Sum ← +`
	Foo ← Sum × ¬
	Bar ← (⊢ MinusSelf Foo)
	EqualThenBar ← Bar∘=
	𝕨(EqualThenBar ⊔ ⊢)𝕩
}

•Show (≠⊑data)‿↑ ⥊ data
