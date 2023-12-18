extends Control

@onready var wood = $PanelContainer/PanelWrapper/Content/Wood/WoodNumber
@onready var ice = $PanelContainer/PanelWrapper/Content/Ice/IceNumber
@onready var houblon = $PanelContainer/PanelWrapper/Content/Houblon/HoublonNumber
@onready var beer = $PanelContainer/PanelWrapper/Content/Beer/BeerNumber
@onready var other = $PanelContainer/PanelWrapper/Content/Other/OtherNumber
@onready var title = $PanelContainer/PanelWrapper/Title

func init(title : String, wood : int = -1, ice : int = -1, houblon : int = -1, beer : int = -1, other : int = -1):
	
	if wood == -1 : $PanelContainer/PanelWrapper/Content/Wood.hide()
	elif wood >= 0 : self.wood.text = s_with_space(wood)
	
	if ice == -1 : $PanelContainer/PanelWrapper/Content/Ice.hide()
	elif ice >= 0 : self.ice.text = s_with_space(ice)
	
	if houblon == -1 : $PanelContainer/PanelWrapper/Content/Houblon.hide()
	elif houblon >= 0 : self.houblon.text = s_with_space(houblon)
	
	if beer == -1 : $PanelContainer/PanelWrapper/Content/Beer.hide()
	elif beer >= 0 : self.beer.text = s_with_space(beer)
	
	if other == -1 : $PanelContainer/PanelWrapper/Content/Other.hide()
	elif other >= 0 : self.other.text = s_with_space(other)
	
	self.title.text = title

func s_with_space(number : int)-> String :
	var string : String = str(number)
	if(string.length() > 3):
		var position : int = string.length()
		while(position > 3):
			string = string.insert(position-3," ")
			position-=3
	return string

func get_wood(in_string : bool=false):
	if(in_string):
		return self.wood.text
	else:
		return  int(self.wood.text)
		
func get_ice(in_string : bool=false):
	if(in_string):
		return self.ice.text
	else:
		return  int(self.ice.text)

func get_houblon(in_string : bool=false):
	if(in_string):
		return self.houblon.text
	else:
		return  int(self.houblon.text)

func get_beer(in_string : bool=false):
	if(in_string):
		return self.beer.text
	else:
		return  int(self.beer.text)

func get_other(in_string : bool=false):
	if(in_string):
		return self.other.text
	else:
		return  int(self.other.text)

func set_wood(number : int):
	self.wood.text = s_with_space(number)
	
func set_ice(number : int):
	self.ice.text = s_with_space(number)
	
func set_houblon(number : int):
	self.houblon.text = s_with_space(number)

func set_beer(number : int):
	self.beer.text = s_with_space(number)

func set_other(number : int):
	self.other.text = s_with_space(number)
