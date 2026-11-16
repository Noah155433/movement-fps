extends Node3D

@export var msg : String
@export_range(80.0, 120.0, 0.1) var freq : float = 0.0

@export var receiver : RadioReceiver

var index : int = 0

var dict = {
	"a": ".-",
	"b": "-...",
	"c": "-.-.",
	"d": "-..",
	"e": ".",
	"f": "..-.",
	"g": "--.",
	"h": "....",
	"i": "..",
	"j": ".---",
	"k": "-.-",
	"l": ".-..",
	"m": "--",
	"n": "-.",
	"o": "---",
	"p": ".--.",
	"q": "--.-",
	"r": ".-.",
	"s": "...",
	"t": "-",
	"u": "..-",
	"v": "...-",
	"w": ".--",
	"x": "-..-",
	"y": "-.--",
	"z": "--..",
	"1": ".----",
	"2": "..---",
	"3": "...--",
	"4": "....-",
	"5": ".....",
	"6": "-....",
	"7": "--...",
	"8": "---..",
	"9": "----.",
	"0": "-----",
	",": "..-..",
	".": ".-.-.-",
	"?": "..--..",
	";": "-.-.-",
	"/": "-..-.",
	"+": ".-.-.",
	"-": "-....-",
	"=": "-...-",
	}

func str_to_bin(msg : String) -> String:
	var rtn : String = ""
	for i in msg.length():
		if dict.has(msg[i].to_lower()): 
			var morse: String = dict[msg[i].to_lower()]
			for j in morse.length():
				rtn += "10" if morse[j] == "." else "1110"
		else:
			rtn += "00"
	return rtn

func _ready() -> void:
	receiver.messages[int(freq / 10.0) - 8] = str_to_bin(msg)
