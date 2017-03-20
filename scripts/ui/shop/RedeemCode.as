package ui.shop
{
   import com.greensock.TweenMax;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   
   public class RedeemCode extends assets_redeemcode
   {
       
      
      public function RedeemCode()
      {
         super();
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
         btnActivate.buttonMode = true;
         closebtn.addEventListener(MouseEvent.CLICK,this.close);
      }
      
      public function close(param1:Event = null) : void
      {
         var e:Event = param1;
         var pm:RedeemCode = this;
         TweenMax.to(pm,0.4,{
            "alpha":0,
            "onComplete":function(param1:RedeemCode):void
            {
               param1.parent.removeChild(param1);
            },
            "onCompleteParams":[pm]
         });
      }
   }
}
