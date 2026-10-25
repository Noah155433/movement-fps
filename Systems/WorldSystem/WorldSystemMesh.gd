@tool

class_name WorldSystemMesh
extends Resource

@export var mesh : PackedScene:
	set(new): mesh = new; changed.emit()
@export_custom(PROPERTY_HINT_NONE, "suffix:m") var position : Vector3 = Vector3(0.0, 0.0, 0.0):
	set(new): position = new; changed.emit()
@export_custom(PROPERTY_HINT_NONE, "suffix:r") var rotation : Vector3 = Vector3(0.0, 0.0, 0.0):
	set(new): rotation = new; changed.emit()
@export_custom(PROPERTY_HINT_LINK, "suffix:m") var scale : Vector3 = Vector3(1.0, 1.0, 1.0):
	set(new): scale = new; changed.emit()
