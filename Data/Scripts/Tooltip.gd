extends ColorRect

onready var margin_container = $MarginContainer
onready var item_name = $MarginContainer/VBoxContainer/ItemName
onready var item_info = $MarginContainer/VBoxContainer/ItemInfo

func _process(_delta):
	rect_position = get_global_mouse_position() + Vector2.ONE * 4
	
func display_info(item):
	item_name.text = item.name + "  "
	item_info.text = Enums.ItemType.keys()[item.type] + ""
	yield(get_tree(), "idle_frame")
	margin_container.rect_size = Vector2()
	rect_size = margin_container.rect_size
