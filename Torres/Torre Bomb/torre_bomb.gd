extends "res://Torres/torreClass.gd"

# Called when the node enters the scene tree for the first time.
func _ready():
	type = "bomb"
	projectil = preload("res://Torres/Projectiles/projectil_bomb.tscn")
	radiusColor = Color(0 / 255.0, 255 / 255.0, 0 / 255.0, 0.3)
	super ._ready()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super ._process(delta)
