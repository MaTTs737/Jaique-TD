extends Node2D

# Variables para el generador de enemigos
var enemy_scene = preload ("res://Enemigos/enemigo_basico/enemy_basico.tscn") # Escena del enemigo
var spawn_interval = 2 # Intervalo de tiempo entre la generación de enemigos
var spawn_timer = 0

# Variables para el Path2D
var path2d_node
@onready var path_follow = $Path/Pointer

func _ready():
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
	# Instanciar un nuevo enemigo desde la escena
	var new_enemy_instance = enemy_scene.instantiate()
	var new_enemy = new_enemy_instance as Area2D
	
	# Agregar el nuevo enemigo como hijo del PathFollow2D
	path_follow.add_child(new_enemy)
