package ui.ingame.sam
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.GradientType;
   import flash.display.SpreadMethod;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class SoundSlider extends Sprite
   {
      
      private static var SoundState:Class = SoundSlider_SoundState;
      
      private static var soundStateBMD:BitmapData = new SoundState().bitmapData;
      
      private static var SoundBar:Class = SoundSlider_SoundBar;
      
      private static var soundBarBMD:BitmapData = new SoundBar().bitmapData;
      
      private static var SoundGrip:Class = SoundSlider_SoundGrip;
      
      private static var soundGripBMD:BitmapData = new SoundGrip().bitmapData;
       
      
      public var WIDTH:int = 158;
      
      public var HEIGHT:int = 29;
      
      private var matrix:Matrix;
      
      private var stateImage:Bitmap;
      
      private var gripImage:Bitmap;
      
      private var barImage:Bitmap;
      
      private var imageBMD:BitmapData;
      
      public function SoundSlider()
      {
         super();
         this.gripImage = new Bitmap(soundGripBMD);
         this.gripImage.y = Math.round((this.HEIGHT - this.gripImage.height) / 2) - 1;
         this.gripImage.x = 147;
         this.barImage = new Bitmap(soundBarBMD);
         this.barImage.y = Math.round((this.HEIGHT - this.barImage.height) / 2) - 1;
         this.barImage.x = 48;
         addChild(this.barImage);
         addChild(this.gripImage);
         addEventListener(MouseEvent.MOUSE_MOVE,function(param1:MouseEvent):void
         {
            var _loc2_:int = param1.localX;
            if(_loc2_ > 147)
            {
               _loc2_ = 147;
            }
            else if(_loc2_ < 47)
            {
               _loc2_ = 47;
            }
            if(param1.buttonDown)
            {
               redraw(_loc2_);
            }
         });
         addEventListener(MouseEvent.MOUSE_UP,function(param1:MouseEvent):void
         {
            var _loc2_:int = param1.localX;
            if(_loc2_ > 147)
            {
               _loc2_ = 147;
            }
            else if(_loc2_ < 47)
            {
               _loc2_ = 47;
            }
            redraw(_loc2_);
         });
         this.buttonMode = true;
         this.useHandCursor = true;
         this.mouseEnabled = true;
         this.matrix = new Matrix();
         this.matrix.createGradientBox(this.WIDTH,this.HEIGHT,Math.PI / 2);
         graphics.clear();
         graphics.lineStyle(1,8092539);
         graphics.beginGradientFill(GradientType.LINEAR,[3223857,2105376],[1,1],[0,255],this.matrix,SpreadMethod.PAD);
         graphics.drawRect(0,-1,this.WIDTH,this.HEIGHT);
         graphics.endFill();
         this.redraw(147);
      }
      
      private function getStateFromVolume() : Bitmap
      {
         var _loc1_:int = this.gripImage.x - 47;
         if(_loc1_ > 100)
         {
            _loc1_ = 100;
         }
         else if(_loc1_ < 0)
         {
            _loc1_ = 0;
         }
         var _loc2_:int = _loc1_ == 0?0:_loc1_ > 0 && _loc1_ < 50?1:2;
         Global.soundVolume = _loc1_;
         var _loc3_:BitmapData = new BitmapData(soundStateBMD.width / 3,soundStateBMD.height,true,0);
         _loc3_.copyPixels(soundStateBMD,new Rectangle(soundStateBMD.width / 3 * _loc2_,0,_loc3_.width,_loc3_.height),new Point());
         return new Bitmap(_loc3_);
      }
      
      private function redraw(param1:int) : void
      {
         this.gripImage.x = param1;
         if(this.stateImage != null)
         {
            removeChild(this.stateImage);
         }
         this.stateImage = this.getStateFromVolume();
         this.stateImage.y = Math.round((this.HEIGHT - this.stateImage.height) / 2) - 1;
         this.stateImage.x = 16;
         addChild(this.stateImage);
      }
   }
}
