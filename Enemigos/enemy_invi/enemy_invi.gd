extends "res://Enemigos/enemyClass.gd"

signal became_invisible
signal became_visible

@onready var invi_timer = $invi_timer
var is_visible : bool = true
# Called when the node enters the scene tree for the first time.
func _ready():
	type = "invi"
	super._ready()
	transition_to(enemyState.special)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta)




func go_special():
	if (state!=enemyState.frozen):
		is_visible=false
		invi_timer.start(randi() % 6 + 10)
		emit_signal("became_invisible", self)
		emit_signal("special_s")
		state=enemyState.special
	else:
		go_idle()
	
func go_idle():
	super.go_idle()
	is_visible=true
	invi_timer.start(1)
	emit_signal("became_visible", self)

func get_visibility()->bool:
	return is_visible

func _on_invi_timer_timeout():
	if (is_visible):
		transition_to(enemyState.special)
	else:
		transition_to(enemyState.idle)
