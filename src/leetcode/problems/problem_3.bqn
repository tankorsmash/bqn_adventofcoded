⟨SolutionValidator, RLog⟩ ← •Import "leetcode_utils.bqn"
body                      ← "
Given a string s, find the length of the longest substring without repeating characters.

Example 1:

Input: s = ""abcabcbb""
Output: 3
Explanation: The answer is ""abc"", with the length of 3.
Example 2:

Input: s = ""bbbbb""
Output: 1
Explanation: The answer is ""b"", with the length of 1.
Example 3:

Input: s = ""pwwkew""
Output: 3
Explanation: The answer is ""wke"", with the length of 3.
Notice that the answer must be a substring, ""pwke"" is a subsequence and not a substring.
"

Solution ← {𝕊string:
	r ← 1↓ (↕≠) string
	↕⟜string¨ r
	¯1⊑ 1+/ ⌈´¨ (=○≠)⟜⍷˘¨ ↕⟜string¨ r
}

3 SolutionValidator Solution "abcabcbb"
1 SolutionValidator Solution "bbbbb"
3 SolutionValidator Solution "pwwkew"
