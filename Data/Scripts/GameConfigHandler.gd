extends Node

var config_file_path = Globals.config_file_path
	
func save_config_file(config):
	# Saves current settings to config file
	
	# Sync dictionary settings to actual in-memory values
	GameSettings.settings = GameSettings.save_settings_to_dict()
	
	# Loop through all settings in the dict, saving each one ConfigFile instance
	var _settings = GameSettings.settings
	for section in _settings.keys():
		for key in _settings[section].keys():
			config.set_value(section, key, _settings[section][key])
	
	# Write to config file
	config.save(config_file_path)
	
func load_config_file(config_path):
	var config = ConfigFile.new()

	# Load config data from a file.	
	var config_loaded = config.load(config_path)
	
	# Create default config file if it could not be read
	if config_loaded != OK:
		save_config_file(config)
	
	#Return ConfigFile instance
	return config

func apply_config(config):
	# Set variables in GameSettings according to config file contents
	
	var _settings = GameSettings.settings
	for section in _settings.keys():
		for key in _settings[section].keys():
			_settings[section][key] = config.get_value(section, key)
	
	GameSettings.load_settings_from_dict()

func _init():
	var Config = load_config_file(config_file_path)
	apply_config(Config)
