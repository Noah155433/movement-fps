extends Node
class_name ItemSlot

var m_item : String = "None"
var m_count : int = 0

func set_item(item : String):
	m_item = item

func set_count(count : int):
	m_count = count

func add_count(count : int):
	m_count += count

func get_item() -> String:
	return m_item

func get_count() -> int:
	return m_count
