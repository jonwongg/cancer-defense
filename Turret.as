package
{
	import flash.display.MovieClip;
	import flash.events.*;
	
	public class Turret extends MovieClip
	{
		private var _root:MovieClip;
		
		private var angle:Number; 
		private var radiansToDegrees:Number = 180/Math.PI;
		private var damage:int = 3;
		private var range:int = 100;
		private var enTarget;
		private var cTime:int = 0;
		private var reloadTime:int = 12;
		private var loaded:Boolean = true;
		
		public function Turret()
		{
			this.addEventListener(Event.ADDED, beginClass);
			this.addEventListener(Event.ENTER_FRAME, eFrameEvents);
		}
		
		private function beginClass(e:Event):void
		{
			_root = MovieClip(root);
 
			this.graphics.beginFill(0x999999);
			this.graphics.drawCircle(0,0,12.5);
			this.graphics.endFill();
			this.graphics.beginFill(0xFFFFFF);
			this.graphics.drawRect(-2.5, 0, 5, 20);
			this.graphics.endFill();
		}
		
		private function eFrameEvents(e:Event):void
		{
			if(_root.gameOver)
			{
				this.removeEventListener(Event.ENTER_FRAME, eFrameEvents);
				MovieClip(this.parent).removeChild(this);
			}
			
			
			var distance:Number = range;
			enTarget = null;
			for(var i:int=_root.enemyHolder.numChildren-1;i>=0;i--)
			{
				var cEnemy = _root.enemyHolder.getChildAt(i);
				if(Math.sqrt(Math.pow(cEnemy.y - y, 2) + Math.pow(cEnemy.x - x, 2)) < distance)
				{
					enTarget = cEnemy;
				}
			}
			
			if(enTarget != null)
			{
				this.rotation = Math.atan2((enTarget.y-y), enTarget.x-x)/Math.PI*180 - 90;
				if(loaded)
				{
					loaded = false;
					var projectile:Projectile = new Projectile();
					projectile.x = this.x;
					projectile.y = this.y;
					
					projectile.target = enTarget;
					projectile.damage = damage;
					_root.addChild(projectile);
				}
			}
			
			if(!loaded)
			{
				cTime++;
				if(cTime == reloadTime)
				{
					loaded = true;
					cTime = 0;
				}
			}			
		}
	}
}