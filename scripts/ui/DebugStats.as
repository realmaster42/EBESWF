package ui
{
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.utils.getTimer;
   import states.PlayState;
   
   public class DebugStats extends TextField
   {
      
      private static const UPDATE_INTERVAL:Number = 1000;
       
      
      private var fontSize:Number;
      
      private var lastUpdate:Number;
      
      private var frameCount:Number;
      
      private var lastFps:Number = 0;
      
      private var state:PlayState;
      
      public function DebugStats(param1:PlayState, param2:Number = 16711680, param3:Number = 30)
      {
         super();
         this.textColor = param2;
         this.fontSize = param3;
         this.multiline = true;
         this.state = param1;
         autoSize = TextFieldAutoSize.LEFT;
         selectable = false;
         mouseEnabled = false;
         addEventListener(Event.ADDED_TO_STAGE,this.setFPSUpdate);
         addEventListener(Event.REMOVED_FROM_STAGE,this.clearFPSUpdate);
      }
      
      private function setFPSUpdate(param1:Event) : void
      {
         addEventListener(Event.ENTER_FRAME,this.updateFPS);
         this.frameCount = 0;
         this.lastUpdate = getTimer();
      }
      
      private function clearFPSUpdate(param1:Event) : void
      {
         removeEventListener(Event.ENTER_FRAME,this.updateFPS);
      }
      
      private function updateFPS(param1:Event) : void
      {
         var _loc2_:Number = getTimer();
         this.frameCount++;
         if(_loc2_ >= this.lastUpdate + UPDATE_INTERVAL)
         {
            this.lastUpdate = _loc2_;
            this.lastFps = this.frameCount;
            this.frameCount = 0;
         }
         this.updateText(this.lastFps);
      }
      
      private function updateText(param1:Number) : void
      {
         htmlText = "Debug version v" + Config.client_type_version + " (" + param1 + " fps)<br>" + "isFlying: " + this.state.player.isFlying + "<br>" + "X: " + Math.floor(this.state.player.x / 16) + "<br>" + "Y: " + Math.floor(this.state.player.y / 16) + "<br>" + "JumpCount: " + this.state.player.jumpCount + "<br>" + "speedX: " + this.state.player.speedX + "<br>" + "speedY: " + this.state.player.speedY + "<br>" + "moX: " + this.state.player.mox + "<br>" + "moY: " + this.state.player.moy + "<br>" + "flipGravity: " + this.state.player.flipGravity + "<br>" + "current_below: " + this.state.player.current_below + "<br>";
      }
   }
}
