extends KinematicBody2D

var health = 1000
var max_health = 1000
export var is_player = false
var is_dead = false
var animatedSprite
var border

var health_bar

func _ready():
	animatedSprite = $AnimatedSprite
	animatedSprite.play("Idle")
	health_bar = $Control/HealthContainer/HealthBar

func take_damage(damage):
	health -= damage
	health_bar.max_value = max_health
	health_bar.value = health
	if health <= 0:
		is_dead = true
