class_name SaveData extends Resource

# IDEA: Have a data_to_save() function on objects that need to save certain attributes.
# They own the logic about what data to provide

@export var last_playmat_data : LastPlaymatData;

@export var money : int;

@export var trunk_data : TrunkData;
@export var deck_data : DeckData;

# TODO Recipes

# TODO Bosses Defeated

@export var treasure_chest_data : TreasureChestData;
