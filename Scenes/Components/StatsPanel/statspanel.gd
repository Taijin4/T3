extends Control

@onready var wood = $PanelContainer/PanelWrapper/Content/Wood/WoodNumber
@onready var ice = $PanelContainer/PanelWrapper/Content/Ice/IceNumber
@onready var houblon = $PanelContainer/PanelWrapper/Content/Houblon/HoublonNumber
@onready var title = $PanelContainer/PanelWrapper/Title

func init(wood : int, ice : int, houblon : int, title : String):
	var list_val = [wood,ice,houblon]
	for i in range(3):
		list_val[i] = s_with_space(list_val[i])
	self.wood.text = list_val[0]
	self.ice.text = list_val[1]
	self.houblon.text = list_val[2]
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
		
func set_wood(number : int):
	self.wood.text = s_with_space(number)
	
func set_ice(number : int):
	self.ice.text = s_with_space(number)
	
func set_houblon(number : int):
	self.houblon.text = s_with_space(number)
