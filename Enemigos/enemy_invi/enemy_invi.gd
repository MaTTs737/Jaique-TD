extends "res://Enemigos/enemyClass.gd"

signal became_invisible
signal became_visible

@onready var invi_timer = $invi_timer
var is_visible : bool = true
# Called when the node enters the scene tree for the first time.
func _ready():
	type = "invi"
	super._ready()
	go_invi()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta)


func transition_to(new_state:enemyState):
	state = new_state
	match state:
		enemyState.idle:
			emit_signal("back_to_normal")
			get_parent().speed = initialSpeed
		enemyState.frozen:
			get_parent().speed /= 4
			specialCondition = true
			#$specialCondition.start()
			emit_signal("freeze")
		enemyState.special:
			specialCondition = true
			#$specialCondition.start() No se que hacen estas lineas pero interfieren
			emit_signal("special_s")


func go_invi():
	print ("se hace invisible")
	is_visible=false
	transition_to(enemyState.special)
	invi_timer.start(randi() % 6 + 10)
	emit_signal("became_invisible", self)
	
func go_visible():
	is_visible=true
	transition_to(enemyState.idle)
	invi_timer.start(2)
	emit_signal("became_visible", self)

func get_visibility()->bool:
	return is_visible

func _on_invi_timer_timeout():
	if (is_visible):
		go_invi()
	else:
		go_visible()
