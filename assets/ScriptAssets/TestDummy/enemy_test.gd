extends CharacterBody3D
class_name enemyTest

var health : int = 100
var is_dead : bool = false

@export var particle_hit_material : Material
@onready var ch_36: MeshInstance3D = $Idle/Skeleton3D/Ch36

var shader_material : ShaderMaterial

func _ready() -> void:
	shader_material = ch_36.get_surface_override_material(0)

func _process(delta: float) -> void:
	if is_dead:
		var trans_amount = shader_material.get_shader_parameter("trans_amount")
		if trans_amount >= 1:
			queue_free()
		trans_amount += delta / 3.0
		shader_material.set_shader_parameter("trans_amount", trans_amount)

func take_damage():
	health -= 10
	if health <= 0:
		is_dead = true

func get_particle_hit_material() -> Material:
	return particle_hit_material
