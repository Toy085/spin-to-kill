@icon("res://addons/at-icons/control/tap.svg")
extends Control

func _ready() -> void:
	visible = Global.is_mobile_os

func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch or event is InputEventScreenDrag:
		visible = true
