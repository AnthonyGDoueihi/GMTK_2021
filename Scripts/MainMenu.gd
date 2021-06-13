extends Control

export var start_scene = "test"

var timer
var volume_slider

var music = preload("res://Assets/Music/Order the pieces.mp3")


func _play_game():
	SceneTransitions._fade_start(start_scene)

func _ready():
	timer = $quit_button/timer
	AudioPlayer._play_sound(music)
	volume_slider = $VolumeSlider
	volume_slider.value = AudioPlayer.volume

func _quit_pressed():
	SceneTransitions._fade_out()
	timer.start()

func _quit_game():
	get_tree().quit()


func _on_volume_changed(value):
	AudioPlayer.change_volume(value)
	
