extends "res://Enemigos/enemyClass.gd"


const pointer = preload("res://Escenario/pointer.tscn")
const minion = preload("res://Enemigos/enemy_spread/enemy_little.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta)


func die():
	var pointer1 = pointer.instantiate()
	var pointer2 = pointer.instantiate()
	var pointer3 = pointer.instantiate()
	var new_minion1 = minion.instantiate()
	var new_minion2 = minion.instantiate()
	var new_minion3 = minion.instantiate()
	pointer1.progress = get_parent().progress + 10
	pointer2.progress = get_parent().progress + 20
	pointer3.progress = get_parent().progress + 30
	
	get_parent().get_parent().add_child(pointer1)
	pointer1.add_child(new_minion1)
	get_parent().get_parent().add_child(pointer2)
	pointer2.add_child(new_minion2)
	get_parent().get_parent().add_child(pointer3)
	pointer3.add_child(new_minion3)
	
	queue_free()
