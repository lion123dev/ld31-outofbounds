package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.util.FlxColor;
import openfl.display.BitmapData;

/**
 * ...
 * @author lion123
 */
class IntroState extends FlxState {
	private var clicked:Bool = false;

	public function new() {
		super();
	}

	override public function create():Void {
		super.create();
		var sp:FlxSprite = new FlxSprite();
		sp.loadGraphic(AssetPaths.Intro__png);
		add(sp);
	}

	override public function update(t:Float):Void {
		if (!clicked) {
			if (FlxG.keys.justPressed.ANY || FlxG.mouse.justPressed) {
				clicked = true;
				Clicked();
			}
		}
		super.update(t);
	}

	private function Clicked():Void {
		FlxG.camera.fade(FlxColor.GREEN, 1, false, go);
	}

	private function go():Void {
		FlxG.switchState(new MenuState());
	}
}
