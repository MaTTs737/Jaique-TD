extends "res://Enemigos/enemyClass.gd"


const pointer = preload("res://Escenario/pointer.tscn")
const minion = preload("res://Enemigos/enemy_spread/enemy_minion.tscn")
var cantMinions = 15
# Called when the node enters the scene tree for the first time.
func _ready():
	type = "spread"
	super._ready()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta)


func die():
	var parentProgress = get_parent().progress
	var main = get_tree().get_root().get_node("Main")
	var map = null
	if main.has_node("map"):
		map = main.get_node("map")
		print("lo encontro")
	else:
		print("El nodo 'Map' no existe. Se omitirán conexiones relacionadas.")

	for i in range(cantMinions):
		var pointer = pointer.instantiate()
		var new_minion = minion.instantiate()
		pointer.progress = parentProgress + i * 10

		# Conectar señales al nodo principal y mapa
		if map != null:
			new_minion.connect("enemy_arrived", Callable(main, "on_enemy_arrived"))
			new_minion.connect("enemy_died", Callable(main, "on_enemy_died"))
			new_minion.connect("enemy_eliminated", Callable(map, "on_enemy_eliminated"))

		# Añadir los nodos al árbol de la escena
		get_parent().get_parent().add_child(pointer)
		pointer.add_child(new_minion)

	# Llamada al método 'die' de la clase base
	super.die()
