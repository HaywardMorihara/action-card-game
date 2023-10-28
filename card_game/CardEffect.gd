# TODO Investigate: Tried making a Resource, but then I couldn't connect signals to it (PointAndClickEffect)
#class_name CardEffect extends Resource
class_name CardEffect extends Node

var next_effect : CardEffect

func get_description() -> String:
	return ""

func execute(world : World):
	pass
