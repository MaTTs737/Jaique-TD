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
	var pointer1 = pointer.instantiate()
	var pointer2 = pointer.instantiate()
	var pointer3 = pointer.instantiate()
	var pointer4 = pointer.instantiate()
	var pointer5 = pointer.instantiate()
	var pointer6 = pointer.instantiate()
	var pointer7 = pointer.instantiate()
	var new_minion1 = minion.instantiate()
	var new_minion2 = minion.instantiate()
	var new_minion3 = minion.instantiate()
	var new_minion4 = minion.instantiate()
	var new_minion5 = minion.instantiate()
	var new_minion6 = minion.instantiate()
	var new_minion7 = minion.instantiate()
	
	pointer1.progress = get_parent().progress + 10
	pointer2.progress = get_parent().progress + 20
	pointer3.progress = get_parent().progress + 30
	pointer4.progress = get_parent().progress 
	pointer5.progress = get_parent().progress -10
	pointer6.progress = get_parent().progress -20
	pointer7.progress = get_parent().progress -30
	
	
	get_parent().get_parent().add_child(pointer1)
	pointer1.add_child(new_minion1)
	get_parent().get_parent().add_child(pointer2)
	pointer2.add_child(new_minion2)
	get_parent().get_parent().add_child(pointer3)
	pointer3.add_child(new_minion3)
	get_parent().get_parent().add_child(pointer4)
	pointer4.add_child(new_minion4)
	get_parent().get_parent().add_child(pointer5)
	pointer5.add_child(new_minion5)
	get_parent().get_parent().add_child(pointer6)
	pointer6.add_child(new_minion6)
	get_parent().get_parent().add_child(pointer7)
	pointer7.add_child(new_minion7)
	
	get_tree().current_scene.coins += reward
	queue_free()
