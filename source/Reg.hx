package;

import flixel.util.FlxSave;
import flixel.FlxG;
/**
 * Handy, pre-built Registry class that can be used to store 
 * references to objects and other things for quick-access. Feel
 * free to simply ignore it or change it in any way you like.
 */
class Reg
{
	public static var startingSpawners:Int;
	public static var lastHitBy:String;
	public static var GRAVITY:Int = 200;
	//800*600
	public static var SCREEN_WIDTH:Int = 400;
	public static var SCREEN_HEIGHT:Int = 300;
	public static var level:Int = 0;
	public static var score:Int = 0;
	
	public static function GetPlayState():PlayState
	{
		return cast(FlxG.state, PlayState);
	}
}