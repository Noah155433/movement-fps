extends Control
class_name InventorySlot

@onready var icon: TextureRect = $Icon
@onready var count: Label = $Count
@onready var color_rect: ColorRect = $ColorRect

var item_icon : ImageTexture:
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
			icon.queue_free()
			count.queue_free()

func set_pos_id(new_id : int) -> void:
	position_id += new_id
		
	position.x = position_id * (size.x + 32)
	
	if position_id == 1:
		color_rect.color = Color.WHITE
	else:
		color_rect.color = Color.RED
