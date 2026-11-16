extends AudioStreamPlayer
class_name RadioReceiver

var messages = ["a", "a", "a", "a", "a"]

var sample_hz = 22050.0
var pulse_hz = 440.0
var phase = 0.0

var freq : float = 80.0
var index : int = 0

var unit_length : int = 5

var playback: AudioStreamPlayback = null

func _fill_buffer():
	var increment = pulse_hz / sample_hz
	var to_fill = playback.get_frames_available()
	if to_fill > 512 * unit_length:
		if messages[int(freq / 10) - 8][index % messages[int(freq / 10) - 8].length()] == '1':
			while to_fill > 0 * unit_length:
				playback.push_frame(Vector2.ONE * sin(phase * TAU))
				phase = fmod(phase + increment, 1.0)
				to_fill -= 1
		else:
			while to_fill > 0 * unit_length:
				playback.push_frame(Vector2.ZERO)
				phase = fmod(phase + increment, 1.0)
				to_fill -= 1
		index += 1

func _process(_delta):
	_fill_buffer()

func _ready():
	self.stream.mix_rate = sample_hz
	play()
	playback = get_stream_playback()
	_fill_buffer()


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == MOUSE_BUTTON_WHEEL_UP:
				freq += 0.5
			if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				freq -+ 0.5
