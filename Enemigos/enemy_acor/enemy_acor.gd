extends "res://Enemigos/enemyClass.gd"

@onready var audio_hit = $audio_hit
@onready var hit_metalico = load("res://Assets Generales/Audios/metal-whoosh-hit-10-202176.mp3")
# Called when the node enters the scene tree for the first time.
func _ready():
	type = "acor"
	super._ready()
	transition_to(enemyState.idle)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta)
	if healthPoints>=60 and state == enemyState.idle:
		anim.animation = "idle"
	elif healthPoints<45 and healthPoints >= 20 and state == enemyState.idle:
		anim.animation = "broken_1"
	elif healthPoints<20 and state == enemyState.idle:
		anim.animation = "broken_2"

func go_frozen():
	super.go_frozen()
	if healthPoints>=60:
		anim.animation = "frozen"
	elif healthPoints<45 and healthPoints >= 20:
		anim.animation = "broken_1_f"
	elif healthPoints<20 : anim.animation = "broken_2_f"



func _on_area_entered(area):
	if area.is_in_group("ammo"):
		get_hit(area.damage,area.type)
		if area.type == "ice" and (state != enemyState.frozen):
			transition_to(enemyState.frozen)
		else: 
			audio_hit.play()
	else: pass
