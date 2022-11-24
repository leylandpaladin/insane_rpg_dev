extends CanvasLayer

var player = null	
var start_id = "1"
var body2 = null
var target2 = null

onready var dialogueWindow = $DialogueBox
onready var interactionDialgoue = $InteractionDialog
onready var player_skin = $"../Appearance"
onready var player_nose = $"../Pivot/Camera_1st/Nose"
onready var player_test = $Player
func _ready():
	
	SignalsGateway.connect("interacted", self, "on_Interaction")
	SignalsGateway.connect("pressed", self, "on_ui_accept")
	SignalsGateway.connect("interact_effect", self, "on_Interaction_effect")
	dialogueWindow.connect("dialogue_signal", self, "dialogue_signal_handler")
	print("signals loaded")
	
		


func on_Interaction(body, target):	
	
	body2 = body
	target2 = target
	
	match target.ObjectType:
		
		-1: # None (default)
			pass
		
		0: # Door
			print(target.obj_name, " is door")			
			if target.DoorType == 0 and target.InterlocationDoor:
				if target.ScenePath == "":
					print("No scene to teleport in")	
				else:												
					var temp_scene_name = target.ScenePath
					print("Attemping to teleport to: ", temp_scene_name)	
					get_tree().change_scene(temp_scene_name)
					
			elif target.DoorType== 1:
			
					lock_control(body)				
					$InteractionDialogue.show()
					$InteractionDialogue/InteractionDialogueText.set_text("Loor is locked, fck off")
					$InteractionDialogue/ye.set_text("try to unlock")	
					
			elif not target.InterlocationDoor:
				print(" .... Playing opening anim")
		1: # NPC
			print(body.name, " is NPC")
		
		2: # Container
			print(body.name, " is container")
			
		3: # Object with effect attached
			if target.accept_before_process:
				
				print("**EFFECT SIGNAL** sent to **>> ", body.name, "<<**")
				
				if not target.usedOnce:
					lock_control(body)				
					$InteractionDialogue.show()
					$InteractionDialogue/InteractionDialogueText.set_text(target.description)
					$InteractionDialogue/ye.set_text(target.promt_action)
					target.usedOnce = true
					
				else:
					lock_control(body)				
					$InteractionDialogue.show()
					$InteractionDialogue/InteractionDialogueText.set_text(target.used_once_line)
					$InteractionDialogue/ye.set_text(target.promt_action)
				
			else:
				print("effect being used without confirmation")
			
		
	
func on_Interaction_effect(body, target):
	
	match target.EffectDone:
		
		99: # WELL SPECIAL EFFECT					
			if not Effects.player_green:
				print(Effects.player_green)
				print("REGISTERING CASE 99 HERE")
				Effects.player_green(player_skin, player_nose)
			

	
func _on_ye_pressed(body, target):
	
	body = body2
	target = target2
	
	if target.ObjectType == 3:
		SignalsGateway.emit_signal("interact_effect", body, target)	
		$InteractionDialogue.hide()
		unlock_control()
	

func _on_nah_pressed():
	
	$InteractionDialogue.hide()
	unlock_control()

func _on_DialogueBox_dialogue_ended():
	unlock_control()


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

func _on_InteractionDialogue_popup_hide():
	unlock_control()















