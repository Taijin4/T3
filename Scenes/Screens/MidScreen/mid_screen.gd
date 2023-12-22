extends Control

signal next_round
@onready var warning_path = $PanelContainer/HBoxContainer/MarginContainer/WarningList
func init(list_warning):
	print(list_warning)
	var w_childrens = warning_path.get_children()
	for child in w_childrens:
		warning_path.remove_child(child)
	if list_warning.size() != 0:
		for warning in list_warning:
			var l = Label.new()
			l.text = warning
			l.add_theme_font_size_override("font-size", 20)
			warning_path.add_child(l)
	else:
		var l = Label.new()
		l.text = "Pas de problème, continue comme ça !"
		l.add_theme_font_size_override("font-size", 20)
		warning_path.add_child(l)


func _on_button_pressed():
	next_round.emit()
