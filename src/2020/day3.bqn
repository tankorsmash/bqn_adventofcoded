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

array ← (≠⊑data)‿↑ ⥊ data
•Show array


n ← 0
•Show (n×3)⊑0⊑(n×1)⊏ array
n ↩ 1
•Show (n×3)⊑0⊑(n×1)⊏ array
n ↩ 2
•Show (n×3)⊑0⊑(n×1)⊏ array
