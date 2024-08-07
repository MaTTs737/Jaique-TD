extends Node

#Variables de las torres
var towerCost = {
	normal = 15,
	hard = 50,
	ice = 30,
	bomb = 100,
}
var towerDamage = {
	normal = 2,
	hard = 10,
	ice = 1,
	bomb = 1,
}
var towerAttackInterval = {
	normal = 0.25,
	hard = 0.5,
	ice = 1,
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
	acc = 10,
	acor = 60,
	invi = 10,
	spread = 40,
	minion = 5
}
var enemyDamage= {
	normal = 5,
	acc = 5,
	acor = 15,
	invi = 25,
	spread = 50,
	minion = 1
}
var enemyReward= {
	normal = 5,
	acc = 5,
	acor = 5,
	invi = 10,
	spread = 10,
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
var spawn_interval = 0.5
var wave_interval = 10


func _ready():
	pass 

func _process(delta):
	pass
