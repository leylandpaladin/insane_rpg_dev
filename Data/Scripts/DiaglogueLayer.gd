extends CanvasLayer

var player = null	
class_name Dialogues
var start_id = "1"
var player_green = false
onready var dialogueWindow = $DialogueBox
onready var player_skin = $"../Appearance"
onready var player_nose = $"../Pivot/Camera_1st/Nose"
onready var player_test = $Player
func _ready():
	
	SignalsGateway.connect("interacted", self, "on_Interaction")
	dialogueWindow.connect("dialogue_signal", self, "dialogue_signal_handler")
	print("signals loaded")
	

func dialogue_signal_handler(value):
	
	if value == "Opened":
		get_tree().change_scene("res://Data/Scenes/BasementOfDoom.tscn")
	elif value == "Well_used":		
		
		player_skin.get_surface_material(0).set_albedo(Color(0, 1, 0))
		player_nose.get_surface_material(0).set_albedo(Color(0, 1, 0))
	
		

func on_Interaction(body, target):	
	
	print("signal received from ", target.obj_name, " to >>>> ", body.name)
	#lock_control(body)	
	
	match target.ObjectType:
		
		0:
			print(target.obj_name, " is door")			
			if target.DoorType == 0 and target.InterlocationDoor:
				if target.ScenePath == "":
					print("No scene to teleport in")	
				else:							
					print("Attemping to teleport to: ", target.ScenePath)	
					get_tree().change_scene_to(load(target.ScenePath))
					
					
			elif not target.InterlocationDoor:
				print(" .... Playing opening anim")
		1:
			print(body.name, " is NPC")
		
		2: 
			print(body.name, " is container")
			
		3: 
			print(body.name, " is has_effect")
	
	#if target.obj_name != "":		
	#	start_dialogue_file(target, start_id)
	#		
	#else:
	#	print('fck you')

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


