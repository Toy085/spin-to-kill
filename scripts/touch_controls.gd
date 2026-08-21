@icon("res://addons/at-icons/control/tap.svg")
extends Control

func _ready() -> void:
	var is_mobile_os = OS.has_feature("mobile") or OS.has_feature("web_android") or OS.has_feature("web_ios")
	
	visible = is_mobile_os
