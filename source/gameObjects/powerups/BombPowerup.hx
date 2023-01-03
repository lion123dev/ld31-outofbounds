package gameObjects.powerups;

import flixel.FlxG;
import gameObjects.Player;
import openfl.display.BitmapData;

/**
 * ...
 * @author lion123
 */
class BombPowerup extends BasePowerup {
	public function new() {
		super(AssetPaths.BombPowerup__png);
	}

	override public function PlayerPickedUp(player:Player):Void {
		super.PlayerPickedUp(player);
		Reg.GetPlayState().Bomb();
		FlxG.sound.play("assets/sounds/bomb.wav");
	}
}
