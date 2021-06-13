extends KinematicBody2D

var velocity = Vector2.ZERO
var target_position
var current_position
var stop_count = 0.0
var max_stop_count = 0.5 

var gravity = 4000

var jump_speed
var distance_allowed
var speed
var max_health
var health
var attack

var animatedSprite

var is_moving = false
var was_moving = false
var is_player = false
var is_hurt = false
var is_dead = false
var parent
var forward 

var health_bar


func _ready():
	if is_player:
		forward = position + Vector2(100, 0)
	else:
		forward = position + Vector2(-100, 0)
	animatedSprite = $AnimatedSprite
	current_position = position
	target_position = position
	animatedSprite.play("Idle")
	health_bar = $Control/HealthContainer/HealthBar
	
func get_input():
	is_moving = false
	velocity.x = 0
	if abs(target_position.x - position.x) > 10:
		if position.x < target_position.x:
			animatedSprite.flip_h = true
			velocity.x += speed
			is_moving = true
			forward = position + Vector2(100, 0)
		elif position.x > (target_position.x - distance_allowed):
			animatedSprite.flip_h = false
			velocity.x -= speed
			is_moving = true
			forward = position + Vector2(-100, 0)

func _physics_process(delta):
	if is_dead:
		return
	var previous_current_position = current_position
	if not is_hurt:
		get_input()
	velocity.y += gravity * delta
	var collision = move_and_collide(velocity, true, true, true)
	

	if collision and collision.collider:
		if is_hurt and collision.collider.collision_layer == 8:
			is_hurt = false
		if collision.collider.collision_layer != 8 and collision.collider.collision_layer != 1:
			if not is_hurt:
				is_hurt = true
				take_damage(collision.collider.attack)
				velocity.x = jump_speed/2 if is_player else -jump_speed/2
				velocity.y = jump_speed
				if not collision.collider.is_moving and not collision.collider.was_moving:
					 collision.collider.take_damage(attack)
		elif collision.collider.collision_layer == 1:
			if not is_hurt:
				if collision.collider.is_player != is_player:
					is_hurt = true
					collision.collider.take_damage(attack)
					velocity.x = jump_speed if is_player else -jump_speed
					velocity.y = jump_speed


	velocity = move_and_slide(velocity, Vector2.UP)

	if was_moving and not is_moving:
		was_moving = false
		animatedSprite.play("Idle")
	elif is_moving and not was_moving:
		was_moving = true
		animatedSprite.play("Walk")
		if is_player:
			animatedSprite.flip_h = true
			forward = position + Vector2(100, 0)
		else:
			animatedSprite.flip_h = false
			forward = position + Vector2(-100, 0)
	current_position = position
	
	if is_moving and previous_current_position == position:
		stop_count += delta
		if stop_count > max_stop_count:
			is_moving = false
	else:
		stop_count = 0
		
func take_damage(damage):
	health -= damage
	health_bar.max_value = max_health
	health_bar.value = health
	if health <= 0:
		is_dead = true
