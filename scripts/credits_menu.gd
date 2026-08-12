@icon("res://addons/at-icons/control/dropdown.svg")
extends Panel

@onready var credits: Panel = $"."
@onready var back_button: Button = $BackButton

func _on_back_button_pressed() -> void:
	credits.visible = false

func open_credits():
	back_button.grab_focus()
