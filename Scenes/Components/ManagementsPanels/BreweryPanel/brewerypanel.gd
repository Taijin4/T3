extends Control

signal hide_panel

@onready var need = {"humans" : 10, "other" : 10, "hop" : 25, "ice" : 25, "wood" : 100}
@onready var production = {"beer" : 50}

func _ready():
	var management_panel = ManagementPanel.new('BreweryPanel', $PanelContainer/VBoxContainer/Content/Ameliorations/Levels)
	


func _on_closing_cross_pressed():
	hide_panel.emit()

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
