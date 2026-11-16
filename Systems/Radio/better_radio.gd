extends Node3D

@export var audio_player : AudioStreamPlayer3D

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == MOUSE_BUTTON_WHEEL_UP:
				audio_player.volume_db += 1
			if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				audio_player.volume_db -= 1
