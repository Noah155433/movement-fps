extends Node
class_name Inventory

var inventory : Array[ItemSlot]

func print_inventory():
	for slot in inventory:
		print(slot.m_item)
		print(slot.m_count)

func _init() -> void:
	inventory.resize(6)
	for i in inventory.size():
		inventory[i] = ItemSlot.new()

func remove_item(item_name : String):
	for i in inventory.size():
		var slot : ItemSlot = inventory[i]
		if slot.m_item == item_name:
			slot.m_item = "None"
			slot.m_count = 0
			return
	return

func get_item_count(item : String) -> int:
	for slot in inventory:
		if slot.m_item == item:
			return slot.get_count()
	return 0

func add_count(item : String, count : int) -> int:
	for i in inventory.size():
		var slot : ItemSlot = inventory[i]
		if slot.m_item == item:
			slot.add_count(count)
			return 0
	
	for i in inventory.size():
		var slot : ItemSlot = inventory[i]
		if slot and slot.m_item == "None":
			slot.set_item(item)
			slot.set_count(count)
			return 0
	
	return 1
