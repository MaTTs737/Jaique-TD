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
	normal = 500,
	hard = 500,
	ice = 400,
	bomb = 300,
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
	invi = 25,
	spread = 25,
	minion = 1
}
var enemySpeed= {
	normal = 200,
	acc = 400,
	acor = 100,
	invi = 200,
	spread = 200,
	minion = 200
}

#Variables de las oleadas
var spawn_interval = 1
var wave_interval = 10


func _ready():
	pass 

func _process(delta):
	pass
