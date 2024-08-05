extends Node

#Variables de las torres
var towerCost = {
	normal = 10,
	hard = 50,
	ice = 30,
	bomb = 100,
}
var towerDamage = {
	normal = 10,
	hard = 10,
	ice = 10,
	bomb = 10,
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
	hard = 500,
	ice = 200,
	bomb = 100,
}


#Variables de los enemigos
var enemyHP= {
	normal = 10,
	acc = 10,
	acor = 10,
	invi = 10,
	spread = 10,
	minion = 5
}
var enemyReward= {
	normal = 10,
	acc = 10,
	acor = 10,
	invi = 10,
	spread = 10,
	minion = 1
}
var enemySpeed= {
	normal = 100,
	acc = 400,
	acor = 50,
	invi = 200,
	spread = 200,
	minion = 200
}

#Variables de las oleadas
var spawn_interval = 1
var wave_interval = 10

#Variables de los proyectiles

func _ready():
	pass 

func _process(delta):
	pass
