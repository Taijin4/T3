class_name FileController

func load_file(filepath : String) -> String :
	if FileAccess.file_exists(filepath):
		var file = FileAccess.open(filepath, FileAccess.READ)
		return file.get_as_text()
	printerr("ERROR : File " + filepath + " did not exist.")
	return ""
