extends "res://Scripts/Unit.gd"

export var unit_speed = 100
export var unit_distance_allowed = 100

func _ready():
	speed = unit_speed
	distance_allowed = unit_distance_allowed
