extends Node2D

@onready var importation=$UI/GroupStats/Importation
@onready var exportation=$UI/GroupStats/Exportation
@onready var local_need=$UI/GroupStats/LocalNeed
@onready var local_production=$UI/GroupStats/LocalProduction

	
# Called when the node enters the scene tree for the first time.
func _ready():
	importation.init(1234,56,7890,"IMPORTATION")
	exportation.init(12439,75734,890,"EXPORTATION")
	local_need.init(1830,2821,93,"BESOINS")
	local_production.init(0,0,100000,"PRODUCTION")

func _on_panel_closed():
	for child in $UI/Panels.get_children():
		if child is Control:
			child.hide()
	$Map.modulate = "#ffffff"

func _on_panel_opened():
	$Map.modulate = "#878787"
