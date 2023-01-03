package gameObjects;

import flixel.FlxSprite;
import openfl.display.BitmapData;
import flixel.FlxG;
import flixel.FlxObject;
/**
 * ...
 * @author lion123
 */

  @:bitmap("assets/images/Player.png")
class PlayerImg extends BitmapData { }

class Player extends OutOfBoundsObject
{
	private var superjump:Int = 0;
	public var isDeathTouch:Bool = false;
	private var deathTouchTimer:Int = 0;
	
	private static var jumpSpeed:Int = 100;
	private static var speed:Int = 150;
	
	private var killed:Bool = false;
	
	public function new(X:Float=0, Y:Float=0) 
	{
		super(X, Y, 10, 10);
		loadGraphic(PlayerImg);
		acceleration.y = Reg.GRAVITY;
	}
	
	public function Jump() {
		velocity.y = -jumpSpeed;
		FlxG.sound.play("assets/sounds/jump.wav");
	}
	
	public function Superjump(amount:Int) {
		superjump = amount;
		FlxG.sound.play("assets/sounds/bigjump.wav");
	}
	
	override public function kill():Void 
	{
		if (!killed) {
			immovable = true;
			visible = false;
			FlxG.sound.play("assets/sounds/die.wav");
			killed = true;
			Reg.GetPlayState().PlayerWasKilled();
		}
	}
	
	public function SetDeathTouch():Void
	{
		isDeathTouch = true;
		deathTouchTimer = 300;
	}
	
	override public function update():Void 
	{
		if (isDeathTouch) {
			deathTouchTimer--;
			if (deathTouchTimer == 0) {
				isDeathTouch = false;
			}
		}
		var touchesFloor:Bool = isTouching(FlxObject.FLOOR);
		if (FlxG.keys.pressed.A || FlxG.keys.pressed.LEFT) {
			acceleration.x = -speed;
		}else{
			if (FlxG.keys.pressed.D || FlxG.keys.pressed.RIGHT) {
				acceleration.x = speed;
			}else {
				acceleration.x *= 0.9;
			}
		}
		if (FlxG.keys.pressed.SPACE || FlxG.keys.pressed.UP || FlxG.keys.pressed.W) {
			if (touchesFloor) {
				Jump();
			}
			if(velocity.y < -50)
				velocity.y -= 5;
		}
		velocity.y -= superjump;
		superjump = 0;
		if (FlxG.keys.pressed.S || FlxG.keys.pressed.DOWN) {
			velocity.y += 5;
		}
		if (touchesFloor) {
			velocity.x *= 0.9;
		}else {
			velocity.x *= 0.95;
		}
		super.update();
	}
	
}