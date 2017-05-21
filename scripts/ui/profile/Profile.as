package ui.profile
{
   import blitter.Bl;
   import data.SimpleProfileObject;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import input.KeyState;
   import items.ItemBrick;
   import items.ItemBrickPackage;
   import items.ItemManager;
   import items.ItemSmiley;
   import playerio.Achievement;
   import playerio.Client;
   import playerio.DatabaseObject;
   import playerio.Message;
   import playerio.PlayerIO;
   import sample.ui.components.Box;
   import sample.ui.components.Label;
   import sample.ui.components.Rows;
   import sample.ui.components.scroll.ScrollBox;
   import ui.profile.Information.BetaInformation;
   import ui.profile.Information.GoldInformation;
   
   public class Profile extends Sprite
   {
      
      private static var Arrows:Class = Profile_Arrows;
      
      public static var arrowsBMD:BitmapData = new Arrows().bitmapData;
      
      public static var MODE_STANDALONE:String = "standalone";
      
      public static var MODE_INGAME:String = "ingame";
       
      
      private var maxPages:int = 5;
      
      private var mode:String;
      
      private var base:Box;
      
      private var content:Box;
      
      private var player_badges:Rows;
      
      private var player_items:Rows;
      
      private var player_levels:Rows;
      
      private var smilies:FillBox;
      
      private var badges:FillBox;
      
      private var blocks:FillBox;
      
      private var worlds:FillBox;
      
      private var information:FillBox;
      
      private var crews:FillBox;
      
      private var button:ProfileCloseButton;
      
      private var closebutton:Box;
      
      private var username:String;
      
      private var loadingText:Box;
      
      private var blackBG:BlackBG;
      
      private var pageNumber:int = 0;
      
      private var itemsScroll:ScrollBox;
      
      private var viewSwitch:assets_profileviewswitch;
      
      private var rooms:Array;
      
      private var worldlist:Array;
      
      private var goldmember:Box;
      
      private var profileObject:SimpleProfileObject;
      
      public function Profile(param1:String, param2:String = "")
      {
         var username:String = param1;
         var mode:String = param2;
         this.base = new Box();
         this.content = new Box();
         this.player_badges = new Rows();
         this.player_items = new Rows();
         this.player_levels = new Rows();
         this.smilies = new FillBox(0);
         this.badges = new FillBox(0);
         this.blocks = new FillBox(2);
         this.worlds = new FillBox(2);
         this.information = new FillBox(22);
         this.crews = new FillBox(10);
         this.button = new ProfileCloseButton();
         this.loadingText = new Box();
         this.viewSwitch = new assets_profileviewswitch();
         this.rooms = [];
         this.worldlist = [];
         super();
         this.blackBG = new BlackBG();
         addChild(this.blackBG);
         if(mode == "")
         {
            mode = MODE_STANDALONE;
         }
         this.mode = mode;
         if(mode == MODE_INGAME)
         {
            this.button.addEventListener(MouseEvent.MOUSE_DOWN,this.handleCloseProfile,false,0,true);
            this.closebutton = new Box().margin(4,4,NaN,NaN).add(this.button);
            this.content.add(this.closebutton);
         }
         this.username = username;
         this.base.margin(10,0,0,0);
         this.base.add(new Box().fill(3355443,1,10).margin(5,5,5,5).add(this.content));
         var load:assets_loading = new assets_loading();
         this.loadingText.addChild(load);
         this.loadingText.x = this.loadingText.x - 100;
         this.loadingText.y = this.loadingText.y - 60;
         this.content.margin(0,0,0,0);
         addChild(this.base);
         this.content.addChild(this.loadingText);
         this.addEventListener(MouseEvent.MOUSE_DOWN,function(param1:MouseEvent):void
         {
            param1.preventDefault();
            param1.stopImmediatePropagation();
            param1.stopPropagation();
         });
         this.base.filters = [new GlowFilter(0,1,6,6,1,10)];
         if(mode != MODE_INGAME)
         {
            Global.base.loadStoredCookie(function():void
            {
               if(Global.cookie.data.username && Global.cookie.data.password)
               {
                  PlayerIO.quickConnect.simpleConnect(Bl.stage,Config.playerio_game_id,Global.cookie.data.username,Global.cookie.data.password,function(param1:Client):void
                  {
                     initAfterAuth(param1);
                  });
               }
               else
               {
                  Global.base.authenticateAsGuest(function(param1:Client):void
                  {
                     initAfterAuth(param1);
                  });
               }
            });
         }
         else if(!Badges.loaded)
         {
            this.init();
         }
         else
         {
            Global.base.requestRemoteMethod("getProfileObject",this.handleProfileObject,username);
         }
         addEventListener(Event.ADDED_TO_STAGE,this.handleAttach);
         this.x = this.x + 10;
         this.y = this.y + 5;
      }
      
      private function initAfterAuth(param1:Client) : void
      {
         Global.base.client = param1;
         Global.client = param1;
         if(Config.use_debug_server)
         {
            param1.multiplayer.developmentServer = Config.developer_server;
         }
         this.init();
      }
      
      private function init() : void
      {
         Badges.refresh(function():void
         {
            Global.client.bigDB.load("Config","staff",function(param1:DatabaseObject):void
            {
               Bl.StaffObject = param1;
               Global.base.requestRemoteMethod("getProfileObject",handleProfileObject,username);
            });
         });
      }
      
      private function handleProfileObject(param1:Message) : void
      {
         this.profileObject = new SimpleProfileObject();
         var _loc2_:int = 0;
         this.profileObject.status = param1.getString(_loc2_++);
         if(this.profileObject.status == "public")
         {
            this.profileObject.key = param1.getString(_loc2_++);
            this.profileObject.name = param1.getString(_loc2_++);
            this.profileObject.oldname = param1.getString(_loc2_++);
            this.profileObject.smiley = param1.getInt(_loc2_++);
            this.profileObject.maxEnergy = param1.getInt(_loc2_++);
            this.profileObject.isOldBeta = param1.getBoolean(_loc2_++);
            this.profileObject.isAdministrator = param1.getBoolean(_loc2_++);
            this.profileObject.goldmember = param1.getBoolean(_loc2_++);
            this.profileObject.goldremain = param1.getNumber(_loc2_++);
            this.profileObject.goldtime = param1.getNumber(_loc2_++);
            this.profileObject.gold_join = param1.getNumber(_loc2_++);
            this.profileObject.gold_expire = param1.getNumber(_loc2_++);
            this.profileObject.room0 = param1.getString(_loc2_) != ""?param1.getString(_loc2_):null;
            _loc2_++;
            this.profileObject.betaonlyroom = param1.getString(_loc2_) != ""?param1.getString(_loc2_):null;
            _loc2_++;
            this.profileObject.setRooms(param1.getString(_loc2_++).split(","),param1.getString(_loc2_++).split(","),param1.getString(_loc2_++).split(","));
         }
         this.showProfile();
      }
      
      private function showProfile() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:Label = null;
         var _loc3_:Box = null;
         var _loc4_:Box = null;
         var _loc5_:Box = null;
         var _loc6_:Box = null;
         var _loc7_:Box = null;
         var _loc8_:Box = null;
         var _loc9_:Label = null;
         var _loc10_:Box = null;
         var _loc11_:ScrollBox = null;
         var _loc12_:Box = null;
         var _loc13_:String = null;
         var _loc14_:uint = 0;
         var _loc15_:Label = null;
         var _loc16_:Label = null;
         var _loc17_:Box = null;
         this.content.removeChild(this.loadingText);
         if(this.profileObject.status == "private")
         {
            this.content.addChild(new Box().add(new Label(this.username.toUpperCase() + "\'s profile is private!",15,"center",16720418,false,"system")));
            this.base.height++;
            this.handleResize();
            if(this.mode == MODE_INGAME)
            {
               if(this.content.contains(this.closebutton))
               {
                  this.content.removeChild(this.closebutton);
                  this.content.add(this.closebutton);
               }
            }
         }
         else if(this.profileObject.status == "error")
         {
            this.content.addChild(new Box().add(new Label("Player not found!",15,"center",16720418,false,"system")));
            this.base.height++;
            this.handleResize();
            if(this.mode == MODE_INGAME && this.content.contains(this.closebutton))
            {
               this.content.removeChild(this.closebutton);
               this.content.add(this.closebutton);
            }
         }
         else
         {
            _loc1_ = this.profileObject.isAdministrator || this.profileObject.isModerator || Player.isDev(this.profileObject.name);
            _loc2_ = new Label(this.profileObject.name.toUpperCase(),25,"center",Player.getNameColor(this.profileObject.name),false,"system");
            this.content.add(new Box().margin(!!_loc1_?Number(5):Number(10),0,0,0).add(_loc2_));
            if(_loc1_)
            {
               _loc13_ = !!Player.isDev(this.profileObject.name)?"Developer":!!this.profileObject.isModerator?"Moderator":!!this.profileObject.isAdministrator?"Administrator":"";
               _loc14_ = !!Player.isDev(this.profileObject.name)?uint(Config.dev_color):!!this.profileObject.isModerator?uint(Config.moderator_color):!!this.profileObject.isAdministrator?uint(Config.admin_color):uint(0);
               this.content.add(new Box().margin(35,0,0,0).add(new Label("Every Build Exists " + _loc13_ + "!",12,"center",_loc14_,false,"system")));
            }
            if(this.profileObject.oldname != "")
            {
               _loc15_ = new Label("Previously known as: " + this.profileObject.oldname.toUpperCase(),12,"left",16777215,false,"system");
               this.content.add(new Box().margin(5,0,0,0).add(_loc15_));
            }
            _loc3_ = new Box().margin(60,0,0,350);
            _loc4_ = new Box();
            _loc4_.fill(1118481,1,10).margin(3,3,3,3);
            this.viewSwitch.tf_text.text = "Worlds";
            this.viewSwitch.btn_left.visible = false;
            this.viewSwitch.btn_right.visible = false;
            _loc4_.add(new Box().margin(0,NaN,NaN,NaN).add(this.viewSwitch));
            _loc3_.add(_loc4_);
            _loc5_ = new Box().margin(85,0,0,350);
            this.itemsScroll = new ScrollBox().margin(3,3,3,3);
            this.itemsScroll.scrollMultiplier = 6;
            this.itemsScroll.add(new Box().margin(0,0,0,15).add(this.player_items));
            this.player_items.spacing(3);
            this.setItemsPage(0);
            _loc6_ = new Box();
            _loc6_.fill(1118481,1,10).margin(3,3,3,3);
            _loc6_.add(this.itemsScroll);
            _loc5_.add(_loc6_);
            this.content.add(_loc3_);
            this.content.add(_loc5_);
            _loc7_ = new Box().margin(60,_loc6_.width,0,0);
            _loc8_ = new Box();
            _loc8_.fill(1118481,1,10).margin(3,3,3,3);
            _loc9_ = new Label("Badges",15,"center",16777215,false,"system");
            _loc8_.add(_loc9_);
            _loc7_.add(_loc8_);
            _loc10_ = new Box().margin(85,_loc6_.width,0,0);
            _loc11_ = new ScrollBox().margin(3,3,3,3);
            _loc11_.scrollMultiplier = 6;
            _loc11_.add(new Box().margin(0,0,0,10).add(this.player_badges));
            this.player_badges.addChild(this.badges);
            _loc12_ = new Box();
            _loc12_.fill(1118481,1,10).margin(3,3,3,3);
            _loc12_.add(_loc11_);
            _loc10_.add(_loc12_);
            this.content.add(_loc7_);
            this.content.add(_loc10_);
            if(this.mode == MODE_INGAME)
            {
               _loc16_ = new Label("",10,"left",16777215,false,"system");
               _loc16_.htmlText = "<u>Show on homepage</u>";
               _loc16_.mouseEnabled = false;
               _loc17_ = new Box().margin(40,0,NaN,NaN).add(_loc16_);
               _loc17_.mouseEnabled = true;
               _loc17_.buttonMode = true;
               _loc17_.addEventListener(MouseEvent.MOUSE_DOWN,this.handleShowProfilePage,false,0,true);
               this.content.add(_loc17_);
               if(this.content.contains(this.closebutton))
               {
                  this.content.removeChild(this.closebutton);
                  this.content.add(this.closebutton);
               }
            }
            PlayerIO.authenticate(Global.stage,Config.playerio_game_id,"watch",{"userId":this.profileObject.key},null,this.handleLoadComplete,this.handleError);
            this.rooms = this.rooms.concat(this.profileObject.roomids);
            if(this.profileObject.room0)
            {
               this.rooms.push(this.profileObject.room0);
            }
            if(this.profileObject.betaonlyroom)
            {
               this.rooms.push(this.profileObject.betaonlyroom);
            }
            this.loadNextLevel(Global.base.client);
         }
      }
      
      private function addArrows() : void
      {
         this.viewSwitch.btn_left.visible = true;
         this.viewSwitch.btn_left.addEventListener(MouseEvent.CLICK,function():void
         {
            switchPage(-1);
         });
         this.viewSwitch.btn_right.visible = true;
         this.viewSwitch.btn_right.addEventListener(MouseEvent.CLICK,function():void
         {
            switchPage(1);
         });
      }
      
      private function switchPage(param1:int) : void
      {
         this.pageNumber = this.pageNumber + param1;
         if(param1 < 0 && this.pageNumber < 0)
         {
            this.pageNumber = this.maxPages - 1;
         }
         if(param1 > 0 && this.pageNumber >= this.maxPages)
         {
            this.pageNumber = 0;
         }
         this.setItemsPage(this.pageNumber);
      }
      
      private function setItemsPage(param1:int) : void
      {
         if(this.player_items.numChildren > 0)
         {
            this.player_items.removeAllChildren();
         }
         switch(param1)
         {
            case 0:
               if(!this.player_items.contains(this.worlds))
               {
                  this.viewSwitch.tf_text.text = "Worlds";
                  this.player_items.addChild(this.worlds);
               }
               break;
            case 1:
               if(!this.player_items.contains(this.smilies))
               {
                  this.viewSwitch.tf_text.text = "Smileys";
                  this.player_items.addChild(this.smilies);
               }
               break;
            case 2:
               if(!this.player_items.contains(this.blocks))
               {
                  this.viewSwitch.tf_text.text = "Blocks";
                  this.player_items.addChild(this.blocks);
               }
               break;
            case 3:
               if(!this.player_items.contains(this.information))
               {
                  this.viewSwitch.tf_text.text = "Information";
                  this.player_items.addChild(this.information);
               }
               break;
            case 4:
               if(!this.player_items.contains(this.crews))
               {
                  this.viewSwitch.tf_text.text = "Crews";
                  this.player_items.addChild(this.crews);
               }
         }
         this.itemsScroll.refresh();
      }
      
      protected function handleShowProfilePage(param1:MouseEvent) : void
      {
         navigateToURL(new URLRequest("http://everybodyedits.com/profiles/" + this.username),"_blank");
      }
      
      protected function handleCloseProfile(param1:MouseEvent) : void
      {
         parent.removeChild(this);
      }
      
      private function loadNextLevel(param1:Client) : void
      {
         var c:Client = param1;
         if(this.rooms.length == 0)
         {
            return;
         }
         var toload:String = this.rooms.pop();
         if(toload == "")
         {
            this.loadNextLevel(c);
            return;
         }
         c.bigDB.load("Worlds",toload,function(param1:DatabaseObject):void
         {
            renderWorld(param1);
            loadNextLevel(c);
         },this.handleError);
         this.handleResize();
      }
      
      private function renderWorld(param1:DatabaseObject) : void
      {
         var o:DatabaseObject = param1;
         if(o == null || o.blocks == null)
         {
            return;
         }
         if(o.hasOwnProperty("hidden") && o["hidden"])
         {
            return;
         }
         var pworld:ProfileWorld = new ProfileWorld(o,true,Global.playing_on_kongregate || Global.playing_on_armorgames || Global.playing_on_faceboook?Boolean(KeyState.isKeyDown(16)):!KeyState.isKeyDown(16),function():void
         {
            handleCloseProfile(null);
         });
         if(pworld.width >= 636)
         {
            pworld.width = 415;
         }
         this.worldlist.push(pworld);
         this.worldlist.sortOn(["plays"],Array.NUMERIC | Array.DESCENDING);
         var a:int = 0;
         while(a < this.worldlist.length)
         {
            this.worlds.addChild(this.worldlist[a]);
            a++;
         }
         this.base.height++;
         this.handleResize();
      }
      
      private function handleLoadComplete(param1:Client) : void
      {
         var c:Client = param1;
         c.payVault.refresh(function():void
         {
            c.achievements.refresh(function():void
            {
               renderItems(c);
               addArrows();
               Global.base.requestRemoteMethod("getCrews",function(param1:Message):void
               {
                  loadCrews(param1);
               },username);
            },handleError);
         },this.handleError);
         this.handleResize();
      }
      
      private function loadCrews(param1:Message) : void
      {
         if(param1.length == 0)
         {
            this.crews.addChild(new Label("This user is not in any crews.",12,"center",16777215,false,"system"));
            return;
         }
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            this.crews.addChild(new ProfileCrew(param1.getString(_loc2_),param1.getString(_loc2_ + 1),param1.getString(_loc2_ + 2),this.refreshItemsScroll));
            _loc2_ = _loc2_ + 3;
         }
      }
      
      private function refreshItemsScroll() : void
      {
         if(this.pageNumber == 4)
         {
            if(this.player_items.numChildren > 0)
            {
               this.player_items.removeAllChildren();
            }
            this.player_items.addChild(this.crews);
            this.itemsScroll.refresh();
         }
      }
      
      private function renderItems(param1:Client) : void
      {
         var _loc7_:GoldInformation = null;
         var _loc8_:BetaInformation = null;
         var _loc9_:ItemSmiley = null;
         var _loc10_:ItemBrickPackage = null;
         var _loc11_:Vector.<ItemBrick> = null;
         var _loc12_:int = 0;
         var _loc13_:ItemBrick = null;
         var _loc14_:int = 0;
         if(this.profileObject.goldmember)
         {
            _loc7_ = new GoldInformation(this.profileObject.name,Global.toPrettyDate(this.profileObject.goldexpire),Global.toPrettyDate(this.profileObject.goldjoin));
            this.information.addChild(_loc7_);
         }
         if(param1.payVault.has("pro"))
         {
            _loc8_ = new BetaInformation(this.profileObject.name);
            this.information.addChild(_loc8_);
         }
         this.information.x = Global.playing_on_kongregate || Global.playing_on_armorgames?Number(-25):Number(0);
         var _loc2_:Vector.<ItemSmiley> = ItemManager.smilies;
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc9_ = _loc2_[_loc3_];
            if(_loc9_.payvaultid == "" || param1.payVault.has(_loc9_.payvaultid) || _loc9_.payvaultid == "pro" && this.profileObject.isOldBeta || this.profileObject.goldmember && _loc9_.payvaultid == "goldmember")
            {
               this.smilies.addChild(new ProfileSmiley(_loc9_));
            }
            _loc3_++;
         }
         var _loc4_:Array = param1.achievements.myAchievements;
         var _loc5_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < _loc4_.length)
         {
            if((_loc4_[_loc3_] as Achievement).completed)
            {
               this.badges.addChild(new ProfileBadge(_loc4_[_loc3_]));
               _loc5_++;
            }
            _loc3_++;
         }
         if(_loc5_ == 0)
         {
            if(this.player_badges.contains(this.badges))
            {
               this.player_badges.removeChild(this.badges);
            }
            this.player_badges.addChild(new Label("This user doesn\'t have any badges.",12,"center",16777215,false,"system"));
         }
         var _loc6_:Vector.<ItemBrickPackage> = ItemManager.brickPackages;
         _loc3_ = 0;
         while(_loc3_ < _loc6_.length)
         {
            _loc10_ = _loc6_[_loc3_];
            _loc11_ = new Vector.<ItemBrick>();
            _loc12_ = 0;
            while(_loc12_ < _loc10_.bricks.length)
            {
               _loc13_ = _loc10_.bricks[_loc12_];
               if(!_loc13_.requiresAdmin)
               {
                  if(_loc13_.payvaultid == "" || param1.payVault.has(_loc13_.payvaultid) || _loc13_.payvaultid == "pro" && this.profileObject.isOldBeta || _loc13_.payvaultid == "goldmember" && this.profileObject.goldmember)
                  {
                     _loc14_ = 0;
                     while(_loc14_ < (param1.payVault.count(_loc13_.payvaultid) || 1))
                     {
                        _loc11_.push(_loc13_);
                        if(_loc13_.payvaultid != "brickdiamond")
                        {
                           break;
                        }
                        _loc14_++;
                     }
                  }
               }
               _loc12_++;
            }
            if(_loc11_.length)
            {
               this.blocks.addChild(new ProfileBrickPackage(_loc10_,_loc11_));
            }
            _loc3_++;
         }
         this.player_items.width++;
         this.base.height++;
         this.handleResize();
      }
      
      private function handleAttach(param1:Event) : void
      {
         stage.addEventListener(Event.RESIZE,this.handleResize);
         this.handleResize();
         x = this.mode == MODE_STANDALONE?Number(35):Number(10);
         y = 5;
      }
      
      private function handleRemove(param1:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.handleAttach);
         stage.removeEventListener(Event.RESIZE,this.handleResize);
      }
      
      private function handleError(param1:Error) : void
      {
      }
      
      private function handleResize(param1:Event = null) : void
      {
         if(stage != null)
         {
            this.base.x = 0;
            this.base.y = 0;
            this.base.width = Global.width - 20;
            this.base.height = Global.height - 20;
         }
      }
   }
}
