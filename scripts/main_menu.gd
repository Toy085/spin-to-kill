@icon("res://addons/at-icons/control/dropdown.svg")
extends Control

@export var game_scene_path : String = "res://world.tscn"

@onready var options_button: Button = $MarginContainer/VBoxContainer/OptionsButton
@onready var quit_button: Button = $MarginContainer/VBoxContainer/QuitButton

@onready var options: Panel = $Options
@onready var credits: Panel = $Credits

@onready var start_button: Button = $MarginContainer/VBoxContainer/StartButton
@onready var tutorial_confirmation_dialog: ConfirmationDialog = $MarginContainer/TutorialConfirmationDialog

func _ready():
	options_button.visible = not Global.is_mobile_os
	quit_button.visible = not (Global.is_mobile_os or Global.is_web)
	
	start_button.grab_focus()
	
func _on_start_button_pressed() -> void:
	if Global.done_tutorial == false:
		tutorial_confirmation_dialog.popup_centered()
	else:
		get_tree().change_scene_to_file(game_scene_path)

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_options_button_pressed() -> void:
	options.visible = true
	options.open_options()
	
func _on_credits_button_pressed() -> void:
	credits.visible = true
	credits.open_credits()


func _on_tutorial_confirmation_dialog_confirmed() -> void:
	get_tree().change_scene_to_file("res://Tutorial.tscn")

func _on_tutorial_confirmation_dialog_canceled() -> void:
	get_tree().change_scene_to_file(game_scene_path)
