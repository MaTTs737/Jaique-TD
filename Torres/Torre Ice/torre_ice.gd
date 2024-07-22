extends "res://Torres/torreClass.gd"

# Called when the node enters the scene tree for the first time.
func _ready():
	super ._ready()
	projectil = preload("res://Torres/Projectiles/projectil_ice.tscn")
	$shootTimer.start(0.5)
	damage /= 5 
	type = "ice"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	super._process(_delta)
