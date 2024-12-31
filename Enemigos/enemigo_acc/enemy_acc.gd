extends "res://Enemigos/enemyClass.gd"


# Called when the node enters the scene tree for the first time.
var accelerated
func _ready():
	type = "acc"
	super._ready()
	accelerated = false
	#Cuenta cada cuanto tiempo se activa la habilidad especial
	$acc_timer.start(randi() % 5 + 1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta)

func go_idle():
	super.go_idle()
	accelerated=false
	$acc_timer.start(randi() % 5 + 1)

func go_frozen():
	super.go_frozen()
	accelerated=false

func go_special ():
	if (state!=enemyState.frozen):
		get_parent().speed = defaultSpeed*8
		state=enemyState.special
		accelerated=true
		#Cuenta cuanto dura la habilidad especial
		$acc_timer.start(randi() % 3 + 1)
		emit_signal("special_s")
		
	else:
		go_idle()
	


#Activa la habilidad especial
func _on_acc_timer_timeout():
	if accelerated==false:
		transition_to(enemyState.special)
	else:
		transition_to(enemyState.idle)
