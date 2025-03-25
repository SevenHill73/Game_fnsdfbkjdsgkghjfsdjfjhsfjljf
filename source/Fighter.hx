package;
import flixel.FlxG;
import flixel.FlxSprite;
class Fighter extends FlxSprite {
    var id:String;

    //This is for the short hop and the full hop
    public var jumpTimer:Int = 0;
    //Double Jump
    var maximumAirJump = 1;
    public var jump = 2;

    var freefall = false;

    public function new(id:String, maximumAirJump:Int = 1) {
        super();
        this.id = id;
        acceleration.y = 900;
		maxVelocity.y = 300;
        this.maximumAirJump = maximumAirJump;
        jump = maximumAirJump + 1;
    }
    override function update(elapsed:Float){
        super.update(elapsed);
        FlxG.collide(PlayState.instance.stage,this);
       //Short Hop and Ground Full Hop
        if (isTouching(DOWN)){
            if (FlxG.keys.pressed.SPACE){
                jumpTimer += 1;
                if (jumpTimer >= 6) {
                    velocity.y = -300;
                    jumpTimer = 0;
                }
            }
            if (FlxG.keys.released.SPACE && jumpTimer < 6 && jumpTimer > 1){
                velocity.y = -200;
                jumpTimer = 0;
            }
        }
        
        //Full Hop In the Air
        if(FlxG.keys.justPressed.SPACE){
            jump -= 1;
            if(!isTouching(DOWN) && jump > -1)
                velocity.y = -300;
        }

        if(isTouching(DOWN) && (jump == 0 || jump != maximumAirJump))
            jump = maximumAirJump;

            
        
    }
}