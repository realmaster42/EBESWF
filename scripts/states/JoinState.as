package states
{
   import blitter.BlState;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class JoinState extends BlState
   {
       
      
      protected var bg:Class;
      
      protected var background:BitmapData;
      
      public function JoinState()
      {
         this.bg = JoinState_bg;
         this.background = new this.bg().bitmapData;
         super();
      }
      
      override public function draw(param1:BitmapData, param2:int, param3:int) : void
      {
         param1.copyPixels(this.background,this.background.rect,new Point(0,0));
      }
   }
}
