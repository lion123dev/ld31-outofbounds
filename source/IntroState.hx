package ;

import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxG;
import flixel.util.FlxColor;
import openfl.display.BitmapData;
/**
 * ...
 * @author lion123
 */

   @:bitmap("assets/images/Intro.png")
class IntroImg extends BitmapData { }
class IntroState extends FlxState
{

	private var clicked:Bool = false;
	public function new() 
	{
		super();
	}
	
	override public function create():Void 
	{
		super.create();
		var sp:FlxSprite = new FlxSprite();
		sp.loadGraphic(IntroImg);
		add(sp);
	}
	
	override public function update():Void 
	{
		if (!clicked) {
			if (FlxG.keys.justPressed.ANY || FlxG.mouse.justPressed) {
				clicked = true;
				Clicked();
			}
		}
		super.update();
	}
	
	private function Clicked():Void
	{
		FlxG.camera.fade(FlxColor.FOREST_GREEN, 1, false, go);
	}
	
	private function go():Void
	{
		FlxG.switchState(new MenuState());
	}
	
}