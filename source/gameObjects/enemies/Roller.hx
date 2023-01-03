package gameObjects.enemies;
import flixel.FlxObject;
import gameObjects.enemies.BaseEnemy;
import gameObjects.Player;
import flixel.util.FlxColor;
import openfl.display.BitmapData;
/**
 * ...
 * @author lion123
 */

 @:bitmap("assets/images/Roller.png")
class RollerImg extends BitmapData { }
 
class Roller extends BaseEnemy
{
	//params
	public var speed:Float;
	public var changedirChance:Float;
	
	//other
	private var direction:Bool;
	
	public function new() 
	{
		super(0, 0, 5, 5);
		name = "Roller";
		loadGraphic(RollerImg, true, 10, 10);
		animation.add("start", [0, 1], 10);
		animation.play("start");
		acceleration.y = Reg.GRAVITY;
	}
	
	override public function SetRandomParams():Void 
	{
		super.SetRandomParams();
		speed = FlxG.random.floatRanged(40, 100);
		changedirChance = FlxG.random.floatRanged(0.5, 2);
	}
	
	override public function update():Void 
	{
		if (FlxG.random.chanceRoll(changedirChance)) {
			direction = !direction;
		}
		if (direction) {
			velocity.x = -speed;
		}else {
			velocity.x = speed;
		}
		flipX = direction;
		super.update();
	}
	
	override public function PlayerCollided(player:Player):Void 
	{
		player.velocity.x = direction? -speed : speed;
		super.PlayerCollided(player);
	}
	
	override public function copy():BaseEnemy 
	{
		var copied:Roller = new Roller();
		copied.speed = speed;
		copied.changedirChance = changedirChance;
		return copied;
	}
}