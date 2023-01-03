package;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import gameObjects.Player;
import gameObjects.Spawner;
import gameObjects.enemies.BaseEnemy;
import gameObjects.powerups.BasePowerup;
import openfl.Assets;
import openfl.display.BitmapData;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState {
	// view
	private var pauseText:FlxText;
	private var scoreText:FlxText;
	private var entities:FlxGroup;

	public var player:Player;

	private var playerShield:FlxSprite;
	private var map:FlxTilemap;
	private var background:FlxSprite;
	private var powerups:FlxGroup;
	private var spawners:FlxGroup;
	// data
	private var _timer:Int;
	private var _scoreTimer:Int = 0;
	private var _nextSpawner:Int;
	private var _nextSpawnerVar:Int;
	private var paused:Bool = false;
	private var ended:Bool = false;
	private var wasMuted:Bool;

	// Interface
	public function Bomb():Void {
		entities.destroy();
		entities = new FlxGroup();
		add(entities);
		FlxG.camera.flash();
		FlxG.camera.shake(0.04, 0.5);
	}

	public function PlayerWasKilled():Void {
		FlxG.camera.fade(FlxColor.BLACK, 2, false, GameOver);
		ended = true;
	}

	public function UpdateScore():Void {
		if (!ended)
			scoreText.text = "Score: " + Reg.score;
	}

	public function AddSpawner():Void {
		spawners.add(new Spawner());
	}

	public function AddEnemy(enemy:BaseEnemy):Void {
		entities.add(enemy);
	}

	// Update
	private function UpdateDifficulty():Void {
		_timer++;
		if (_timer > _nextSpawner) {
			AddSpawner();
			_timer = 0;
			_nextSpawnerVar++;
			_nextSpawner = _nextSpawnerVar * _nextSpawnerVar;
		}
	}

	private function GameOver():Void {
		FlxG.switchState(new EndScreenState());
	}

	override public function update(e:Float):Void {
		if (FlxG.keys.justPressed.P || FlxG.keys.justPressed.ESCAPE) {
			paused = !paused;
			pauseText.visible = paused;
			if (paused) {
				wasMuted = FlxG.sound.muted;
				FlxG.sound.muted = true;
			} else {
				FlxG.sound.muted = wasMuted;
			}
		}
		if (!paused)
			super.update(e);
		if (!paused && !ended) {
			playerShield.visible = player.isDeathTouch;
			if (player.isDeathTouch) {
				playerShield.x = player.x - 1.5;
				playerShield.y = player.y - 1.5;
			}
			FlxG.overlap(player, powerups, onPowerupPickup);
			FlxG.collide(player, entities, onEnemyCollided);
			FlxG.collide(player, map);
			FlxG.collide(entities, map);
			UpdateDifficulty();

			if (FlxG.random.bool(0.22)) {
				var powerup:BasePowerup = BasePowerup.GetRandom();
				powerups.add(powerup);
			}
			_scoreTimer++;
			if (_scoreTimer >= 30) {
				_scoreTimer = 0;
				Reg.score += spawners.length;
				UpdateScore();
			}
		}
	}

	private function onPowerupPickup(object1:FlxBasic, object2:FlxBasic):Void {
		var powerup:BasePowerup = cast object2;
		var player:Player = cast object1;
		if (powerup == null || player == null)
			return;
		powerup.PlayerPickedUp(player);
	}

	private function onEnemyCollided(object1:FlxBasic, object2:FlxBasic):Void {
		var enemy:BaseEnemy = cast object2;
		var player:Player = cast object1;
		if (player == null || enemy == null)
			return;
		enemy.PlayerCollided(player);
		Reg.lastHitBy = enemy.name;
		FlxG.sound.play("assets/sounds/hit.wav");
	}

	// Init
	override public function create():Void {
		Reg.lastHitBy = "yourself";
		super.create();
		Instantiate();
		DrawEverything();
		for (i in 0...Reg.startingSpawners) {
			AddSpawner();
		}
		FlxG.sound.playMusic("assets/music/mainMusic.wav", 0.6);
	}

	private function Instantiate():Void {
		Reg.score = 0;
		entities = new FlxGroup();
		powerups = new FlxGroup();
		spawners = new FlxGroup();
		player = new Player();
		player.x = 150;
		player.y = 200;
		playerShield = new FlxSprite();
		playerShield.loadGraphic(AssetPaths.Shield__png);
		playerShield.visible = false;
		map = new FlxTilemap();
		background = new FlxSprite();
		background.loadGraphic(AssetPaths.Background__png);
		scoreText = new FlxText(150, 10, 0, "", 15);
		pauseText = new FlxText(150, 100, 0, "Paused", 30);
		pauseText.visible = false;
		UpdateScore();
		_timer = 0;
		_nextSpawnerVar = 20;
	}

	private function DrawEverything():Void {
		map.loadMapFromCSV(Assets.getText("assets/data/level.csv"), AssetPaths.Tileset__png, 10, 10);
		map.drag.x = 100;
		add(background);
		add(map);
		add(spawners);
		add(entities);
		add(powerups);
		add(player);
		add(playerShield);
		add(scoreText);
		add(pauseText);
	}

	// destructor
	override public function destroy():Void {
		super.destroy();
	}
}
