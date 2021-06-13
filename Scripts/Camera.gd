extends Camera2D

export var margin = 50
var camera_movement = Vector2.ZERO
var speed = 450 
var _prev_mouse_pos

func _physics_process(delta):
	var rec = get_viewport().get_visible_rect()
	var v = get_local_mouse_position() + rec.size/2
	if rec.size.x - v.x <= margin:
		camera_movement.x += speed * delta
	if v.x <= margin:
		camera_movement.x -= speed * delta
	if rec.size.y - v.y <= margin:
		camera_movement.y += speed * delta
	if v.y <= margin:
		camera_movement.y -= speed * delta

	position += camera_movement
	
	# Set camera movement to zero, update old mouse position.
	camera_movement = Vector2(0,0)
	_prev_mouse_pos = get_local_mouse_position()
