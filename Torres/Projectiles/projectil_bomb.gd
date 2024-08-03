extends "res://Torres/Projectiles/projectilClass.gd"


const explosion = preload("res://Torres/Projectiles/explosion_bomb.tscn")
var hit_enemies : Callable = func(): queue_free()
# Called when the node enters the scene tree for the first time.
func _ready():
	super ._ready() # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super ._process(delta)

func explode():
	$AnimatedSprite2D.visible = false
	var new_explosion = explosion.instantiate()
	new_explosion.connect("tree_exited",hit_enemies)
	new_explosion.global_position = global_position
	get_tree().get_current_scene().add_child(new_explosion)
	queue_free()
	
func hit():
	explode()

