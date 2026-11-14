extends Node3D

@onready var screen: MeshInstance3D = $crt/Plane_001

var screen_material : ShaderMaterial
var cursor_pos : int = 0

var character_array: Array[int]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	character_array.resize(40*30)
	screen_material = screen.get_active_material(0)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed():
		match event.key_label:
			4194308:
				if cursor_pos > 0:
					cursor_pos -= 1
				character_array[cursor_pos] = 0
				screen_material.set_shader_parameter("msg", character_array)
			_:
				print(event.key_label)
				if cursor_pos < 1200:
					character_array[cursor_pos] = event.key_label
					cursor_pos += 1
				screen_material.set_shader_parameter("msg", character_array)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
