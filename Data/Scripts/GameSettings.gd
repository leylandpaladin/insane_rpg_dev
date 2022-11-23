extends Node

# This dictionary is used for synchronizing settings between config file and
# variables in GameSettings. Also holds default values for the settings.
var settings = {
	'GameSettings':
		{
			'locale': 'en'
		}
	} 

# Declaring global variables to hold setting values
export var locale : String = settings['GameSettings']['locale']

func load_settings_from_dict():
	# This updates variables from settins dictionary
	# Called after loading config file values to said dictionary
	locale = settings['GameSettings']['locale']

func save_settings_to_dict():
	# This updates dictionary stored values from in-memory values
	var _s = {
		'GameSettings':
			{
				'locale': locale
			}
	}
	return _s
