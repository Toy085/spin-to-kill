@icon("res://addons/at-icons/control/tap.svg")
extends Control

func _ready() -> void:
	visible = Global.is_mobile_os
