package
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.*;
	
	public class Enemy extends MovieClip
	{
		private var _root:MovieClip;
		public var xSpeed:int;
		public var ySpeed:int;
		public var maxSpeed:int = 3;
		public var health:int = 5;
 
		public function Enemy()
		{
			this.addEventListener(Event.ADDED, beginClass);
			this.addEventListener(Event.ENTER_FRAME, eFrameEvents);
		}
		
		private function beginClass(e:Event):void
		{
			_root = MovieClip(root);
 
			if(_root.startDir == 'UP')
			{
				this.y = 300;
				this.x = _root.startCoord;
				this.xSpeed = 0;
				this.ySpeed = -maxSpeed;
			} 
			else if(_root.startDir == 'RIGHT')
			{
				this.x = -25;
				this.y = _root.startCoord;
				this.xSpeed = maxSpeed;
				this.ySpeed = 0;
			} 
			else if(_root.startDir == 'DOWN')
			{
				this.y = -25;
				this.x = _root.startCoord;
				this.xSpeed = 0;
				this.ySpeed = maxSpeed;
			} 
			else if(_root.startDir == 'LEFT')
			{
				this.x = 550;
				this.y = _root.startCoord;
				this.xSpeed = -maxSpeed;
				this.ySpeed = 0;
			}
 
			this.graphics.beginFill(0xFF0000);
			this.graphics.drawCircle(12.5,12.5,5);
			this.graphics.endFill();
		}
		
		private function eFrameEvents(e:Event):void
		{
			this.x += xSpeed;
			this.y += ySpeed;
 
			if(_root.finDir == 'UP')
			{
				if(this.y <= -25)
				{
					destroyThis();
					_root.lives --;
				}
			} 
			else if(_root.finDir == 'RIGHT')
			{
				if(this.x >= 550)
				{
					destroyThis();
					_root.lives --;
				}
			} 
			else if(_root.finDir == 'DOWN')
			{
				if(this.y >= 300)
				{
					destroyThis();
					_root.lives --;
				}
			} 
			else if(_root.startDir == 'LEFT')
			{
				if(this.x <= 0)
				{
					destroyThis();
					_root.lives --;
				}
			}
 
			if(_root.gameOver || this.health <= 0)
			{
				destroyThis();
			}
		}
		
		public function destroyThis():void
		{
			_root.enemiesLeft --;
			this.removeEventListener(Event.ENTER_FRAME, eFrameEvents);
			this.parent.removeChild(this);
		}
	}
}