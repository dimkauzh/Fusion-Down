extends KinematicBody2D

onready var anim = $AnimatedSprite
onready var timer = $"Timer-Animation"
onready var ray = $RayCast2D
export var speed = 400
var left = false
var up = false
var down = false
var right = false
var nothing
var enemy = Global.enemy
var attack_pressed = false

func get_input():
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
		anim.play("right")
		
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
		anim.play("left")
		
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
		anim.play("down")
		
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
		anim.play("up")
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	else:
		attack()

		if anim.get_animation() == "up":
			anim.play("idle-up")
		elif anim.get_animation() == "down":
			anim.play("idle-down")
		elif anim.get_animation() == "left":
			anim.play("idle-left")
		elif anim.get_animation() == "right":
			anim.play("idle-right")

	velocity = move_and_slide(velocity, Vector2.UP)	
	
func attack():
	if Input.is_action_just_pressed("attack"):
		if ray.is_colliding():
			var ray_overlapper = ray.get_collider()
			ray_overlapper.health -= 20
		if anim.get_animation() == "up" or anim.get_animation() == "idle-up":
				anim.play("attack-up")
				attack_animation(false, false, true, false)
				timer.start()
		elif anim.get_animation() == "down" or anim.get_animation() == "idle-down":
				anim.play("attack-down")
				timer.start()
				attack_animation(false, false, false, true)
		elif anim.get_animation() == "left" or anim.get_animation() == "idle-left":
				anim.play("attack-left")
				timer.start()
				attack_animation(true, false, false, false)
		elif anim.get_animation() == "right" or anim.get_animation() == "idle-right":
				anim.play("attack-right")
				timer.start()
				attack_animation(false, true, false, false)
				
func _process(_delta):
	get_input()
	
func _on_Timer_timeout():
	if up:
		anim.play("idle-up")
		attack_animation(false, false, false, false)
	if down:
		anim.play("idle-down")
		attack_animation(false, false, false, false)
	if left:
		anim.play("idle-left")
		attack_animation(false, false, false, false)
	if right:
		anim.play("idle-right")
		attack_animation(false, false, false, false)

func attack_animation(left_1, right_1, up_1, down_1):
	up = up_1
	down = down_1
	left = left_1
	right = right_1
