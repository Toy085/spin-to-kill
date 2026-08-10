@icon("res://addons/at-icons/control/pause.svg")
extends Control

@onready var options: Panel = $Options
@onready var resume_button: Button = $MarginContainer/VBoxContainer/ResumeButton

func _ready() -> void:
	hide()

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		toggle_pause()

func toggle_pause():
	get_tree().paused = !get_tree().paused

	if get_tree().paused:
		show()
		resume_button.grab_focus()
	else:
		hide()

func _on_resume_button_pressed():
	toggle_pause()

func _on_quit_button_pressed():
	get_tree().quit()

func _on_options_button_pressed() -> void:
	options.visible = true
	options.open_options()
