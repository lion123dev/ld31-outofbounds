package gameObjects;

import flixel.FlxG;
import flixel.FlxSprite;
import gameObjects.enemies.BaseEnemy;
import gameObjects.enemies.Roller;
import openfl.display.BitmapData;

/**
 * ...
 * @author lion123
 */
class Spawner extends FlxSprite {
	public static var SPAWNER_DELAY:Int = 200;

	private var repositioning:Bool = false;
	private var mutating:Bool = false;
	private var _prototype_:BaseEnemy;
	private var _timer:Int;

	private var moveX:Float;
	private var moveY:Float;

	public function new(X:Float = 0, Y:Float = 0) {
		super(X, Y);
		loadGraphic(AssetPaths.Spawner__png, true, 15, 15);
		animation.add("idle", [0]);
		animation.add("appear", [1, 2, 3, 4, 5, 6, 0], 10, false);
		animation.add("rotate", [8, 9, 10, 0], 10);
		animation.add("mutate", [
			30, 30, 30, 30, 0, 0, 0, 0, 30, 30, 0, 0, 30, 30, 0, 0, 30, 0, 30, 0, 30, 0, 30, 0
		], 30, false);
		animation.add("spark1", [12, 13, 14, 15, 0], 10, false);
		animation.add("spark2", [16, 17, 18, 19, 0], 10, false);
		animation.add("spark3", [20, 21, 22, 0], 10, false);
		animation.add("spark4", [23, 24, 25, 0], 10, false);
		animation.add("spark5", [26, 27, 28, 29, 0], 10, false);

		animation.play("appear");

		changeEnemy();
		_timer = 0;
		x = FlxG.random.float(50, Reg.SCREEN_WIDTH - 50);
		y = FlxG.random.float(50, Reg.SCREEN_HEIGHT - 50);
	}

	private function changeEnemy():Void {
		_prototype_ = BaseEnemy.GetRandom();
		_prototype_.SetRandomParams();
	}

	private function playSpark():Void {
		if (!repositioning && !mutating) {
			var name:String = "spark" + FlxG.random.int(1, 5);
			animation.play(name);
		}
	}

	private function Reposition():Void {
		if (!repositioning) {
			animation.play("rotate", true);
			repositioning = true;
			_timer = 0;
			var newx:Float = FlxG.random.float(50, Reg.SCREEN_WIDTH - 50);
			var newy:Float = FlxG.random.float(50, Reg.SCREEN_HEIGHT - 50);
			moveX = (newx - x) / 30;
			moveY = (newy - y) / 30;
		}
	}

	override public function update(t:Float):Void {
		_timer++;
		if (repositioning) {
			x += moveX;
			y += moveY;
			if (_timer == 30) {
				repositioning = false;
			}
		} else {
			if (!mutating && FlxG.random.bool(0.1)) {
				Reposition();
			}
			if (_timer % 10 == 0)
				playSpark();
		}

		if (mutating) {
			if (_timer > 50) {
				mutating = false;
			}
		} else {
			if (!repositioning && FlxG.random.bool(0.1)) {
				mutating = true;
				animation.play("mutate", true);
				_timer = 0;
				changeEnemy();
			}
		}

		if (_timer > SPAWNER_DELAY && FlxG.random.bool(2)) {
			animation.play("rotate", true);
			_timer = 0;
			var newEnemy:BaseEnemy = _prototype_.copy();
			newEnemy.x = x;
			newEnemy.y = y;
			Reg.GetPlayState().AddEnemy(newEnemy);
			FlxG.sound.play("assets/sounds/spawn.wav", 0.6);
		}

		super.update(t);
	}
}
