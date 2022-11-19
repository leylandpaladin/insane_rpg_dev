class_name Interactable
extends Node

onready var timer = $Timer

export var promt_message = "Interact"
export var promt_action = "Interact"

signal interacted(body)

func get_interaction_text():
	return promt_message

func interact(body):
	print(body, " <<<<< interacted with >>>>> ", name)
	emit_signal("interacted", body)
	print("signal emited")
	


