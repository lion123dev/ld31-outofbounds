package gameObjects.powerups;

import flixel.FlxG;
import flixel.FlxSprite;
import gameObjects.OutOfBoundsObject;
import gameObjects.Player;

/**
 * ...
 * @author lion123
 */
class BasePowerup extends OutOfBoundsObject {
	public static var POWERUP_INDENTED:Int = 9;
	public static var VELOCITY:Int = 75;

	public static function GetRandom():BasePowerup {
		var powerup:BasePowerup = new PointsPowerup();
		var randomInt:Int = FlxG.random.int(0, 4);
		for (i in 0...2) {
			if (randomInt == 4) {
				randomInt = FlxG.random.int(0, 4);
			}
		}
		switch (randomInt) {
			case 0:
				powerup = new PointsPowerup();
			case 1:
				powerup = new DeathTouchPowerup();
			case 2:
				powerup = new BombPowerup();
			case 3:
				powerup = new SuperjumpPowerup();
			case 4:
				powerup = new DeathPowerup();
		}
		var randX:Float;
		var randY:Float;
		if (randomInt > 2) {
			// bad powerups
			randX = Reg.GetPlayState().player.x;
			randY = Reg.GetPlayState().player.y;
		} else {
			// good powerup
			randX = FlxG.random.float(50, Reg.SCREEN_WIDTH - 50);
			randY = FlxG.random.float(50, Reg.SCREEN_HEIGHT - 50);
		}
		randomInt = FlxG.random.int(0, 3);
		switch (randomInt) {
			case 0:
				powerup.x = randX;
				powerup.y = -POWERUP_INDENTED;
				powerup.velocity.y = VELOCITY;
			case 1:
				powerup.x = -POWERUP_INDENTED;
				powerup.y = randY;
				powerup.velocity.x = VELOCITY;
			case 2:
				powerup.x = randX;
				powerup.y = Reg.SCREEN_HEIGHT - POWERUP_INDENTED;
				powerup.velocity.y = -VELOCITY;
			case 3:
				powerup.x = Reg.SCREEN_WIDTH - POWERUP_INDENTED;
				powerup.y = randY;
				powerup.velocity.x = -VELOCITY;
		}
		return powerup;
	}

	public function new(graphic:String) {
		super(0, 0, 10, 10);
		loadGraphic(graphic, true, 20, 20);
		animation.add("start", [0, 1], 2);
		animation.play("start");
	}

	public function PlayerPickedUp(player:Player):Void {
		kill();
		/* TO-BE-OVERRIDEN*/
	}
}
