extends Node2D

# Variables para el generador de enemigos
var enemy_scene # = preload ("res://Enemigos/enemigo_basico/enemy_basico.tscn")  Escena del enemigo
var spawn_interval = 3 # Intervalo de tiempo entre la generación de enemigos
var spawn_timer = 0
var wave = 0 # Para probar - numero de oleada
const pointer = preload("res://Escenario/pointer.tscn")
const base_enemies= 5
@onready var enemy_timer=$Timer

const enemies = { # Diccionario de escenas de enemigos
	normal = preload("res://Enemigos/enemigo_basico/enemy_basico.tscn"),
	acc = preload("res://Enemigos/enemigo_acc/enemy_acc.tscn"),
	spread = preload("res://Enemigos/enemy_spread/enemy_spread.tscn"),
	invi = preload("res://Enemigos/enemy_invi/enemy_invi.tscn"),
	acor = preload("res://Enemigos/enemy_acor/enemy_acor.tscn")
}
var enemyProbabilities = {
	normal = 0.9,  # 30% de probabilidad
	acc = 0.1,     # 40% de probabilidad
	spread = 0,  # 10% de probabilidad
	invi = 0,    # 10% de probabilidad
	acor = 0     # 10% de probabilidad
}



# Variables para el Path2D
var path2d_node
@onready var path_follow = $Path
@onready var timer = $Timer
func _ready():
	enemy_scene = enemies.normal
	timer.start(1)
	# Buscar el nodo Path2D en el mapa
	# path2d_node = get_node("Path2D")
	pass
	# Obtener el nodo PathFollow2D del nodo Path2D
	# path_follow = path2d_node.get_child(0)

func _process(delta):
	pass
	
	
# Método para generar un enemigo
func select_enemy_based_on_probability() -> String:
	var random_value = randf() # Genera un número aleatorio entre 0 y 1
	var cumulative_probability = 0.0
	
	for key in enemyProbabilities.keys():
		cumulative_probability += enemyProbabilities[key]
		if random_value <= cumulative_probability:
			return key  # Retorna la clave del diccionario que corresponde al enemigo seleccionado
	
	return ""  # Valor de respaldo en caso de error

func spawn_enemy(enemy_key: String):
	var enemy_scene = enemies.get(enemy_key, null)
	var new_enemy_instance = enemy_scene.instantiate()
	var new_enemy = new_enemy_instance as Area2D
	var new_pointer = pointer.instantiate() # Agregar un nuevo path follow
	path_follow.add_child(new_pointer) 
	new_pointer.add_child(new_enemy)# Agregar el nuevo enemigo como hijo del PathFollow2D


func set_wave(wave:int) -> int:
	var total_enemies=base_enemies*(1+0.1*wave)
	match wave:
		2: 
			enemyProbabilities.acor=0.1
			enemyProbabilities.normal-=0.1
		4:
			enemyProbabilities.invi=0.1
			enemyProbabilities.normal-=0.1
		6:
			enemyProbabilities.spread=0.1
			enemyProbabilities.normal-=0.1
		7:  
			enemyProbabilities.normal=0
			enemyProbabilities.acc=0.25
			enemyProbabilities.invi=0.25
			enemyProbabilities.acor=0.25
			enemyProbabilities.spread=0.25
	return total_enemies

func launch_wave():
	wave+=1
	print("Oleada:", wave)
	var total_enemies=set_wave(wave)
	print("Cantidad de enemigos: ",total_enemies)
	for i in range(total_enemies):
		await get_tree().create_timer(1).timeout
		var enemy_type = select_enemy_based_on_probability()
		spawn_enemy(enemy_type)
	print ("Fin de Oleada ", wave)
		

func _on_timer_timeout():
	await launch_wave()
	print ("Empieza Timer para siguiente oleada ")
	timer.start(10)
