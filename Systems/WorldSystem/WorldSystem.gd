@tool
extends Node3D
class_name WorldSystem

@export var meshes: Array[WorldSystemMesh]:
	set(value):
		meshes = value
		if is_inside_tree():
			on_world_mesh_changed()

@export var lights: Array[WorldSystemLight]:
	set(value):
		lights = value
		if is_inside_tree():
			on_world_light_changed()


var mesh_container: Node3D
var light_container: Node3D


func _ready() -> void:
	mesh_container = _get_or_create_container("MeshContainer")
	light_container = _get_or_create_container("LightContainer")
	
	on_world_mesh_changed()
	on_world_light_changed()


func _get_or_create_container(container_name: String) -> Node3D:
	var container := get_node_or_null(container_name) as Node3D
	
	if container == null:
		container = Node3D.new()
		container.name = container_name
		add_child(container)
	
		if Engine.is_editor_hint():
			container.owner = get_tree().edited_scene_root

	return container


func _clear_container(container: Node3D) -> void:
	for child in container.get_children():
		container.remove_child(child)
		child.queue_free()


func on_world_mesh_changed() -> void:
	if not is_inside_tree():
		return

	if mesh_container == null or not is_instance_valid(mesh_container):
		mesh_container = _get_or_create_container("MeshContainer")

	for mesh_data in meshes:
		if mesh_data == null:
			continue

		if not mesh_data.changed.is_connected(_on_mesh_changed):
			mesh_data.changed.connect(_on_mesh_changed)
	
	_clear_container(mesh_container)

	for mesh_data in meshes:
		if mesh_data == null or mesh_data.mesh == null:
			continue
	
		var instance := mesh_data.mesh.instantiate() as Node3D

		if instance == null:
			push_warning("WorldSystem mesh must instantiate a Node3D.")
			continue
	
		instance.position = mesh_data.position
		instance.rotation = mesh_data.rotation
		instance.scale = mesh_data.scale
	
		mesh_container.add_child(instance)
	
		if Engine.is_editor_hint():
			instance.owner = get_tree().edited_scene_root


func on_world_light_changed() -> void:
	if not is_inside_tree():
		return

	if light_container == null or not is_instance_valid(light_container):
		light_container = _get_or_create_container("LightContainer")
	
	_clear_container(light_container)
	
	for light_data in lights:
		if light_data == null or light_data.light_instance == null:
			continue
	
		var light: Node3D = light_data.light_instance
	
		if light.get_parent() != null:
			light.get_parent().remove_child(light)
	
		light_container.add_child(light)
	
		if Engine.is_editor_hint():
			light.owner = get_tree().edited_scene_root
	

func _on_mesh_changed() -> void:
	on_world_mesh_changed()
