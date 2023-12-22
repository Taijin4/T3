extends HBoxContainer

signal level_unlocked(column : int, level)
var levels_group_path = preload('res://Scenes/Components/VLevelsGroup/v_levels_group.tscn')
var jsoncontroller = JsonController.new()

func init(panel_name : String, unlock_first_level = true):
	var children = get_children()
	for child in children:
		remove_child(child)
	var data : Array = jsoncontroller.load_from_file('res://Scenes/Components/ManagementsPanels/' + panel_name + '/levels.json')
	var id= 0;
	for column_data in data:
		var lg = levels_group_path.instantiate()
		lg.init(column_data, id, unlock_first_level)
		lg.level_unlocked.connect(_on_level_unlocked)
		add_child(lg)
		id+=1

func _on_level_unlocked(column_id : int, level_data):
	level_unlocked.emit(column_id, level_data)
