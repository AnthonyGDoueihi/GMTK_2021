extends "res://Scripts/Unit.gd"

export var unit_speed = 70
export var unit_health = 250
export var unit_attack = 90
export var unit_distance_allowed = 100
export var unit_jump_speed = -500
export var unit_is_player = false
var lord_mints = []

func _ready():
	speed = unit_speed
	distance_allowed = unit_distance_allowed
	health = unit_health
	max_health = unit_health
	attack = unit_attack
	jump_speed = unit_jump_speed
	is_player = unit_is_player

func _process(delta):
	if not is_moving:
		find_new_target()

func find_new_target():
	var closest_mint
	var closest_mint_dist
	for mint in lord_mints:
		var new_dist = position.distance_to(mint.position)
		if not closest_mint_dist or new_dist < closest_mint_dist:
			closest_mint = mint
			closest_mint_dist = new_dist
	
	randomize()
	if closest_mint:
		target_position = closest_mint.forward + Vector2(rand_range(-unit_distance_allowed, unit_distance_allowed), 0)
	else:
		target_position = Vector2(rand_range(-900, 900), 0)
