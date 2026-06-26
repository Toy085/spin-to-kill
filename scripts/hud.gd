extends Control

@onready var coinlabel: RichTextLabel = $CoinLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	coinlabel.text = "COINS: [outline_size=6][color=gold]" + str(Global.current_run_money) + "[/color][/outline_size]"
