package states
{
   import blitter.BlState;
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   
   public class LoadState extends BlState
   {
       
      
      private var loadingscreen:Class;
      
      protected var bmdata:BitmapData;
      
      protected var color:Number = 0;
      
      protected var modifier:Number = 0.05;
      
      protected var callback:Function;
      
      protected var timer:int = 0;
      
      public function LoadState()
      {
         this.loadingscreen = LoadState_loadingscreen;
         this.bmdata = new this.loadingscreen().bitmapData;
         super();
         Global.stage.frameRate = 60;
      }
      
      override public function enterFrame() : void
      {
         this.timer++;
         super.enterFrame();
      }
      
      override public function draw(param1:BitmapData, param2:int, param3:int) : void
      {
         this.color = this.color + this.modifier;
         if(this.color > 1)
         {
            this.color = 1;
         }
         param1.copyPixels(this.bmdata,this.bmdata.rect,new Point(0,0));
         param1.colorTransform(param1.rect,new ColorTransform(1,1,1,this.color));
         if(this.color < 0 && this.callback != null)
         {
            this.callback();
            this.callback = null;
         }
         super.draw(param1,param2,param3);
      }
      
      public function fadeOut(param1:Function) : void
      {
         this.color = 1;
         this.modifier = -0.05;
         this.callback = param1;
      }
   }
}
