extends Control

signal hide_panel
signal change_money(sum : int)
var jsoncontroller = JsonController.new()
@onready var need = {"humans" : 5, "other" : 10, "beer" : 2}
@onready var production = {"humans" : 50}

func _ready():
	$PanelContainer/VBoxContainer/Content/Ameliorations/LevelsInitiator.init("ResidentielPanel")

func _on_close_button_pressed():
	hide_panel.emit()

func get_need(type : String = ""):
	if type == "":
		return need
	else:
		return need.get(type)

func get_production(type : String = ""):
	if type == "":
		return production
	else:
		return production.get(type)

func set_need(value, type : String = ""):
	if type == "":
		need = value
	else:
		need[type] = value

func set_production(value, type : String = ""):
	if type == "":
		production = value
	else:
		production[type] = value


func _on_levels_initiator_level_unlocked(column, level_data):
	for addition in level_data["addition"]:
		if addition["name"] != "other":
			if addition["type"] == "need":
				need[addition["name"]] += addition["value"]
			elif addition["type"] == "production":
				production[addition["name"]] += addition["value"]
			else:
				printerr("YA UN PROBLEME DANS LE JSON CHEF !")
	change_money.emit(-int(level_data["price"]))
