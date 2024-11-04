⟨Get, Post⟩ ← •Import "../external/bqn-curl/curl.bqn"
⟨FromBytes⟩ ← •Import "../external/bqn-libs/strings.bqn"
⟨Parse, Export⟩ ← •Import "../external/bqn-libs/json.bqn"


filename ← "reddit.json"

# ⟨content⟩ ←Get "https://reddit.com/r/programming.json"
# filename •file.Chars (Export Parse content)

content ←  Parse •file.Bytes filename

children ← >4⊏1⊏>1⊏1⊏ content

Pp ← {100↑•Fmt⋄𝕩}

FindColumn ← {
	column ← 𝕨
	column ({(𝕨⊸⍷)∘⊏𝕩}/1⊸⊏) 𝕩
}
# •Show ((<"title")⊸FindColumn  >·1⊸⊏1⊸⊏)  Pp ⊏>⊏  children

# grid ← ((↕10)⊸(≍¨) )˘↕9
grid ← | 9- +´¨ ⍉↕10‿9
•Show grid


