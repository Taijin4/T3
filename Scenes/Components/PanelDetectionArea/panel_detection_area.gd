extends Node2D

signal panel_was_opened
@onready var hover_label = $Bloc
@onready var hover_polygon = $Polygon2D

func _ready():
	$Bloc/Label.text = get_meta("HoverText")
	hover_polygon.polygon = $Area2D/CollisionPolygon2D.polygon
	hover_polygon.color = Color(255, 255, 255, 0.3)
	hover_polygon.position = $Area2D/CollisionPolygon2D.position
	hover_polygon.hide()

func _on_area_2d_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("left_mouse"):
		panel_was_opened.emit()
		get_node(get_meta("PanelToOpen")).show()
	else:
		hover_label.show()
		hover_polygon.show()
		var decalage : Vector2 = Vector2(-(hover_label.size.x/2), -(hover_label.size.y))
		hover_label.set_position(get_global_mouse_position() + decalage)


func _on_area_2d_mouse_exited():
	hover_label.hide()
	hover_polygon.hide()
