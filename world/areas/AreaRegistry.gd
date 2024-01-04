class_name AreaRegistry extends Node

# TODO Ideally, auto-generate this, using the scene IDs as sources of truth
# Note: It is possible (and should be) to have multiple area_id's pointing at the same scene
const area_id_to_scene_path := {
	"demo_area": "res://world/areas/DemoArea.tscn",
	"christmas_area": "res://world/areas/ChristmasArea.tscn",
	"library": "res://world/buildings/library/LibraryArea.tscn",
	"house_1": "res://world/buildings/house_1/House1Area.tscn"
}
