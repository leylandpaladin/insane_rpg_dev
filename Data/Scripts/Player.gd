extends KinematicBody
# пример наследования, игрок это и есть кинематик боди.
# Вектор3 это объект который передает данные о координатах игрока в 3д пространстве.
# Обращаемся к велосити каждый раз когда нужно получить нашу позицию.
var velocity = Vector3()
# Гравитация - наш вес, в случае если нам понадобится падать


	

# ! функция _ready выполняет вложенные в нее код когда объект инициалируется игрой.

# ! SET MOUSE MODE Означает что игра захватывает мышь
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
# Получаем инпут игрока
func get_input():
	var input_dir = Vector3()
	# Трансформ - бейсиз, это координата Z от лица игрока, грубо говоря это сторона в которорую прямо сейчас смотрит игрок. 
	# отнимая его Z мы движемся вперед! А прибавляя - назад.
	# is_action_just_pressed принимает в себя название действия, бинд для него задается в настройках проекта godot.

	if Input.is_action_pressed("move_forward"):
		input_dir += -global_transform.basis.z
	if Input.is_action_pressed("move_back"):
		input_dir += global_transform.basis.z
	# Трасформируем координату X чтобы двигаться в разные стороны, по тому же принципу что с движениями вперед/назад.
	if Input.is_action_pressed("strafe_left"):
		input_dir += -global_transform.basis.x
	if Input.is_action_pressed("strafe_right"):
		input_dir += global_transform.basis.x
	if Input.is_action_just_pressed("jump") and is_on_floor():
		input_dir += global_transform.basis.y
	# Обработка Esc. Пока это сразу закрывает приложение, потом нужно будет открывать менюшку
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()
	if Input.is_action_just_pressed("change_cameramode"):
		change_camera_mode()
	# Нормализирует инпут таким образом что мы не сможем слишком быстро стрейфится
	input_dir = input_dir.normalized() 
	
	# Возвращаем значение куда именно мы движемся для использования в других функциях.
	return input_dir
		
		
		
func change_camera_mode():
		if $Pivot/Camera_1st.current == true:
			$Pivot/Camera_3rd/.set_current(true)
			Globals.isInFirstPerson = false
			
						
		else:
			$Pivot/Camera_1st.set_current(true)
			Globals.isInFirstPerson = true
		
# Мауслук в этой функции
func _unhandled_input(event):
	

	if event is InputEventMouseMotion:
		# крутим башкой в 3д пространстве
		# y лево/право
		rotate_y(-event.relative.x * Globals.mouse_sensitivity)
		# Крутим башкой вверх-вниз с ограничением чтобы не крутится вертикальной центрифугой
		$Pivot.rotate_x(-event.relative.y * Globals.mouse_sensitivity)
		$Pivot.rotation.x = clamp($Pivot.rotation.x, -1.2,1.2)
		
func _physics_process(delta):
	
	# получаем позицию нашего движения и множим на желаемый коэфициэнт скорость.
	var desired_velocity = get_input() * Globals.player_max_speed
	
	# так как велосити - это экземпляр объекта Vector3, мы можем модифицировать вот таким вот образом:
	# гравити * дельту сменит нашу позицию при падении. К примеру если захотим падать быстрее, можно менять вес.
	# дельта - временной отрезок между предъидущим и текущим фреймом.
	velocity.y += desired_velocity.y * Globals.player_jump_height * delta
	velocity.y += Globals.player_gravity * delta
	velocity.x = desired_velocity.x
	velocity.z = desired_velocity.z

	# Применям велосити для движения, не до конца понял этот момент, CTRL + LMB - документация.
	velocity = move_and_slide(velocity, Vector3.UP, true)

	
func change_weapon():
	pass
	

func _process(delta):
	
	pass
	


# Called when the node enters the scene tree for the first time.


