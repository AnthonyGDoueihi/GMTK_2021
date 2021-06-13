extends "res://Scripts/Unit.gd"

export var unit_speed = 100
export var unit_health = 100
export var unit_attack = 10
export var unit_distance_allowed = 0
export var unit_jump_speed = -1000
export var unit_is_player = false

var border

func _ready():
	speed = unit_speed
	distance_allowed = unit_distance_allowed
	health = unit_health
	max_health = unit_health
	attack = unit_attack
	jump_speed = unit_jump_speed
	is_player = unit_is_player
	if unit_is_player:
		border = $Control/border

func select():
	border.show()

func deselect():
	border.hide()

