package ui
{
   import blitter.Bl;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import playerio.Message;
   
   public class LobbyLoginBox extends LobbyLoginBox_Asset
   {
       
      
      private var base:EverybodyEdits;
      
      private var profileVisible:Boolean;
      
      public function LobbyLoginBox(param1:EverybodyEdits)
      {
         var base:EverybodyEdits = param1;
         super();
         this.base = base;
         login_btn.addEventListener(MouseEvent.MOUSE_DOWN,function():void
         {
            base.showMainLogin();
         });
      }
      
      private function handleRequestCallback(param1:Boolean) : void
      {
         this.profileVisible = param1;
         if(param1)
         {
            profilestate.htmlText = "Profile is <u><a href=\'event:blank\'>public</a></u>";
         }
         else
         {
            profilestate.htmlText = "Profile is <u><a href=\'event:blank\'>private</a></u>";
         }
      }
      
      public function ShowLogout() : void
      {
         var self:LobbyLoginBox = null;
         gotoAndStop(2);
         this.base.requestRemoteMethod("getProfile",function(param1:Message):void
         {
            handleRequestCallback(param1.getBoolean(0));
         });
         profilestate.addEventListener(MouseEvent.MOUSE_DOWN,function():void
         {
            base.requestRemoteMethod("toggleProfile",function(param1:Message):void
            {
               handleRequestCallback(param1.getBoolean(0));
            },!profileVisible);
         });
         logininfo.htmlText = "Logged in as " + "<u><a href=\'event:" + Global.playerObject.name + "\'>" + Global.playerObject.name + "</a></u>";
         logininfo.addEventListener(TextEvent.LINK,this.handleLinkClicked,false,0,true);
         self = this;
         logout_btn.addEventListener(MouseEvent.MOUSE_DOWN,function():void
         {
            self.parent.removeChild(self);
            base.logout();
         });
         if(Global.playing_on_armorgames || Global.playing_on_faceboook || Bl.data.iskongregate || Global.playing_on_mousebreaker)
         {
            logout_btn.visible = false;
         }
      }
      
      protected function handleLinkClicked(param1:TextEvent) : void
      {
         var _loc2_:NavigationEvent = new NavigationEvent(NavigationEvent.SHOW_PROFILE,true);
         _loc2_.username = param1.text;
         dispatchEvent(_loc2_);
      }
   }
}
