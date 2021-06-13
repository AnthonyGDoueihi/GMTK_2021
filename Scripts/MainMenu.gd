extends Control

export var start_scene = "test"

var volume_slider

var music = preload("res://Assets/Music/Game_Jam_June_2021-Menu.wav")


func _play_game():
	SceneTransitions._fade_start(start_scene)

func _ready():
	AudioPlayer._play_sound(music)
	volume_slider = $VolumeSlider
	volume_slider.value = AudioPlayer.volume

func _quit_game():
	get_tree().quit()


func _on_volume_changed(value):
	AudioPlayer.change_volume(value)
	
