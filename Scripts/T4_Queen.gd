extends KinematicBody2D

var health = 1000
var max_health = 1000
var selected = false

var animatedSprite

const DEFAULT_Y = 179.208

func _ready():
	animatedSprite = $AnimatedSprite
	animatedSprite.play("Idle")

func take_damage(damage):
	health -= damage
	if health <= 0:
		queue_free()
