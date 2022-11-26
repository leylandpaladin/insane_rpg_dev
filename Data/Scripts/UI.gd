extends CanvasLayer

onready var hotbar := $Hotbar
onready var inventory_menu := $InventoryMenu

# TODO: make more unified input logic and handler
func _unhandled_input(event):
	if event.is_action_pressed("inventory_menu"):
		inventory_menu.visible = !inventory_menu.visible
		if (!Globals.mouseLocked):
			Globals.mouseLocked = true
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Globals.mouseLocked = false
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		
