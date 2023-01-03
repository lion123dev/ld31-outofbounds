package gameObjects.powerups;

import gameObjects.Player;
import openfl.display.BitmapData;

/**
 * ...
 * @author lion123
 */
class DeathPowerup extends BasePowerup {
	public function new() {
		super(AssetPaths.DeathPowerup__png);
	}

	override public function PlayerPickedUp(player:Player):Void {
		super.PlayerPickedUp(player);
		player.kill();
	}
}
