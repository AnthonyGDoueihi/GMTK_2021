extends CanvasLayer

var path = "test"

var menu = preload("res://scenes/main_menu.tscn")
var game = preload("res://scenes/test.tscn")

var duration = 0.5
var rect
var tween
var timer

func _ready():
	rect = $rect
	tween = $tween
	timer = $timer
	timer.wait_time = duration

func _fade_start(is_game):
	path = game if is_game else menu 
	_fade_out()
	timer.start()

func _fade_in():
	tween.interpolate_property(rect, "color",
	rect.color, Color(0.0, 0.0, 0.0, 0.0), duration,
	Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()

func _fade_out():
	tween.interpolate_property(rect, "color",
	rect.color, Color(0.0, 0.0, 0.0, 1.0), duration,
	Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()

func _change_scene():
	get_tree().change_scene_to(path)
	_fade_in()
