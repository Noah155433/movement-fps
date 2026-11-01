extends Control
class_name InventorySlot

@onready var icon: TextureRect = $Background/Icon
@onready var count: Label = $Background/Count
@onready var background: TextureRect = $Background
@onready var interaction: Control = $Interaction


var item_icon : Texture2D:
	set(new):
		item_icon = new
		if icon: icon.texture = new
var item_name : String
var item_count : int:
	set(new):
		item_count = new
		if count: count.text = str(new)

var is_filled : bool = false:
	set(new):
		is_filled = new
		if icon: icon.texture = item_icon if new else null
		if count: count.text = str(item_count) if new else ""

var slot_id : int = 0
var position_id : int = 0
var is_dummy : bool = false:
	set(new):
		is_dummy = new
		if is_dummy:
			background.self_modulate = Color.WHITE
			icon.queue_free()
			count.queue_free()

func toggle_interact_menu():
	if not is_dummy and is_filled:
		interaction.visible = not interaction.visible

func close_interact_menu():
	interaction.visible = false

func set_pos_id(new_id : int, max_size : int) -> void:
	position_id = (position_id + new_id) % max_size
	if position_id < 0:
		position_id += max_size
		
	position.x = position_id * size.x
	

func change_count(new : int) -> void:
	item_count += new
	if item_count <= 0: remove_item()

func set_count(new : int) -> void:
	item_count = new
	if item_count <= 0: remove_item()

func set_item(name : String, icon : ImageTexture) -> void:
	item_name = name
	item_icon = icon
	item_count = 0
	is_filled = true

func remove_item() -> void:
	item_count = 0
	item_name = "None"
	is_filled = false

func _on_delete_button_down() -> void:
	change_count(-1)
