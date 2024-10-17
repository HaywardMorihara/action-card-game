extends AnimationPlayer

func _ready() -> void:
	current_animation_changed.connect(_on_current_animation_changed)

func _on_current_animation_changed(name: String) -> void:
	var current_animation = get_current_animation();
	var animation_length: float = get_current_animation_length();
	var current_animation_frame = get_current_animation_position();
	var rand_start_frame: float = randf_range(0, current_animation_length);
	seek(rand_start_frame);
