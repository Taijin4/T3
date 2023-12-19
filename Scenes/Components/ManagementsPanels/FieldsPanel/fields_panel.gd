extends Control

signal hide_panel

func _ready():
	var management_panel = ManagementPanel.new('FieldsPanel', $PanelContainer/VBoxContainer/Content/Ameliorations/Levels)
	


func _on_closing_cross_pressed():
	hide_panel.emit()
