extends Node


var mapsize

func _ready():
	mapsize = $Background.texture.get_size()
	$Player.position = mapsize / 2
	
func _process(delta):
	$Player.position.x = clamp($Player.position.x, 50, mapsize.x - 50)
	$Player.position.y = clamp($Player.position.y, 50, mapsize.y - 50)
	
