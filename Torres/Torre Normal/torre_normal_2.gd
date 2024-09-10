extends "res://Torres/torreClass.gd"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	damage = DifficultySettings.TOWER_DAMAGE_DEFAULT_2[type]
	speed = DifficultySettings.TOWER_ATTACK_INTERVAL_DEFAULT_2[type]
	$shootTimer.wait_time= speed
	$shootTimer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super ._process(delta)
