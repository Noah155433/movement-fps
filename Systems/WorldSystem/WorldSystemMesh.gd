class_name WorldSystemMesh
extends Resource

@export var mesh : PackedScene
@export_custom(PROPERTY_HINT_NONE, "suffix:m") var position : Vector3
@export_custom(PROPERTY_HINT_NONE, "suffix:r") var rotation : Vector3
@export_custom(PROPERTY_HINT_LINK, "suffix:m") var scale : Vector3 = Vector3(1.0, 1.0, 1.0)
