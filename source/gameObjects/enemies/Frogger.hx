package gameObjects.enemies;

import flixel.FlxG;
import flixel.FlxObject;
import openfl.display.BitmapData;

/**
 * ...
 * @author lion123
 */
class Frogger extends BaseEnemy {
	// params
	public var jumpSpeed:Float;
	public var speed:Float;

	// other
	private var direction:Bool;

	public function new() {
		super(0, 0, 5.5, 5);
		name = "Frogger";
		loadGraphic(AssetPaths.Frogger__png, true, 11, 10);
		animation.add("start", [0], 1, false);
		animation.add("jump", [1], 1, false);
		animation.play("start");
		acceleration.y = Reg.GRAVITY;
	}

	override public function SetRandomParams():Void {
		super.SetRandomParams();
		speed = FlxG.random.float(40, 100);
		jumpSpeed = FlxG.random.float(60, 120);
	}

	override public function update(t:Float):Void {
		if (this.justTouched(FlxObject.FLOOR)) {
			velocity.x = 0;
			animation.play("start");
		}
		var touchesFloor:Bool = isTouching(FlxObject.FLOOR);
		if (touchesFloor && FlxG.random.bool(1)) {
			var faceLeft:Bool = FlxG.random.bool(50);
			velocity.x = faceLeft ? -speed : speed;
			velocity.y = -jumpSpeed;
			flipX = faceLeft;
			animation.play("jump");
		}
		super.update(t);
	}

	override public function PlayerCollided(player:Player):Void {
		if (y > player.y)
			player.velocity.y = -(120 + Math.abs(velocity.y));
		super.PlayerCollided(player);
	}

	override public function copy():BaseEnemy {
		var copied:Frogger = new Frogger();
		copied.speed = speed;
		copied.jumpSpeed = jumpSpeed;
		return copied;
	}
}
