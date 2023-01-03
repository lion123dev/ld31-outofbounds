package gameObjects.powerups;
import flixel.FlxG;
import gameObjects.Player;
import openfl.display.BitmapData;
/**
 * ...
 * @author lion123
 */

@:bitmap("assets/images/DeathTouchPowerup.png")
class DeathTouchPowerupImg extends BitmapData { }

class DeathTouchPowerup extends BasePowerup
{

	public function new() 
	{
		super(DeathTouchPowerupImg);
	}
	
	override public function PlayerPickedUp(player:Player):Void 
	{
		super.PlayerPickedUp(player);
		player.SetDeathTouch();
		FlxG.sound.play("assets/sounds/shield.wav");
	}
	
}