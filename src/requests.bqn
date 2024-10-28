⟨Get, Post⟩ ← •Import "../external/bqn-curl/curl.bqn"
⟨FromBytes⟩ ← •Import "../external/bqn-libs/strings.bqn"
⟨Parse, Export⟩ ← •Import "../external/bqn-libs/json.bqn"


⟨content⟩ ←Get "https://httpbun.com/get"
•Show ⍉ Parse content
