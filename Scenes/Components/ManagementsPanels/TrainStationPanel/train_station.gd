extends Control

signal hide_panel

@onready var need = {"humans" : -1, "other" : -1}
@onready var production = {"humans" : 2000}
@onready var importation = {"hop" : 0, "ice" : 5000, "wood" : 12000, "beer" : -1, "other" : 30000}
@onready var exportation = {"hop" : 3500, "ice" : -0, "wood" : 0, "beer" : 10000, "other" : -1}



func _ready():
	var management_panel = ManagementPanel.new('TrainStationPanel', $PanelContainer/VBoxContainer/Content/Ameliorations/Levels)
func _on_close_button_pressed():
	hide_panel.emit()
	print(need.get("humans"))
	need["humans"] = 2
	print(need.get("humans"))

func get_need(type : String = ""):
	if(type == ""):
		return need
	else:
		return need.get(type)

func get_production(type : String = ""):
	if(type == ""):
		return production
	else:
		return production.get(type)

func get_importation(type : String = ""):
	if(type == ""):
		return importation
	else:
		return importation.get(type)

func get_exportation(type : String = ""):
	if(type == ""):
		return exportation
	else:
		return exportation.get(type)

func set_need(value, type : String = ""):
	if(type == ""):
		need = value
	else:
		need[type] = value

func set_production(value, type : String = ""):
	if(type == ""):
		production = value
	else:
		production[type] = value

func set_importation(value, type : String = ""):
	if(type == ""):
		importation = value
	else:
		importation[type] = value

func set_exportation(value, type : String = ""):
	if(type == ""):
		exportation = value
	else:
		exportation[type] = value
