package classes {
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	import flash.utils.Dictionary;
	
	public class Animations {
		
		public static const ANIMATION_FINISHED:String = "TiTS_Animation_Finish";
		public static const ANIMATION_OVERLAP:String = "TiTS_Animation_Overlap";
		
		private static var animations:Dictionary = new Dictionary();
				
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
		
		public static function animateZoom(target:Sprite, fromScale:Number, toScale:Number, overlap:Number, time:int):void {
			if((fromScale == toScale && overlap <= 0) || time == 0) {
				target.scaleX = toScale;
				target.scaleY = toScale;
				
				setTimeout(target.dispatchEvent, 1, new Event(ANIMATION_FINISHED));
				animations[target] = undefined;
				return;
			} else if (overlap > 0 && fromScale >= toScale + overlap){
				overlap = 0;
				target.dispatchEvent(new Event(ANIMATION_OVERLAP));
			}
			if(animations[target]) clearTimeout(animations[target]);
			
			fromScale += (toScale + overlap - fromScale + overlap) / time;
			target.scaleX = fromScale;
			target.scaleY = fromScale;
			
			animations[target] = setTimeout(animateZoom, 1, target, fromScale, toScale, overlap, time - 1);
		}

	}
	
}
