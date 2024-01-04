class_name AreaTransition extends Area2D

@export var id : String;
@export_file var transitions_to : String;
@export var linked_transition_area : String;

var is_fully_transitioned : bool = false

func _ready() -> void:
	await get_tree().process_frame # Don't make these assertions until the scene is fully ready and processing has started (because Buildings will set these from a parent Node)
	assert(id, 'id must be set for AreaTransition');
	assert(transitions_to, 'transitions_to must be set for AreaTransition');
	assert(linked_transition_area, 'linked_transition_area must be set for AreaTransition');

func _on_body_entered(body: Node2D) -> void:
	if body is Player and is_fully_transitioned:
		var next_area : Resource = load(transitions_to) as Resource;
		GlobalSignals.transition_to.emit(next_area, linked_transition_area);

func _on_timer_timeout() -> void:
	is_fully_transitioned = true;
