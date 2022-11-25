extends Node


var player_green = false

func player_green_effect(body,nose,magnitude):
	
	player_green = true
	body.get_surface_material(0).set_albedo(Color(0, magnitude, 0, 255))
	nose.get_surface_material(0).set_albedo(Color(0, magnitude, 0, 255))
