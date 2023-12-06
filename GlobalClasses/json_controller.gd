class_name JsonController

var file = FileController.new()

func load_from_file(filepath : String):
	var json = JSON.new()
	var error = json.parse(file.load_file(filepath))
	if error == OK:
		return json.data
	else:
		printerr("ERROR RETRIEVING DATA FROM FILE " + filepath)
		return []
