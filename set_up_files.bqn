
year‿day ← •args


Log ← {msg𝕊val:
	•Show msg‿val
	val
}

•ParseFloat year
•ParseFloat day


inputs_dir ← •wdpath∾"/inputs/" ∾ year
sample_dir ← •wdpath∾ "/samples/" ∾ year
source_dir ← •wdpath∾ "/src/" ∾ year

inputs_filename ← •wdpath∾ "/inputs/" ∾ year ∾ "/day" ∾ day ∾ ".txt"
sample_filename ← •wdpath∾ "/samples/" ∾ year ∾ "/day" ∾ day ∾ ".txt"
source_filename ← •wdpath∾ "/src/" ∾ year ∾ "/day" ∾ day ∾ ".bqn"

text ← "i am green!"
# wrap text with green ascii color:
Green ← {𝕊text: "[32m" ∾ text ∾ "[0m"}
# wrap with grey color:
Grey ← {𝕊text: "[90m" ∾ text ∾ "[0m"}
# wrap with red color:
Red ← {𝕊text: "[31m" ∾ text ∾ "[0m"}

SafeCreateDir ← {𝕊dir:
	fs ← ⟨
		# •file.CreateDir⎊(•Out "Can't create dir, maybe already exists ? "∾ •Currenterror) dir,
		{𝕤⋄ •file.CreateDir dir⋄ Green "dir created successfully"},
		Grey "dir already exists!"
	⟩
	⊢◶ fs •file.Exists dir
}

SafeCreateFile ← {𝕊filepath:
	⊢◶ ⟨
		filepath •file.Bytes⎊(•Out "Can't create file, maybe already exists ? "∾ •Currenterror)  "",
		"file created success!"
	⟩ •file.Exists filepath

}


•Out "Creating input directory: " ∾ inputs_dir
•Show SafeCreateDir inputs_dir
•Out "Creating sample directory: " ∾ sample_dir
•Show SafeCreateDir sample_dir
•Out "Creating source directory: " ∾ source_dir
•Show SafeCreateDir source_dir

# •Out "Creating input file: " ∾ inputs_filename
# •Show SafeCreateFile inputs_filename
# •Out "Creating sample file: " ∾ sample_filename
# •Show SafeCreateFile sample_filename
# •Out "Creating source file: " ∾ source_filename
# •Show SafeCreateFile source_filename

