extends Node


var player_green = false

func player_green(body,nose):
	
	player_green = true
	body.get_surface_material(0).set_albedo(Color(0, 1, 0))
	nose.get_surface_material(0).set_albedo(Color(0, 1, 0))
