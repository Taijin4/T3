extends Control

signal hide_panel
signal change_money(sum : int)
var jsoncontroller = JsonController.new()
@onready var need = {"humans" : 0, "other" : 0}
@onready var production = {"wood" : 0}

func _ready():
	$PanelContainer/VBoxContainer/Content/Ameliorations/LevelsInitiator.init("SawmillPanel")
	var tab : Array = jsoncontroller.load_from_file('res://Scenes/Components/ManagementsPanels/SawmillPanel/levels.json')
	for val in tab[0][0].get("addition"):
		if val.get("type") == "production" :
			production[val.get("name")] = val.get("value")
		elif val.get("type") == "need" :
			need[val.get("name")] = val.get("value")


func _on_closing_cross_pressed():
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
		if addition["type"] == "need":
			need[addition["name"]] += addition["value"]
		elif addition["type"] == "production":
			production[addition["name"]] += addition["value"]
	change_money.emit(-int(level_data["price"]))
