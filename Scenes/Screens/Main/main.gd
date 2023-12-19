extends Node2D

@onready var importation=$UI/GroupStats/Importation
@onready var exportation=$UI/GroupStats/Exportation
@onready var local_need=$UI/GroupStats/LocalNeed
@onready var local_production=$UI/GroupStats/LocalProduction
@onready var member_money=$UI/StatsMMPanelWrapper

	
# Called when the node enters the scene tree for the first time.
func _ready():
	importation.init("IMPORTATION",12000,5000,0,-1,30000)
	exportation.init("EXPORTATION",0,0,3500,10000,-1)
	local_need.init("BESOINS",32000,21000,12000,1500,27000)
	local_production.init("PRODUCTION",20000,16000,22000,11500,-1)
	member_money.init(250000,20000,12000)

func _on_panel_closed():
	for child in $UI/Panels.get_children():
		if child is Control:
			child.hide()
	$Map.modulate = "#ffffff"
	for area in $DetectionAreas.get_children():
		area.enable()

func _on_panel_opened():
	$Map.modulate = "#878787"
	for area in $DetectionAreas.get_children():
		area.disable()
