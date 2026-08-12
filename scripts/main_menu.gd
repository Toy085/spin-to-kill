@icon("res://addons/at-icons/control/dropdown.svg")
extends Control

@export var game_scene_path : String = "res://world.tscn"

@onready var options: Panel = $Options
@onready var credits: Panel = $Credits

@onready var start_button: Button = $MarginContainer/VBoxContainer/StartButton

func _ready():
	start_button.grab_focus()
	
func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file(game_scene_path)

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_options_button_pressed() -> void:
	options.visible = true
	options.open_options()
	
func _on_credits_button_pressed() -> void:
	credits.visible = true
	credits.open_credits()
