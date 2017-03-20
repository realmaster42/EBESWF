package ui.roomlist
{
   import flash.events.MouseEvent;
   
   public class GuestRegisterForWorlds extends asset_registerforworlds
   {
       
      
      public function GuestRegisterForWorlds()
      {
         super();
         buttonMode = true;
         mouseChildren = false;
         addEventListener(MouseEvent.CLICK,this.handleClick,false,0,true);
      }
      
      protected function handleClick(param1:MouseEvent) : void
      {
         Global.base.showRegister();
      }
   }
}
