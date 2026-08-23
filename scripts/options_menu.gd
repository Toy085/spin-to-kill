@icon("res://addons/at-icons/control/dropdown.svg")
extends Panel

@onready var options: Panel = $"."
@onready var audio_control: HSlider = $VBoxContainer/MasterSliderLabel/AudioControl
@onready var audio_control_music: HSlider = $VBoxContainer/MusicSliderLabel/AudioControl
@onready var audio_control_sfx: HSlider = $VBoxContainer/SFXSliderLabel/AudioControl
@onready var fullscreen_toggle: CheckButton = $VBoxContainer/FullscreenLabel/FullscreenToggle
@onready var lang_dropdown: OptionButton = $VBoxContainer/LangLabel/LangDropdown

@onready var fullscreen_label: Label = $VBoxContainer/FullscreenLabel

var locales: PackedStringArray = []

func _ready() -> void:
	fullscreen_label.visible = not (Global.is_web or Global.is_mobile_os)
	_setup_language_dropdown()

func _setup_language_dropdown() -> void:
	lang_dropdown.clear()
	
	locales = TranslationServer.get_loaded_locales()

	var active_locale: String = TranslationServer.get_locale()
	var select_index: int = 0

	for i in range(locales.size()):
		var locale_code: String = locales[i]
		var language_name: String = TranslationServer.get_locale_name(locale_code)
		
		lang_dropdown.add_item(language_name)

		if active_locale.begins_with(locale_code):
			select_index = i

	if locales.size() > 0:
		lang_dropdown.select(select_index)

func _on_back_button_pressed() -> void:
	options.visible = false

func open_options():
	audio_control.grab_focus()

func _on_fullscreen_toggle_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func _on_lang_dropdown_item_selected(index: int) -> void:
	var selected_locale: String = locales[index]
	TranslationServer.set_locale(selected_locale)
