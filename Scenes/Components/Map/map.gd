extends Camera2D

var zoom_min = Vector2(.35,.35)
var zoom_max = Vector2(1,1)
var zoom_speed = Vector2(.05,.05)

var tileMapSize = Vector2(2912, 1527)

func _ready():
	zoom = zoom_min
	print(tileMapSize)
	
func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			print(zoom)
			if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				if zoom > zoom_min:
					zoom -= zoom_speed
				elif zoom == zoom_min:
					position = tileMapSize / 2
					print("Min")
			if event.button_index == MOUSE_BUTTON_WHEEL_UP:
				if zoom < zoom_max:
					zoom += zoom_speed
	pass


func _process(delta):
	var movement = Vector2.ZERO
	var speed = 400
	
	if Input.is_action_pressed("MoveRight"):
		if ((2912 - position.x) * zoom.x > 578):
			movement.x += 1
	if Input.is_action_pressed("MoveLeft"):
		if (position.x * zoom.x > 580):
			movement.x -= 1
	if Input.is_action_pressed("MoveDown"):
		if ((1527 - position.y) * zoom.y > 320):
			movement.y += 1
	if Input.is_action_pressed("MoveUp"):
		if (position.y * zoom.y > 310):
			movement.y -= 1
	if Input.is_action_pressed("SpeedUp"):
		speed *= 2.5
	position += movement.normalized() * speed * delta


