extends Node2D

var selected_unit

var unit_array = []
var lord_mints = []
var warriors = []
var minions = []
var queen
var camera
var resources


var keycodes = [49, 50, 51, 52, 53, 54, 55, 56, 57] 

func _ready():
	camera = get_tree().get_nodes_in_group("Camera")[0]
	queen = get_tree().get_nodes_in_group("PlayerQueen")[0]
	unit_array.append(queen)
	selected_unit = queen
	lord_mints = get_tree().get_nodes_in_group("PlayerMints")
	warriors = get_tree().get_nodes_in_group("PlayerWarriors")
	minions = get_tree().get_nodes_in_group("PlayerMinions")
	unit_array += lord_mints
	
func _process(delta):
	for i in range(0, unit_array.size()):
		if Input.is_key_pressed(keycodes[i]):
			selected_unit.selected = false
			selected_unit = unit_array[i]
			selected_unit.selected = true
			camera.snap_to(selected_unit.position.x)

func _unhandled_input(event):
	if event is InputEventMouseButton and event.pressed:
		if selected_unit != queen:
			selected_unit.target_position = get_global_mouse_position()
