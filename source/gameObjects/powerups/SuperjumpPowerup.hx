package gameObjects.powerups;
import gameObjects.Player;
import openfl.display.BitmapData;
/**
 * ...
 * @author lion123
 */

@:bitmap("assets/images/SuperJumpPowerup.png")
class SuperjumpPowerupImg extends BitmapData { }

class SuperjumpPowerup extends BasePowerup
{

	public function new() 
	{
		super(SuperjumpPowerupImg);
	}
	
	override public function PlayerPickedUp(player:Player):Void 
	{
		super.PlayerPickedUp(player);
		player.Superjump(200);
	}
	
}