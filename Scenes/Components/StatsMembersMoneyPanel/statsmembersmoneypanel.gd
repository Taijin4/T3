extends Control

@onready var money = $PanelContainer/PanelWrapper/Content/Money/MoneyValue
@onready var member_max_value = $PanelContainer/PanelWrapper/Content/Members/MembersMaxValue
@onready var member_value = $PanelContainer/PanelWrapper/Content/Members/MembersValue

func init(money : int, member_max_value : int, member_value : int):
	var list_val = [money,member_max_value,member_value]
	for i in range(3):
		list_val[i] = s_with_space(list_val[i])
	self.money.text = list_val[0]
	self.member_max_value.text = list_val[1]
	self.member_value.text = list_val[2]
	
func s_with_space(number : int)-> String :
	var string : String = str(number)
	if(string.length() > 3):
		var position : int = string.length()
		while(position > 3):
			string = string.insert(position-3," ")
			position-=3
	return string
		
func set_member_value(number : int):
	self.member_value.text = s_with_space(number)
	
func set_member_max_value(number : int):
	self.member_max_value.text = s_with_space(number)
	
func set_money(number : int):
	self.money.text = s_with_space(number)
