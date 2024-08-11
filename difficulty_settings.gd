extends Node

#Variables de las torres
var towerCost = {
	normal = 30,
	hard = 100,
	ice = 50,
	bomb = 300,
}
var towerDamage = {
	normal = 5,
	hard = 10,
	ice = 2,
	bomb = 1,
}
var towerAttackInterval = {
	normal = 1,
	hard = 1,
	ice = 1,
	bomb = 3,
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
	invi = 5,
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
	normal = 1,
	acc = 5,
	acor = 5,
	invi = 10,
	spread = 10,
	minion = 0
}
var enemySpeed= {
	normal = 100,
	acc = 300,
	acor = 75,
	invi = 100,
	spread = 100,
	minion = 100
}

#Variables de las oleadas
var spawn_interval = 0.5
var wave_interval = 30
const final_wave = 20

func _ready():
	pass 

func _process(delta):
	pass
