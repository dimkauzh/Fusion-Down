extends KinematicBody2D

onready var anim = $AnimatedSprite
onready var timer = $"Timer-Animation"
onready var ray_h = $"Ray-H"
onready var ray_v = $"Ray-V"
export var speed = 400
var left = false
var up = false
var down = false
var right = false
var nothing
var attack_pressed = false
var health = 500

func get_input():
	var velocity = Vector2.ZERO # The player's movement vector.

	
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
		anim.play("right")
		
	elif Input.is_action_pressed("ui_left"):
		velocity.x -= 1
		anim.play("left")
		
	elif Input.is_action_pressed("ui_down"):
		velocity.y += 1
		anim.play("down")
		
	elif Input.is_action_pressed("ui_up"):
		velocity.y -= 1
		anim.play("up")
			
	if Input.is_action_pressed("ui_down") and Input.is_action_pressed("ui_right"):
		velocity.x += 1
		anim.play("right")
		
	if Input.is_action_pressed("ui_up") and Input.is_action_pressed("ui_right"):
		velocity.x += 1
		anim.play("right")

	if Input.is_action_pressed("ui_up") and Input.is_action_pressed("ui_left"):
		velocity.x -= 1
		anim.play("left")
		
	if Input.is_action_pressed("ui_down") and Input.is_action_pressed("ui_left"):
		velocity.x -= 1
		anim.play("left")

		
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
		if ray_h.is_colliding():
			var ray_overlapper_h = ray_h.get_collider()
			ray_overlapper_h.health -= 40
		if ray_v.is_colliding():
			var ray_overlapper_v = ray_v.get_collider()
			ray_overlapper_v.health -= 40
			
		if anim.get_animation() == "up" or anim.get_animation() == "idle-up":
				anim.play("attack-up")
				attack_animation(false, false, true, false)
				timer.start()
		if anim.get_animation() == "down" or anim.get_animation() == "idle-down":
				anim.play("attack-down")
				timer.start()
				attack_animation(false, false, false, true)
		if anim.get_animation() == "left" or anim.get_animation() == "idle-left":
				anim.play("attack-left")
				timer.start()
				attack_animation(true, false, false, false)
		if anim.get_animation() == "right" or anim.get_animation() == "idle-right":
				anim.play("attack-right")
				timer.start()
				attack_animation(false, true, false, false)
				
func _process(_delta):
	get_input()
	Global.player_health = health
	
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
