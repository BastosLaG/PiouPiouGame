extends Area2D

var pBulletEffect := preload("res://ennemy/Explosion.tscn")

export var minSpeed := 40
export var maxSpeed := 60
export var pv: int = 100
var playerInArea: Player = null

func _process(delta):
	if playerInArea != null:
		playerInArea.damage(1)
		self.damage(pv)

func _physics_process(delta):
	position.x -= rand_range(minSpeed, maxSpeed) * delta

func damage(amount: int):
	pv -= amount
	if pv <= 0:
		var bulletEffect := pBulletEffect.instance()
		bulletEffect.position = position
		get_tree().current_scene.add_child(bulletEffect)
		queue_free() 

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Enemy_area_entered(area):
	if area is Player:
		playerInArea = area
		area.damage(1)

func _on_Enemy_area_exited(area):
	if area is Player:
		playerInArea = null
