extends CanvasLayer

onready var hotbar := $Hotbar
onready var inventory_menu := $InventoryMenu
onready var drag_preview = $DragPreview

func _ready():
	for item_slot in get_tree().get_nodes_in_group("item_slot"):
		var index = item_slot.get_index()
		item_slot.connect("gui_input", self, "_on_ItemSlot_gui_input", [index])

# TODO: make more unified input logic and handler
func _unhandled_input(event):
	if event.is_action_pressed("inventory_menu"):
		if inventory_menu.visible and drag_preview.dragged_item: return
		inventory_menu.visible = !inventory_menu.visible
		if (!Globals.mouseLocked):
			Globals.mouseLocked = true
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Globals.mouseLocked = false
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

		
func _on_ItemSlot_gui_input(event, index):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			if inventory_menu.visible:
				drag_item(index)
		elif event.button_index == BUTTON_RIGHT and event.pressed:
			if inventory_menu.visible:
				split_item(index)

func drag_item(index):
	var inventory_item = Inventory.items[index]
	var dragged_item = drag_preview.dragged_item
	# pick item
	if inventory_item and !dragged_item:
		drag_preview.dragged_item = Inventory.remove_item(index)
	# drop item
	elif !inventory_item and dragged_item:
		drag_preview.dragged_item = Inventory.set_item(index, dragged_item)
	elif inventory_item and dragged_item:
		# stack items
		if inventory_item.name == dragged_item.name and inventory_item.stackable:
			Inventory.set_item_quantity(index, dragged_item.quantity)
			drag_preview.dragged_item = null
		# swap items
		else:
			drag_preview.dragged_item = Inventory.set_item(index, dragged_item)
			
func split_item(index):
		var inventory_item = Inventory.items[index]
		var dragged_item = drag_preview.dragged_item
		if !inventory_item or !inventory_item.stackable: return
		var split_amount = ceil(inventory_item.quantity / 2.0)
		if dragged_item and inventory_item.name == dragged_item.name:
			drag_preview.dragged_item.quantity += split_amount
			Inventory.set_item_quantity(index, -split_amount)
		if !dragged_item:
			var item = inventory_item.duplicate()
			item.quantity = split_amount
			drag_preview.dragged_item = item
			Inventory.set_item_quantity(index, -split_amount)
