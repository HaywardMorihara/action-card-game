extends CardEffect

func get_description() -> String:
	return ""

func execute(world : Area):
	# TODO Effect
	
	# Default handling of next effect	
	if next_effect:
		next_effect.execute(world)
