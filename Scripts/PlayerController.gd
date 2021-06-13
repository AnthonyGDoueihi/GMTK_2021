extends Node2D

var selected_unit

onready var minion = preload("res://Nodes/Units/T1_Good_Minion.tscn")
onready var warrior = preload("res://Nodes/Units/T2_Good_Warrior.tscn")
onready var lord_mint = preload("res://Nodes/Units/T3_Good_Lord_Mint.tscn")

var lord_mints = []
var warriors = []
var minions = []
var queen
var camera
var resources = 100

var helper
var keycodes = [49, 50, 51, 52, 53, 54, 55, 56, 57] 

func _ready():
	camera = get_tree().get_nodes_in_group("Camera")[0]
	queen = get_tree().get_nodes_in_group("PlayerQueen")[0]
	lord_mints = get_tree().get_nodes_in_group("PlayerMints")
	if lord_mints:
		selected_unit = lord_mints[0]
		lord_mints[0].select()
	warriors = get_tree().get_nodes_in_group("PlayerWarriors")
	minions = get_tree().get_nodes_in_group("PlayerMinions")
	set_lord_mints()
	helper = $Helper
		
func _process(delta):
	for i in range(0, lord_mints.size()):
		if Input.is_key_pressed(keycodes[i]):
			if selected_unit:
				selected_unit.deselect()
			selected_unit = lord_mints[i]
			selected_unit.select()
	
	resources += lord_mints.size() * 2 * delta

	if Input.is_action_pressed("snap"):
		camera.snap_to(selected_unit.position.x)
		
	check_dead()
	
func check_dead():
	if queen.is_dead:
		camera.defeat()
		return 
	for w in warriors:
		if w and w.is_dead:
			warriors.erase(w)
			w.queue_free()
	for m in minions:
		if m and m.is_dead:
			minions.erase(m)
			m.queue_free()
	for lm in lord_mints:
		if lm and lm.is_dead:
			if lm == selected_unit:
				selected_unit = null
			lord_mints.erase(lm)
			lm.queue_free()

func _unhandled_input(event):
	if event is InputEventMouseButton and event.pressed:
		if selected_unit and selected_unit != queen:
			selected_unit.target_position = get_global_mouse_position()

func set_lord_mints():
	for w in warriors:
		w.lord_mints = lord_mints
	for m in minions:
		m.lord_mints = lord_mints 

func build_minion():
	if resources > 10:
		resources -= 10
		var new_minion = minion.instance()
		new_minion.lord_mints = lord_mints
		new_minion.position = Vector2(-900, 200)
		minions.append(new_minion)
		add_child(new_minion)
	
func build_warrior():
	if resources > 50:
		resources -= 50
		var new_warrior = warrior.instance()
		new_warrior.lord_mints = lord_mints
		new_warrior.position = Vector2(-900, 200)
		warriors.append(new_warrior)
		add_child(new_warrior)
	
func build_lord_mint():
	if resources > 100:
		resources -= 100
		var new_lord_mint = lord_mint.instance()
		new_lord_mint.position = Vector2(-900, 200)
		lord_mints.append(new_lord_mint)
		add_child(new_lord_mint)
		set_lord_mints()

