@icon("res://addons/at-icons/node/note_double.svg")
extends Node

@onready var audio_player: AudioStreamPlayer = AudioStreamPlayer.new()

var music_tracks: Dictionary = {
	"res://world.tscn": [
		preload("res://assets/A Bag of Chips/100 Victories.wav"), 
		preload("res://assets/A Bag of Chips/Dizzy Racing.wav"),
		preload("res://assets/A Bag of Chips/Face The Facts.wav"),
		preload("res://assets/A Bag of Chips/It Takes A Hero.wav"),
		preload("res://assets/A Bag of Chips/Mom's Workout CD.wav"),
		preload("res://assets/A Bag of Chips/Post-Adventure Tea Party.wav"),
		preload("res://assets/A Bag of Chips/Sinister Abode.wav"),
		preload("res://assets/A Bag of Chips/Space Cadet Training Montage.wav"),
		preload("res://assets/A Bag of Chips/Stumble Around.wav"),
		preload("res://assets/A Bag of Chips/The World Is Ours.wav")
	],
	"res://ShopMenu.tscn": null
}

var current_track_path: String = ""

func _ready() -> void:
	add_child(audio_player)
	audio_player.bus = "Music"
	get_tree().scene_changed.connect(_on_scene_changed)

func _on_scene_changed() -> void:
	var current_scene = get_tree().current_scene
	if not current_scene:
		return
		
	var scene_path = current_scene.scene_file_path
	
	if music_tracks.has(scene_path) and music_tracks[scene_path] != null:
		play_track(scene_path)
	else:
		audio_player.stop()
		current_track_path = ""

func play_track(scene_path: String) -> void:
	if current_track_path == scene_path and audio_player.playing:
		return
		
	current_track_path = scene_path
	var tracks: Array = music_tracks[scene_path]
	
	if not tracks.is_empty():
		var random_track = tracks.pick_random()
		audio_player.stream = random_track
		audio_player.play()
