extends CardEffect

func get_description() -> String:
	return "Does the thing"

func execute(world : World):
	print("executing %s on %s" % [get_description(), world.player]);
