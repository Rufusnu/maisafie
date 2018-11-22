extends Area2D
export (int) var DAMAGE
var buttons_pressed = false
# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var knock = 400
var pos
var dist

func _ready():
	pass

func _physics_process(delta):
	var face = get_parent().faceing_right
	if face:
		position.x = pos + dist
	else:
		position.x = pos - dist
	$Sprite.flip_h=!face
	

func setup(dis, facing_right):
	#user facing_right to determine if you need to flip the animation
	pos = position.x
	dist = dis
	if !facing_right:
		knock = -knock
	if facing_right:
		position.x = pos + dist
	else:
		position.x = pos - dist
	
	$Sprite.flip_h=!facing_right
	

func _on_Timer_timeout():
	queue_free()


func _on_melee_body_entered(body):
	#print("Zing")
	if body.name != "Player" and body.has_method("take_damage"):
		body.take_damage(DAMAGE)
		if body.has_method("knock"):
			var mov = Vector2(knock, -abs(knock)/2)
			body.knock(mov)
