extends Node

#Variables de las torres
var towerCost = {
	normal = 15,
	hard = 50,
	ice = 30,
	bomb = 100,
}
var towerDamage = {
	normal = 5,
	hard = 15,
	ice = 2,
	bomb = 5,
}
var towerAttackInterval = {
	normal = 0.5,
	hard = 0.5,
	ice = 0.5,
	bomb = 0.5,
}

#Variables de los proyectiles de las torres
var projectileSpeed = {
	normal = 600,
	hard = 600,
	ice = 400,
	bomb = 200,
}


#Variables de los enemigos
var enemyHP= {
	normal = 10,
	acc = 15,
	acor = 40,
	invi = 10,
	spread = 20,
	minion = 5
}
var enemyDamage= {
	normal = 5,
	acc = 5,
	acor = 15,
	invi = 25,
	spread = 30,
	minion = 1
}
var enemyReward= {
	normal = 5,
	acc = 5,
	acor = 15,
	invi = 5,
	spread = 5,
	minion = 1
}
var enemySpeed= {
	normal = 100,
	acc = 400,
	acor = 50,
	invi = 150,
	spread = 100,
	minion = 100
}

#Variables de las oleadas
var spawn_interval = 1
var wave_interval = 5


func _ready():
	pass 

func _process(delta):
	pass
