extends Control

signal hide_panel
var jsoncontroller = JsonController.new()

@onready var need = {"humans" : 10, "other" : 10, "hop" : 25, "ice" : 25, "wood" : 100}
@onready var production = {"beer" : 50}

func _ready():
	$PanelContainer/VBoxContainer/Content/Ameliorations/LevelsInitiator.init("BreweryPanel")

func _on_closing_cross_pressed():
	hide_panel.emit()

func get_need(type : String = ""):
	print("brewery")
	print(need)
	print(production)
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


func _on_levels_initiator_level_unlocked(column, level):
	var panel_data = jsoncontroller.load_from_file('res://Scenes/Components/ManagementsPanels/BreweryPanel/levels.json')
	var level_data = panel_data[column][level-1]
	for addition in level_data["addition"]:
		if addition["name"] != "other":
			if addition["type"] == "need":
				need[addition["name"]] += addition["value"]
			elif addition["type"] == "production":
				production[addition["name"]] += addition["value"]
			else:
				printerr("YA UN PROBLEME DANS LE JSON CHEF !")
	var prod_beer = production["beer"]
	need["wood"] = prod_beer * 2
	need["hop"] = prod_beer / 2
	need["ice"] = prod_beer / 2
