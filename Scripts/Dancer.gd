extends Node2D

var dancers = []
var go_left = true

func _ready():
	dancers = get_children()
	dancers.erase($Timer)
	$Timer.start()

func _physics_process(delta):
	for d in dancers:
		if go_left:
			d.position.x += delta * 50
			d.flip_h = true
		else:
			dancers.position.x -= delta * 50
			d.flip_h = false

func swap():
	go_left = !go_left
	$Timer.start()
