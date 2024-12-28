extends "res://Enemigos/enemyClass.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
	type = "acc"
	super._ready()
	#Cuenta cada cuanto tiempo se activa la habilidad especial
	$acc_timer.start(randi() % 5 + 1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta)

func go_idle():
	super.go_idle()
	$acc_timer.start(randi() % 5 + 1)

func go_special ():
	if (state!=enemyState.frozen):
		get_parent().speed = defaultSpeed*8
		specialCondition = true
		#Cuenta cuanto dura la habilidad especial
		emit_signal("special_s")
	$specialCondition.start(randi() % 3 + 1)


#Activa la habilidad especial
func _on_acc_timer_timeout():
	transition_to(enemyState.special)
