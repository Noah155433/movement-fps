extends Node3D
class_name PickupItem

@export var item_name : String = "None"
@export var item_icon : Texture2D = null
@export var item_count : int = 1

@onready var label: Sprite3D = $Label

static func _new(name : String, icon : Texture2D, count : int) -> PickupItem:
	var instance = PickupItem.new()
	instance.item_name = name
	instance.item_count = count
	instance.item_icon = icon
	return instance

func interact(player : Player):
	player.inventory.add_count(self)
	queue_free()

func show_label():
	label.visible = true

func hide_label():
	label.visible = false
