extends KinematicBody2D

var velocity = Vector2.ZERO
var target_position

var distance_allowed
var speed

var animatedSprite

var is_moving = false
var was_moving = false

var parent

func _ready():
	animatedSprite = $AnimatedSprite
	target_position = position
	animatedSprite.play("Idle")

func get_input():
	velocity.x = 0
	is_moving = false
	if target_position.x - position.x > distance_allowed:
		if position.x < target_position.x:
			animatedSprite.flip_h = true
			velocity.x += speed
			is_moving = true
		elif position.x > (target_position.x - distance_allowed):
			animatedSprite.flip_h = false
			velocity.x -= speed
			is_moving = true

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity, Vector2.UP)
	if was_moving and not is_moving:
		was_moving = false
		animatedSprite.play("Idle")
	elif is_moving and not was_moving:
		was_moving = true
		animatedSprite.play("Walk")
