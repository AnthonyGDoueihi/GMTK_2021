extends Camera2D

export var margin = 50
var camera_movement = Vector2.ZERO
var speed = 450 
var _prev_mouse_pos

var snap_to_pos
var snapping = false

var music1 = preload("res://Assets/Music/Game-Jam-June-2021-1.ogg")
var music2 = preload("res://Assets/Music/Game-Jam-June-2021-2.ogg")
var music3 = preload("res://Assets/Music/Game-Jam-June-2021-3.ogg")

func _ready():
	AudioPlayer._play_sound(music1)
	$Timer1.wait_time = 24
	$Timer1.start()
	
func second_song():
	AudioPlayer._stop_sound()
	AudioPlayer._play_sound(music2)
	$Timer2.wait_time = 48
	$Timer2.start()

func third_song():
	AudioPlayer._stop_sound()
	AudioPlayer._play_sound(music3)
	
func snap_to(x_pos):
	snap_to_pos = x_pos
	snapping = true

func _physics_process(delta):
	if !snapping:
		var rec = get_viewport().get_visible_rect()
		var v = get_local_mouse_position() + rec.size/2
		if rec.size.x - v.x <= margin or Input.is_action_pressed("ui_right"):
			camera_movement.x += speed * delta
		if v.x <= margin or Input.is_action_pressed("ui_left"):
			camera_movement.x -= speed * delta
			

		position += camera_movement
		
		# Set camera movement to zero, update old mouse position.
		camera_movement = Vector2(0,0)
		_prev_mouse_pos = get_local_mouse_position()
	else:
		position.x = snap_to_pos
		snapping = false

func victory():
	get_tree().paused = true
	$Victory.show()

func defeat():
	get_tree().paused = true
	$Defeat.show()


func _main_menu():
	pass # Replace with function body.
