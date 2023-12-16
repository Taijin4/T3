extends Control

signal hide_panel

func _ready():
	var management_panel = ManagementPanel.new('res://Scenes/Components/ResidentielPanel', $PanelContainer/VBoxContainer/Content/Ameliorations/Levels)

func _on_close_button_pressed():
	hide_panel.emit()
