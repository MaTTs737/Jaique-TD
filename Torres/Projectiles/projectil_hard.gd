extends "res://Torres/Projectiles/projectilClass.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
	type = "hard"
	super ._ready()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta)
