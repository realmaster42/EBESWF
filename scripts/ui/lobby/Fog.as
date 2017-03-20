package ui.lobby
{
   import com.greensock.BlitMask;
   import com.greensock.TweenMax;
   import com.greensock.easing.Linear;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   
   public class Fog extends Sprite
   {
       
      
      protected var fogBM:Class;
      
      public var fog:BitmapData;
      
      private var dir:int = 0;
      
      private var added:Number = 0.1;
      
      private var blitMask:BlitMask;
      
      public function Fog()
      {
         this.fogBM = Fog_fogBM;
         this.fog = new this.fogBM().bitmapData;
         super();
         var _loc1_:Bitmap = new Bitmap(this.fog);
         this.blitMask = new BlitMask(_loc1_,_loc1_.x,_loc1_.y,_loc1_.width,_loc1_.height,true,true,0,false);
         addChild(this.blitMask);
         TweenMax.to(this,60,{
            "x":-(_loc1_.width - 850),
            "yoyo":true,
            "ease":Linear.easeInOut,
            "repeat":-1
         });
      }
   }
}
