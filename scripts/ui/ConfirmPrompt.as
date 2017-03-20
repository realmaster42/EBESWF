package ui
{
   import com.greensock.TweenMax;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   
   public class ConfirmPrompt extends asset_confirmprompt
   {
       
      
      private var focusBase:Boolean;
      
      public function ConfirmPrompt(param1:String, param2:Boolean = true)
      {
         var text:String = param1;
         var focusBase:Boolean = param2;
         super();
         this.focusBase = focusBase;
         this.addEventListener(MouseEvent.MOUSE_DOWN,function(param1:MouseEvent):void
         {
            param1.preventDefault();
            param1.stopImmediatePropagation();
            param1.stopPropagation();
         });
         this.addEventListener(KeyboardEvent.KEY_DOWN,function(param1:KeyboardEvent):void
         {
            param1.preventDefault();
            param1.stopImmediatePropagation();
            param1.stopPropagation();
         });
         textbox.text = text;
         btn_no.addEventListener(MouseEvent.CLICK,this.close);
         closebtn.addEventListener(MouseEvent.CLICK,this.close);
      }
      
      public function close(param1:Event = null) : void
      {
         var e:Event = param1;
         var pm:ConfirmPrompt = this;
         TweenMax.to(pm,0.4,{
            "alpha":0,
            "onComplete":function(param1:ConfirmPrompt):void
            {
               if(param1 != null && param1.parent != null)
               {
                  if(stage && focusBase)
                  {
                     stage.focus = Global.base;
                  }
                  param1.parent.removeChild(param1);
               }
            },
            "onCompleteParams":[pm]
         });
      }
   }
}
