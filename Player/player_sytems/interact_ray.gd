extends RayCast3D

@export var player : Player

var current_object : Node3D = null

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and is_colliding():
		var collider : Node3D = get_collider().get_owner() if get_collider().get_owner() else get_collider()
		if collider.is_in_group("interactable"):
			if collider.has_method("interact"):
				collider.interact(player)
			else:
				print("interactable collider doesn't have interaction function")
	
	if is_colliding() and get_collider():
		var collider = get_collider().get_owner() if get_collider().get_owner() else get_collider()
		if collider != current_object:
			hide_label(current_object)
			current_object = collider
		if collider.is_in_group("interactable"):
			show_label(collider)
	else:
		hide_label(current_object)
		current_object = null

func show_label(object):
	if object and object.has_method("show_label"): object.show_label()

func hide_label(object):
	if object and object.has_method("hide_label"): object.hide_label()
