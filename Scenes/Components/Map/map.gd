extends Camera2D

var zoom_min = Vector2(.2,.2)
var zoom_max = Vector2(2,2)
var zoom_speed = Vector2(.05,.05)

func _input(event):
	position = Vector2(-200, -100)
	zoom = Vector2(.17,.17)
	if Input.is_action_just_pressed("Move"):
		position -= event.relative / zoom
