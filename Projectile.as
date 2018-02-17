package
{
	import flash.display.MovieClip;
	import flash.events.*;
	
	public class Projectile extends MovieClip
	{
		private var _root:*;
		public var target;
		public var damage:int = 1;
		
		private var xVelocity:Number;
		private var yVelocity:Number;
		private var maxSpeed:Number = 5;
		
		public function Projectile()
		{
			this.addEventListener(Event.ADDED, beginClass);
			this.addEventListener(Event.ENTER_FRAME, eFrame);
		}
		
		private function beginClass(e:Event):void
		{
			_root = MovieClip(root);
			
			this.graphics.beginFill(0xFFFF00);
			this.graphics.drawCircle(0,0,3);
			this.graphics.endFill();
		}
		
		private function eFrame(e:Event):void
		{
			var distanceX:Number = target.x + 12.5 - this.x;
			var distanceY:Number = target.y + 12.5 - this.y;
			var angle:Number = Math.atan2(distanceY,distanceX);
			xVelocity = Math.cos(angle) * maxSpeed;
			yVelocity = Math.sin(angle) * maxSpeed;
			
			this.x+=xVelocity;
			this.y+=yVelocity;
			
			if (this.hitTestObject(target))
			{
				target.health-=damage;
				destroyThis();
			}
			if (target==null || _root.gameOver)
			{
				destroyThis();
			}
		}
		
		public function destroyThis():void
		{
			this.removeEventListener(Event.ENTER_FRAME, eFrame);
			MovieClip(this.parent).removeChild(this);
		}
	}
}