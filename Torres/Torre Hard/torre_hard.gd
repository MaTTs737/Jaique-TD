extends "res://Torres/torreClass.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
	type = "hard"
	projectil = preload("res://Torres/Projectiles/projectil_hard.tscn")
	radiusColor = Color(255 / 255.0, 0 / 255.0, 0 / 255.0, 0.3)
	super ._ready()
	damage = 80

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super ._process(delta)
