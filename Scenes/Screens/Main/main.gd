extends Node2D
# main variable
@onready var money = 10000
@onready var members = 40

# Panels to show to user several values
@onready var importation=$UI/GroupStats/Importation
@onready var exportation=$UI/GroupStats/Exportation
@onready var local_need=$UI/GroupStats/LocalNeed
@onready var local_production=$UI/GroupStats/LocalProduction
@onready var member_money=$UI/StatsMMPanelWrapper

#Panels to modify values
@onready var train_st=$UI/Panels/TrainStationPanel
@onready var resident=$UI/Panels/ResidentielPanel
@onready var sawmill=$UI/Panels/SawmillPanel
@onready var brewery=$UI/Panels/BreweryPanel
@onready var ice_fact=$UI/Panels/IceFactoryPanel
@onready var field=$UI/Panels/FieldsPanel
@onready var all_panels = [train_st,resident,sawmill,brewery,ice_fact,field]

	
# Called when the node enters the scene tree for the first time.
func _ready():
	var imp = train_st.get_importation()
	importation.init("IMPORTATION",imp["wood"],imp["ice"],imp["hop"],imp["beer"],imp["other"])
	var exp = train_st.get_exportation()
	exportation.init("EXPORTATION",exp["wood"],exp["ice"],exp["hop"],exp["beer"],exp["other"])
	var nee = get_all_need()
	local_need.init("BESOINS",nee["wood"],nee["ice"],nee["hop"],nee["beer"],nee["other"])
	var pro = get_all_production()
	local_production.init("PRODUCTION",pro["wood"],pro["ice"],pro["hop"],pro["beer"],-1)
	member_money.init(money,resident.get_production("humans"),members)

func _on_panel_closed():
	for child in $UI/Panels.get_children():
		if child is Control:
			child.hide()
	for area in $DetectionAreas.get_children():
		area.enable()
	$Map.enable()

func _on_panel_opened():
	for area in $DetectionAreas.get_children():
		area.disable()
	$Map.disable()

func get_all_need():
	var all = {"wood" : 0, "ice" : 0, "hop" : 0, "beer" : 0, "other" : 0, "humans" : 0}
	for pan in all_panels:
		var res = pan.get_need()
		print(res)
		all["wood"] += res.get("wood") if res.get("wood") != null else 0
		all["ice"] += res.get("ice") if res.get("ice") != null else 0
		all["hop"] += res.get("hop") if res.get("hop") != null else 0
		all["beer"] += res.get("beer") if res.get("beer") != null else 0
		all["other"] += res.get("other") if res.get("other") != null else 0
		all["humans"] += res.get("humans") if res.get("humans") != null else 0
	return all

func get_all_production():
	var all = {"wood" : 0, "ice" : 0, "hop" : 0, "beer" : 0, "other" : 0, "humans" : 0}
	for pan in all_panels:
		var res = pan.get_production()
		print(res)
		all["wood"] += res.get("wood") if res.get("wood") != null else 0
		all["ice"] += res.get("ice") if res.get("ice") != null else 0
		all["hop"] += res.get("hop") if res.get("hop") != null else 0
		all["beer"] += res.get("beer") if res.get("beer") != null else 0
		all["other"] += res.get("other") if res.get("other") != null else 0
		all["humans"] += res.get("humans") if res.get("humans") != null else 0
	return all
