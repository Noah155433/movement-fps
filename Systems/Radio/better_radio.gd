extends Node3D

@export var audio_player : AudioStreamPlayer3D
@export var audio_stream : AudioStream

@export_range(80.0, 120.0, 0.1) var freq : float = 80.0
var current_freq : float = 80.0

func _ready() -> void:
	audio_player.stream = audio_stream
	audio_player.play()
	audio_player.volume_db = 0 - (pow(freq - current_freq, 2))


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == MOUSE_BUTTON_WHEEL_UP:
				current_freq += 0.3
			elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				current_freq -= 0.3
			current_freq = clamp(current_freq, 80.0, 120.0)
			audio_player.volume_db = 0 - (pow(freq - current_freq, 2))
