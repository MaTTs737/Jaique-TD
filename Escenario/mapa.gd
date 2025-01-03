extends Node2D

# Variables para el generador de enemigos
var enemy_scene # = preload ("res://Enemigos/enemigo_basico/enemy_basico.tscn")  Escena del enemigo
var spawn_interval = 3 # Intervalo de tiempo entre la generación de enemigos
var spawn_timer = 0
var wave = 1 # Para probar - numero de oleada
var intro_waves = [3, 6, 10, 14]
var intro_waves_triggered = {}
const pointer = preload("res://Escenario/pointer.tscn")
const base_enemies = 5
var countingTime = false
var timeSurvived=0.0

var lastCheck = 0
var checkInterval=15
var checkCant = 0

var enemiesAlive= 0
var enemiesSpawned=0
var enemiesInWave=0

@onready var enemy_timer=$Timer
@onready var audio_hdp = $audio_hdp
@onready var time_left = $Control/timerLabel
@onready var winLabel = $Control/winLabel
@onready var nextButton = $nextWave_button
@onready var path_follow = $Path
@onready var timer = $Timer

const enemies = { # Diccionario de escenas de enemigos
	normal = preload("res://Enemigos/enemigo_basico/enemy_basico.tscn"),
	acc = preload("res://Enemigos/enemigo_acc/enemy_acc.tscn"),
	spread = preload("res://Enemigos/enemy_spread/enemy_spread.tscn"),
	invi = preload("res://Enemigos/enemy_invi/enemy_invi.tscn"),
	acor = preload("res://Enemigos/enemy_acor/enemy_acor.tscn")
}
const minion = preload("res://Enemigos/enemy_spread/enemy_minion.tscn")
var enemyProbabilities = {
	normal = 1, 
	acc = 0,     
	spread = 0,  
	invi = 0,    
	acor = 0     
}

# Variables para el Path2D
var path2d_node

func _ready():
	randomize()
	enemy_scene = enemies.normal
	timer.start(3)
	# Buscar el nodo Path2D en el mapa
	# path2d_node = get_node("Path2D")
	for wave in intro_waves:
		intro_waves_triggered[wave] = false
	# Obtener el nodo PathFollow2D del nodo Path2D
	# path_follow = path2d_node.get_child(0)

func _process(delta):
	if countingTime:
		timeSurvived+=delta
		update_time_left()
		if int(timeSurvived) >= lastCheck + checkInterval:
			increaseDifficulty()
			lastCheck += checkInterval
		
	else:
		update_time_left()

func increaseDifficulty():
	checkCant +=1
	if DifficultySettings.spawn_interval>0.3:
		DifficultySettings.spawn_interval-=0.1
	if checkCant < 10:
		for key in DifficultySettings.enemySpeed.keys():
			DifficultySettings.enemySpeed[key] = DifficultySettings.enemySpeed[key]*1.1
	for key in DifficultySettings.enemyHP.keys():
		DifficultySettings.enemyHP[key] = DifficultySettings.enemyHP[key]*1.1
	
# Método para generar un enemigo
func select_enemy_based_on_probability() -> String:
	var random_value = randf() 
	var cumulative_probability = 0.0
	
	for key in enemyProbabilities.keys():
		cumulative_probability += enemyProbabilities[key]
		if random_value <= cumulative_probability:
			return key  
	return "" 

func spawn_enemy(enemy_key: String):
	var enemy_scene = enemies.get(enemy_key, null)
	var new_enemy_instance = enemy_scene.instantiate()
	var new_enemy = new_enemy_instance as Area2D
	
	new_enemy.connect("enemy_eliminated", Callable(self, "on_enemy_eliminated"))
	new_enemy.connect("enemy_died", Callable(get_parent(), "on_enemy_died"))
	new_enemy.connect("enemy_arrived", Callable(get_parent(), "on_enemy_arrived"))
	var new_pointer = pointer.instantiate() # Agregar un nuevo path follow
	path_follow.add_child(new_pointer) 
	new_pointer.add_child(new_enemy)# Agregar el nuevo enemigo como hijo del PathFollow2D

