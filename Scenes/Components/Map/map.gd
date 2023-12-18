extends Camera2D

var zoom_min = Vector2(.38,.38)
var zoom_max = Vector2(1,1)
var zoom_speed = Vector2(.025,.025)
var map_size = Vector2.ZERO

func _ready():
	var tilemap = get_parent().get_node("TileMap")  # Accéder à la TileMap via le nœud parent (si la caméra est enfant de la TileMap)
	map_size = tilemap.get_used_rect().size
	
func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				if zoom > zoom_min:
					zoom -= zoom_speed
				else:
					position.x = 1301
					position.y = 656
			if event.button_index == MOUSE_BUTTON_WHEEL_UP:
				if zoom < zoom_max:
					zoom += zoom_speed
					var mouse_pos = get_global_mouse_position()
					position = mouse_pos
		var tilemap = get_parent().get_node("TileMap") 
		map_size = tilemap.get_used_rect().size
		#print("Tile map : " + str(map_size))
	pass


func _process(delta):
	var movement = Vector2.ZERO
	#print(position)
	#print(position * zoom)
	#print(zoom)
	if Input.is_action_pressed("MoveRight"):
		if ((2448 - position.x) * zoom.x > 578):
			movement.x += 1
	if Input.is_action_pressed("MoveLeft"):
		if (position.x * zoom.x > 590):
			movement.x -= 1
	if Input.is_action_pressed("MoveDown"):
		if ((1809 - position.y) * zoom.y > 330):
			movement.y += 1
	if Input.is_action_pressed("MoveUp"):
		if (position.y * zoom.y > 335):
			movement.y -= 1
	position += movement.normalized() * 400 * delta
	
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		if event.button_mask == MOUSE_BUTTON_MASK_MIDDLE:
			position -= event.relative / zoom

