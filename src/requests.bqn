⟨Get, Post⟩ ← •Import "../external/bqn-curl/curl.bqn"
⟨FromBytes⟩ ← •Import "../external/bqn-libs/strings.bqn"
⟨Parse, Export⟩ ← •Import "../external/bqn-libs/json.bqn"

Pp ← {•Show 100↑•Fmt𝕩⋄𝕩}
Rr ← { •Show (100⊸↑ •Repr 𝕩)⋄𝕩}


filename ← "reddit.json"

# ⟨content⟩ ←Get "https://reddit.com/r/programming.json"
# filename •file.Chars (Export Parse content)

content ←  Parse •file.Bytes filename

submissions ← children ← 1⊏ 1⊑ data ← 1⊏ content

# finds the data associated to the field
FindColumn ← {
	column ← 𝕨
	column ({(𝕨⊸⍷)∘⊏𝕩}/1⊸⊏) 𝕩
}

KindData ← 1⊏⊑
KindDataChildren ← 1⊑ KindData

submission ← KindDataChildren 4⊑ submissions
•Show ((<"title")⊸FindColumn )  submission
# •Show 0‿3⊑ 1⊑  1⊏>⊏  children
columns_names ← 0⊏ submission
•Show columns_names
