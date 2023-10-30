class_name AimAndShootFireballEffect extends CardEffect

func get_description() -> String:
	return "Summons a fireball and shoots based on the player's aim"

func execute(world : World):
	var point_and_click_effect : PointAndClickEffect = PointAndClickEffect.new() as PointAndClickEffect;
	
	var create_fireball_effect : CreateFireballEffect = CreateFireballEffect.new() as CreateFireballEffect;
	point_and_click_effect.next_effect = create_fireball_effect;
	
	if next_effect:
		create_fireball_effect.next_effect = next_effect;
	
	point_and_click_effect.execute(world);
