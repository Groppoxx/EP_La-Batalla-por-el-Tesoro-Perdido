extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -400.0
const GRAVITY = 900.0
const DECELERATION = 1500.0

@onready var animations = get_node("AnimatedSprite2D")

func _ready() -> void:
	animations.play("Idle")
	

func _physics_process(delta: float) -> void:
	
	# Aplica la gravedad siempre (si no está en el suelo, acelerará hacia abajo)
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	
	# Maneja el salto si el personaje está en el suelo
	if Input.is_action_just_pressed("up_move") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Obtener la dirección de movimiento horizontal (izquierda o derecha)
	var direction := Input.get_axis("left_move", "right_move")
	
	# Maneja la aceleración y desaceleración
	if direction != 0:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, DECELERATION * delta)

	# Mueve al personaje basado en la física
	move_and_slide()

	# Actualiza la animación según el estado
	if not is_on_floor():
		if velocity.y < 0:  # Subiendo
			animations.play("Jump")
		elif velocity.y > 0:  # Cayendo
			animations.play("Fall")
	elif abs(velocity.x) > 0.1:  # Si está corriendo
		if animations.animation != "Run":
			animations.play("Run")
	else:  # Si está en reposo
		if animations.animation != "Idle":
			animations.play("Idle")
	
	# *** Controla el flip del sprite según la dirección ***
	if velocity.x > 0:
		animations.flip_h = false
	elif velocity.x < 0:
		animations.flip_h = true

# Función que se ejecuta cuando algo entra en el Area2D
func _on_area_2d_body_entered(area) -> void:
	if area.is_in_group("Player_2"):
		print(self.name, " chocó con " ,"Player_2")
