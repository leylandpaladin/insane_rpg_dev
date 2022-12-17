extends PanelContainer

onready var slots = $VBoxContainer/InfoPanel/HBoxContainer/Slots

func _ready():
	rect_position = (get_viewport_rect().size - rect_size) / 1.8
	Inventory.connect("item_count_changed", self, "set_text")
	
func set_text(item_count):
	slots.set_text(str("Slots: %d/24" % [item_count]))

