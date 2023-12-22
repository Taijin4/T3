extends Control

signal new_text_submitted(type : String, text : String)
var allowed_chars = RegEx.new()
@onready var materials_cost = {"wood" : 40, "hop" : 80, "ice" : 20, "other" : 1000, "beer" : 200}

func _ready():
	$content/title_container/title.text = get_meta("FieldTitle")
	allowed_chars.compile("[^0-9]")
	reset()

func reset():
	$content/input_container/LineEdit.text = "0"
	set_price(0, get_meta("Prefix"))

func set_price(new_price : int, prefix : String):
	$content/price_container/price.text = prefix + " " + str(new_price) + "€"


func _on_line_edit_text_submitted(new_text):
	if new_text == "" or allowed_chars.search(new_text):
		new_text = "0"
		$content/input_container/LineEdit.text = "0"
	else:
		set_price(materials_cost[get_meta("type")]*int(new_text), get_meta("Prefix"))
		new_text_submitted.emit(get_meta("type"), new_text)



func _on_line_edit_focus_exited():
	_on_line_edit_text_submitted($content/input_container/LineEdit.text)
