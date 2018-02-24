extends Area2D

var vel = Vector2()
export (int) var speed

func _ready():
	$Tween.interpolate_property($Grenade, "rect_position", Vector2(0,0), Vector2(4000,2000), 2.0, Tween.TRANS_BACK, Tween.EASE_IN)

func start_at(dir, pos):
	rotate(dir)
	position = pos
	vel = Vector2(speed, 0).rotated(dir + PI/2-.75)

func _physics_process(delta):
#func _process(delta):
	$Tween.start()
	position = get_position() + vel * delta

	

func _on_Lifetime_timeout():
	$ExplisionCollision.disabled == false
	if $ExplosionSound.playing == false:
		$ExplosionSound.play()
	else:
		queue_free()
	
