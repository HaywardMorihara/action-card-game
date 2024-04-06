class_name AreaRegistry extends Node

# TODO Ideally, auto-generate this, using the scene IDs as sources of truth
# Note: It is possible (and should be) to have multiple area_id's pointing at the same scene
const area_id_to_scene_path := {
	"demo_area": "res://world/areas/demo/DemoArea.tscn",
	"demo_area_library": "res://world/areas/demo/buildings/LibraryArea.tscn",
	"demo_area_house_1": "res://world/areas/demo/buildings/House1Area.tscn",
	
	"starting_area": "res://world/areas/starting_area/StartingArea.tscn",
	"starting_area_home": "res://world/areas/starting_area/buildings/HomeArea.tscn",
	
	"christmas_area": "res://world/areas/christmas/ChristmasArea.tscn",
	"christmas_area_library": "res://world/areas/christmas/buildings/LibraryArea.tscn",
	"christmas_area_house_1": "res://world/areas/christmas/buildings/House1Area.tscn",
}

func _ready() -> void:
	for area_id in area_id_to_scene_path:
		assert(FileAccess.file_exists(area_id_to_scene_path[area_id]))
