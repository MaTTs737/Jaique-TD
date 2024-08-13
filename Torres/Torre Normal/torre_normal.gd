extends "res://Torres/torreClass.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
	type = "normal"
	projectil = preload("res://Torres/Projectiles/projectil_normal.tscn")
	radiusColor = Color(0 / 255.0, 0 / 255.0, 255 / 255.0, 0.3)
	super ._ready()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta)

