extends CharacterBody3D
class_name enemyTest

var health : int = 100
var is_dead : bool = false
var impulse_applied : bool = false

@export var particle_hit_material : Material
@onready var ch_36: MeshInstance3D = $Human/metarig/Skeleton3D/Human
@onready var physical_bone_simulator_3d: PhysicalBoneSimulator3D = $Human/metarig/Skeleton3D/PhysicalBoneSimulator3D

var shader_material : ShaderMaterial

func _ready() -> void:
	shader_material = ch_36.get_surface_override_material(0)
	for child in physical_bone_simulator_3d.get_children():
		if child is PhysicalBone3D:
			child.angular_damp = 1
			child.linear_damp = 1

func _process(delta: float) -> void:
	if is_dead:
		physical_bone_simulator_3d.physical_bones_start_simulation()
		if not impulse_applied:
			(physical_bone_simulator_3d.get_child(0) as PhysicalBone3D).apply_impulse(Vector3(randf_range(-3, 3), randf_range(-3, 3), randf_range(-3, 3)), Vector3(0, 0, 0))
			impulse_applied = true

func take_damage(count : int):
	health -= count
	if health <= 0:
		is_dead = true

func get_particle_hit_material() -> Material:
	return particle_hit_material
