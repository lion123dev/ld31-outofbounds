package gameObjects.enemies;
import openfl.display.BitmapData;
import flixel.FlxObject;
import flixel.util.FlxRandom;
/**
 * ...
 * @author lion123
 */

@:bitmap("assets/images/Frogger.png")
class FroggerImg extends BitmapData { }

class Frogger extends BaseEnemy
{
	//params
	public var jumpSpeed:Float;
	public var speed:Float;
	
	//other
	private var direction:Bool;
	
	public function new() 
	{
		super(0, 0, 5.5, 5);
		name = "Frogger";
		loadGraphic(FroggerImg, true, 11, 10);
		animation.add("start", [0], 1, false);
		animation.add("jump", [1], 1, false);
		animation.play("start");
		acceleration.y = Reg.GRAVITY;
	}
	
	override public function SetRandomParams():Void 
	{
		super.SetRandomParams();
		speed = FlxRandom.floatRanged(40, 100);
		jumpSpeed = FlxRandom.floatRanged(60, 120);
	}
	
	override public function update():Void 
	{
		if (this.justTouched(FlxObject.FLOOR)) {
			velocity.x = 0;
			animation.play("start");
		}
		var touchesFloor:Bool = isTouching(FlxObject.FLOOR);
		if (touchesFloor && FlxRandom.chanceRoll(1)) {
			var faceLeft:Bool = FlxRandom.chanceRoll();
			velocity.x = faceLeft? -speed : speed;
			velocity.y = -jumpSpeed;
			flipX = faceLeft;
			animation.play("jump");
		}
		super.update();
	}
	
	override public function PlayerCollided(player:Player):Void 
	{
		if(y > player.y)
			player.velocity.y = -(120 + Math.abs(velocity.y));
		super.PlayerCollided(player);
	}
	
	override public function copy():BaseEnemy 
	{
		var copied:Frogger = new Frogger();
		copied.speed = speed;
		copied.jumpSpeed = jumpSpeed;
		return copied;
	}
	
}