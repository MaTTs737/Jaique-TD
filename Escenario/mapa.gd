extends Node2D

# Variables para el generador de enemigos
var enemy_scene # = preload ("res://Enemigos/enemigo_basico/enemy_basico.tscn")  Escena del enemigo
var spawn_interval = 3 # Intervalo de tiempo entre la generación de enemigos
var spawn_timer = 0
var wave = 1 # Para probar - numero de oleada
const pointer = preload("res://Escenario/pointer.tscn")
const base_enemies = 5
@onready var enemy_timer=$Timer
@onready var time_left = $Label

const enemies = { # Diccionario de escenas de enemigos
	normal = preload("res://Enemigos/enemigo_basico/enemy_basico.tscn"),
	acc = preload("res://Enemigos/enemigo_acc/enemy_acc.tscn"),
	spread = preload("res://Enemigos/enemy_spread/enemy_spread.tscn"),
	invi = preload("res://Enemigos/enemy_invi/enemy_invi.tscn"),
	acor = preload("res://Enemigos/enemy_acor/enemy_acor.tscn")
}
var enemyProbabilities = {
	normal = 1, 
	acc = 0,     
	spread = 0,  
	invi = 0,    
	acor = 0     
}



# Variables para el Path2D
var path2d_node
@onready var path_follow = $Path

@onready var timer = $Timer
func _ready():
	randomize()
	enemy_scene = enemies.normal
	timer.start(3)
	# Buscar el nodo Path2D en el mapa
	# path2d_node = get_node("Path2D")
	pass
	# Obtener el nodo PathFollow2D del nodo Path2D
	# path_follow = path2d_node.get_child(0)

func _process(delta):
	update_time_left()
	
	
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
	var new_pointer = pointer.instantiate() # Agregar un nuevo path follow
	path_follow.add_child(new_pointer) 
	new_pointer.add_child(new_enemy)# Agregar el nuevo enemigo como hijo del PathFollow2D


#ajusta la posibilidad de que un enemigo aparezca
func set_enemy_chance(wave:int):
	match wave:
		2: 
			enemyProbabilities.normal=0.6
			enemyProbabilities.acc=0.2
			enemyProbabilities.invi=0.0
			enemyProbabilities.acor=0.2
			enemyProbabilities.spread=0.0
		4:
			enemyProbabilities.normal=0.6
			enemyProbabilities.acc=0.15
			enemyProbabilities.invi=0.1
			enemyProbabilities.acor=0.15
			enemyProbabilities.spread=0
		6:
			enemyProbabilities.normal=0.5
			enemyProbabilities.acc=0.2
			enemyProbabilities.invi=0.1
			enemyProbabilities.acor=0.2
			enemyProbabilities.spread=0.1
		8:  
			enemyProbabilities.normal=0.5
			enemyProbabilities.acc=0.2
			enemyProbabilities.invi=0.1
			enemyProbabilities.acor=0.1
			enemyProbabilities.spread=0.1
		20:  
			enemyProbabilities.normal=0.0
			enemyProbabilities.acc=0.3
			enemyProbabilities.invi=0.2
			enemyProbabilities.acor=0.2
			enemyProbabilities.spread=0.3
	pass


func set_wave(wave:int) -> int:
	print("Oleada:", wave)
	print("Cantidad de enemigos Base: ",base_enemies)
	
	# Incrementa total_enemies en funcion de numero de oleada
	var total_enemies=  base_enemies* pow(1.15, wave - 1) # E(n)=E(1)⋅(1+r)^n-1 donde n es el numero de oleada y r es el incremento
	print ("Incremento por oleada ","15% de la anterior =", total_enemies)
	
	# Vuelve a incrementar total_enemies en funcion de daño recibido
	var increment= 1+0.01*(100-get_parent().life_points) # si se recibio 3 de daño aumenta 3%,etc
	total_enemies=total_enemies*increment
	print ("Incremento por daño ",100-get_parent().life_points,"% =", total_enemies)
	
	set_enemy_chance(wave)
	
	return total_enemies

func launch_wave():
	var total_enemies=set_wave(wave)
	for i in range(total_enemies):
		await get_tree().create_timer(DifficultySettings.spawn_interval).timeout
		var enemy_type = select_enemy_based_on_probability()
		spawn_enemy(enemy_type)
	print ("Fin de Oleada ", wave)
	wave+=1
		

func final_wave_protocol ():
	time_left.text = ("GANASTE")
	set_enemy_chance(wave)
	for key in DifficultySettings.enemySpeed:
		DifficultySettings.enemySpeed[key] = DifficultySettings.enemySpeed[key]*1.5
	for key in DifficultySettings.enemyHP:
		DifficultySettings.enemyHP[key] = DifficultySettings.enemySpeed[key]*2

	while (true):
		DifficultySettings.spawn_interval = 0.1
		await get_tree().create_timer(DifficultySettings.spawn_interval).timeout
		var enemy_type = select_enemy_based_on_probability()
		spawn_enemy(enemy_type)

func update_time_left():
	time_left.text = str(ceil(timer.time_left))

func _on_timer_timeout():
	if (wave < DifficultySettings.final_wave):
		await launch_wave()
		print ("Empieza Timer para siguiente oleada ")
		timer.start(DifficultySettings.wave_interval)
	else:
		final_wave_protocol()


func _on_next_wave_button_pressed():
	_on_timer_timeout()
