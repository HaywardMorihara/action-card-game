extends Node

@export_dir var cards_dir : String

var contents : Dictionary = {
	
}

func _ready():
	# TODO I don't think this is necessary, I should be able to get rid of this
#	var card_scenes : Array[String] = _find_dir_contents(cards_dir);
#	print(card_scenes);

	_load_trunk_data();
	
# TODO	
func _load_trunk_data():
	contents = {
		"FireballCard.tscn": 10,
	}

func _find_dir_contents(path):
	var dir = DirAccess.open(path);
	
	if not dir:
		return null;
	
	var dir_contents : Array[String] = [];
	
	dir.list_dir_begin();
	var file_name = dir.get_next();
	while file_name != "":
		dir_contents.append(file_name);
		file_name = dir.get_next();
	
#	dir.list_dir_end();		
	return dir_contents;
