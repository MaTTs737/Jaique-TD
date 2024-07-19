extends "res://Torres/torreClass.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
	super ._ready()
	projectil = preload("res://Torres/Projectiles/projectil_normal.tscn")
	type = "normal"
	$shootTimer.start(0.5)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta)

