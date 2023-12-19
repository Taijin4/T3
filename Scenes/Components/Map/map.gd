extends Node2D

@onready var camera = $Camera2D

var zoom_min = Vector2(.35,.35)
var zoom_max = Vector2(1,1)
var zoom_speed = Vector2(.05,.05)

var tileMapSize = Vector2(2912, 1527)

var is_disabled = false

func _ready():
	camera.zoom = zoom_min
	
func _input(event):
	if not is_disabled and event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				if camera.zoom > zoom_min:
					camera.zoom -= zoom_speed
					#print("sup")
				elif camera.zoom <= zoom_min:
					camera.position = tileMapSize / 2
					#print("Min")
			if event.button_index == MOUSE_BUTTON_WHEEL_UP:
				if camera.zoom < zoom_max:
					camera.zoom += zoom_speed
			#print(str(camera.zoom) + "!=" + str(zoom_min))
	pass


func _process(delta):
	if not is_disabled:
		var movement = Vector2.ZERO
		var speed = 400
		
		if Input.is_action_pressed("MoveRight"):
			if ((2912 - camera.position.x) * camera.zoom.x > 578):
				movement.x += 1
		if Input.is_action_pressed("MoveLeft"):
			if (camera.position.x * camera.zoom.x > 580):
				movement.x -= 1
		if Input.is_action_pressed("MoveDown"):
			if ((1527 - camera.position.y) * camera.zoom.y > 320):
				movement.y += 1
		if Input.is_action_pressed("MoveUp"):
			if (camera.position.y * camera.zoom.y > 310):
				movement.y -= 1
		if Input.is_action_pressed("SpeedUp"):
			speed *= 2.5
		camera.position += movement.normalized() * speed * delta

func disable():
	modulate = "#878787"
	is_disabled = true
	
func enable():
	modulate = "#ffffff"
	is_disabled = false
