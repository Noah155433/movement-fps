@tool

extends AreaLight3D
class_name EmissiveFlickeringAreaLight3D

@export var on_time : float = 1.0
@export var off_time : float = 0.1
@export var on_time_variation : float = 0.0
@export var off_time_variation : float = 0.0

@export var light_depth : float = 0.1

var flicker_timer: Timer
var mesh : MeshInstance3D


func _ready() -> void:
	get_tree().create_timer(on_time + randf_range(0, on_time_variation)).timeout.connect(_on_flicker_timer_timeout)
	var instance = MeshInstance3D.new()
	instance.mesh = BoxMesh.new()
	instance.mesh.size = Vector3(area_size.x, area_size.y, light_depth)
	var material = StandardMaterial3D.new()
	material.emission_enabled = true
	material.emission = light_color
	material.emission_energy_multiplier = light_energy
	instance.mesh.surface_set_material(0, material)
	mesh = instance
	mesh.transform = transform
	add_sibling.call_deferred(mesh)

func _on_flicker_timer_timeout() -> void:
	if visible == true:
		visible = false
		update_mesh()
		get_tree().create_timer(off_time + randf_range(0, off_time_variation)).timeout.connect(_on_flicker_timer_timeout)
	else:
		visible = true
		update_mesh()
		get_tree().create_timer(on_time + randf_range(0, on_time_variation)).timeout.connect(_on_flicker_timer_timeout)

func update_mesh():
	mesh.transform = transform
	mesh.mesh.size = Vector3(area_size.x, area_size.y, light_depth)
	var material : StandardMaterial3D = StandardMaterial3D.new()
	material.emission_enabled = true if visible else false
	material.emission = light_color
	material.emission_energy_multiplier = light_energy
	mesh.mesh.surface_set_material(0, material)
