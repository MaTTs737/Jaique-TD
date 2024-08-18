extends "res://Torres/torreClass.gd"

var isFreezing = false

# Called when the node enters the scene tree for the first time.
func _ready():
	type = "ice"
	projectil = preload("res://Torres/Projectiles/projectil_ice.tscn")
	radiusColor = Color(153 / 255.0, 204 / 255.0, 255 / 255.0, 0.3)
	super ._ready()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	super._process(_delta)

func shoot():  # Tiene un shoot especifico distinto del towerClass. Ademas No hace danio, no invoca al get_hit del enemy
	$AnimationPlayer.play("shoot")
	$audio_player_shoot.play()
	can_shoot = false
	freezeEnemies()
	$shootTimer.start(2.5)
	
	
func freezeEnemies(): # Funcion especifica para poder llamarla desde la animacion shoot sin romper nada
	for i in enemies_in_range:
		if i.state != i.enemyState.frozen:
			i.transition_to(i.enemyState.frozen)

func stop_audio():
	$audio_player_shoot.stop()
	
