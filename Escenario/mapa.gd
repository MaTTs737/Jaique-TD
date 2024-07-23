extends Node2D

# Variables para el generador de enemigos
var enemy_scene # = preload ("res://Enemigos/enemigo_basico/enemy_basico.tscn")  Escena del enemigo
var spawn_interval = 2 # Intervalo de tiempo entre la generación de enemigos
var spawn_timer = 0
var turno = 1 # Para probar
const pointer = preload("res://Escenario/pointer.tscn")


const enemies = { # Diccionario de escenas de enemigos
	normal = preload("res://Enemigos/enemigo_basico/enemy_basico.tscn"),
	acc = preload("res://Enemigos/enemigo_acc/enemy_acc.tscn"),
	spread = preload("res://Enemigos/enemy_spread/enemy_spread.tscn"),
	invi = preload("res://Enemigos/enemy_invi/enemy_invi.tscn"),
	acor = preload("res://Enemigos/enemy_acor/enemy_acor.tscn")
}

# Variables para el Path2D
var path2d_node
@onready var path_follow = $Path

func _ready():
	enemy_scene = enemies.normal
	# Buscar el nodo Path2D en el mapa
	# path2d_node = get_node("Path2D")
	pass
	# Obtener el nodo PathFollow2D del nodo Path2D
	# path_follow = path2d_node.get_child(0)

func _process(delta):
	# Incrementar el temporizador
	spawn_timer += delta
	
	# Verificar si es tiempo de generar un enemigo
	if spawn_timer >= spawn_interval:
		spawn_enemy()
		spawn_timer = 0
	
# Método para generar un enemigo
func spawn_enemy():
	match turno:
		1: enemy_scene = enemies.normal
		2: enemy_scene = enemies.acc
		3: enemy_scene = enemies.spread
		4: enemy_scene = enemies.invi
		5: enemy_scene = enemies.acor
	turno +=1
	if turno >= 6 : turno = 1 # Cambia tipo de enemigo del proximo spawn
	# Instanciar un nuevo enemigo desde la escena
	var new_enemy_instance = enemy_scene.instantiate()
	var new_enemy = new_enemy_instance as Area2D
	var new_pointer = pointer.instantiate() # Agregar un nuevo path follow
	path_follow.add_child(new_pointer) 
	new_pointer.add_child(new_enemy)# Agregar el nuevo enemigo como hijo del PathFollow2D
