extends HBoxContainer

signal level_unlocked(level : int)
var levels_group_path = preload('res://Scenes/Components/VLevelsGroup/v_levels_group.tscn')
var jsoncontroller = JsonController.new()

func init(panel_name : String):
	var data : Array = jsoncontroller.load_from_file('res://Scenes/Components/ManagementsPanels/' + panel_name + '/levels.json')
	for column in data:
		var lg = levels_group_path.instantiate()
		lg.init(column)
		lg.level_unlocked.connect(_on_level_unlocked)
		add_child(lg)

func _on_level_unlocked(level : int):
	level_unlocked.emit(level)
