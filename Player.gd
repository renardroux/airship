extends Area2D

export (float) var ROT_SPEED
export (int) var THRUST
export (int) var MAX_VEL
export (float) var FRICTION
export (PackedScene) var bullet


var rot = 0
var vel = Vector2()
var acc = Vector2()
var float_direction = "float_up"

func _ready():
	$Tween.interpolate_property($Sprite, "scale", Vector2(.78, .78), Vector2(.74, .74), 3.0, Tween.TRANS_SINE, Tween.EASE_IN)
	$Tween.start()
#	$Shadow.position += Vector2(15, 20)
	
func _process(delta):
	if Input.is_action_pressed("ui_select"):
		if $Gun_Timer.time_left == 0:
			shoot()
	if Input.is_action_pressed("ui_right"):
		rot += ROT_SPEED * delta
	if Input.is_action_pressed("ui_left"):
		rot -= ROT_SPEED * delta
	if Input.is_action_pressed("ui_up"):
		acc = Vector2(THRUST, 0).rotated(rot)
	else:
		acc = Vector2(0,0)
		
	acc += vel * -FRICTION
	vel += acc * delta
	position += vel * delta
	rotation = rot + PI / 2
	

	#$Shadow.rotation = rot + PI / 2
	
	if vel.length() > 10:
		$SmokeTrail.emitting = true
		if $EngineSound.is_playing():
			pass
		else:
			$EngineSound._set_playing(true)

		
	else:
		$SmokeTrail.emitting = false
		$EngineSound._set_playing(false)
		
func shoot():
	$Gun_Timer.start()
	var b = bullet.instance()
	#var b = bullet.instance()
	$Bullet_Container.add_child(b)
	b.start_at(rot, $Muzzle.global_position)


func _on_Tween_tween_completed( object, key ):
	if float_direction == "float_up":
		$Tween.interpolate_property($Sprite, "scale", Vector2(.90, .90), Vector2(.78, .78), 3.0, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
		float_direction = "float_down"
	else:
		$Tween.interpolate_property($Sprite, "scale", Vector2(.78, .78), Vector2(.90, .90), 3.0, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
		float_direction = "float_up"
