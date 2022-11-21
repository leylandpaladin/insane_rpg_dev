extends CanvasLayer

var player = null	
class_name Dialogues

func ready():
	
	get_signals()
	
func _on_DisgustingWell_interacted(body):
	
	print("signal recieved")
	$DiaglogueLayer/DialogueBox.start()
	Globals.mouseLocked = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	body.set_physics_process(false)
	body.set_process_input(false)
	player = body


func _on_Well_dialogue_dialogue_ended():
	Globals.mouseLocked = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	player.set_physics_process(true)
	player.set_process_input(true)
	player = null

func get_signals():
	
	var interactable_objects = get_tree().get_nodes_in_group("Interactable")
	for obj in interactable_objects:
		obj.connect("interacted", self, "interacted")
		print("singal connected for: ", obj)
	print("dialogues ready")
