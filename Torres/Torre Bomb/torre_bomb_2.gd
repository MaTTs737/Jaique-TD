extends "res://Torres/torre_class_2.gd"


func _ready():
	type = "bomb"
	projectil = preload("res://Torres/Projectiles/projectil_bomb.tscn")
	radiusColor = Color(0 / 255.0, 255 / 255.0, 0 / 255.0, 0.3)
	super ._ready()

func _process(delta: float) -> void:
	super ._process(delta)
