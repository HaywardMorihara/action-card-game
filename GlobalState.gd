extends Node

signal save_complete

# For Windows, this is: C:\Users\natha\AppData\Roaming\Godot\app_userdata\Action Card Game
const save_path : String = "user://save_data.tres";
const default_save_data_path : String = "res://default_save_data.tres";

var last_playmat_data : LastPlaymatData = LastPlaymatData.new() as LastPlaymatData;

var money : int;

var trunk_data : TrunkData = TrunkData.new() as TrunkData; 
var deck_data : DeckData = DeckData.new() as DeckData;

# TODO Recipes

# TODO Bosses Defeated

var treasure_chest_data : TreasureChestData;

func _ready():
	reset();
	# TODO Debug mode
	var save_data = load("res://default_save_data.tres") as SaveData;
	from_save_data(save_data);

func save_data_exists() -> bool:
	return ResourceLoader.exists(save_path);

func reset():
	var save_data = load("res://default_save_data.tres") as SaveData;
	from_save_data(save_data);
	
func load():
	# TODO Should really error here
	assert(ResourceLoader.exists(save_path), "Could not find save data!");
	var save_data = load(save_path) as SaveData;
	from_save_data(save_data);
	
func save():
	ResourceSaver.save(as_save_data(), save_path);
	save_complete.emit();

func from_save_data(save_data : SaveData):
	last_playmat_data = save_data.last_playmat_data;
	money = save_data.money;
	trunk_data = save_data.trunk_data;
	deck_data = save_data.deck_data;
	treasure_chest_data = save_data.treasure_chest_data;
	
func as_save_data() -> SaveData:
	var save_data = SaveData.new();
	save_data.last_playmat_data = last_playmat_data;
	save_data.money = money;
	save_data.trunk_data = trunk_data;
	save_data.deck_data = deck_data;
	save_data.treasure_chest_data = treasure_chest_data;
	return save_data;
