extends GridContainer

class_name Grid

export (PackedScene) var ItemSlot

var slots

func display_item_slots(cols, rows):
	slots = cols * rows
	for index in range(slots):
		var slot = ItemSlot.instance()
		add_child(slot)
		slot.display_item(Inventory.items[index])
	Inventory.connect("items_changed", self, "_on_Inventory_items_changed")
	
func _on_Inventory_items_changed(indexes):
	for index in indexes:
		if index < slots:
			var slot = get_child(index)
			slot.display_item(Inventory.items[index])
