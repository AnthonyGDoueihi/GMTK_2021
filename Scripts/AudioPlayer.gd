extends AudioStreamPlayer

var tween
var volume = 0.0
var stopped = false

func _ready():
	volume_db = -20.0
	tween = $tween

func _play_sound(music):
	set_stream(music)
	tween.interpolate_property(self, "volume_db",
		volume_db, volume, 0.5,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()

	play()

func _stop_sound():
	tween.interpolate_property(self, "volume_db",
		volume_db, -20.0, 0.5,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()

func change_volume(new_volume):
	if new_volume < -23:
		stop()
		stopped = true
	else:
		volume = new_volume
		volume_db = new_volume
		if stopped:
			play()
			stopped = false
