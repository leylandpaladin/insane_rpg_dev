class_name Interactable
extends Node



export var promt_message := "Interact"
export var promt_action := "Interact"
export var obj_name := "Generic"
export var description := ""
export var attackable := false
export var accept_before_process := false

enum TYPE {NONE = -1, DOOR = 0, NPC = 1, CONTAINER = 2, HAS_EFFECT = 3}
export (TYPE) var ObjectType


func get_interaction_text():
	return promt_message

func interact(body):
	
	print(body.name, " <<<<< interacted with >>>>> ", self.obj_name)
	SignalsGateway.emit_signal("interacted", body, self)
	print("signal emited to: ", body.name, " from ", self.obj_name)
	
	

	
	
