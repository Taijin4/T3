extends Node2D
# main variable
@onready var money = 15000
@onready var members = 45
@onready var materials_cost = {"wood" : 40, "hop" : 80, "ice" : 20, "other" : 500, "beer" : 200}
@onready var warning = 0
@onready var round_nbr = 1
@onready var list_warning = []

# Panels to show to user several values
@onready var importation=$UI/Stats/GroupStats/Importation
@onready var exportation=$UI/Stats/GroupStats/Exportation
@onready var local_need=$UI/Stats/GroupStats/LocalNeed
@onready var local_production=$UI/Stats/GroupStats/LocalProduction
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
	update_panels_values()
	
func disable_events():
	for area in $DetectionAreas.get_children():
		area.disable()
	$Map.disable()
	$UI/NextRound.hide()

func enable_events():
	for area in $DetectionAreas.get_children():
		area.enable()
	$Map.enable()
	$UI/NextRound.show()
	
func _on_panel_closed():
	for child in $UI/Panels.get_children():
		if child is Control:
			child.hide()
	enable_events()
	update_panels_values()

func _on_panel_opened():
	disable_events()

func get_all_need():
	var all = {"wood" : 0, "ice" : 0, "hop" : 0, "beer" : 0, "other" : 0, "humans" : 0}
	for pan in all_panels:
		var res = pan.get_need()
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
		all["wood"] += res.get("wood") if res.get("wood") != null else 0
		all["ice"] += res.get("ice") if res.get("ice") != null else 0
		all["hop"] += res.get("hop") if res.get("hop") != null else 0
		all["beer"] += res.get("beer") if res.get("beer") != null else 0
		all["other"] += res.get("other") if res.get("other") != null else 0
		all["humans"] += res.get("humans") if res.get("humans") != null else 0
	return all

func increase_money(value : int):
	self.money+=value
	member_money.set_money(money)

func decrease_money(value : int):
	self.money-=value
	member_money.set_money(money)

func do_export_import(possible_exportation : Dictionary):
	var import = train_st.get_importation()
	for value in import:
		if import[value] != 1:
			decrease_money(import[value]*materials_cost[value])
	var export = possible_exportation
	for value in export:
		if export[value] != 1:
			increase_money(export[value]*materials_cost[value])

func min(a : int, b : int):
	return a if a<b else b

func do_import_members():
	var place = resident.get_production("humans")
	var job = get_all_need()["humans"]
	var max_import = train_st.get_production("humans")
	
	var there_is_place = members < place
	var there_is_job = members < job
	if there_is_job and there_is_place:
		members += min(max_import,min(job-members, place-members))
	elif !there_is_job :
		members=job

func do_need():
	var storage = {"wood" : 0, "ice" : 0, "hop" : 0, "beer" : 0, "other" : 0}
	var ressources = train_st.get_importation()
	var prod = get_all_production()
	var need = get_all_need()
	var export = (train_st.get_exportation()).duplicate(true)
	var coef_present_members=(members*100/member_money.get_job_value())
	var coef_production=coef_present_members if coef_present_members < 100 else 100
	if coef_production < 100 :
		list_warning.append("Tu ne produit pas à ton max car il manque des employés dans ton quartier !!")
	#Add all ressources aviable
	for val in ressources:
		storage[val] += ressources[val] if ressources[val] != -1 else 0
	
	for val in storage:
		storage[val] += ((prod[val]*coef_production)/100) if prod[val] != -1 else 0
	#Remove ressources needed or export
	var subsist_need = true
	var ressources_not_aviable = {"wood" : 0, "ice" : 0, "hop" : 0, "beer" : 0}
	var problem = false
	
	for val in storage:
		storage[val] -= ((need[val]*coef_production)/100) if need[val] != -1 else 0
		if storage[val] < 0 :
			ressources_not_aviable[val] += -storage[val]
			problem = true
			subsist_need=false
	if problem :
		var available = (brewery.get_need()).duplicate(true)
		available.erase("humans")
		available.erase("other")
		for val in available :
			available[val] -= ressources_not_aviable[val]
		var missing_beer = brewery.get_production("beer") - min(available["wood"]/2,min(available["ice"]*2,available["hop"]*2))
		storage["beer"] -= missing_beer
		storage["wood"] += missing_beer*2
		storage["ice"] += missing_beer*0.5
		storage["hop"] += missing_beer*0.5
		if storage["beer"] < 0 :
			storage["beer"] = 0
			subsist_need=false
	if !subsist_need :
		list_warning.append("Ton quartier n'arrive pas à subvenir à ses besoins !!")
		warning+=1
		members = members/2 if members/2 > 10 else members-10 if members-10 > 0 else 0
	for val in export:
		export[val] = export[val] if export[val] < storage[val] else storage[val]
	do_export_import(export)
	for val in export :
		storage[val] -= export[val] if export[val] != -1 else 0
		if storage[val] > 100 :
			list_warning.append("Tu gaspille des "+str(val)+" ! Gère mieux ta production ou ton importation !!")
			warning+=1

func detect_loose_win():
	if warning >= 3 :
		var pro = get_all_production()
		disable_events()
		$UI/EndScreen.init(false, self.money, self.members, pro["beer"],pro["ice"],pro["wood"],pro["hop"])
		$UI/EndScreen.show()
	if round_nbr == 10 :
		var pro = get_all_production()
		disable_events()
		$UI/EndScreen.init(true, self.money, self.members, pro["beer"],pro["ice"],pro["wood"],pro["hop"])
		$UI/EndScreen.show()
	
	

func manage_warning():
	if round_nbr%2 == 0 :
		warning-=1 if warning > 0 else 0
	if money < 0 :
		warning+=1 + (-money/35000)
		print("JE PASSE")
		list_warning.append("Tu es dans le négatif ! Ressaisis-toi !!")

func update_panels_values():
	var nee = get_all_need()
	local_need.init("BESOINS",nee["wood"],nee["ice"],nee["hop"],nee["beer"],nee["other"])
	var pro = get_all_production()
	local_production.init("PRODUCTION",pro["wood"],pro["ice"],pro["hop"],pro["beer"],-1)
	train_st.set_importation(nee["other"],"other")
	var imp = train_st.get_importation()
	importation.init("IMPORTATION",imp["wood"],imp["ice"],imp["hop"],imp["beer"],imp["other"])
	var export = train_st.get_exportation()
	exportation.init("EXPORTATION",export["wood"],export["ice"],export["hop"],export["beer"],export["other"])

	member_money.init(money,resident.get_production("humans"),members, nee["humans"])

func reset_default_values():
	for val in all_panels:
		val.init()
	money = 15000
	members = 45
	materials_cost = {"wood" : 40, "hop" : 80, "ice" : 20, "other" : 500, "beer" : 200}
	warning = 0
	round_nbr = 1
	update_panels_values()
	enable_events()
	$UI/EndScreen.hide()

func open_mid_screen():
	do_import_members()
	do_need()
	manage_warning()
	print(list_warning)
	disable_events()
	$UI/MidScreen.init(list_warning)
	$UI/MidScreen.show()

func __on_next_round():
	$UI/MidScreen.hide()
	enable_events()
	round_nbr+=1
	update_panels_values()
	detect_loose_win()
	print("Round ",round_nbr)
	list_warning.clear()
	
