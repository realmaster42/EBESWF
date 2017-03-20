package ui.tutorial
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import states.LobbyState;
   import ui.ConfirmPrompt;
   
   public class Buttons extends assets_tutorialbuttons
   {
       
      
      private var okCallback:Function;
      
      private var nextCallback:Function;
      
      private var skipCallback:Function;
      
      public function Buttons(param1:int, param2:Function = null, param3:Function = null, param4:Function = null)
      {
         var _loc6_:MovieClip = null;
         super();
         gotoAndStop(param1);
         if(param2 != null)
         {
            this.okCallback = param2;
         }
         if(param3 != null)
         {
            this.nextCallback = param3;
         }
         if(param4 != null)
         {
            this.skipCallback = param4;
         }
         var _loc5_:int = 0;
         while(_loc5_ < numChildren)
         {
            _loc6_ = getChildAt(_loc5_) as MovieClip;
            _loc6_.buttonMode = true;
            _loc6_.useHandCursor = true;
            _loc6_.mouseChildren = false;
            _loc6_.gotoAndStop(1);
            _loc6_.addEventListener(MouseEvent.CLICK,this.handleMouseClick);
            _loc6_.addEventListener(MouseEvent.MOUSE_OVER,this.handleMouse);
            _loc6_.addEventListener(MouseEvent.MOUSE_OUT,this.handleMouse);
            _loc5_++;
         }
      }
      
      protected function handleMouseClick(param1:MouseEvent) : void
      {
         var prompt:ConfirmPrompt = null;
         var e:MouseEvent = param1;
         var btn:MovieClip = e.target as MovieClip;
         switch(btn.name)
         {
            case "okButton":
               if(this.okCallback != null)
               {
                  this.okCallback();
               }
               break;
            case "nextButton":
               if(this.nextCallback != null)
               {
                  this.nextCallback();
               }
               break;
            case "skipButton":
               if(this.skipCallback != null)
               {
                  this.skipCallback();
               }
               break;
            case "cancelButton":
               prompt = new ConfirmPrompt("Are you sure you want to quit the tutorial?",false);
               prompt.ben_yes.addEventListener(MouseEvent.CLICK,function(param1:MouseEvent):void
               {
                  prompt.close();
                  Global.base.hideTutorial();
                  if((Global.base.state as LobbyState).roomlist.joiningDisabled == true)
                  {
                     (Global.base.state as LobbyState).roomlist.enableJoining();
                  }
               });
               Global.base.showConfirmPrompt(prompt);
               break;
            case "closeButton":
               Global.base.hideTutorial();
         }
      }
      
      protected function handleMouse(param1:MouseEvent) : void
      {
         if(param1.type == MouseEvent.MOUSE_OVER)
         {
            if((param1.target as MovieClip).currentFrame == 1)
            {
               (param1.target as MovieClip).gotoAndStop(2);
            }
         }
         if(param1.type == MouseEvent.MOUSE_OUT)
         {
            if((param1.target as MovieClip).currentFrame == 2)
            {
               (param1.target as MovieClip).gotoAndStop(1);
            }
         }
      }
   }
}
