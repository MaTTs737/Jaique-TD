extends "res://Enemigos/enemyClass.gd"


const pointer = preload("res://Escenario/pointer.tscn")
const minion = preload("res://Enemigos/enemy_spread/enemy_minion.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	type = "spread"
	super._ready()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta)


func die():
	#Hijo de puta usa un bucle for
	emit_signal("enemy_died")
	var parentProgress = get_parent().progress
	for i in range (15):
		var pointer = pointer.instantiate()
		var new_minion = minion.instantiate()
		pointer.progress = parentProgress + i*10
		get_parent().get_parent().add_child(pointer)
		pointer.add_child(new_minion)
	get_tree().current_scene.coins += reward
	queue_free()
