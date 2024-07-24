extends "res://Torres/torreClass.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
	super ._ready()
	type = "hard"
	$shootTimer.start(0.5)
	projectil = preload("res://Torres/Projectiles/projectil_hard.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super ._process(delta)
