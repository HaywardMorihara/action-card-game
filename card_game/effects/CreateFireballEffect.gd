class_name CreateFireballEffect extends CardEffect

var FireballScene := preload("res://world/attacks/Fireball.tscn");

var target : Vector2

func get_description() -> String:
	return "Summons a fireball"

func execute(world : Area):
	var fireball : Fireball = FireballScene.instantiate() as Fireball;
	fireball.position = world.player.position; 
	fireball.target = target;
	world.add_child(fireball);
	if next_effect:
		next_effect.execute(world);
