extends KinematicBody2D

var health = 1000
var max_health = 1000
var selected = false

var animatedSprite
var border

const DEFAULT_Y = 179.208

func _ready():
	animatedSprite = $AnimatedSprite
	animatedSprite.play("Idle")
	border = $Control/border
	select()

func take_damage(damage):
	health -= damage
	if health <= 0:
		queue_free()

func select():
	border.show()

func deselect():
	border.hide()
