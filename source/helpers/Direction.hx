package helpers;

import flixel.FlxG;

/**
 * ...
 * @author lion123
 */
class Direction {
	public static function GetRandom():Direction {
		return new Direction(FlxG.random.int(0, 3));
	}

	private var _n:Int;

	public function new(n:Int) {
		_n = n;
	}

	public function GetAngle():Float {
		return _n * 90;
	}

	public function GetX():Int {
		if (_n == 1)
			return 1;
		if (_n == 3)
			return -1;
		return 0;
	}

	public function GetY():Int {
		if (_n == 0)
			return -1;
		if (_n == 2)
			return 1;
		return 0;
	}
}
