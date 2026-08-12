extends Control

@onready var coinlabel: RichTextLabel = $CoinLabel
@onready var healthbar: ProgressBar = $HealthBar

func _ready() -> void:
	healthbar.max_value = Global.health

func _process(_delta: float) -> void:
	coinlabel.text = "COINS: [outline_size=6][color=gold]" + str(Global.current_run_money) + "[/color][/outline_size]"
	healthbar.value = Global.health
