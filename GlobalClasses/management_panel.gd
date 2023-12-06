extends Control

class_name ManagementPanel


var levels_group_path = preload('res://Scenes/Components/VLevelsGroup/v_levels_group.tscn')
var jsoncontroller = JsonController.new()

func _init(component_path : String, levels_wrapper : Node):
	var data : Array = jsoncontroller.load_from_file(component_path + '/levels.json')
	for column in data:
		var lg = levels_group_path.instantiate()
		lg.init(column)
		levels_wrapper.add_child(lg)
