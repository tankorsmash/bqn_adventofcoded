⟨SolutionValidator, RLog⟩ ← •Import "leetcode_utils.bqn"
body                ← "
Given an array of integers nums and an integer target, return indices of the
two numbers such that they add up to target.

Example 1:
Input: nums = [2,7,11,15], target = 9
Output: [0,1]
Explanation: Because nums[0] + nums[1] == 9, we return [0, 1].
Example 2:

Input: nums = [3,2,4], target = 6
Output: [1,2]
Example 3:

Input: nums = [3,3], target = 6
Output: [0,1]
"

Solution ← {target𝕊input:
	# •Show input
	# •Show ⋈⌜˜ input
	pair ← ⥊ ⋈⌜˜ ↕ ≠input
	Filter ← (≠˜⌜˜· ↕≠)
	indices ← / ⥊ Filter⊸× target⊸=¨ +´¨ ⋈⌜˜ input
	⊑ indices⊏pair
	# •Show nums ← (2⊑⊑) (target⊸=⊑¨)⊸/ +´⊸⋈¨ (1⊸≠=´)¨⊸/ ⍷ ∧¨ ⥊ ⋈⌜˜ input
	# •Show nums ⊐˜ input
}

0‿1 SolutionValidator 9 Solution 2‿7‿11‿15
1‿2 SolutionValidator 6 Solution 3‿2‿4
0‿1 SolutionValidator 6 Solution 3‿3
