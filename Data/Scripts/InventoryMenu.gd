extends Grid

func _ready():
	display_item_slots(Inventory.cols, Inventory.rows)
	yield(get_tree(), "idle_frame")
	hide()
