extends Area2D

class_name Player

var tel_Tir := preload("res://bullet/bullet.tscn")
var pBulletEffect := preload("res://ennemy/Explosion.tscn")

onready var animatedSprite := $AnimatedSprite
onready var emplacementArme := $position_armement
onready var cadence_delai := $cadence
onready var invincibility_timer := $invincibiliter
onready var clignoTime := $clignotement

export var speed: float = 100
export var cadence: float = 0.1
export var pv: int = 3 
export var damageInvincibilityTime := 1 

var velocity = Vector2(0, 0)

func _ready():
	animatedSprite.visible = true

func _process(delta):
	if velocity.x > 0:
		animatedSprite.play("run")
	else:
		animatedSprite.play("idle")
	
	if Input.is_action_pressed("tir") and cadence_delai.is_stopped():
		cadence_delai.start(cadence)
		for enfant in emplacementArme.get_children() :
			var tir := tel_Tir.instance()
			tir.global_position = enfant.global_position
			get_tree().current_scene.add_child(tir)

func _physics_process(delta):
	var dirVec := Vector2(-0.5, 0)
	if Input.is_action_pressed("move_left"):
		dirVec.x = -1
	if Input.is_action_pressed("move_right"):
		dirVec.x = 1
	if Input.is_action_pressed("move_up"):
		dirVec.y = -1
	if Input.is_action_pressed("move_down"):
		dirVec.y = 1
	
	velocity = dirVec.normalized() * speed
	position += velocity * delta
	
	#Stop aux cleeping
	var viewRect := get_viewport_rect()
	position.x = clamp(position.x, 0, viewRect.size.x)
	position.y = clamp(position.y, 0, viewRect.size.y)
	
func damage(amount: int):
	if !invincibility_timer.is_stopped():
		return
	
	invincibility_timer.start(damageInvincibilityTime)
	
	pv -= amount
	print("Point de vie : %s"% pv)
	if pv <= 0:
		var bulletEffect := pBulletEffect.instance()
		bulletEffect.position = position
		get_tree().current_scene.add_child(bulletEffect)
		print("Joueur mort")
		queue_free()

