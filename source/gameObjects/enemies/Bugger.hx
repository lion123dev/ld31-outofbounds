package gameObjects.enemies;

import flixel.FlxG;
import flixel.FlxObject;
import gameObjects.Player;
import gameObjects.enemies.BaseEnemy;
import helpers.Direction;
import openfl.display.BitmapData;

/**
 * ...
 * @author lion123
 */
class Bugger extends BaseEnemy {
	// params
	public var speed:Float;

	private var dir:Direction;

	public function new() {
		super(0, 0, 4, 4.5);
		name = "Bugger";
		loadGraphic(AssetPaths.Bugger__png, true, 8, 9);
		animation.add("start", [0, 1], 10);
		animation.play("start");
		// bakedRotationAngle = 90;
		ChangeRotation();
	}

	override public function SetRandomParams():Void {
		super.SetRandomParams();
		speed = FlxG.random.float(30, 60);
	}

	private function ChangeRotation():Void {
		dir = Direction.GetRandom();

		angle = dir.GetAngle();
	}

	override public function update(t:Float):Void {
		velocity.x = dir.GetX() * speed;
		velocity.y = dir.GetY() * speed;
		if (FlxG.random.bool(1) || isTouching(FlxObject.ANY)) {
			ChangeRotation();
		}
		super.update(t);
	}

	override public function PlayerCollided(player:Player):Void {
		player.velocity.x = dir.GetX() * 160;
		player.velocity.y = dir.GetY() * 160;
		player.update(FlxG.elapsed);
		super.PlayerCollided(player);
	}

	override public function copy():BaseEnemy {
		var copied:Bugger = new Bugger();
		copied.speed = speed;
		return copied;
	}
}
