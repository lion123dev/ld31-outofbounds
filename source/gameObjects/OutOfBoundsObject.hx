package gameObjects;

import flixel.FlxSprite;

/**
 * ...
 * @author lion123
 */
class OutOfBoundsObject extends FlxSprite {
	private var xOffset:Float;
	private var yOffset:Float;

	public function new(X:Float = 0, Y:Float = 0, _xOffset:Float, _yOffset:Float) {
		super(X, Y);
		xOffset = _xOffset;
		yOffset = _yOffset;
	}

	override public function update(t:Float):Void {
		if (x + xOffset < 0 || y + yOffset < 0 || x - xOffset > Reg.SCREEN_WIDTH || y - yOffset > Reg.SCREEN_HEIGHT) {
			kill();
		}
		super.update(t);
	}
}
