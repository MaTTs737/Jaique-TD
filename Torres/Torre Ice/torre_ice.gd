extends "res://Torres/torreClass.gd"

# Called when the node enters the scene tree for the first time.
func _ready():
	type = "ice"
	projectil = preload("res://Torres/Projectiles/projectil_ice.tscn")
	radiusColor = Color(153 / 255.0, 204 / 255.0, 255 / 255.0, 0.3)
	super ._ready()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	super._process(_delta)
