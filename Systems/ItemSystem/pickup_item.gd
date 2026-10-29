@tool

extends Node3D
class_name PickupItem

@onready var mesh: MeshInstance3D = $MeshInstance3D
@onready var coll: CollisionShape3D = $Area3D/CollisionShape3D

@export var item_name : String = "None"
@export var item_count : int = 1
