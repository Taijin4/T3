extends VBoxContainer


var level_scene_path = preload("res://Scenes/Components/Level/level.tscn")
var current_level = 0

func init(data):
	for level in data:
		var level_scene = level_scene_path.instantiate()
		level_scene.init(level['num'], level['price'], level['addition'])
		level_scene.disable()
		level_scene.is_unlocked.connect(on_level_unlocked)
		add_child(level_scene)
		
	get_children()[0].enable()

func on_level_unlocked(niveau : int):
	current_level = niveau
	if get_child_count() > niveau:
		get_children()[niveau].enable()
