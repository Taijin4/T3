extends Control

@onready var money = $MarginContainer/PanelContainer/PanelWrapper/Content/Money/MoneyValue
@onready var member_max_value = $MarginContainer/PanelContainer/PanelWrapper/Content/Members/MembersMaxValue
@onready var member_value = $MarginContainer/PanelContainer/PanelWrapper/Content/Members/MembersValue
@onready var job_value = $MarginContainer/PanelContainer/PanelWrapper/Content/Job/JobValue
@onready var job_mem_value = $MarginContainer/PanelContainer/PanelWrapper/Content/Job/MembersValue

func init(moneys : int, member_max_value : int, member_value : int, job_value : int):
	var list_val = [moneys,member_max_value,member_value,job_value]
	for i in range(4):
		list_val[i] = s_with_space(list_val[i])
	self.money.text = list_val[0]
	self.member_max_value.text = list_val[1]
	self.member_value.text = list_val[2]
	self.job_value.text = list_val[3]
	self.job_mem_value.text = list_val[2]
	
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
