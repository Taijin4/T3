extends Control

var is_game_won = false

@onready var victory_label = $Container/VBoxContainer/Sentences/VictoryLabel
@onready var sentence_label = $Container/VBoxContainer/Sentences/SentenceLabel
@onready var money_image = $Container/VBoxContainer/MarginContainer/Columns/FirstColumn/MoneyContainer/money
@onready var money_label = $Container/VBoxContainer/MarginContainer/Columns/FirstColumn/MoneyContainer/Label
@onready var humans_image = $Container/VBoxContainer/MarginContainer/Columns/FirstColumn/FirstColumnMargin/HumansContainer/humans
@onready var humans_label = $Container/VBoxContainer/MarginContainer/Columns/FirstColumn/FirstColumnMargin/HumansContainer/Label
@onready var beer_image = $Container/VBoxContainer/MarginContainer/Columns/FirstColumn/BeerContainer/beer
@onready var beer_label = $Container/VBoxContainer/MarginContainer/Columns/FirstColumn/BeerContainer/Label
@onready var ice_image = $Container/VBoxContainer/MarginContainer/Columns/SecondColumn/IceContainer/ice
@onready var ice_label = $Container/VBoxContainer/MarginContainer/Columns/SecondColumn/IceContainer/Label
@onready var hop_image = $Container/VBoxContainer/MarginContainer/Columns/SecondColumn/SecondColumnMargin/HopContainer/hop
@onready var hop_label = $Container/VBoxContainer/MarginContainer/Columns/SecondColumn/SecondColumnMargin/HopContainer/Label
@onready var wood_image = $Container/VBoxContainer/MarginContainer/Columns/SecondColumn/WoodContainer/wood
@onready var wood_label = $Container/VBoxContainer/MarginContainer/Columns/SecondColumn/WoodContainer/Label
@onready var columns_margins = $Container/VBoxContainer/MarginContainer
@onready var first_column_margin = $Container/VBoxContainer/MarginContainer/Columns/FirstColumn/FirstColumnMargin
@onready var second_column_margin = $Container/VBoxContainer/MarginContainer/Columns/SecondColumn/SecondColumnMargin

var money = "10 525"
var humans = "150/160"
var beer = "600T/tour"
var ice = "600T/tour"
var wood = "600T/tour"
var hop = "600T/tour"

# Called when the node enters the scene tree for the first time.
func _ready():
	if is_game_won:
		victory_label.text = "Victoire"
		victory_label.add_theme_color_override("font_color", Color(0, 1, 0, 1))
		sentence_label.text = "Bravo vous avez gagné la partie"
		sentence_label.add_theme_color_override("font_color", Color(1, 1, 1, 1))
		
	else:
		victory_label.text = "Défaite"
		victory_label.add_theme_color_override("font_color", Color(1, 0, 0, 1))
		sentence_label.text = "Dommage, vous avez perdu la partie"
		sentence_label.add_theme_color_override("font_color", Color(1, 1, 1, 1))
		
	victory_label.add_theme_font_size_override("font_size", 70)
	victory_label.position.x = (get_viewport_rect().size.x - victory_label.get_rect().size.x) / 2
	victory_label.position.y = 60
	sentence_label.add_theme_font_size_override("font_size", 50)
	sentence_label.position.x = (get_viewport_rect().size.x - sentence_label.get_rect().size.x) / 2
	sentence_label.position.y = 160
	
	columns_margins.add_theme_constant_override("margin_top", 100)
	columns_margins.add_theme_constant_override("margin_left", 50)
	columns_margins.add_theme_constant_override("margin_right", 50)
	first_column_margin.add_theme_constant_override("margin_top", 50)
	first_column_margin.add_theme_constant_override("margin_bottom", 50)
	second_column_margin.add_theme_constant_override("margin_top", 50)
	second_column_margin.add_theme_constant_override("margin_bottom", 50)
	money_label.text = money
	money_label.position.x += 100
	money_label.add_theme_font_size_override("font_size", 50)
	humans_label.text = humans
	humans_label.add_theme_font_size_override("font_size", 50)
	beer_label.text = beer 
	beer_label.add_theme_font_size_override("font_size", 50)
	ice_label.text = ice
	ice_label.add_theme_font_size_override("font_size", 50)
	hop_label.text = hop
	hop_label.add_theme_font_size_override("font_size", 50)
	wood_label.text = wood
	wood_label.add_theme_font_size_override("font_size", 50)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
