package gameObjects.powerups;

import gameObjects.Player;
import openfl.display.BitmapData;

/**
 * ...
 * @author lion123
 */
class SuperjumpPowerup extends BasePowerup {
	public function new() {
		super(AssetPaths.SuperJumpPowerup__png);
	}

	override public function PlayerPickedUp(player:Player):Void {
		super.PlayerPickedUp(player);
		player.Superjump(200);
	}
}
