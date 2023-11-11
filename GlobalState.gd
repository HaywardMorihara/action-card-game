extends Node

const save_path : String = "user://acg/data.tres";
const default_save_data_path : String = "res://default_save_data.tres";

var money : int;

var trunk : Dictionary; # key: CardId (str), value: Count (int)
var deck : Dictionary; # key: CardId (str), value: Count (int)

# TODO Recipes

# TODO Bosses Defeated
# TODO Treasures found

func _ready():
	reset();
	# TODO Debug mode
	var save_data = load("res://default_save_data.tres") as SaveData;
	from_save_data(save_data);

func save_data_exists() -> bool:
	return ResourceLoader.exists(save_path);

func reset():
	from_save_data(SaveData.new());
	
func load():
	# TODO Should really error here
	assert(ResourceLoader.exists(save_path), "Could not find save data!");
	var save_data = load(save_path) as SaveData;
	from_save_data(save_data);
	
func save():
	ResourceSaver.save(as_save_data(), save_path);

func from_save_data(save_data : SaveData):
	money = save_data.money;
	trunk = save_data.trunk;
	deck = save_data.deck;
	
func as_save_data() -> SaveData:
	var save_data = SaveData.reset();
	save_data.money = money;
	save_data.trunk = trunk;
	save_data.deck = deck;
	return save_data;
