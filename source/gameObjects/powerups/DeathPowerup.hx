package gameObjects.powerups;
import gameObjects.Player;
import openfl.display.BitmapData;
/**
 * ...
 * @author lion123
 */

@:bitmap("assets/images/DeathPowerup.png")
class DeathPowerupImg extends BitmapData { }

class DeathPowerup extends BasePowerup
{

	public function new() 
	{
		super(DeathPowerupImg);
	}
	
	override public function PlayerPickedUp(player:Player):Void 
	{
		super.PlayerPickedUp(player);
		player.kill();
	}
	
}