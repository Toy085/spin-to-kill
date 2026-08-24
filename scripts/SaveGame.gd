@icon("res://addons/at-icons/node/floppy_disk.svg")
class_name SaveGame
extends Resource

@export var total_money: int = 0
@export var deaths: int = 0
@export var item_levels: Dictionary = {}

@export var cooldown: float = 0.75
@export var health: int
@export var max_health: int = 100
@export var speed: int = 100
@export var damage: int = 5
@export var greed: int = 0
@export var coin_radius: float = 32
@export var axe_range: float = 50
