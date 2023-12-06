class_name Level

extends Control

var level_data : Dictionary = {
	"level" : 0,
	"addition" : ""
}
var locked : bool = true
signal is_unlocked(col : String, niveau : int)

func init(level : int, price : int, addition : String):
	level_data['level'] = level
	level_data['addition'] = addition
	# locked
	find_child('LockedPrice').text = "----- $" + str(price) + "----- "
	find_child('LockedAddition').text = addition
	
	#unlocked
	find_child('UnlockedPrice').text = "Niveau" + str(level)
	find_child('UnlockedAddition').text = addition


func _on_button_pressed():
	if locked:
		unlock()

func disable():
	$Button.disabled = true
func enable():
	$Button.disabled = false


func unlock():
	locked = not locked
	$Button/Locked.hide()
	$Button/Unlocked.show()
	$Button.modulate = "#00FF00"
	is_unlocked.emit(level_data['level'])
