data ← •file.Lines "../../samples/2020/day2.txt"
# data ← •file.Lines "../../inputs/2020/day2.txt"

# numbers ← •ParseFloat¨ data

MinusSelf ← -˜
Sum ← +`
Bar ← (⊢ MinusSelf Sum × ¬)
RankThenBar ← Bar∘=
Split ← (RankThenBar ⊔ ⊢)
•Show ' 'Split⊑data
# (•Show " "((⊢-˜+`×¬)∘=⊔⊢))¨ data




