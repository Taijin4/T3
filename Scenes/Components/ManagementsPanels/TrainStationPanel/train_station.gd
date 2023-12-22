extends Control

signal hide_panel
signal change_money(sum : int)
var jsoncontroller = JsonController.new()
@onready var need = {"humans" : 0, "other" : 0}
@onready var production = {"humans" : 50}
@onready var importation = {"hop" : 0, "ice" : 0, "wood" : 0, "beer" : -1, "other" : 0}
@onready var exportation = {"hop" : 0, "ice" : 0, "wood" : 0, "beer" : 0, "other" : -1}



func _ready():
	init()

func init():
	$PanelContainer/VBoxContainer/Content/Ameliorations/LevelsInitiator.init("TrainStationPanel", false)
	need = {"humans" : 0, "other" : 0}
	production = {"humans" : 50}
	importation = {"hop" : 0, "ice" : 0, "wood" : 0, "beer" : -1, "other" : 0}
	exportation = {"hop" : 0, "ice" : 0, "wood" : 0, "beer" : 0, "other" : -1}

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

func get_importation(type : String = ""):
	if type == "":
		return importation
	else:
		return importation.get(type)

func get_exportation(type : String = ""):
	if type == "":
		return exportation
	else:
		return exportation.get(type)

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

func set_importation(value, type : String = ""):
	if type == "":
		importation = value
	else:
		importation[type] = value

func set_exportation(value, type : String = ""):
	if type == "":
		exportation = value
	else:
		exportation[type] = value


func _on_i_text_field_new_text_submitted(type, text):
	importation[type] = int(text)
	

func _on_e_text_field_new_text_submitted(type, text):
	exportation[type] = int(text)
	


func _on_levels_initiator_level_unlocked(column, level_data):
	for addition in level_data["addition"]:
		if addition.has("type"):
			if addition["type"] == "need":
				need[addition["name"]] += addition["value"]
			elif addition["type"] == "production":
				production[addition["name"]] += addition["value"]
	change_money.emit(-int(level_data["price"]))
