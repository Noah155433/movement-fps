extends CharacterBody3D
class_name enemyTest

var health : int = 100

func take_damage():
	health -= 10
	if health <= 0:
		queue_free()
