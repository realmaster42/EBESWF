package ui.lobby
{
   import com.greensock.TweenMax;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Graphics;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class Background extends Sprite
   {
       
      
      protected var image:Class;
      
      protected var img:BitmapData;
      
      private var currentImage:int = 0;
      
      private var maxFrames:int = 0;
      
      private var particles:Array;
      
      private var mode:String;
      
      private var bm:Bitmap;
      
      public function Background()
      {
         this.image = Background_image;
         this.img = new this.image().bitmapData;
         this.particles = [];
         this.mode = FallingItemMode.NONE;
         this.bm = new Bitmap(new BitmapData(1,1));
         super();
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         addChild(this.bm);
         this.maxFrames = this.img.width / 850 - 1;
         this.showImage(0);
         if(Config.lobbyEffect == FallingItemMode.SNOW)
         {
            this.particles.push(4);
            this.mode = FallingItemMode.SNOW;
         }
         else if(Config.lobbyEffect == FallingItemMode.RAIN)
         {
            this.particles.push(10);
            this.mode = FallingItemMode.RAIN;
         }
         else if(Config.lobbyEffect == FallingItemMode.CONFETTI)
         {
            this.particles.push(11,12,13);
            this.mode = FallingItemMode.CONFETTI;
         }
         else if(Config.lobbyEffect == FallingItemMode.LEAVES)
         {
            this.particles.push(14,15);
            this.mode = FallingItemMode.LEAVES;
         }
      }
      
      public function showImage(param1:int) : void
      {
         var index:int = param1;
         var g:Graphics = this.graphics;
         var bmd:BitmapData = new BitmapData(850,500,true,0);
         bmd.copyPixels(this.img,new Rectangle(850 * index,0,850,500),new Point(0,0));
         bmd.colorTransform(new Rectangle(0,0,bmd.width,bmd.height),new ColorTransform(0.4,0.4,0.4,1));
         this.bm.bitmapData = bmd;
         this.bm.alpha = 0;
         TweenMax.to(this.bm,2,{"alpha":1});
         TweenMax.delayedCall(10,function():void
         {
            TweenMax.to(bm,0.6,{
               "alpha":0,
               "onComplete":function():void
               {
                  currentImage++;
                  if(currentImage > maxFrames)
                  {
                     currentImage = 0;
                  }
                  showImage(currentImage);
               }
            });
         });
      }
      
      public function onEnterFrame(param1:Event) : void
      {
         var _loc2_:int = 0;
         if(this.particles.length > 0)
         {
            _loc2_ = 0;
            if(this.mode == FallingItemMode.SNOW)
            {
               _loc2_ = 25;
            }
            if(this.mode == FallingItemMode.RAIN)
            {
               _loc2_ = 75;
            }
            if(this.mode == FallingItemMode.CONFETTI)
            {
               _loc2_ = 75;
            }
            if(this.mode == FallingItemMode.LEAVES)
            {
               _loc2_ = 75;
            }
            if(Math.random() * 100 < _loc2_)
            {
               addChild(new FallingItem(this.particles[Math.floor(Math.random() * this.particles.length)],Math.random() * Global.width,-10,this.mode));
            }
         }
      }
   }
}