#ajusta la posibilidad de que un enemigo aparezca
func set_enemy_chance(wave:int):
	match wave:
		3: 
			enemyProbabilities.normal=0.8
			enemyProbabilities.acc=0.2
			enemyProbabilities.invi=0.0
			enemyProbabilities.acor=0.0
			enemyProbabilities.spread=0.0
		6:
			enemyProbabilities.normal=0.65
			enemyProbabilities.acc=0.2
			enemyProbabilities.invi=0.0
			enemyProbabilities.acor=0.15
			enemyProbabilities.spread=0
		10:
			enemyProbabilities.normal=0.5
			enemyProbabilities.acc=0.2
			enemyProbabilities.invi=0.1
			enemyProbabilities.acor=0.2
			enemyProbabilities.spread=0.0
		14:  
			enemyProbabilities.normal=0.4
			enemyProbabilities.acc=0.2
			enemyProbabilities.invi=0.1
			enemyProbabilities.acor=0.2
			enemyProbabilities.spread=0.1
		20:  
			enemyProbabilities.normal=0.2
			enemyProbabilities.acc=0.2
			enemyProbabilities.invi=0.2
			enemyProbabilities.acor=0.2
			enemyProbabilities.spread=0.2

func set_wave(wave:int) -> int:
	var total_enemies
	total_enemies = base_enemies * pow(1.15, wave - 1) # E(n)=E(1)⋅(1+r)^n-1 donde n es el numero de oleada y r es el incremento
	var increment= 1+0.01*(100-get_parent().life_points) # si se recibio 3 de daño aumenta 3%,etc
	total_enemies=total_enemies*increment
	set_enemy_chance(wave)
	
	return total_enemies

func intro_wave(type:String):
	enemiesInWave=3
	for i in enemiesInWave:
		await get_tree().create_timer(DifficultySettings.spawn_interval).timeout
		enemiesSpawned+=1
		enemiesAlive+=1
		spawn_enemy(type)

func update_progress(wave:int):
	$Control_ProgressBar/ProgressBar.update(wave)

func launch_wave():
	enemiesSpawned=0
	if (wave in intro_waves and not intro_waves_triggered [wave]):
		intro_waves_triggered[wave]=true
		match wave:
			3: 
				await intro_wave("acc")
			6:
				await intro_wave("acor")
			10:
				await intro_wave("invi")
			14:  
				await intro_wave("spread")
	else:
		update_progress(wave)
		if wave == 1 :
			audio_hdp.play()
		var enemy_type
		enemiesInWave=set_wave(wave)
		print ("INWAVE:",enemiesInWave)
		for i in range(enemiesInWave):
			await get_tree().create_timer(DifficultySettings.spawn_interval).timeout
			enemy_type = select_enemy_based_on_probability()
			enemiesSpawned+=1
			enemiesAlive+=1
			print("ALIVE:", enemiesAlive)
			spawn_enemy(enemy_type)
		wave+=1
func final_wave_protocol ():
	Global.player_won = true
	Global.playerScore.coinsLeft=self.get_parent().coins
	Global.playerScore.lifeLeft=self.get_parent().life_points
	$Control_ProgressBar/ProgressBar.visible=false
	winLabel.visible = true
	set_enemy_chance(wave)
	time_left.visible=false
	await get_tree().create_timer(3).timeout
	countingTime=true
	time_left.visible=true
	while (true):
		await get_tree().create_timer(DifficultySettings.spawn_interval).timeout
		var enemy_type = select_enemy_based_on_probability()
		spawn_enemy(enemy_type)

func update_time_left():
	if not countingTime:
		time_left.text = str(ceil(timer.time_left))
	else:
		time_left.text = str(ceil(timeSurvived))

func _on_timer_timeout():
	nextButton.visible=false
	time_left.visible=false
	if (wave < DifficultySettings.final_wave):
		launch_wave()
	else:
		final_wave_protocol()

func _on_next_wave_button_pressed():
	timer.stop()
	timer.emit_signal("timeout")

func count_enemies():
	var enemy_count = 0
	for i in range(path_follow.get_child_count()):
		var path_child = path_follow.get_child(i)
		if path_child is PathFollow2D:
			for j in range(path_child.get_child_count()):
				var possible_enemy = path_child.get_child(j)
				if possible_enemy.is_in_group("enemies"): # Marca los enemigos con un grupo
					enemy_count += 1
	return enemy_count


func on_enemy_eliminated(type):
	print("conecto")
	var enemy_count = count_enemies()
	print("enemy_count:", enemy_count)
	if (enemy_count == 1) and (enemiesSpawned>=enemiesInWave): # por algun motivo la cantidad minima siempre es uno
		nextButton.visible=true
		time_left.visible=true
		timer.start(DifficultySettings.wave_interval)
