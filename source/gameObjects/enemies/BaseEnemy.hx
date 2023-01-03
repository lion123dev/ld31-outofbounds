package gameObjects.enemies;

import flixel.FlxG;
import flixel.FlxSprite;
import gameObjects.OutOfBoundsObject;
import gameObjects.Player;
/**
 * ...
 * @author lion123
 */
class BaseEnemy extends OutOfBoundsObject
{

	public var name:String;
	
	public static function GetByName(name:String):BaseEnemy
	{
		switch(name) {
			case "Frogger": return new Frogger();
			case "Bugger" : return new Bugger();
			case "Roller" : return new Roller();
		}
		return null;
	}
	
	public static function GetRandom():BaseEnemy 
	{
		var rndIndex:Int = FlxG.random.intRanged(0, 2);
		switch(rndIndex) {
			case 0: return new Roller();
			case 1: return new Bugger();
			case 2: return new Frogger();
		}
		//default
		return new Bugger();
	}
	
	public function new(X:Float=0, Y:Float=0, _xOffset:Float, _yOffset:Float) 
	{
		super(X, Y, _xOffset, _yOffset);
		name = "Enemy";
	}
	
	public function copy():BaseEnemy
	{
		/* TO-BE-OVERRIDEN */
		return null;
	}
	
	public function PlayerCollided(player:Player):Void
	{
		if (player.isDeathTouch) {
			kill();
			FlxG.sound.play("assets/sounds/kill.wav");
		}
		/* TO-BE-OVERRIDEN*/
	}
	
	public function SetRandomParams():Void
	{
		/* TO-BE-OVERRIDEN*/
	}
	
	override public function kill():Void 
	{
		Reg.score += 5;
		super.kill();
	}
	
}