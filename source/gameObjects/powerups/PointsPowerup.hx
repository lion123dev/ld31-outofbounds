package gameObjects.powerups;

import flixel.FlxG;
import gameObjects.Player;
import openfl.display.BitmapData;

/**
 * ...
 * @author lion123
 */
class PointsPowerup extends BasePowerup {
	public function new() {
		super(AssetPaths.PointsPowerup__png);
	}

	override public function PlayerPickedUp(player:Player):Void {
		super.PlayerPickedUp(player);
		Reg.score += 250;
		FlxG.sound.play("assets/sounds/bonus.wav");
	}
}
