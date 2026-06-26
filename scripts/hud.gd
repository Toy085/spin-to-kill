extends Control

@onready var coinlabel: RichTextLabel = $CoinLabel
@onready var healthbar: ProgressBar = $HealthBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	healthbar.max_value = Global.health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	coinlabel.text = "COINS: [outline_size=6][color=gold]" + str(Global.current_run_money) + "[/color][/outline_size]"
	healthbar.value = Global.health
