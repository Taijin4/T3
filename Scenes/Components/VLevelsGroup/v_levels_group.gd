extends VBoxContainer

signal level_unlocked(column_id : int, level)
var level_scene_path = preload("res://Scenes/Components/Level/level.tscn")
var current_level = 0
var last_turn_level = 0
var turn = 0
var column_id : int

func init(data, column_id, unlock_first_level = true):
	for level_data in data:
		var level_scene = level_scene_path.instantiate()
		level_scene.init(level_data)
		level_scene.disable()
		level_scene.is_unlocked.connect(on_level_unlocked)
		add_child(level_scene)
		
	get_children()[0].enable()
	if unlock_first_level:
		get_children()[0]._on_button_pressed()
		
	column_id = column_id

func on_level_unlocked(level_data):
	current_level = level_data["num"]
	if get_child_count() > level_data["num"]:
		get_children()[level_data["num"]].enable()
	level_unlocked.emit(column_id, level_data)
