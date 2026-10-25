@tool

extends Node3D
class_name WorldSystem

@export var meshes : Array[WorldSystemMesh]:
	set(new_world_mesh):
		meshes = new_world_mesh
		on_world_mesh_changed()

func on_world_mesh_changed():
	for c in get_children():
		c.queue_free()
	for mesh in meshes:
		var instance = mesh.mesh.instantiate() as Node3D
		instance.position = mesh.position
		instance.rotation = mesh.rotation
		instance.scale = mesh.scale
		add_child(instance)
		
