extends "res://Scripts/Unit.gd"

export var unit_speed = 100
export var unit_health = 100
export var unit_attack = 100
export var unit_distance_allowed = 100
export var unit_jump_speed = -1800

const DEFAULT_Y = 222.512

func _ready():
	speed = unit_speed
	distance_allowed = unit_distance_allowed
	health = unit_health
	max_health = unit_health
	attack = unit_attack
	jump_speed = unit_jump_speed
