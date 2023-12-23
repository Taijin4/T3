extends Control

signal new_text_submitted(type : String, text : String)
var allowed_chars = RegEx.new()
@onready var materials_cost = {"wood" : 40, "hop" : 80, "ice" : 20, "other" : 1000, "beer" : 200}

func _ready():
	allowed_chars.compile("[^0-9]")
	$content/title_container/title.text = get_meta("FieldTitle")
	init()
	
	
func init():
	$content/input_container/LineEdit.text=""
	update_price(0)


func update_price(number : int):
	$content/price_container/price.text = get_meta("Prefix") + " " + str(number * materials_cost[get_meta("type")])


func _on_line_edit_text_changed(new_text):
	if new_text == "" or allowed_chars.search(new_text):
		$content/input_container/LineEdit.delete_char_at_caret()
	else:
		update_price(int(new_text))
		new_text_submitted.emit(get_meta("type"), new_text)
