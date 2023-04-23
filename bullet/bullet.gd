extends Area2D

var pBulletEffect := preload("res://bullet/particle_blaster.tscn")

export var speed = 500

func _physics_process(delta):
	position.x += speed * delta


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_bullet_area_entered(area):
	if area.is_in_group("dammageable"):
		var bulletEffect := pBulletEffect.instance()
		bulletEffect.position = position
		get_tree().current_scene.add_child(bulletEffect)
		
		area.damage(25)
		
		queue_free()
