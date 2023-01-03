package gameObjects.enemies;
import gameObjects.enemies.BaseEnemy;
import gameObjects.Player;
import helpers.Direction;
import openfl.display.BitmapData;
import flixel.FlxObject;
import flixel.util.FlxRandom;
/**
 * ...
 * @author lion123
 */

 @:bitmap("assets/images/Bugger.png")
class BuggerImg extends BitmapData { }

class Bugger extends BaseEnemy
{

	//params
	public var speed:Float;
	private var dir:Direction;
	
	public function new() 
	{
		super(0, 0, 4, 4.5);
		name = "Bugger";
		loadGraphic(BuggerImg, true, 8, 9);
		animation.add("start", [0, 1], 10);
		animation.play("start");
		//bakedRotationAngle = 90;
		ChangeRotation();
	}
	
	override public function SetRandomParams():Void 
	{
		super.SetRandomParams();
		speed = FlxRandom.floatRanged(30, 60);
	}
	
	private function ChangeRotation():Void
	{
		dir = Direction.GetRandom();
		
		angle = dir.GetAngle();
	}
	
	override public function update():Void 
	{
		velocity.x = dir.GetX()*speed;
		velocity.y = dir.GetY()*speed;
		if (FlxRandom.chanceRoll(1) || isTouching(FlxObject.ANY)) {
			ChangeRotation();
		}
		super.update();
	}
	
	override public function PlayerCollided(player:Player):Void 
	{
		player.velocity.x = dir.GetX() * 160;
		player.velocity.y = dir.GetY() * 160;
		player.update();
		super.PlayerCollided(player);
	}
	
	override public function copy():BaseEnemy 
	{
		var copied:Bugger = new Bugger();
		copied.speed = speed;
		return copied;
	}
	
}