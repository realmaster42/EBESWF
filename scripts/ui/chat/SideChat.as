package ui.chat
{
   import blitter.Bl;
   import com.greensock.TweenLite;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.text.TextFormat;
   import io.player.tools.Badwords;
   import playerio.Connection;
   import playerio.Message;
   import sample.ui.components.Label;
   import sample.ui.components.Rows;
   import sample.ui.components.scroll.ScrollBox;
   
   public class SideChat extends Sprite
   {
       
      
      protected var CHATBG:Class;
      
      private var ucontainer:Rows;
      
      private var userlist:ScrollBox;
      
      private var ccontainer:Rows;
      
      private var chatbox:ScrollBox;
      
      private var labelName:Label;
      
      private var labelBy:Label;
      
      private var bg:Sprite;
      
      private var returntolobbybtn:asset_return_to_lobby;
      
      private var loginbtn:asset_login_now;
      
      private var friendsonline:Boolean = false;
      
      private var guests:Object;
      
      private var plays:int = 0;
      
      private var favorites:int = 0;
      
      private var likes:int = 0;
      
      private var ownername:String;
      
      private var myname:String = "";
      
      private var chats:Array;
      
      private var users:Object;
      
      public var names:Object;
      
      private var staffJoined:Boolean;
      
      public function SideChat(param1:Connection)
      {
         var c:Connection = param1;
         this.CHATBG = SideChat_CHATBG;
         this.ucontainer = new Rows().spacing(0);
         this.ccontainer = new Rows().spacing(0);
         this.labelName = new Label("",20,"left",16777215,false,"visitor");
         this.labelBy = new Label("",12,"left",11184810,false,"visitor");
         this.bg = new Sprite();
         this.returntolobbybtn = new asset_return_to_lobby();
         this.loginbtn = new asset_login_now();
         this.guests = {};
         this.chats = [];
         this.users = {};
         this.names = {};
         super();
         this.returntolobbybtn.addEventListener(MouseEvent.CLICK,function():void
         {
            Global.base.ShowLobby();
         });
         this.loginbtn.addEventListener(MouseEvent.CLICK,function():void
         {
            Global.base.logout();
         });
         c.addMessageHandler("add",function(param1:Message, param2:int, param3:String, param4:String, param5:int, param6:Number, param7:Number, param8:Boolean, param9:Boolean, param10:Boolean, param11:int, param12:int, param13:int, param14:Boolean, param15:Boolean, param16:Boolean, param17:Boolean, param18:int, param19:int, param20:int, param21:uint):void
         {
            addUser(param2.toString(),param3,param10,param14,param15,param18,param21);
         });
         c.addMessageHandler("left",function(param1:Message, param2:int):void
         {
            removeUser(param2.toString());
         });
         c.addMessageHandler("updatemeta",function(param1:Message, param2:String, param3:String, param4:int, param5:int, param6:int):void
         {
            setMetaData(param2,param3,param4,param5,param6);
            Global.currentLevelname = param3;
         });
         c.addMessageHandler("say",function(param1:Message, param2:int, param3:String):void
         {
            if(param3.length > 0)
            {
               addChat(param2.toString(),param3);
            }
         });
         c.addMessageHandler("say_old",function(param1:Message, param2:String, param3:String, param4:Boolean, param5:uint):void
         {
            var _loc6_:uint = !!param4?uint(Config.friend_color_dark):uint(Config.default_color_dark);
            if(Player.isAdmin(param2))
            {
               _loc6_ = Config.admin_color;
            }
            if(Player.isModerator(param2))
            {
               _loc6_ = Config.moderator_color;
            }
            if(param5 != 0)
            {
               _loc6_ = param5;
            }
            addLine(param2,param3,_loc6_,true);
         });
         c.addMessageHandler("write",function(param1:Message, param2:String, param3:String):void
         {
            addLine(param2,param3,16777215);
         });
         this.bg.graphics.beginFill(0,1);
         this.bg.graphics.drawRect(0,0,100,500);
         this.bg.x = 3;
         addChild(this.bg);
         addChild(new this.CHATBG());
         this.userlist = new ScrollBox().margin(1,1,1,1).add(this.ucontainer);
         this.userlist.border(1,1118481,1);
         this.userlist.width = Global.width - 640 - 5;
         this.userlist.scrollMultiplier = 6;
         this.userlist.x = 3;
         this.userlist.y = 50;
         addChild(this.userlist);
         this.chatbox = new ScrollBox().margin(1,1,1,1).add(this.ccontainer);
         this.chatbox.x = 3;
         this.chatbox.y = 172;
         this.chatbox.scrollMultiplier = 6;
         this.chatbox.border(1,1118481,1);
         this.chatbox.height = Global.height - this.chatbox.y;
         addChild(this.chatbox);
         this.labelName.x = 3;
         this.labelName.y = 0;
         addChild(this.labelName);
         this.labelBy.x = 4;
         this.labelBy.y = 15;
         addChild(this.labelBy);
         addEventListener(Event.ADDED_TO_STAGE,this.handleAttach);
         addEventListener(Event.REMOVED_FROM_STAGE,this.handleRemove);
      }
      
      public function refresh() : void
      {
         if(this.userlist)
         {
            this.userlist.refresh();
         }
         if(this.chatbox)
         {
            this.chatbox.refresh();
         }
      }
      
      private function addSystemMessage(param1:String) : ChatEntry
      {
         return this.addLine("* SYSTEM",param1,16777215);
      }
      
      public function handleAttach(param1:Event) : void
      {
         stage.addEventListener(Event.RESIZE,this.handleResize);
         this.handleResize();
         if(Global.isFirstLogin && Global.roomid == Global.playerObject.homeworld)
         {
            TweenLite.delayedCall(3,this.addSystemMessage,["Welcome to your home world!"]);
            TweenLite.delayedCall(5,this.addSystemMessage,["Use the bottom bar to select what items you wish to place, then click where you want to draw!"]);
            TweenLite.delayedCall(10,this.addSystemMessage,["You can find more items in the items tab by clicking the \'More\' button."]);
            TweenLite.delayedCall(13,this.addSystemMessage,["Press the god mode button to fly around freely as you edit."]);
            TweenLite.delayedCall(16,this.addSystemMessage,["Check out \'Options\' to see other useful options."]);
         }
      }
      
      public function handleRemove(param1:Event) : void
      {
         stage.removeEventListener(Event.RESIZE,this.handleResize);
      }
      
      private function handleResize(param1:Event = null) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = Global.width;
         this.bg.width = _loc2_ - 640;
         this.userlist.width = _loc2_ - 640 - 5;
         this.userlist.height = 115;
         this.chatbox.width = _loc2_ - 640 - 5;
         if(Global.player_is_guest)
         {
            addChild(this.returntolobbybtn);
            addChild(this.loginbtn);
            _loc3_ = Math.min(Math.max(this.bg.width - 5,50),182.25);
            this.returntolobbybtn.width = _loc3_;
            this.returntolobbybtn.height = _loc3_ * 0.12;
            this.returntolobbybtn.x = 27;
            this.returntolobbybtn.y = 120 + 347 + 32 - this.returntolobbybtn.height;
            this.loginbtn.width = _loc3_;
            this.loginbtn.height = _loc3_ * 0.12;
            this.loginbtn.x = 27;
            this.loginbtn.y = 120 + 347 + 32 - this.returntolobbybtn.height - 2 - this.loginbtn.height;
            this.chatbox.height = this.chatbox.height - (this.returntolobbybtn.height + this.loginbtn.height + 10);
            this.clearChat();
            this.addLine("* SYSTEM","If you want to chat, you should register an account!",16777215,false);
         }
         else
         {
            if(this.returntolobbybtn && this.returntolobbybtn.parent)
            {
               this.returntolobbybtn.parent.removeChild(this.returntolobbybtn);
            }
            if(this.loginbtn && this.loginbtn.parent)
            {
               this.returntolobbybtn.parent.removeChild(this.loginbtn);
            }
         }
         this.redrawUserlist();
      }
      
      public function setMe(param1:String, param2:String, param3:Boolean, param4:int, param5:Boolean, param6:uint) : void
      {
         this.myname = param2;
         this.addUser(param1,param2,param3,false,param5,param4,param6);
         this.redrawUserlist();
      }
      
      public function addFavorite(param1:int = 1) : void
      {
         this.setMetaData(this.ownername,Bl.data.roomname,this.plays,this.favorites = this.favorites + param1,this.likes);
      }
      
      public function addLike(param1:int = 1) : void
      {
         this.setMetaData(this.ownername,Bl.data.roomname,this.plays,this.favorites,this.likes = this.likes + param1);
      }
      
      public function setMetaData(param1:String, param2:String, param3:int, param4:int, param5:int) : void
      {
         Global.setPath(Badwords.Filter(param2) + " | Everybody Edits");
         Bl.data.roomname = Badwords.Filter(param2);
         this.labelName.text = Badwords.Filter(param2);
         this.ownername = param1;
         this.plays = param3;
         this.favorites = param4;
         this.likes = param5;
         this.updateBy();
      }
      
      public function addChat(param1:String, param2:String) : void
      {
         var _loc3_:UserlistItem = this.users[param1] as UserlistItem;
         if(_loc3_)
         {
            this.addLine(_loc3_.username,param2,_loc3_.chatColor);
         }
      }
      
      public function addLine(param1:String, param2:String, param3:Number, param4:Boolean = false) : ChatEntry
      {
         var _loc10_:* = null;
         var _loc11_:Number = NaN;
         param2 = Badwords.Filter(param2);
         var _loc5_:Boolean = param2.search(new RegExp("\\b" + this.myname + "\\b","i")) != -1 || param1.substr(-5).toLowerCase() == "> you";
         var _loc6_:* = this.chatbox.scrollHeight - this.chatbox.scrollY < 50;
         var _loc7_:ChatEntry = new ChatEntry(param1,param2,!!_loc5_?Number(2236962):Number(0),param3,param4);
         this.ccontainer.addChild(_loc7_);
         var _loc8_:Boolean = Global.coloredUsernames;
         var _loc9_:TextFormat = new TextFormat(null,null,null,!_loc8_);
         for(_loc10_ in this.names)
         {
            if(_loc8_)
            {
               _loc9_.color = (this.names[_loc10_] as UserlistItem).darkChatColor;
            }
            _loc7_.highlightWords(new RegExp("\\b" + _loc10_ + "\\b","gi"),_loc9_);
         }
         if(this.ccontainer.numChildren > 80)
         {
            _loc11_ = this.chatbox.scrollHeight;
            this.ccontainer.removeChild(this.ccontainer.getChildAt(0));
            if(!_loc6_)
            {
               this.chatbox.refresh();
               this.chatbox.scrollY = this.chatbox.scrollY + (this.chatbox.scrollHeight - _loc11_);
            }
         }
         this.chatbox.refresh();
         if(_loc6_)
         {
            this.chatbox.scrollY = 100000;
         }
         return _loc7_;
      }
      
      public function clearChat() : void
      {
         this.ccontainer.removeAllChildren();
         this.chatbox.scrollY = 0;
      }
      
      public function addUser(param1:String, param2:String, param3:Boolean, param4:Boolean = false, param5:Boolean = false, param6:int = 0, param7:uint = 0) : void
      {
         var _loc8_:UserlistItem = null;
         var _loc9_:ChatEntry = null;
         if(this.names[param2] == null)
         {
            _loc8_ = new UserlistItem(param2,param3,param4,param5,param7);
            this.names[param2] = _loc8_;
            this.ucontainer.addChild(_loc8_);
            this.userlist.refresh();
            _loc8_.setUserId(param1);
            _loc8_.setTeam(param6);
            if(!this.staffJoined && (Player.isAdmin(param2) || Player.isModerator(param2)))
            {
               this.staffJoined = true;
               if(Global.player_is_guest)
               {
                  _loc9_ = this.addSystemMessage("You can pm admins or moderators by using /pm command.");
                  _loc9_.highlightWords(/\badmins\b/gi,new TextFormat(null,null,Config.admin_color,true));
                  _loc9_.highlightWords(/\bmoderators\b/gi,new TextFormat(null,null,Config.moderator_color,true));
               }
            }
         }
         this.users[param1] = this.names[param2];
         this.names[param2].count = this.names[param2].count + 1;
         this.redrawUserlist();
      }
      
      public function getUsers() : Object
      {
         var _loc2_:* = null;
         var _loc1_:Object = {};
         for(_loc2_ in this.names)
         {
            _loc1_[_loc2_.toUpperCase()] = true;
         }
         return _loc1_;
      }
      
      public function removeUser(param1:String) : void
      {
         if(this.users[param1])
         {
            if(--this.users[param1].count == 0)
            {
               delete this.names[this.users[param1].username];
               this.ucontainer.removeChild(this.users[param1]);
               this.userlist.refresh();
            }
            delete this.users[param1];
            this.redrawUserlist();
         }
      }
      
      private function toScoreFormat(param1:int) : String
      {
         var _loc2_:Array = param1.toString().split("");
         var _loc3_:int = 0;
         var _loc4_:int = _loc2_.length;
         while(_loc4_ >= 0)
         {
            if(_loc3_ > 0 && _loc4_ > 0 && _loc3_ % 3 == 0)
            {
               _loc2_.splice(_loc4_,0,["."]);
            }
            _loc3_++;
            _loc4_--;
         }
         return _loc2_.join("");
      }
      
      private function redrawUserlist() : void
      {
         var x:String = null;
         var item:UserlistItem = null;
         var tusers:Array = [];
         this.friendsonline = true;
         for(x in this.users)
         {
            item = this.users[x];
            this.friendsonline = this.friendsonline && item.isfriend;
            tusers.push(item);
         }
         while(this.ucontainer.numChildren > 0)
         {
            this.ucontainer.removeChild(this.ucontainer.getChildAt(0));
         }
         tusers.sort(function(param1:UserlistItem, param2:UserlistItem):Number
         {
            if(!param1.isfriend && param2.isfriend)
            {
               return 1;
            }
            if(param1.isfriend && !param2.isfriend)
            {
               return -1;
            }
            if(param1.isguest && !param2.isguest)
            {
               return 1;
            }
            if(!param1.isguest && param2.isguest)
            {
               return -1;
            }
            if(param1.canchat && !param2.canchat)
            {
               return -1;
            }
            if(!param1.canchat && param2.canchat)
            {
               return 1;
            }
            return param1.time < param2.time?Number(1):Number(-1);
         });
         var a:int = 0;
         while(a < tusers.length)
         {
            this.ucontainer.addChild(tusers[a]);
            a++;
         }
         this.updateBy();
         this.userlist.scrollY = this.userlist.scrollY;
      }
      
      public function updateBy() : void
      {
         var infostring:String = "plays: " + this.toScoreFormat(this.plays);
         infostring = infostring + ("\nfavorites: " + this.toScoreFormat(this.favorites));
         infostring = infostring + ("\nlikes: " + this.toScoreFormat(this.likes));
         var labelButton:Sprite = new Sprite();
         var label2Button:Sprite = new Sprite();
         if(this.ownername)
         {
            if(Global.currentLevelCrew == "")
            {
               this.labelBy.text = "By " + this.ownername + "\n" + infostring;
               this.labelBy.setTextFormat(new TextFormat(null,null,Player.getNameColor(this.ownername)),3,3 + this.ownername.length);
            }
            else
            {
               this.labelBy.text = "By " + Global.currentLevelCrewName + "\nHosted by " + this.ownername + "\n" + infostring;
               this.labelBy.setTextFormat(new TextFormat(null,null,16777215),3,3 + Global.currentLevelCrewName.length);
               this.labelBy.setTextFormat(new TextFormat(null,null,Player.getNameColor(this.ownername)),14 + Global.currentLevelCrewName.length,14 + Global.currentLevelCrewName.length + this.ownername.length);
            }
            labelButton.graphics.beginFill(16711935,0);
            labelButton.graphics.drawRect(0,0,this.labelBy.width,8);
            labelButton.x = this.labelBy.x;
            labelButton.y = this.labelBy.y;
            if(Global.currentLevelCrew != "")
            {
               label2Button.graphics.beginFill(16711935,0);
               label2Button.graphics.drawRect(0,0,this.labelBy.width,8);
               label2Button.x = this.labelBy.x;
               label2Button.y = this.labelBy.y + 9;
               addChild(label2Button);
            }
            labelButton.buttonMode = true;
            label2Button.buttonMode = true;
            addChild(labelButton);
         }
         else
         {
            this.labelBy.text = infostring;
         }
         this.userlist.y = this.labelBy.y + this.labelBy.height - 2;
         labelButton.addEventListener(MouseEvent.MOUSE_DOWN,function(param1:MouseEvent):void
         {
            var _loc2_:NavigationEvent = null;
            if(Global.currentLevelCrew == "")
            {
               if(Bl.shiftKey)
               {
                  navigateToURL(new URLRequest("http://everybodyedits.com/profiles/" + ownername),"_blank");
               }
               else
               {
                  _loc2_ = new NavigationEvent(NavigationEvent.SHOW_PROFILE,true);
                  _loc2_.username = ownername;
                  dispatchEvent(_loc2_);
               }
            }
            else if(Bl.shiftKey)
            {
               navigateToURL(new URLRequest("http://everybodyedits.com/crews/" + Global.currentLevelCrew),"_blank");
            }
            else
            {
               _loc2_ = new NavigationEvent(NavigationEvent.SHOW_CREW_PROFILE,true);
               _loc2_.crewname = Global.currentLevelCrew;
               dispatchEvent(_loc2_);
            }
         });
         label2Button.addEventListener(MouseEvent.MOUSE_DOWN,function(param1:MouseEvent):void
         {
            var _loc2_:NavigationEvent = null;
            if(Bl.shiftKey)
            {
               navigateToURL(new URLRequest("http://everybodyedits.com/profiles/" + ownername),"_blank");
            }
            else
            {
               _loc2_ = new NavigationEvent(NavigationEvent.SHOW_PROFILE,true);
               _loc2_.username = ownername;
               dispatchEvent(_loc2_);
            }
         });
      }
      
      public function toggleVisible(param1:Boolean) : void
      {
         visible = param1;
      }
   }
}
