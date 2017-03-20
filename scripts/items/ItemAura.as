package items
{
   import animations.AnimationManager;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class ItemAura
   {
       
      
      public var shapeId:int;
      
      public var colorId:int;
      
      public var bmd:BitmapData;
      
      public var frames:int = 1;
      
      public var speed:Number = 0.2;
      
      private var isAnimated:Boolean = false;
      
      private var animationBMD:BitmapData;
      
      private var drawRect:Rectangle;
      
      public function ItemAura(param1:int, param2:int, param3:BitmapData)
      {
         this.drawRect = new Rectangle();
         super();
         this.shapeId = param1;
         this.colorId = param2;
         this.bmd = param3;
         this.drawRect = param3.rect;
      }
      
      public function drawTo(param1:BitmapData, param2:int, param3:int, param4:int = 0) : void
      {
         if(this.isAnimated)
         {
            this.drawRect.y = param4 * 64;
            param1.copyPixels(this.animationBMD,this.drawRect,new Point(param2,param3));
         }
         else
         {
            param1.copyPixels(this.bmd,this.drawRect,new Point(param2,param3));
         }
      }
      
      public function setFramedAnimation(param1:BitmapData, param2:int, param3:Number) : void
      {
         this.animationBMD = param1;
         this.frames = param2;
         this.speed = param3;
         this.isAnimated = true;
      }
      
      public function setRotationAnimation(param1:int, param2:int) : void
      {
         this.animationBMD = AnimationManager.createRotationAnimation(this.bmd,param1,param2);
         this.frames = param1;
         this.isAnimated = true;
      }
   }
}
