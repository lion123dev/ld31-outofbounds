package gameObjects.powerups;
import gameObjects.Player;
import openfl.display.BitmapData;
import flixel.FlxG;
/**
 * ...
 * @author lion123
 */

@:bitmap("assets/images/PointsPowerup.png")
class PointsPowerupImg extends BitmapData { }

class PointsPowerup extends BasePowerup
{

	public function new() 
	{
		super(PointsPowerupImg);
	}
	
	override public function PlayerPickedUp(player:Player):Void 
	{
		super.PlayerPickedUp(player);
		Reg.score += 250;
		FlxG.sound.play("assets/sounds/bonus.wav");
	}
	
}