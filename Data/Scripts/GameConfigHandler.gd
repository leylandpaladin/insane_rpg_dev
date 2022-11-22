extends Node

func init_config_file(path):
	var config = ConfigFile.new()

	# Store default values
	config.set_value("GameSettings", "locale", GameSettings.locale)

	# Save default values to a file
	config.save(path)
	
	#Return config file instance
	return config

func read_config_file(config_path):
	var config = ConfigFile.new()

	# Load config data from a file.	
	var config_loaded = config.load(config_path)

	# Create default config file if it could not be read
	if config_loaded != OK:
		print('no config')
		config = init_config_file(config_path)
	
	return config

func save_settings():
	#TODO - save all settings via GameSettings.get_property_list()
	pass
	
func apply_config(config):
	GameSettings.locale = config.get_value("GameSettings", "locale")

func _init():
	var Config = read_config_file(Globals.config_file_path)
	apply_config(Config) 
	print (GameSettings.locale)
