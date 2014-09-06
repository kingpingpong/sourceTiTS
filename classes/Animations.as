package classes {
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	import flash.utils.Dictionary;
	
	public class Animations {
		
		public static const ANIMATION_FINISHED:String = "TiTS_Animation_Finish";
		
		private static var animations:Dictionary = new Dictionary();
		
		public function Animations() {}
		
		public static function animateSimple(target:Sprite, fromX:Number, fromY:Number, toX:Number, toY:Number, beginFade:Number, endFade:Number, time:int, rotate:int = 0):void
		{
			if((fromX == toX && fromY == toY && beginFade == endFade && rotate == 0) || time == 0) 
			{
				target.x = toX;
				target.y = toY;
				target.alpha = endFade;
				
				setTimeout(target.dispatchEvent, 1, new Event(ANIMATION_FINISHED));
				animations[target] = undefined;
				return;
			}
			if(animations[target]) clearTimeout(animations[target]);
			
			target.x = fromX += (toX - fromX) / time;
			target.y = fromY += (toY - fromY) / time;
			target.alpha = beginFade += (endFade - beginFade) / time;
			
			var tempRotate:Number;
			if(rotate > 0)
			{
				tempRotate = (target.rotation >= 0 ? 360 - target.rotation : -target.rotation) + (rotate - 1) * 360;
				tempRotate /= time;
				
				if(tempRotate + target.rotation >= 0 && target.rotation < 0) rotate--;
				if(tempRotate + target.rotation >= 360)
				{
					rotate--;
					tempRotate -= 360;
				}
								
				target.rotation += tempRotate;
			}
			else if(rotate < 0)
			{
				tempRotate = (target.rotation <= 0 ? -360 - target.rotation : -target.rotation) - (rotate + 1) * 360;
				tempRotate /= time;
				
				if(tempRotate + target.rotation <= 0 && target.rotation > 0) rotate++;
				if(tempRotate + target.rotation <= -360)
				{
					rotate++;
					tempRotate += 360;
				}
								
				target.rotation += tempRotate;
			}
			
			animations[target] = setTimeout(animateSimple, 1, target, fromX, fromY, toX, toY, beginFade, endFade, time - 1, rotate);
		}

	}
	
}
