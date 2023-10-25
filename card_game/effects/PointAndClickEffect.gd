class_name PointAndClickEffect extends CardEffect

var AimerScene := preload("res://ui/Aimer.tscn");

func get_description() -> String:
	return "Allows the player to aim and designate a target"

func execute(world : World):
	var aimer : Aimer = AimerScene.instantiate();
	aimer.aim_finished.connect(_on_aimer_finished);
	world.add_child(aimer);

func _on_aimer_finished(target : Vector2):
	if next_effect:
		next_effect.target = target;
		GlobalSignals.execute.emit(next_effect.execute);
