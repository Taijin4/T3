extends HBoxContainer


var levels_group_path = preload('res://Scenes/Components/VLevelsGroup/v_levels_group.tscn')
var jsoncontroller = JsonController.new()

func init(panel_name : String):
	var data : Array = jsoncontroller.load_from_file('res://Scenes/Components/ManagementsPanels/' + panel_name + '/levels.json')
	for column in data:
		var lg = levels_group_path.instantiate()
		lg.init(column)
		add_child(lg)
