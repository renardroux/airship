extends Area2D

export (float) var ROT_SPEED
export (int) var THRUST
export (int) var MAX_VEL
export (float) var FRICTION

var rot = 0
var vel = Vector2()
var acc = Vector2()
var float_direction = "float_up"

func _ready():
	$Tween.interpolate_property($Sprite, "scale", Vector2(.78, .78), Vector2(.74, .74), 3.0, Tween.TRANS_SINE, Tween.EASE_IN)
	$Tween.start()
	
func _process(delta):
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

func _on_Tween_tween_completed( object, key ):
	if float_direction == "float_up":
		$Tween.interpolate_property($Sprite, "scale", Vector2(.74, .74), Vector2(.78, .78), 3.0, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
		float_direction = "float_down"
	else:
		$Tween.interpolate_property($Sprite, "scale", Vector2(.78, .78), Vector2(.74, .74), 3.0, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
		float_direction = "float_up"
