extends Node

const TOWER_COST_DEFAULT = {
	normal = 30,
	hard = 100,
	ice = 50,
	bomb = 500,
}

const TOWER_DAMAGE_DEFAULT = {
	normal = 5,
	hard = 10,
	ice = 2,
	bomb = 1,
}

const TOWER_ATTACK_INTERVAL_DEFAULT = {
	"normal" = 1,
	"hard" = 1,
	"ice" = 1,
	"bomb" = 3,
}

const PROJECTILE_SPEED_DEFAULT = {
	normal = 500,
	hard = 500,
	ice = 400,
	bomb = 300,
}

const ENEMY_HP_DEFAULT = {
	normal = 10,
	acc = 10,
	acor = 60,
	invi = 5,
	spread = 60,
	minion = 5
}

const ENEMY_DAMAGE_DEFAULT = {
	normal = 5,
	acc = 5,
	acor = 15,
	invi = 25,
	spread = 50,
	minion = 1
}

const ENEMY_REWARD_DEFAULT = {
	normal = 1,
	acc = 5,
	acor = 5,
	invi = 10,
	spread = 10,
	minion = 0
}

const ENEMY_SPEED_DEFAULT = {
	normal = 100,
	acc = 100,
	acor = 100,
	invi = 150,
	spread = 100,
	minion = 150
}

const SPAWN_INTERVAL_DEFAULT = 0.5
const WAVE_INTERVAL_DEFAULT = 30
const final_wave = 20

# Variables que se usarán en el juego

var towerCost = {}
var towerDamage = {}
var towerAttackInterval = {}
var projectileSpeed = {}
var enemyHP = {}
var enemyDamage = {}
var enemyReward = {}
var enemySpeed = {}
var spawn_interval
var wave_interval

# Función para reiniciar las variables a los valores por defecto
func reset_difficulty_variables():
	towerCost = TOWER_COST_DEFAULT.duplicate()
	towerDamage = TOWER_DAMAGE_DEFAULT.duplicate()
	towerAttackInterval = TOWER_ATTACK_INTERVAL_DEFAULT.duplicate()
	projectileSpeed = PROJECTILE_SPEED_DEFAULT.duplicate()
	enemyHP = ENEMY_HP_DEFAULT.duplicate()
	enemyDamage = ENEMY_DAMAGE_DEFAULT.duplicate()
	enemyReward = ENEMY_REWARD_DEFAULT.duplicate()
	enemySpeed = ENEMY_SPEED_DEFAULT.duplicate()
	spawn_interval = SPAWN_INTERVAL_DEFAULT
	wave_interval = WAVE_INTERVAL_DEFAULT
