extends CanvasLayer

var player = null	
class_name Dialogues
var start_id = "1"

onready var dialogueWindow = $DialogueBox

func _ready():
	
	SignalsGateway.connect("interacted", self, "on_Interaction")
	print("signals loaded")
	
func on_Interaction(body, target):	
	
	print("signal received from ", target, " to >>>> ", body)
	
	lock_control(body)	
	if target.obj_name != "":		
		start_dialogue_file(target, start_id)
			
	else:
		print('fck you')

func _on_DialogueBox_dialogue_ended():
	unlock_control()

func get_signals():
	
	var interactable_objects = get_tree().get_nodes_in_group("Interactable")
	for obj in interactable_objects:
		obj.connect("interacted", self, "interacted")
		print("singal connected for: ", obj)
	print("dialogues ready")


func lock_control(body):
	
	print("=== CONTROLS LOCKED ===")
	Globals.mouseLocked = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	body.set_physics_process(false)
	body.set_process_input(false)
	player = body
	
func unlock_control():
	
	print("=== CONTROLS UNLOCKED ===")
	Globals.mouseLocked = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	player.set_physics_process(true)
	player.set_process_input(true)
	player = null



func start_dialogue_file(target, start_id):
					
	dialogueWindow.load_file("res://Data/Dialogues/%s.json" % [target.obj_name])
	dialogueWindow.start(start_id)



func _on_DialogueBox_dialogue_signal(Opened):
	print("got ya")
	get_tree().change_scene("res://Data/Scenes/BasementOfDoom.tscn")

