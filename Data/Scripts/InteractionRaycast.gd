extends RayCast


var current_collider

onready var interaction_text = get_node("../../../UI/Control/InteractionText")

onready var promt = $Promt
func _ready():
	add_exception(owner)
	set_interaction_text("")

func _physics_process(delta):
		
	promt.text = ""
	
	if is_colliding():
		var detected = get_collider()
		if detected is Interactable:
			if current_collider != detected:
				promt.text = detected.obj_name			
				set_interaction_text(detected.get_interaction_text())
			
						
			if Input.is_action_just_pressed("interact"):
				detected.interact(owner)
				set_interaction_text(detected.get_interaction_text())
	elif not is_colliding():
				
		set_interaction_text("")

func set_interaction_text(text):
#	
	if text == "":
		interaction_text.set_text("")
		interaction_text.set_visible(false)
	else:
		var interact_key = OS.get_scancode_string(InputMap.get_action_list("interact")[0].scancode)
		
		interaction_text.set_text("Press %s to %s" % [interact_key, text])
		interaction_text.set_visible(true)
		
