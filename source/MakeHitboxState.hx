package;
import flixel.FlxSprite;
import openfl.text.TextFieldAutoSize;
#if MakeHitboxState
import flixel.FlxG;
import flixel.FlxState;
import flixel.addons.ui.FlxUIDropDownMenu;
import flixel.addons.ui.StrNameLabel;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxInputText;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import tjson.TJSON as Json;
class MakeHitboxState extends FlxState{
	var fighter:FighterBasic;
    var fighterSelection:FlxUIDropDownMenu;
    var fighterAnimationSelection:FlxUIDropDownMenu;
    var curframe:FlxText;
    var createHitbox:FlxButton;
    var hitBoxes:List<Hitbox> = new List();
	var completeButton:FlxButton;

	var type:FlxInputText;
	var size:FlxInputText;
	var property:FlxInputText;
	var kbAngle:FlxInputText;

	var hitboxPropertiesGroup:FlxTypedGroup<FlxInputText>;

	public static var arrTmpJson(default, null):Array<BasicStructure> = new Array();
    
	var arrow:FlxSprite;
    override function create() {
		hitboxPropertiesGroup = new FlxTypedGroup();
        super.create();
        FlxG.state.bgColor = FlxColor.CYAN;

		createHitbox = new FlxButton(0, 600, 'Create A Hitbx for this frame', function()
		{
			var propertySplit = property.textField.text.split(',');
			hitBoxes.add(new Hitbox(0, 0, fighter.animation.name, fighter, type.textField.text, Std.parseInt(size.textField.text),
				fighter.animation.curAnim.curFrame, propertySplit, Std.parseFloat(kbAngle.textField.text)));
			for (i in hitBoxes)
			{
				// i.visible = false;
				if (Lambda.has(members, i))
					continue;
				else
				{
					i.screenCenter();
					add(i);
				}
			}
		});
        createHitbox.scale.y = 1.5;
        createHitbox.updateHitbox();

		completeButton = new FlxButton(0, 400, 'Complete', function()
		{
			json();
			openSubState(new JsonOutput());
		});
		completeButton.updateHitbox();

        arrow = new FlxSprite().loadGraphic(AssetPaths.arrow__png);
		fighter = new FighterBasic(0);
        fighter.screenCenter();
        fighter.animation.play('idle');
        fighter.animation.pause();
        fighter.animation.curAnim.curFrame = 0;

		type = new FlxInputText();
		size = new FlxInputText();
		property = new FlxInputText();
		kbAngle = new FlxInputText();
		hitboxPropertiesGroup.add(type);
		hitboxPropertiesGroup.add(size);
		hitboxPropertiesGroup.add(property);
		hitboxPropertiesGroup.add(kbAngle);
		type.text = 'circle';
		size.text = '24';
		property.text = 'none';
		kbAngle.text = '0';
		var g = 0;
		for (i in hitboxPropertiesGroup)
		{
			i.textField.width = 100;
			i.y += g * 20 + 500;
			g++;
		}

        curframe = new FlxText(0,300,'hi');
        curframe.color = FlxColor.BLACK;

        var n = 0;
        var fighterArray:Array<StrNameLabel> = new Array();
        for(i in FighterState.fightersID.keyValueIterator()){
            fighterArray[n] = new StrNameLabel(i.value,i.value);
            n++;
        }
        fighterSelection = new FlxUIDropDownMenu(0,0,fighterArray);
        fighterSelection.callback = (str:String) -> {
            fighter.loadFighterGraphic(Std.parseInt(str));
			reload();
        };

        var fighterAnimationArray:Array<StrNameLabel> = new Array();
        n = 0;
        for(i in fighter.animation.getNameList()){
            fighterAnimationArray[n] = new StrNameLabel(i,i);
            n++;
        }
        fighterAnimationSelection = new FlxUIDropDownMenu(0,100,fighterAnimationArray);
        fighterAnimationSelection.callback = (str:String) -> {
            fighter.animation.play(str);
            fighter.animation.pause();
            fighter.animation.curAnim.curFrame = 0;
			reload();
        };

        add(fighterAnimationSelection);
        add(fighterSelection);
        add(fighter);
        add(curframe);
        add(createHitbox);
		add(completeButton);
		add(hitboxPropertiesGroup);
    }
    override function update(elapsed:Float) {
        super.update(elapsed);
        curframe.screenCenter(Y);
        curframe.text = 'CurFrame: ${Std.string(fighter.animation.curAnim.curFrame)}\nTotal Frame: ${Std.string(fighter.animation.curAnim.numFrames)}';
        if(FlxG.keys.justPressed.LEFT){

            if(fighter.animation.curAnim.curFrame < 0)
                fighter.animation.curAnim.curFrame = fighter.animation.curAnim.numFrames;
            else
                fighter.animation.curAnim.curFrame -= 1;
			reload();
        }
        if(FlxG.keys.justPressed.RIGHT){
			if (fighter.animation.curAnim.curFrame < fighter.animation.curAnim.numFrames - 1)
                fighter.animation.curAnim.curFrame += 1;
                
            else
                fighter.animation.curAnim.curFrame = 0;
			reload();
		}
		for (i in hitBoxes)
		{
			if (i.mouseOver)
			{
				i.enableMouseClicks(false);
				i.enableMouseDrag();
			}
			else
			{
				i.disableMouseClicks();
				i.disableMouseDrag();
			}
			if (i.isDragged && FlxG.keys.anyJustPressed([BACKSPACE, DELETE]))
			{
				remove(i);
				json();
			}
		}
	}

	var tmpJson:BasicStructure;

	function json()
	{
		// Hitbox Saving
		var x = 0;
		arrTmpJson = [];
		for (i in hitBoxes)
		{
			if (Lambda.has(members, i))
			{
				tmpJson = {
					animName: i.animName,
					type: i.type,
					frame: i.curFrame,
					pos: i.pos,
					size: i.size,
					property: i.property,
					kbAngle: i.kbAngle == Math.NaN ? 0 : i.kbAngle
				};
				arrTmpJson[x] = tmpJson;
			}
			x++;
		}
	}

	function reload()
	{
        for(i in hitBoxes){
			if (i.animName != fighter.animation.curAnim.name || i.curFrame != fighter.animation.curAnim.curFrame)
			{
				i.draggable = false;
				i.visible = false;
			}
			else
			{
				i.draggable = true;
				i.visible = true;
			}
		}
	}
}

typedef BasicStructure =
{
	var animName:String;
	var type:String;
	var frame:Int;
	var pos:Array<Float>;
	var size:Float;
	var property:Array<String>;
	var kbAngle:Float;
}
class JsonOutput extends flixel.FlxSubState
{
	var button:FlxButton;
	var text:FlxInputText;

	override function create()
	{
		super.create();
		button = new FlxButton(0, 0, 'close', function()
		{
			close();
		});
		button.screenCenter();
		button.y -= 100;
		add(button);

		text = new FlxInputText();
		text.text = StringTools.replace(Json.encode(MakeHitboxState.arrTmpJson), "},", "},\n");
		text.textField.visible = false;
		text.screenCenter();
		text.editable = false;
		add(text);
    }
}

#end