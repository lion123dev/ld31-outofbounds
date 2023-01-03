package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import gameObjects.enemies.BaseEnemy;

/**
 * ...
 * @author lion123
 */
class EndScreenState extends FlxState {
	public function new() {
		super();
	}

	private function CreateEnemies(enemy:BaseEnemy):Void {
		if (enemy == null)
			return;
		enemy.SetRandomParams();
		var newEnemy:BaseEnemy;
		for (i in 0...10) {
			newEnemy = enemy.copy();
			newEnemy.SetRandomParams();
			newEnemy.x = FlxG.random.float(50, Reg.SCREEN_WIDTH - 50);
			newEnemy.y = FlxG.random.float(50, Reg.SCREEN_HEIGHT - 50);
			add(newEnemy);
		}
	}

	override public function create():Void {
		super.create();
		FlxG.sound.music.stop();
		CreateEnemies(BaseEnemy.GetByName(Reg.lastHitBy));
		var gameOver:FlxText = new FlxText(0, 0, Reg.SCREEN_WIDTH, "Game Over!", 25);
		gameOver.setFormat(null, 25, 0xffffff, "center");
		var scoreText:FlxText = new FlxText(0, 50, Reg.SCREEN_WIDTH, "Your score is: " + Reg.score, 20);
		scoreText.setFormat(null, 20, 0xffffff, "center");
		var killedByText:FlxText = new FlxText(0, 100, Reg.SCREEN_WIDTH, "You were killed by " + Reg.lastHitBy, 18);
		killedByText.setFormat(null, 18, 0xffffff, "center");
		add(gameOver);
		add(scoreText);
		add(killedByText);
		add(new FlxButton(160, 200, "Okay", Leave));
	}

	private function Leave():Void {
		FlxG.switchState(new MenuState());
	}
}
