package ui.ingame.pam
{
   import blitter.BlText;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import playerio.Connection;
   import states.PlayState;
   import ui.BadgeInstance;
   
   public class PlayerActionsMenu extends Sprite
   {
       
      
      private var w:Number = 150;
      
      private var numButtons:int = 0;
      
      public var closed:Boolean = false;
      
      public var targetPlayer:Player;
      
      public var me:Player;
      
      public var playState:PlayState;
      
      public var connection:Connection;
      
      public function PlayerActionsMenu(param1:String, param2:String, param3:Connection)
      {
         var username:String = param1;
         var userId:String = param2;
         var connection:Connection = param3;
         super();
         this.playState = Global.base.state as PlayState;
         this.me = this.playState.getPlayer();
         if(this.me.name == username)
         {
            this.targetPlayer = this.me;
         }
         else
         {
            this.targetPlayer = this.playState.getPlayers()[userId];
         }
         this.connection = connection;
         this.initializeUI();
         this.initializeButtons();
         var h:int = 100 + this.numButtons * 22;
         graphics.beginFill(8026746,0.75);
         graphics.drawRect(0,0,this.w,h);
         graphics.beginFill(0,0.75);
         graphics.drawRect(1,1,this.w - 2,h - 2);
         addEventListener(MouseEvent.CLICK,function(param1:MouseEvent):void
         {
            param1.preventDefault();
            param1.stopPropagation();
         });
      }
      
      private function initializeUI() : void
      {
         var _loc2_:Bitmap = null;
         var _loc3_:BadgeInstance = null;
         var _loc1_:BlText = new BlText(14,this.w - 4,Player.getProfileColor(this.targetPlayer.name),"center","visitor");
         _loc1_.text = this.targetPlayer.name + "\n" + this.getRank(this.targetPlayer.name);
         _loc2_ = new Bitmap(_loc1_.clone());
         _loc2_.x = 2;
         _loc2_.y = 8;
         addChild(_loc2_);
         _loc3_ = Badges.getBadge(this.targetPlayer.badge) || new BadgeInstance();
         _loc3_.x = 43;
         _loc3_.y = 33;
         addChild(_loc3_);
      }
      
      private function getRank(param1:String) : String
      {
         if(Player.isAdmin(param1))
         {
            return "Administrator";
         }
         if(Player.isModerator(param1))
         {
            return "Moderator";
         }
         if(Player.isDev(param1))
         {
            return "Developer";
         }
         if(Global.worldOwner == param1)
         {
            return "World Owner";
         }
         if(this.targetPlayer.isCrewMember)
         {
            return "Crew member";
         }
         return "";
      }
      
      private function initializeButtons() : void
      {
         this.addButton(new SpectatePAMButton(this.w,this));
         this.addButton(new ShowProfilePAMButton(this.w,this));
         this.addButton(new ToggleEditPAMButton(this.w,this));
         this.addButton(new ToggleGodPAMButton(this.w,this));
         this.addButton(new MutePAMButton(this.w,this));
         this.addButton(new KickPAMButton(this.w,this));
         this.addButton(new BanPAMButton(this.w,this));
         this.addButton(new ReportPAMButton(this.w,this));
         this.addButton(new PAMButton(this.w,this));
      }
      
      public function close(param1:MouseEvent = null) : void
      {
         if(parent != null)
         {
            parent.removeChild(this);
         }
         this.closed = true;
      }
      
      private function addButton(param1:PAMButton) : void
      {
         if(!param1.active)
         {
            return;
         }
         param1.x = 1;
         param1.y = 101 + this.numButtons * 22;
         addChild(param1);
         this.numButtons++;
      }
   }
}
