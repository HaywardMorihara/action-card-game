class_name BuildingEnterable extends Sprite2D

@export var entrance_id : String;
@export_file var transitions_to : String;
@export var exit_id : String;

@onready var area_transition : AreaTransition = $AreaTransition as AreaTransition;

func _ready() -> void:
	assert(entrance_id, 'entrance_id must be set for AreaTransition');
	area_transition.id = entrance_id;
	assert(transitions_to, 'transitions_to must be set for AreaTransition');
	area_transition.transitions_to = transitions_to;
	assert(exit_id, 'exit_id must be set for AreaTransition');
	area_transition.linked_transition_area = exit_id;
