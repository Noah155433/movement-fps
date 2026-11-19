extends Node3D

var freq : float = 80.0
@export var pin : MeshInstance3D
@export var knob : MeshInstance3D

func _ready() -> void:
	pin.position.x = remap(freq, 80.0, 120.0, -0.05, 0.85)
	knob.rotation.z = remap(freq, 80.0, 120.0, PI, -PI)


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == MOUSE_BUTTON_WHEEL_UP:
				freq += 0.3
			elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				freq -= 0.3
			freq = clamp(freq, 80.0, 120.0)
			pin.position.x = remap(freq, 80.0, 120.0, -0.05, 0.085)
			knob.rotation.z = remap(freq, 80.0, 120.0, PI, -PI)
