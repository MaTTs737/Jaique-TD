extends "res://Enemigos/enemyClass.gd"


func _init():
	type = "normal"
	reward = 10
	anim = $AnimatedSprite2D
# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	_init()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta)
