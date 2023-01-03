package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.input.keyboard.FlxKey;
import flixel.util.FlxColor;
/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState
{
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();
		FlxG.camera.fade(FlxColor.FOREST_GREEN, 1, true);
		FlxG.sound.muteKeys = ["M"];
		var logoText:FlxText = new FlxText(0, 20, Reg.SCREEN_WIDTH, "Out of Bounds!");
		logoText.setFormat(null, 32, 0xffffff, "center");
		var objectiveText:FlxText = new FlxText(0, 130, Reg.SCREEN_WIDTH, "Get as many points as you can by staying on the screen." +
		" Controls: WSAD or Arrow Keys. P or ESC pauses, M mutes");
		var diffText:FlxText = new FlxText(0, 160, Reg.SCREEN_WIDTH, "Harder difficulties have more spawners at the start");
		add(logoText);
		add(objectiveText);
		add(diffText);
		add(new FlxText(0, 0, 0, "Made for LD compo #31 by _lion123", 10));
		add(new FlxButton(160, 200, "Easy (1)", Easy));
		add(new FlxButton(160, 230, "Medium (10)", Medium));
		add(new FlxButton(160, 260, "Hard (20)", Hard));
		add(new FlxButton(300, 275, "Watch Intro", Intro));
		FlxG.sound.play("assets/sounds/bomb.wav");
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
		
	}	
	
	private function Intro():Void
	{
		FlxG.switchState(new IntroState());
	}
	
	private function Easy():Void
	{
		StartGame(1);
	}
	
	private function Medium():Void
	{
		StartGame(10);
	}
	
	private function Hard():Void
	{
		StartGame(20);
	}
	
	private function StartGame(amountSpawners:Int):Void
	{
		Reg.startingSpawners = amountSpawners;
		FlxG.switchState(new PlayState());
	}
}