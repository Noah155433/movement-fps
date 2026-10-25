extends CharacterBody3D
class_name enemyTest

var health : int = 100

@export var particle_hit_material : Material

func take_damage():
	health -= 10
	if health <= 0:
		queue_free()

func get_particle_hit_material() -> Material:
	return particle_hit_material
