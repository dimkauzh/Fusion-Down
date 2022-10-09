extends KinematicBody2D

export var speed = 400

func get_input():
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
		$AnimatedSprite.play("right")
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
		$AnimatedSprite.play("left")
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
		$AnimatedSprite.play("down")
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
		$AnimatedSprite.play("up")

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	else:
		$AnimatedSprite.frame = 0
		$AnimatedSprite.stop()
	
	velocity = move_and_slide(velocity, Vector2.UP)	
	#position += velocity * delta
	
func _process(_delta):
	get_input()
	
