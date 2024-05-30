extends "res://Enemigos/enemyClass.gd"


func _init():
	damage = 10
	healthPoints = 2
	type = "normal"
	speed = 1
	reward = 10
# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta)
