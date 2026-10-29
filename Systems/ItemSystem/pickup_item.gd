extends Node3D
class_name PickupItem

@export var item_name : String = "None"
@export var item_count : int = 1

@onready var label: Sprite3D = $Label

func interact(player : Player):
	player.inventory.add_count(item_name, item_count)
	queue_free()

func show_label():
	label.visible = true

func hide_label():
	label.visible = false
