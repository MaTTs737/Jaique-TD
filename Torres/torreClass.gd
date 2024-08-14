extends Node2D

var damage : int
var speed : int
var cost : int
var type : String
var radiusColor : Color
var target : Object
var enemies_in_range = []
var enemyIn = Callable(self,"_on_DetectionArea_area_entered")
var enemyOut = Callable(self,"_on_DetectionArea_area_exited")
var projectil = preload("res://Torres/Projectiles/projectil_normal.tscn")
@onready var anim = $AnimationPlayer
@onready var collision_shape = $DetectionArea/colision
var can_shoot = true


func shoot():
	var disparo = projectil.instantiate()
	disparo.target = target
	disparo.damage = damage
	disparo.type = type
	add_child(disparo)
	can_shoot = false
	$shootTimer.start()
	anim.play("shoot")
	

	# Called when the node enters the scene tree for the first time.
func _ready():
	damage = DifficultySettings.towerDamage[type]
	speed = DifficultySettings.towerAttackInterval[type]
	cost = DifficultySettings.towerCost[type]
	$shootTimer.wait_time= DifficultySettings.towerAttackInterval[type]
	$shootTimer.start()
	print ("Tipo: ", type)
	print ("daño: ", damage)
	print ("velocidad de tiro: ", speed)
	print ("costo: ", cost)
	#$DetectionArea.connect("area_entered", enemyIn)
	#$DetectionArea.connect("area_exited", enemyOut)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_key_pressed(KEY_ALT):
		queue_redraw()
	else:
		queue_redraw()
	if enemies_in_range.size() > 0:
		target = enemies_in_range[0]
	if target and can_shoot: shoot()

func _draw():
	if Input.is_key_pressed(KEY_ALT):
		draw_circle(Vector2.ZERO, collision_shape.shape.radius, radiusColor)

func _on_DetectionArea_area_exited(area):
	if area.is_in_group("enemies"):
		enemies_in_range.erase(area)
		if target == area:
			if enemies_in_range:
				target = enemies_in_range[0]
			else : target = null
		if area.has_method("get_visibility"):
			area.disconnect("became_invisible", Callable(self, "_on_enemy_became_invisible"))
			area.disconnect("became_visible", Callable(self, "_on_enemy_became_visible"))
	if area.is_in_group("ammo") and area.get_parent() == self:
		print("salio")
		area.queue_free()
	
	


func _on_shoot_timer_timeout():
	can_shoot = true


func _on_detection_area_entered(area):
	if area.is_in_group("enemies"):
		if not area.has_method("get_visibility") :
			enemies_in_range.append(area)
		else :
			area.connect("became_invisible", Callable(self, "_on_enemy_became_invisible"))
			area.connect("became_visible", Callable(self, "_on_enemy_became_visible"))
			if area.get_visibility() == true:
				enemies_in_range.append(area)

# Elimina al enemigo de la lista de objetivos cuando se vuelve invisible
func _on_enemy_became_invisible(enemy):
	if enemy in enemies_in_range:
		enemies_in_range.erase(enemy)
	if target == enemy:
		if enemies_in_range.size() > 0:
			target = enemies_in_range[0]
		else:
			target = null

# Vuelve a agregar al enemigo cuando se haga visible si sigue en su rango
func _on_enemy_became_visible(enemy):
	if enemy not in enemies_in_range:
		enemies_in_range.append(enemy)
