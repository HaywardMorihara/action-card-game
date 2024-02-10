extends Node

# TODO GET RID OF THIS
# ...and what should I do instead? I forgot what the plan was haha

# This set in CardGame._ready()
# Initializing so we can statically type
var card_game : CardGame = CardGame.new() as CardGame;

# This is set in Area._ready()
# Initializing so we can statically yupe
var world : Area = Area.new() as Area;
