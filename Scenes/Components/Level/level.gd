class_name Level

extends Control

var data : Dictionary = {}
var locked : bool = true
signal is_unlocked(level_data)

func init(level_data):
	data = level_data
	var addition = level_data["addition"]
	if typeof(addition) == TYPE_ARRAY:
		for add in addition:
			var sentence = add["sentence"].replace("{value}", str(add["value"]))
			
			var l1 := Label.new()
			l1.text = sentence
			l1.add_theme_font_size_override("font_size", 18)
			l1.autowrap_mode = TextServer.AUTOWRAP_ARBITRARY
			$Button/Margin/Locked/LockedAddition.add_child(l1)
			
			var l2 := Label.new()
			l2.text = sentence
			l2.add_theme_font_size_override("font_size", 18)
			l2.autowrap_mode = TextServer.AUTOWRAP_ARBITRARY
			$Button/Margin/Unlocked/UnlockedAddition.add_child(l2)
	
	# locked
	find_child('LockedPrice').text = "----- " + str(level_data["price"]) + "€ ----- "
	
	#unlocked
	find_child('UnlockedLevel').text = "Niveau " + str(level_data["num"])


func _on_button_pressed():
	if locked:
		unlock()

func disable():
	$Button.disabled = true
func enable():
	$Button.disabled = false


func unlock():
	locked = not locked
	$Button/Margin/Locked.hide()
	$Button/Margin/Unlocked.show()
	$Button.self_modulate = "#00FF00"
	is_unlocked.emit(data)
