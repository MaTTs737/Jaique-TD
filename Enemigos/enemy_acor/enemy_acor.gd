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
	if healthPoints>20 and state == enemyState.idle:
		anim.animation = "idle"
	if healthPoints<15 and healthPoints >= 101 and state == enemyState.idle:
		anim.animation = "broken_1"
	elif healthPoints<10 and state == enemyState.idle:
		anim.animation = "broken_2"

func transition_to(new_state:enemyState):
	state = new_state
	match state:
		enemyState.idle:
			get_parent().speed = initialSpeed
		enemyState.frozen:
			audio_freeze.play()
			if healthPoints>=20:
				anim.animation = "frozen"
			elif healthPoints > 15:
				anim.animation = "broken_1_f"
			else : anim.animation = "broken_2_f"
			
			get_parent().speed /= 2
			specialCondition = true
			$specialCondition.start()
		enemyState.special:
			specialCondition = true
			$specialCondition.start()

func _on_area_entered(area):
	if area.is_in_group("ammo"):
		get_hit(area.damage,area.type)
		if area.type == "ice" and (state != enemyState.frozen):
			transition_to(enemyState.frozen)
		else: 
			audio_hit.play()
	else: pass
