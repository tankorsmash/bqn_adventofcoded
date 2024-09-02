# data ← •file.Lines "../../samples/2020/day1.txt"
data ← •file.Lines "../../inputs/2020/day1.txt"

numbers ← •ParseFloat¨ data

# from bqncrate, pairs each element with each other element
pairs ←⥊(<⟨⟩)<⊸∾⌜´ numbers‿numbers

# which pairs sum to 2020
sums ← 2020= (+´)¨ pairs

# the first index pair that sums to 2020
first_pair_idx ← ⊑sums⊐1


# find the index of the first pair that sums to 2020
first_pair ← first_pair_idx⊑pairs

# 2020 day1 part 1 sample requires the product of the pair
•Show (×´ first_pair)

