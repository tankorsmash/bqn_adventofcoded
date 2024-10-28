⟨Get, Post⟩ ← •Import "../external/bqn-curl/curl.bqn"
⟨FromBytes⟩ ← •Import "../external/bqn-libs/strings.bqn"
⟨Parse, Export⟩ ← •Import "../external/bqn-libs/json.bqn"


filename ← "reddit.json"

# ⟨content⟩ ←Get "https://reddit.com/r/programming.json"
# filename •file.Chars (Export Parse content)

content ←  Parse •file.Bytes filename

children ← >4⊏1⊏>1⊏1⊏ content

•Show (<"title") ({(𝕨⊸⍷)∘⊏𝕩}/1⊸⊏)  >1⊏1⊏>0⊏ children


