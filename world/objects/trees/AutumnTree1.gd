extends Sprite2D

@export var common_frames : Array[int]
@export var uncommon_frames : Array[int]

func _ready() -> void:
	if randf() > 0.9:
		frame = uncommon_frames[randi() % uncommon_frames.size()]
	else:
		frame = common_frames[randi() % common_frames.size()]
