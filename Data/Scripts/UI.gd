extends CanvasLayer

onready var hotbar := $Hotbar
onready var inventory_menu := $InventoryBG/VBoxContainer/InventoryMenu
onready var inventory_bg := $InventoryBG
onready var drag_preview = $DragPreview
onready var tooltip = $Tooltip

func _ready():
	for item_slot in get_tree().get_nodes_in_group("item_slot"):
		var index = item_slot.get_index()
		item_slot.connect("gui_input", self, "_on_ItemSlot_gui_input", [index])
		item_slot.connect("mouse_entered", self, "show_tooltip", [index])
		item_slot.connect("mouse_exited", self, "hide_tooltip")
	hide_tooltip()
		
# TODO: make more unified input logic and handler
func _unhandled_input(event):
	if event.is_action_pressed("inventory_menu"):
		if inventory_menu.visible and drag_preview.dragged_item: return
		inventory_menu.visible = !inventory_menu.visible
		inventory_bg.visible = !inventory_bg.visible
		Inventory.visible = !Inventory.visible
		if (!Globals.mouseLocked):
			Globals.mouseLocked = true
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Globals.mouseLocked = false
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			hide_tooltip()

		
func _on_ItemSlot_gui_input(event, index):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			if inventory_menu.visible:
				drag_item(index)
				hide_tooltip()
		elif event.button_index == BUTTON_RIGHT and event.pressed:
			if inventory_menu.visible:
				split_item(index)
				hide_tooltip()

func drag_item(index):
	var inventory_item = Inventory.items[index]
	var dragged_item = drag_preview.dragged_item
	# pick item
	if inventory_item and !dragged_item:
		Inventory.item_count -= 1
		drag_preview.dragged_item = Inventory.remove_item(index)
		log_action(inventory_item.name + " picked up from slot " + str(index))
	# drop item
	elif !inventory_item and dragged_item:
		Inventory.item_count += 1
		drag_preview.dragged_item = Inventory.set_item(index, dragged_item)
		log_action(dragged_item.name + " dropped to slot " + str(index))
	elif inventory_item and dragged_item:
		# stack items
		if inventory_item.name == dragged_item.name and inventory_item.stackable:
			log_action("Stacked " + dragged_item.name + " quantities " + str(dragged_item.quantity) + " + " + str(inventory_item.quantity))			
			Inventory.set_item_quantity(index, dragged_item.quantity)
			log_action("New stack total of " + dragged_item.name + "s in slot " + str(index) + " is " + str(inventory_item.quantity))
			drag_preview.dragged_item = null
		# swap items
		else:
			drag_preview.dragged_item = Inventory.set_item(index, dragged_item)
			log_action("Swapping " + dragged_item.name + " and " + inventory_item.name)
			
func split_item(index):
		var inventory_item = Inventory.items[index]
		var dragged_item = drag_preview.dragged_item
		if !inventory_item or !inventory_item.stackable: return
		if inventory_item.quantity == 1:
			Inventory.item_count -= 1
		var split_amount = ceil(inventory_item.quantity / 2.0)
		if dragged_item and inventory_item.name == dragged_item.name:
			drag_preview.dragged_item.quantity += split_amount
			Inventory.set_item_quantity(index, -split_amount)
			log_action("Splitting stack of " + dragged_item.name + "s")
		if !dragged_item:
			var item = inventory_item.duplicate()
			item.quantity = split_amount
			drag_preview.dragged_item = item
			Inventory.set_item_quantity(index, -split_amount)
			log_action("Splitting stack of " + inventory_item.name + "s")

func show_tooltip(index):
	var inventory_item = Inventory.items[index]
	if inventory_item and !drag_preview.dragged_item:
		tooltip.display_info(inventory_item)
		tooltip.show()
	else:
		tooltip.hide()

func hide_tooltip():
	tooltip.hide()
	
func log_action(input):
	Console.write("[color=#4ab3ff]Inventory action: [/color]")
	Console.write_line(input)
