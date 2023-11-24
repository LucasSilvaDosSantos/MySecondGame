extends Node2D

const WAIT_DURATION = 1.0

 # as aqui apenas melhora a semantica, já que o primeiro é o nome que esta no elemento e o segundo é o tipo 
@onready var platform = $AnimatableBody2D as AnimatableBody2D

# o export é para a edição via o inspetor de forma pratica 
@export var move_speed = 3.0
@export var distance = 192 # 12x16 (16 é o tamnho do tile)vezes o tamanho do bloco, aqui posso por oque eu achar que precisa-
@export var move_horizontal = true

var follow = Vector2.ZERO # para mover sem trepidar 
var platform_center = 16 # o centro do tile

# Called when the node enters the scene tree for the first time.
func _ready():
	move_platform() # inicia tudo porem não inicia o movimento em si


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	platform.position = platform.position.lerp(follow, 0.5) # faz a plataforma se mover 

func move_platform():
	var move_direction = Vector2.RIGHT * distance if move_horizontal else Vector2.UP * distance
	var duration = move_direction.length() / float(move_speed * platform_center)
	
	var platform_tween = create_tween().set_loops().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	#set_loops() para ficar em loop e não parar depois de uma repetição
	#isso aqui que faz a movimentação no final 
	platform_tween.tween_property(self, "follow", move_direction, duration).set_delay(WAIT_DURATION)
	platform_tween.tween_property(self, "follow", Vector2.ZERO, duration).set_delay(duration + WAIT_DURATION) # para voltar a plataforma

#set_trans(Tween.TRANS_LINEAR) para fazer uma transação mais suave-
