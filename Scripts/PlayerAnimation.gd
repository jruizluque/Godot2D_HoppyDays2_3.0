extends AnimatedSprite

func update(motion):
	if motion.y < 0:
		play("jump")
	elif motion.x > 0:
		play("run")
		set_flip_h(false)
	elif motion.x < 0:
		play("run")
		set_flip_h(true)
	else:
		play("idle")
		set_flip_h(false)