extends Node

func player_green(body,nose):
	
	body.get_surface_material(0).set_albedo(Color(0, 1, 0))
	nose.get_surface_material(0).set_albedo(Color(0, 1, 0))
