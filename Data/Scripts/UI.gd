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

func drag_item(index):
	var inventory_item = Inventory.items[index]
	var dragged_item = drag_preview.dragged_item
	# pick item
	if inventory_item and !dragged_item:
		drag_preview.dragged_item = Inventory.remove_item(index)
	# drop item
	elif !inventory_item and dragged_item:
		drag_preview.dragged_item = Inventory.set_item(index, dragged_item)
	# swap items
	elif inventory_item and dragged_item:
		drag_preview.dragged_item = Inventory.set_item(index, dragged_item)
