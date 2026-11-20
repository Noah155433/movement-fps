extends Node3D

@export var transmissions : Array[RadioTransmission]
var audio_instances : Array[AudioStreamPlayer3D]
var current_freq : float = 80.0

@export var pin : MeshInstance3D
@export var knob : MeshInstance3D

@export var static_player : AudioStreamPlayer3D

func _ready() -> void:
	pin.position.x = remap(current_freq, 80.0, 120.0, -0.019, 0.116)
	knob.rotation.z = remap(current_freq, 80.0, 120.0, PI, -PI)
	
	for i in transmissions.size():
		var instance = AudioStreamPlayer3D.new()
		instance.stream = transmissions[i].sound
		instance.autoplay = true
		instance.volume_db = 0 - pow(transmissions[i].frequency - current_freq, 3)
		add_child(instance)
		audio_instances.append(instance)


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == MOUSE_BUTTON_WHEEL_UP:
				current_freq += 0.3
			elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				current_freq -= 0.3
			current_freq = clamp(current_freq, 80.0, 120.0)
			pin.position.x = remap(current_freq, 80.0, 120.0, -0.019, 0.116)
			knob.rotation.z = remap(current_freq, 80.0, 120.0, PI, -PI)
			
			var volume : float = -INF
			for i in transmissions.size():
				var new : float = 0 - pow(transmissions[i].frequency - current_freq, 2)
				audio_instances[i].volume_db = new
				if new > volume:
					volume = new
			static_player.volume_db = -50 - volume
