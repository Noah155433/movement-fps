extends CharacterBody3D
class_name enemyTest

var health : int = 100
var is_dead : bool = false

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
		#var trans_amount = shader_material.get_shader_parameter("trans_amount")
		#if trans_amount >= 1:
			#queue_free()
		#trans_amount += delta / 3.0
		#shader_material.set_shader_parameter("trans_amount", trans_amount)

func take_damage():
	health -= 10
	if health <= 0:
		is_dead = true

func get_particle_hit_material() -> Material:
	return particle_hit_material
