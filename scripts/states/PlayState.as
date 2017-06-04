package states
{
   import animations.AnimatedSprite;
   import animations.AnimationManager;
   import blitter.Bl;
   import blitter.BlContainer;
   import blitter.BlSprite;
   import blitter.BlState;
   import blitter.BlText;
   import com.greensock.TweenMax;
   import com.greensock.easing.Quint;
   import flash.display.BitmapData;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.MouseEvent;
   import flash.events.SecurityErrorEvent;
   import flash.geom.Point;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   import items.ItemId;
   import items.ItemManager;
   import playerio.Connection;
   import playerio.Message;
   import sounds.SoundId;
   import sounds.SoundManager;
   import ui.BrickContainer;
   import ui.ConfirmPrompt;
   import ui.DebugStats;
   import ui.Tile;
   import ui.chat.UserlistItem;
   
   public class PlayState extends BlState
   {
      
      private static var DeathIcon:Class = PlayState_DeathIcon;
      
      private static var deathIconBMD:BitmapData = new DeathIcon().bitmapData;
       
      
      public var player:Player;
      
      public var world:World;
      
      public var debugStats:DebugStats;
      
      protected var connection:Connection;
      
      protected var players:Object;
      
      public var minimap:MiniMap;
      
      protected var totalCoins:int = 0;
      
      protected var bonusCoins:int = 0;
      
      protected var gravityMultiplier:Number = 1;
      
      protected var cointext:BlText;
      
      protected var cointextcontainer:BlContainer;
      
      protected var worldowner:String;
      
      protected var saidOver9000:Boolean = false;
      
      private var touchCooldown:int = 100;
      
      public var lastframe:BitmapData;
      
      private var spectatingText:BlText;
      
      private var stopSpectatingText:BlText;
      
      protected var particles:Array;
      
      protected var bcointext:BlText;
      
      protected var bcointextcontainer:BlContainer;
      
      protected var rw:int = 0;
      
      protected var rh:int = 0;
      
      protected var deathcounttext:BlText;
      
      protected var deathcountcontainer:BlContainer;
      
      protected var eraserLayerLock:int;
      
      private var queue:Array;
      
      private var tilequeue:Array;
      
      private var inEditArea:Boolean = false;
      
      private var showCoinGate:uint = 0;
      
      private var pastX:uint = 0;
      
      private var pastY:uint = 0;
      
      private var pastT:Number;
      
      private var chatTime:Number;
      
      private var starty:Number = 0;
      
      private var startx:Number = 0;
      
      private var endy:Number = 0;
      
      private var endx:Number = 0;
      
      private var fPid_:int = 1000000;
      
      private var lockPlacement:Boolean = false;
      
      private var _isPlayerSpectating:Boolean = false;
      
      public function PlayState(param1:Connection, param2:Message, param3:int, param4:String, param5:int, param6:int, param7:int, param8:Boolean, param9:int, param10:int, param11:uint, param12:String, param13:int, param14:int, param15:Number, param16:uint, param17:Boolean, param18:ByteArray)
      {
         var s:PlayState = null;
         var shadowDebug:Boolean = false;
         var history:Array = null;
         var info:Object = null;
         var c:Connection = param1;
         var m:Message = param2;
         var myid:int = param3;
         var name:String = param4;
         var face:int = param5;
         var aura:int = param6;
         var auraColor:int = param7;
         var smileyGoldBorder:Boolean = param8;
         var x:int = param9;
         var y:int = param10;
         var ChatColor:uint = param11;
         var badge:String = param12;
         var rw:int = param13;
         var rh:int = param14;
         var gravityMultiplier:Number = param15;
         var bgColor:uint = param16;
         var isCrewMember:Boolean = param17;
         var orangeSwitches:ByteArray = param18;
         this.players = {};
         this.cointextcontainer = new BlContainer();
         this.particles = [];
         this.bcointextcontainer = new BlContainer();
         this.deathcountcontainer = new BlContainer();
         this.queue = [];
         this.tilequeue = [];
         this.pastT = new Date().time;
         this.chatTime = new Date().time;
         super();
         if((Global.roomid.indexOf("PW") == 0 || Global.roomid.indexOf("BW") == 0) && !Config.disableCookie)
         {
            history = [];
            if(Global.cookie.data.history != null)
            {
               history = Global.cookie.data.history;
            }
            info = {
               "id":Global.roomid,
               "name":Global.currentLevelname,
               "time":new Date()
            };
            history.reverse();
            history.push(info);
            history.reverse();
            if(history.length > Global.historyLimit)
            {
               history = history.slice(0,Global.historyLimit);
            }
            Global.cookie.data.history = history;
            Global.cookie.flush();
         }
         if(Config.forceKongregate)
         {
            Config.maxwidth = Config.kongWidth;
            Global.playing_on_kongregate = true;
         }
         if(Config.forceArmorGames)
         {
            Config.maxwidth = Config.kongWidth;
            Global.playing_on_armorgames = true;
         }
         if(Config.forceFacebook)
         {
            Global.playing_on_faceboook = true;
         }
         this.rw = width;
         this.rh = height;
         this.connection = c;
         this.gravityMultiplier = gravityMultiplier;
         this.world = new World();
         this.world.deserializeFromMessage(rw,rh,m);
         this.world.setBackgroundColor(bgColor);
         add(this.world);
         this.world.orangeSwitches = {};
         var activeOrangeSwitches:Array = this.getIntArrayFromVarint(orangeSwitches);
         var i:int = 0;
         while(i < activeOrangeSwitches.length)
         {
            this.world.orangeSwitches[activeOrangeSwitches[i]] = true;
            i++;
         }
         this.totalCoins = this.world.getTypeCount(100);
         this.bonusCoins = this.world.getTypeCount(101);
         this.player = new Player(this.world,name,true,c,this);
         this.player.worldGravityMultiplier = gravityMultiplier;
         this.player.x = x;
         this.player.y = y;
         this.player.frame = face;
         this.player.aura = aura;
         this.player.auraColor = auraColor;
         this.player.isgoldmember = Global.playerObject.goldmember;
         if(ChatColor != 0)
         {
            this.player.nameColor = ChatColor;
         }
         this.player.wearsGoldSmiley = smileyGoldBorder;
         this.player.badge = badge;
         this.player.isCrewMember = isCrewMember;
         this.x = -x;
         this.y = -y;
         add(this.player);
         Global.playerInstance = this.player;
         this.world.setPlayer(this.player);
         target = this.player;
         if(Global.roomid == "PWhhGENdqja0I")
         {
            this.addFakePlayer(16,0,"mrvoid",-(13.2 * 16),-(9.2 * 16),false,true,false,Config.admin_color);
         }
         this.player.hitmap = this.world;
         this.minimap = new MiniMap(this.world,rw,rh);
         Global.myId = myid;
         this.cointext = new BlText(12,100,16777215,"right");
         this.cointext.x = 523;
         this.cointext.y = 20;
         this.cointextcontainer.add(this.cointext);
         this.bcointext = new BlText(12,100,16777215,"right");
         this.bcointext.x = 523;
         this.bcointext.y = 20;
         this.bcointextcontainer.add(this.bcointext);
         this.deathcounttext = new BlText(12,100,16777215,"right");
         this.deathcounttext.x = 523;
         this.deathcounttext.y = 20;
         this.deathcountcontainer.add(this.deathcounttext);
         this.spectatingText = new BlText(12,300,16777215,"center","system");
         this.spectatingText.x = 197;
         this.spectatingText.y = 4;
         this.stopSpectatingText = new BlText(12,300,16777215,"center","system");
         this.stopSpectatingText.x = 197;
         this.stopSpectatingText.y = 450;
         this.stopSpectatingText.text = "Click anywhere to stop spectating";
         var tcoin:BlSprite = BlSprite.createFromBitmapData(ItemManager.getBrickPackageByName("coins").bricks[0].bmd);
         tcoin.x = 626 - 4;
         tcoin.y = 24 - 3;
         this.cointextcontainer.add(tcoin);
         var btcoin:BlSprite = BlSprite.createFromBitmapData(ItemManager.getBrickPackageByName("coins").bricks[1].bmd);
         btcoin.x = 626 - 4;
         btcoin.y = 24 - 3;
         this.bcointextcontainer.add(btcoin);
         var skull:BlSprite = BlSprite.createFromBitmapData(deathIconBMD);
         skull.x = 626 - 2;
         skull.y = 24 - 3;
         this.deathcountcontainer.add(skull);
         s = this;
         shadowDebug = Config.enableDebugShadow;
         this.debugStats = new DebugStats(this,268435455,35);
         if(Config.run_in_development_mode)
         {
            Global.base.overlayContainer.addChild(this.debugStats);
         }
         this.connection.addMessageHandler("m",function(param1:Message, param2:int, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number, param9:Number, param10:Number, param11:Boolean, param12:Boolean):void
         {
            var _loc13_:Player = null;
            if(param2 != myid || shadowDebug)
            {
               _loc13_ = players[param2] as Player;
               if(!_loc13_ && shadowDebug)
               {
                  _loc13_ = new Player(world,"shadow",false,connection,s);
                  players[param2] = _loc13_;
                  addBefore(_loc13_,player);
               }
               if(_loc13_)
               {
                  _loc13_.x = param3;
                  _loc13_.y = param4;
                  _loc13_.speedX = param5;
                  _loc13_.speedY = param6;
                  _loc13_.modifierX = param7;
                  _loc13_.modifierY = param8;
                  _loc13_.horizontal = param9;
                  _loc13_.vertical = param10;
                  _loc13_.isDead = false;
                  _loc13_.spacedown = param11;
                  _loc13_.spacejustdown = param12;
                  if(_loc13_.hasLevitation)
                  {
                     if(param11)
                     {
                        _loc13_.applyThrust();
                        _loc13_.isThrusting = true;
                     }
                     else
                     {
                        _loc13_.isThrusting = false;
                     }
                  }
               }
            }
         });
         this.connection.addMessageHandler("add",function(param1:Message, param2:int, param3:String, param4:String, param5:int, param6:Number, param7:Number, param8:Boolean, param9:Boolean, param10:Boolean, param11:int, param12:int, param13:int, param14:Boolean, param15:Boolean, param16:Boolean, param17:Boolean, param18:int, param19:int, param20:int, param21:uint, param22:String, param23:Boolean, param24:ByteArray, param25:int, param26:Boolean = false, param27:Boolean = false):void
         {
            var _loc29_:* = false;
            var _loc30_:Number = NaN;
            var _loc31_:Array = null;
            var _loc32_:int = 0;
            var _loc28_:Player = players[param2] as Player;
            if(!_loc28_)
            {
               _loc28_ = new Player(world,param3,false,null,s);
               _loc28_.id = param2;
               players[param2] = _loc28_;
               _loc28_.isInGodMode = param8;
               _loc28_.isInAdminMode = param9;
               _loc28_.isInModeratorMode = param17;
               _loc28_.SetStaffAura(param25);
               _loc28_.worldGravityMultiplier = gravityMultiplier;
               _loc28_.x = Math.min(param6,(rw - 2) * 16);
               _loc28_.y = Math.min(param7,(rh - 2) * 16);
               _loc28_.frame = param5;
               _loc28_.aura = param19;
               _loc28_.auraColor = param20;
               _loc28_.coins = param11;
               _loc28_.bcoins = param12;
               _loc28_.deaths = param13;
               _loc28_.isgoldmember = param15;
               _loc28_.wearsGoldSmiley = param16;
               _loc28_.team = param18;
               _loc28_.canToggleGodMode = param27;
               _loc28_.render = Bl.data.showPlayer;
               _loc29_ = param3.indexOf("-") != -1;
               _loc30_ = 13421772;
               if(!param10)
               {
                  _loc30_ = 11184810;
               }
               if(_loc29_)
               {
                  _loc30_ = 6710886;
               }
               if(param14)
               {
                  _loc30_ = Config.friend_color;
               }
               if(Player.isAdmin(_loc28_.name))
               {
                  _loc30_ = Config.admin_color;
               }
               if(Player.isModerator(_loc28_.name))
               {
                  _loc30_ = Config.moderator_color;
               }
               if(param21 != 0)
               {
                  _loc30_ = param21;
               }
               _loc28_.nameColor = _loc30_;
               _loc28_.canEdit = param26;
               _loc28_.badge = param22;
               _loc28_.isCrewMember = param23;
               _loc28_.switches = {};
               _loc31_ = getIntArrayFromVarint(param24);
               _loc32_ = 0;
               while(_loc32_ < _loc31_.length)
               {
                  _loc28_.switches[_loc31_[_loc32_]] = true;
                  _loc32_++;
               }
               addBefore(_loc28_,player);
            }
         });
         this.connection.addMessageHandler("k",function(param1:Message, param2:int):void
         {
            var _loc3_:* = null;
            var _loc4_:Player = null;
            player.hascrown = param2 == myid;
            for(_loc3_ in players)
            {
               _loc4_ = players[_loc3_] as Player;
               _loc4_.hascrown = parseInt(_loc3_) == param2;
            }
            checkCrown(param2 == myid);
         });
         this.connection.addMessageHandler("ks",function(param1:Message, param2:int):void
         {
            var _loc3_:* = null;
            var _loc4_:Player = null;
            if(!player.hascrownsilver)
            {
               player.hascrownsilver = param2 == myid;
            }
            for(_loc3_ in players)
            {
               _loc4_ = players[_loc3_] as Player;
               if(!_loc4_.hascrownsilver)
               {
                  _loc4_.hascrownsilver = parseInt(_loc3_) == param2;
               }
            }
         });
         this.connection.addMessageHandler("c",function(param1:Message, param2:String, param3:int, param4:int):void
         {
            var _loc5_:Player = players[param2];
            if(_loc5_ != null)
            {
               _loc5_.coins = param3;
               _loc5_.bcoins = param4;
            }
         });
         this.connection.addMessageHandler("favorited",function(param1:Message):void
         {
            SoundManager.playMiscSound(SoundId.FAVORITE);
            doAnim(player,"favorite");
         });
         this.connection.addMessageHandler("liked",function(param1:Message):void
         {
            SoundManager.playMiscSound(SoundId.LIKE);
            doAnim(player,"like");
         });
         this.connection.addMessageHandler("unfavorited",function(param1:Message):void
         {
            SoundManager.playMiscSound(SoundId.UNFAVORITE);
         });
         this.connection.addMessageHandler("unliked",function(param1:Message):void
         {
            SoundManager.playMiscSound(SoundId.UNLIKE);
         });
         this.connection.addMessageHandler("magic",function(param1:Message):void
         {
            SoundManager.playMiscSound(SoundId.MAGIC);
         });
         this.connection.addMessageHandler("b",function(param1:Message, param2:int, param3:int, param4:int, param5:int, param6:int = -1):void
         {
            setTile(param2,param3,param4,param5,{});
            setBlockPlayerData(param3,param4,param2,param6);
         });
         this.connection.addMessageHandler("bc",function(param1:Message, param2:int, param3:int, param4:int, param5:int, param6:int = -1):void
         {
            setTile(0,param2,param3,param4,{"goal":param5});
            setBlockPlayerData(param2,param3,0,param6);
         });
         this.connection.addMessageHandler("pt",function(param1:Message, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int, param8:int = -1):void
         {
            setTile(0,param2,param3,param4,{
               "rotation":param5,
               "id":param6,
               "target":param7
            });
            setBlockPlayerData(param2,param3,0,param8);
         });
         this.connection.addMessageHandler("wp",function(param1:Message, param2:int, param3:int, param4:int, param5:String, param6:int = -1):void
         {
            setTile(0,param2,param3,param4,{"target":param5});
            setBlockPlayerData(param2,param3,0,param6);
         });
         this.connection.addMessageHandler("br",function(param1:Message, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int = -1):void
         {
            setTile(param6,param2,param3,param4,{"rotation":param5});
            setBlockPlayerData(param2,param3,param6,param7);
         });
         this.connection.addMessageHandler("lb",function(param1:Message, param2:int, param3:int, param4:int, param5:String, param6:String, param7:int = -1):void
         {
            setTile(0,param2,param3,param4,{
               "text":param5,
               "text_color":param6
            });
            setBlockPlayerData(param2,param3,0,param7);
         });
         this.connection.addMessageHandler("ts",function(param1:Message, param2:int, param3:int, param4:int, param5:String, param6:int, param7:int = -1):void
         {
            setTile(0,param2,param3,param4,{
               "text":param5,
               "signtype":param6
            });
            setBlockPlayerData(param2,param3,0,param7);
         });
         this.connection.addMessageHandler("bs",function(param1:Message, param2:int, param3:int, param4:int, param5:int, param6:int = -1):void
         {
            setTile(0,param2,param3,param4,{"sound":param5});
            setBlockPlayerData(param2,param3,0,param6);
         });
         this.connection.addMessageHandler("fill",function(param1:Message, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int):void
         {
            var _loc9_:int = 0;
            var _loc8_:int = param4;
            while(_loc8_ <= param6)
            {
               _loc9_ = param5;
               while(_loc9_ <= param6)
               {
                  setTile(param3,_loc8_,_loc9_,param2,{});
                  setBlockPlayerData(_loc8_,_loc9_,param3,-1);
                  _loc9_++;
               }
               _loc8_++;
            }
         });
         this.connection.addMessageHandler("left",function(param1:Message, param2:int):void
         {
            var _loc3_:Player = players[param2];
            if(_loc3_ != null)
            {
               if(_loc3_ == target)
               {
                  stopSpectating();
               }
               Global.base.ui2instance.hidePlayerActions(_loc3_.name);
               delete players[param2];
               remove(_loc3_);
            }
         });
         this.connection.addMessageHandler("god",function(param1:Message, param2:int, param3:Boolean):void
         {
            if(param2 == myid)
            {
               player.isInGodMode = param3;
               player.resetDeath();
               world.setShowAllSecrets(param3);
            }
            var _loc4_:Player = players[param2];
            if(_loc4_ != null)
            {
               _loc4_.isInGodMode = param3;
               _loc4_.resetDeath();
            }
         });
         this.connection.addMessageHandler("toggleGod",function(param1:Message, param2:int, param3:Boolean):void
         {
            var _loc4_:Player = null;
            if(param2 == myid)
            {
               player.canToggleGodMode = param3;
               if(!param3)
               {
                  player.isInGodMode = false;
               }
            }
            else
            {
               _loc4_ = players[param2];
               if(_loc4_ != null)
               {
                  _loc4_.canToggleGodMode = param3;
                  if(!param3)
                  {
                     _loc4_.isInGodMode = false;
                  }
               }
            }
         });
         this.connection.addMessageHandler("access",function(param1:Message):void
         {
            player.canEdit = true;
         });
         this.connection.addMessageHandler("lostaccess",function(param1:Message):void
         {
            if(!Bl.data.owner)
            {
               player.isInGodMode = false;
            }
            player.canEdit = false;
            player.canToggleGodMode = false;
         });
         this.connection.addMessageHandler("editRights",function(param1:Message, param2:int, param3:Boolean):void
         {
            var _loc4_:Player = players[param2] as Player;
            if(!_loc4_)
            {
               return;
            }
            _loc4_.canEdit = param3;
            if(!param3)
            {
               _loc4_.canToggleGodMode = false;
            }
         });
         this.connection.addMessageHandler("admin",function(param1:Message, param2:int, param3:Boolean, param4:int):void
         {
            if(param2 == myid)
            {
               player.SetStaffAura(param4);
               player.isInAdminMode = param3;
               player.resetDeath();
            }
            var _loc5_:Player = players[param2];
            if(_loc5_ != null)
            {
               _loc5_.SetStaffAura(param4);
               _loc5_.isInAdminMode = param3;
               _loc5_.resetDeath();
            }
         });
         this.connection.addMessageHandler("mod",function(param1:Message, param2:int, param3:Boolean, param4:int):void
         {
            if(param2 == myid)
            {
               player.SetStaffAura(param4);
               player.isInModeratorMode = param3;
               player.resetDeath();
            }
            var _loc5_:Player = players[param2];
            if(_loc5_ != null)
            {
               _loc5_.SetStaffAura(param4);
               _loc5_.isInModeratorMode = param3;
               _loc5_.resetDeath();
            }
         });
         this.connection.addMessageHandler("say",function(param1:Message, param2:int, param3:String):void
         {
            if(param2 == myid)
            {
               player.say(param3);
            }
            var _loc4_:Player = players[param2];
            if(_loc4_ != null)
            {
               _loc4_.say(param3);
            }
         });
         this.connection.addMessageHandler("autotext",function(param1:Message, param2:int, param3:String):void
         {
            if(param2 == myid)
            {
               player.say(param3);
            }
            var _loc4_:Player = players[param2];
            if(_loc4_ != null)
            {
               _loc4_.say(param3);
            }
         });
         this.connection.addMessageHandler("face",function(param1:Message, param2:int, param3:int):void
         {
            var _loc4_:Player = null;
            if(param2 == myid)
            {
               player.frame = param3;
            }
            else
            {
               _loc4_ = players[param2] as Player;
               if(_loc4_)
               {
                  _loc4_.frame = param3;
               }
            }
         });
         this.connection.addMessageHandler("aura",function(param1:Message, param2:int, param3:int, param4:int):void
         {
            var _loc5_:Player = null;
            if(param2 == myid)
            {
               player.aura = param3;
               player.auraColor = param4;
            }
            else
            {
               _loc5_ = players[param2] as Player;
               if(_loc5_)
               {
                  _loc5_.aura = param3;
                  _loc5_.auraColor = param4;
               }
            }
         });
         this.connection.addMessageHandler("smileyGoldBorder",function(param1:Message, param2:int, param3:Boolean):void
         {
            var _loc4_:Player = null;
            if(param2 == myid)
            {
               player.wearsGoldSmiley = param3;
               Global.base.ui2instance.smileyAuraMenu.updateAllSmileyBorders();
            }
            else
            {
               _loc4_ = players[param2] as Player;
               if(_loc4_)
               {
                  _loc4_.wearsGoldSmiley = param3;
               }
            }
         });
         this.connection.addMessageHandler("ps",function(param1:Message, param2:int, param3:int, param4:int, param5:Boolean):void
         {
            var _loc6_:Player = null;
            if(param2 != myid)
            {
               if(param3 == 0)
               {
                  _loc6_ = players[param2] as Player;
                  if(_loc6_ != null)
                  {
                     _loc6_.pressPurpleSwitch(param4,param5);
                  }
               }
               else if(param3 == 1)
               {
                  pressOrangeSwitch(param4,param5);
               }
            }
         });
         this.connection.addMessageHandler("hide",function(param1:Message):void
         {
            var _loc2_:int = 0;
            while(_loc2_ < param1.length)
            {
               switch(param1.getString(_loc2_))
               {
                  case "red":
                     showRed();
                     break;
                  case "green":
                     showGreen();
                     break;
                  case "blue":
                     showBlue();
                     break;
                  case "cyan":
                     showCyan();
                     break;
                  case "magenta":
                     showMagenta();
                     break;
                  case "yellow":
                     showYellow();
                     break;
                  case "timedoor":
                     showTimedoor();
               }
               _loc2_++;
            }
         });
         this.connection.addMessageHandler("show",function(param1:Message):void
         {
            var _loc2_:int = 0;
            while(_loc2_ < param1.length)
            {
               switch(param1.getString(_loc2_))
               {
                  case "red":
                     hideRed();
                     break;
                  case "green":
                     hideGreen();
                     break;
                  case "blue":
                     hideBlue();
                     break;
                  case "cyan":
                     hideCyan();
                     break;
                  case "magenta":
                     hideMagenta();
                     break;
                  case "yellow":
                     hideYellow();
                     break;
                  case "timedoor":
                     hideTimedoor();
               }
               _loc2_++;
            }
         });
         this.connection.addMessageHandler("reset",function(param1:Message):void
         {
            world.removeAllLabels();
            tilequeue = [];
            var _loc2_:Array = world.deserializeFromMessage(rw,rh,param1);
            world.setMapArray(_loc2_);
            world.lookup.resetSecrets();
            minimap.reset(world);
            _loc2_ = [];
            player.coins = 0;
            player.bcoins = 0;
            player.deaths = 0;
            player.flipGravity = 0;
            player.respawn();
            totalCoins = world.getTypeCount(100);
            bonusCoins = world.getTypeCount(101);
         });
         this.connection.addMessageHandler("clear",function(param1:Message, param2:int, param3:int, param4:int = 9, param5:int = 0):void
         {
            var _loc8_:int = 0;
            var _loc9_:int = 0;
            world.removeAllLabels();
            tilequeue = [];
            var _loc6_:Array = [];
            var _loc7_:int = 0;
            while(_loc7_ < 2)
            {
               _loc6_[_loc7_] = [];
               _loc8_ = 0;
               while(_loc8_ < param3)
               {
                  _loc6_[_loc7_][_loc8_] = [];
                  _loc9_ = 0;
                  while(_loc9_ < param2)
                  {
                     _loc6_[_loc7_][_loc8_][_loc9_] = param5;
                     _loc9_++;
                  }
                  _loc8_++;
               }
               _loc7_++;
            }
            _loc8_ = 0;
            while(_loc8_ < rh)
            {
               _loc6_[0][_loc8_][0] = param4;
               _loc6_[0][_loc8_][rw - 1] = param4;
               _loc8_++;
            }
            _loc8_ = 0;
            while(_loc8_ < rw)
            {
               _loc6_[0][0][_loc8_] = param4;
               _loc6_[0][rh - 1][_loc8_] = param4;
               _loc8_++;
            }
            totalCoins = 0;
            bonusCoins = 0;
            player.coins = 0;
            player.bcoins = 0;
            player.deaths = 0;
            world.setMapArray(_loc6_);
            minimap.reset(world);
            _loc6_ = [];
            world.lookup.reset();
            world.orangeSwitches = new ByteArray();
         });
         this.connection.addMessageHandler("resetGlobalSwitches",function():void
         {
            world.orangeSwitches = new ByteArray();
         });
         this.connection.addMessageHandler("refreshshop",function():void
         {
            Global.base.refresShop();
         });
         this.connection.addMessageHandler("tele",function(param1:Message):void
         {
            var _loc5_:int = 0;
            var _loc6_:int = 0;
            var _loc7_:int = 0;
            var _loc8_:int = 0;
            var _loc9_:Player = null;
            var _loc2_:Boolean = param1.getBoolean(0);
            var _loc3_:Boolean = param1.getBoolean(1);
            if(_loc3_)
            {
               world.orangeSwitches = new ByteArray();
            }
            var _loc4_:int = 2;
            while(_loc4_ < param1.length)
            {
               _loc5_ = param1.getInt(_loc4_);
               _loc6_ = param1.getInt(_loc4_ + 1);
               _loc7_ = param1.getInt(_loc4_ + 2);
               _loc8_ = param1.getInt(_loc4_ + 3);
               _loc9_ = players[_loc5_];
               if(_loc9_ != null)
               {
                  _loc9_.x = _loc6_;
                  _loc9_.y = _loc7_;
                  _loc9_.deaths = _loc8_;
                  _loc9_.respawn();
                  if(_loc2_)
                  {
                     _loc9_.hascrown = false;
                     _loc9_.hascrownsilver = false;
                     _loc9_.resetCoins();
                     _loc9_.switches = {};
                     _loc9_.resetCheckpoint();
                  }
               }
               if(_loc5_ == myid)
               {
                  if(!isPlayerSpectating)
                  {
                     offset(player.x - _loc6_,player.y - _loc7_);
                  }
                  player.x = _loc6_;
                  player.y = _loc7_;
                  player.deaths = _loc8_;
                  player.respawn();
                  if(_loc2_)
                  {
                     player.hascrown = false;
                     player.hascrownsilver = false;
                     player.resetCoins();
                     player.switches = {};
                     player.resetCheckpoint();
                     world.resetCoins();
                     world.lookup.resetSecrets();
                  }
               }
               _loc4_ = _loc4_ + 4;
            }
         });
         this.connection.addMessageHandler("kill",function(param1:Message, param2:int):void
         {
            var _loc3_:Player = null;
            var _loc4_:Player = null;
            try
            {
               _loc3_ = player;
               if(param2 == myid)
               {
                  _loc3_ = player;
               }
               else
               {
                  _loc4_ = players[param2] as Player;
                  _loc3_ = _loc4_;
               }
               if(!_loc3_.isInAdminMode && !_loc3_.isInGodMode && !_loc3_.isInModeratorMode)
               {
                  _loc3_.killPlayer();
               }
               return;
            }
            catch(ex:Error)
            {
               return;
            }
         });
         this.connection.addMessageHandler("teleport",function(param1:Message, param2:int, param3:Number, param4:Number):void
         {
            var _loc5_:Player = null;
            if(param2 == myid)
            {
               player.setPosition(param3,param4);
            }
            else
            {
               _loc5_ = players[param2] as Player;
               if(_loc5_)
               {
                  _loc5_.setPosition(param3,param4);
               }
            }
         });
         this.connection.addMessageHandler("backgroundColor",function(param1:Message, param2:uint):void
         {
            var _loc3_:* = false;
            var _loc4_:int = 0;
            if(Bl.data.canChangeWorldOptions)
            {
               _loc3_ = (param2 >> 24 & 255) == 255;
               Global.backgroundEnabled = _loc3_;
               Global.bgColor = param2;
               if(Global.base.ui2instance.settingsMenu.levelOptions != null)
               {
                  Global.base.ui2instance.settingsMenu.levelOptions.backgroundColorSelector.handleBackgroundChange(param1,param2);
               }
               else if(Global.cookie.data.previousColors.indexOf(param2) == -1)
               {
                  Global.cookie.data.previousColors.push(param2);
                  _loc4_ = 1;
                  while(_loc4_ < 5)
                  {
                     Global.cookie.data.previousColors[_loc4_] = Global.cookie.data.previousColors[_loc4_ + 1];
                     _loc4_++;
                  }
                  Global.cookie.data.previousColors.length = 4;
               }
            }
            world.setBackgroundColor(param2);
            minimap.reset(world);
         });
         this.connection.addMessageHandler("effect",function(param1:Message, param2:int, param3:int, param4:Boolean, param5:int = 0):void
         {
            var _loc6_:Player = null;
            if(param2 == myid)
            {
               player.setEffect(param3,param4,param5);
            }
            else
            {
               _loc6_ = players[param2] as Player;
               if(_loc6_)
               {
                  _loc6_.setEffect(param3,param4,param5);
               }
            }
         });
         this.connection.addMessageHandler("team",function(param1:Message, param2:int, param3:int):void
         {
            var _loc4_:Player = null;
            if(param2 == myid)
            {
               player.team = param3;
               (Global.base.sidechat.names[player.name] as UserlistItem).setTeam(param3);
            }
            else
            {
               _loc4_ = players[param2] as Player;
               if(_loc4_)
               {
                  _loc4_.team = param3;
                  (Global.base.sidechat.names[_loc4_.name] as UserlistItem).setTeam(param3);
               }
            }
         });
         this.connection.addMessageHandler("muted",function(param1:Message, param2:int, param3:Boolean):void
         {
            var _loc4_:Player = players[param2] as Player;
            if(_loc4_)
            {
               _loc4_.muted = param3;
            }
         });
         this.connection.addMessageHandler("badgeChange",function(param1:Message, param2:int, param3:String):void
         {
            var _loc4_:Player = null;
            if(param2 == myid)
            {
               player.badge = param3;
            }
            else
            {
               _loc4_ = players[param2] as Player;
               if(_loc4_)
               {
                  _loc4_.badge = param3;
               }
            }
         });
         this.connection.addMessageHandler("restoreProgress",function(param1:Message, param2:int, param3:Number, param4:Number, param5:int, param6:int, param7:ByteArray, param8:ByteArray, param9:ByteArray, param10:ByteArray, param11:int, param12:uint, param13:uint, param14:ByteArray, param15:Number, param16:Number):void
         {
            var _loc19_:Array = null;
            var _loc20_:int = 0;
            var _loc17_:* = param2 == myid;
            var _loc18_:Player = !!_loc17_?player:players[param2] as Player;
            if(_loc18_)
            {
               _loc18_.respawn();
               _loc18_.x = param3;
               _loc18_.y = param4;
               _loc18_.coins = param5;
               _loc18_.bcoins = param6;
               _loc18_.deaths = param11;
               _loc18_.checkpoint_x = param12;
               _loc18_.checkpoint_y = param13;
               _loc18_.switches = {};
               _loc19_ = getIntArrayFromVarint(param14);
               _loc20_ = 0;
               while(_loc20_ < _loc19_.length)
               {
                  _loc18_.switches[_loc19_[_loc20_]] = true;
                  _loc20_++;
               }
               _loc18_.speedX = param15;
               _loc18_.speedY = param16;
               if(_loc17_)
               {
                  if(!isPlayerSpectating)
                  {
                     offset(_loc18_.x - param3,_loc18_.y - param4);
                  }
                  restoreCoins(param7,param8,false);
                  restoreCoins(param9,param10,true);
               }
            }
         });
         this.connection.send("init2");
         Global.stage.frameRate = Config.maxFrameRate;
      }
      
      private function restoreCoins(param1:ByteArray, param2:ByteArray, param3:Boolean) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         param1.position = 0;
         param2.position = 0;
         while(param1.position < param1.length)
         {
            _loc4_ = (param1.readUnsignedByte() << 8) + param1.readUnsignedByte();
            _loc5_ = (param2.readUnsignedByte() << 8) + param2.readUnsignedByte();
            this.world.setTileComplex(0,_loc4_,_loc5_,!!param3?111:110,null);
         }
      }
      
      private function loadFile(param1:String, param2:Function) : void
      {
         var url:String = param1;
         var callback:Function = param2;
         var wrapper:Loader = new Loader();
         var loader:URLLoader = new URLLoader();
         loader.dataFormat = URLLoaderDataFormat.BINARY;
         loader.addEventListener(Event.COMPLETE,function(param1:Event):void
         {
            callback();
         });
         loader.addEventListener(IOErrorEvent.IO_ERROR,function(param1:IOErrorEvent):void
         {
         });
         loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,function(param1:SecurityErrorEvent):void
         {
         });
         loader.load(new URLRequest(url));
      }
      
      private function updateMinimap(param1:int, param2:int) : void
      {
         this.minimap.updatePixel(param1,param2,this.world.getMinimapColor(param1,param2));
      }
      
      public function hideRed() : void
      {
         this.world.hideRed = false;
         if(this.world.overlaps(this.player))
         {
            this.world.hideRed = true;
            this.queue.push(this.hideRed);
         }
      }
      
      public function hideGreen() : void
      {
         this.world.hideGreen = false;
         if(this.world.overlaps(this.player))
         {
            this.world.hideGreen = true;
            this.queue.push(this.hideGreen);
         }
      }
      
      public function hideBlue() : void
      {
         this.world.hideBlue = false;
         if(this.world.overlaps(this.player))
         {
            this.world.hideBlue = true;
            this.queue.push(this.hideBlue);
         }
      }
      
      public function hideCyan() : void
      {
         this.world.hideCyan = false;
         if(this.world.overlaps(this.player))
         {
            this.world.hideCyan = true;
            this.queue.push(this.hideCyan);
         }
      }
      
      public function hideMagenta() : void
      {
         this.world.hideMagenta = false;
         if(this.world.overlaps(this.player))
         {
            this.world.hideMagenta = true;
            this.queue.push(this.hideMagenta);
         }
      }
      
      public function hideYellow() : void
      {
         this.world.hideYellow = false;
         if(this.world.overlaps(this.player))
         {
            this.world.hideYellow = true;
            this.queue.push(this.hideYellow);
         }
      }
      
      public function hideTimedoor() : void
      {
         this.world.hideTimedoor = false;
      }
      
      public function pressOrangeSwitch(param1:int, param2:Boolean) : void
      {
         var switchId:int = param1;
         var enabled:Boolean = param2;
         this.world.orangeSwitches[switchId] = enabled;
         if(this.world.overlaps(this.player))
         {
            this.world.orangeSwitches[switchId] = !enabled;
            this.queue.push(function():void
            {
               pressOrangeSwitch(switchId,enabled);
            });
         }
      }
      
      public function checkCrown(param1:Boolean) : void
      {
         var collide:Boolean = param1;
         this.player.collideWithCrownDoorGate = collide;
         if(this.world.overlaps(this.player))
         {
            this.player.collideWithCrownDoorGate = !collide;
            this.queue.push(function():void
            {
               checkCrown(collide);
            });
         }
      }
      
      public function showRed() : void
      {
         this.world.hideRed = true;
         if(this.world.overlaps(this.player))
         {
            this.world.hideRed = false;
            this.queue.push(this.showRed);
         }
      }
      
      public function showGreen() : void
      {
         this.world.hideGreen = true;
         if(this.world.overlaps(this.player))
         {
            this.world.hideGreen = false;
            this.queue.push(this.showGreen);
         }
      }
      
      public function showBlue() : void
      {
         this.world.hideBlue = true;
         if(this.world.overlaps(this.player))
         {
            this.world.hideBlue = false;
            this.queue.push(this.showBlue);
         }
      }
      
      public function showCyan() : void
      {
         this.world.hideCyan = true;
         if(this.world.overlaps(this.player))
         {
            this.world.hideCyan = false;
            this.queue.push(this.showCyan);
         }
      }
      
      public function showMagenta() : void
      {
         this.world.hideMagenta = true;
         if(this.world.overlaps(this.player))
         {
            this.world.hideMagenta = false;
            this.queue.push(this.showMagenta);
         }
      }
      
      public function showYellow() : void
      {
         this.world.hideYellow = true;
         if(this.world.overlaps(this.player))
         {
            this.world.hideYellow = false;
            this.queue.push(this.showYellow);
         }
      }
      
      public function showTimedoor() : void
      {
         this.world.hideTimedoor = true;
      }
      
      public function checkPurple() : void
      {
         this.world.canShowOrHidePurple = true;
         if(this.world.overlaps(this.player))
         {
            this.world.canShowOrHidePurple = false;
         }
      }
      
      public function setTile(param1:int, param2:int, param3:int, param4:int, param5:Object) : void
      {
         var _loc16_:Tile = null;
         var _loc17_:Player = null;
         var _loc6_:int = 0;
         while(_loc6_ < this.tilequeue.length)
         {
            _loc16_ = this.tilequeue[_loc6_] as Tile;
            if((this.tilequeue[_loc6_] as Tile).equals(new Tile(param1,param2,param3,param4,param5)))
            {
               this.tilequeue.splice(_loc6_,1);
               _loc6_--;
            }
            _loc6_++;
         }
         var _loc7_:int = this.world.getTile(param1,param2,param3);
         if(_loc7_ == param4 && _loc7_ != ItemId.COINDOOR && _loc7_ != ItemId.COINGATE && _loc7_ != ItemId.BLUECOINDOOR && _loc7_ != ItemId.BLUECOINGATE && _loc7_ != ItemId.PORTAL && _loc7_ != 77 && _loc7_ != 83 && _loc7_ != 1520 && _loc7_ != 1000 && _loc7_ != ItemId.SPIKE && _loc7_ != ItemId.WORLD_PORTAL && _loc7_ != ItemId.PORTAL_INVISIBLE && _loc7_ != ItemId.SWITCH_PURPLE && _loc7_ != ItemId.DOOR_PURPLE && _loc7_ != ItemId.GATE_PURPLE && _loc7_ != ItemId.DEATH_DOOR && _loc7_ != ItemId.DEATH_GATE && _loc7_ != ItemId.EFFECT_TEAM && _loc7_ != ItemId.TEAM_DOOR && _loc7_ != ItemId.TEAM_GATE && _loc7_ != ItemId.EFFECT_CURSE && _loc7_ != ItemId.EFFECT_FLY && _loc7_ != ItemId.TEXT_SIGN && _loc7_ != ItemId.EFFECT_JUMP && _loc7_ != ItemId.EFFECT_PROTECTION && _loc7_ != ItemId.EFFECT_RUN && _loc7_ != ItemId.EFFECT_ZOMBIE && _loc7_ != ItemId.EFFECT_LOW_GRAVITY && _loc7_ != ItemId.EFFECT_MULTIJUMP && _loc7_ != ItemId.EFFECT_GRAVITY && _loc7_ != ItemId.SWITCH_ORANGE && _loc7_ != ItemId.DOOR_ORANGE && _loc7_ != ItemId.GATE_ORANGE && !ItemId.isBlockRotateable(_loc7_) && !ItemId.isBackgroundRotateable(_loc7_))
         {
            return;
         }
         var _loc8_:int = this.totalCoins;
         var _loc9_:int = this.player.coins;
         var _loc10_:int = this.bonusCoins;
         var _loc11_:int = this.player.bcoins;
         this.world.setTileComplex(param1,param2,param3,param4,param5);
         var _loc12_:Boolean = _loc7_ == 100 || _loc7_ == 110;
         var _loc13_:Boolean = param4 == 100 || param4 == 110;
         if(_loc13_)
         {
            if(!_loc12_)
            {
               this.totalCoins++;
            }
            else
            {
               this.player.coins--;
            }
         }
         else if(_loc12_)
         {
            if(_loc7_ == 110)
            {
               this.player.coins--;
            }
            this.totalCoins--;
         }
         if(_loc7_ == ItemId.CHECKPOINT)
         {
            if(this.player.checkpoint_x == param2 && this.player.checkpoint_y == param3)
            {
               this.player.resetCheckpoint();
            }
            for each(_loc17_ in this.players)
            {
               if(_loc17_.checkpoint_x == param2 && _loc17_.checkpoint_y == param3)
               {
                  _loc17_.resetCheckpoint();
               }
            }
         }
         var _loc14_:Boolean = _loc7_ == 101 || _loc7_ == 111;
         var _loc15_:Boolean = param4 == 101 || param4 == 111;
         if(_loc15_)
         {
            if(!_loc14_)
            {
               this.bonusCoins++;
            }
            else
            {
               this.player.bcoins--;
            }
         }
         else if(_loc14_)
         {
            if(_loc7_ == 111)
            {
               this.player.bcoins--;
            }
            this.bonusCoins--;
         }
         if(this.world.Overlaps(this.player,param2,param3))
         {
            this.totalCoins = _loc8_;
            this.bonusCoins = _loc10_;
            this.player.coins = _loc9_;
            this.player.bcoins = _loc11_;
            this.world.setTileComplex(param1,param2,param3,_loc7_,param5);
            this.tilequeue.push(new Tile(param1,param2,param3,param4,param5));
         }
         this.updateMinimap(param2,param3);
      }
      
      override public function enterFrame() : void
      {
         var _loc4_:Player = null;
         var _loc5_:* = null;
         var _loc6_:Tile = null;
         super.enterFrame();
         this.cointext.text = this.player.coins + "/" + this.totalCoins;
         this.bcointext.text = this.player.bcoins + "/" + this.bonusCoins;
         this.deathcounttext.text = this.player.deaths + "x";
         var _loc1_:Player = target as Player;
         if(_loc1_ != null)
         {
            this.spectatingText.text = "Spectating " + _loc1_.name.toUpperCase();
         }
         if(this.player.deaths > 9000 && !this.saidOver9000 && Global.soundVolume > 0)
         {
            this.saidOver9000 = true;
            SoundManager.playMiscSound(SoundId.OVER9000);
         }
         var _loc2_:int = this.queue.length;
         while(_loc2_--)
         {
            this.queue.shift()();
         }
         var _loc3_:int = this.tilequeue.length;
         while(_loc3_--)
         {
            _loc6_ = this.tilequeue.shift();
            this.setTile(_loc6_.layer,_loc6_.xo,_loc6_.yo,_loc6_.value,_loc6_.properties);
         }
         for each(_loc4_ in this.players)
         {
            this.minimap.showPlayer(_loc4_,_loc4_.minimapColor);
         }
         this.minimap.showPlayer(this.player,this.player.minimapColor);
         for(_loc5_ in this.players)
         {
            _loc4_ = this.players[_loc5_] as Player;
            _loc4_.enterChat();
         }
         this.player.enterChat();
      }
      
      override public function tick() : void
      {
         var confirm:ConfirmPrompt = null;
         var screenshotConfirm:ConfirmPrompt = null;
         var favBricks:BrickContainer = null;
         var id:int = 0;
         var pos:int = 0;
         var layer:int = 0;
         var determinedLayer:int = 0;
         var clicked:Boolean = false;
         var numberDown:int = 0;
         var dochange:Boolean = false;
         var lap:Boolean = this.world.overlaps(this.player) != 0;
         var old:Number = this.world.showCoinGate;
         this.world.showCoinGate = this.player.coins;
         if(this.world.overlaps(this.player))
         {
            this.world.showCoinGate = old;
         }
         var oldb:Number = this.world.showBlueCoinGate;
         this.world.showBlueCoinGate = this.player.bcoins;
         if(this.world.overlaps(this.player))
         {
            this.world.showBlueCoinGate = oldb;
         }
         var oldd:Number = this.world.showDeathGate;
         this.world.showDeathGate = this.player.deaths;
         if(this.world.overlaps(this.player))
         {
            this.world.showDeathGate = oldd;
         }
         var i:int = 0;
         while(i < this.particles.length - 1)
         {
            if(this.particles[i] != null)
            {
               this.particles[i].tick();
               if(this.particles[i].life >= this.particles[i].maxlife)
               {
                  remove(this.particles[i]);
                  delete this.particles[i];
               }
            }
            i++;
         }
         if(Bl.isKeyDown(16))
         {
            if(Bl.isKeyJustPressed(85))
            {
               Global.cookie.data.hideUsernames = !Global.cookie.data.hideUsernames;
               Global.base.SystemSay(!!Global.cookie.data.hideUsernames?"Usernames are now hidden.":"Usernames are now visible.","* System");
            }
            if(Bl.isKeyJustPressed(73))
            {
               Global.cookie.data.hideChatBubbles = !Global.cookie.data.hideChatBubbles;
               Global.base.SystemSay(!!Global.cookie.data.hideChatBubbles?"Chat bubbles are now hidden.":"Chat bubbles are now visible.","* System");
            }
            if(Bl.isKeyJustPressed(66))
            {
               confirm = new ConfirmPrompt("Do you want to make a screenshot?");
               confirm.ben_yes.addEventListener(MouseEvent.MOUSE_DOWN,function(param1:MouseEvent):void
               {
                  confirm.close();
                  Screenshot.SavePNG(param1);
               });
               Global.base.showConfirmPrompt(confirm);
            }
            if(Bl.isKeyJustPressed(86) && Global.base.ui2instance.minimapEnabled)
            {
               confirm = new ConfirmPrompt("Do you want to save the minimap?");
               confirm.ben_yes.addEventListener(MouseEvent.MOUSE_DOWN,function(param1:MouseEvent):void
               {
                  confirm.close();
                  Screenshot.SavePNGWithMinimap(param1);
               });
               Global.base.showConfirmPrompt(confirm);
            }
         }
         else if(Bl.isKeyJustPressed(73))
         {
            Global.getPlacer = !Global.getPlacer;
            Global.base.SystemSay("Inspect tool active: " + Global.getPlacer.toString().toUpperCase(),"* System");
         }
         if((Bl.data.isAdmin || Bl.data.isModerator) && Bl.isKeyDown(16))
         {
            if(Bl.isKeyDown(71))
            {
               x = x + 15;
            }
            if(Bl.isKeyDown(74))
            {
               x = x - 15;
            }
            if(Bl.isKeyDown(89))
            {
               y = y + 15;
            }
            if(Bl.isKeyDown(72))
            {
               y = y - 15;
            }
            if(Bl.isKeyJustPressed(82))
            {
               if(target)
               {
                  target = null;
               }
               else
               {
                  target = this.player;
               }
            }
            if(Bl.isKeyJustPressed(79))
            {
               Global.base.toggleUI();
            }
            else if(Bl.isKeyJustPressed(78))
            {
               screenshotConfirm = new ConfirmPrompt("Do you want to make a screenshot of this entire world?");
               screenshotConfirm.ben_yes.addEventListener(MouseEvent.MOUSE_DOWN,function(param1:MouseEvent):void
               {
                  screenshotConfirm.close();
                  Screenshot.SavePNGWithFullWorld(param1);
               });
               Global.base.showConfirmPrompt(screenshotConfirm);
            }
         }
         else if(Bl.isKeyJustPressed(71) && Bl.data.canToggleGodMode)
         {
            this.connection.send("god",!this.player.isInGodMode);
            if(this.player.isInAdminMode)
            {
               this.connection.send("admin");
            }
            if(this.player.isInModeratorMode)
            {
               this.connection.send("mod");
            }
         }
         var xo:int = (Bl.mouseX - this.x) / 16 >> 0;
         var yo:int = (Bl.mouseY - this.y) / 16 >> 0;
         if(Bl.isMiddleMouseJustPressed)
         {
            if(Global.playerInstance.name.toLowerCase() == Global.worldOwner.toLowerCase() || Global.playerInstance.canEdit)
            {
               favBricks = Global.base.ui2instance.favoriteBricks;
               id = this.world.getTile(0,xo,yo);
               if(id == 0)
               {
                  id = this.world.getTile(1,xo,yo);
                  if(id == 0)
                  {
                     favBricks.select(0);
                     return;
                  }
               }
               if(favBricks.getPosFromID(id) != -1)
               {
                  this.readBlock(this.getLayerFromId(id),xo,yo,favBricks.getPosFromID(id));
               }
               else
               {
                  pos = favBricks.selectedBlock;
                  this.readBlock(this.getLayerFromId(id),xo,yo,pos);
               }
            }
         }
         if(Bl.isMouseJustPressed || Bl.data.isLockedRoom && Bl.isMouseDown)
         {
            if(Global.base.ui2instance.playerActionsVisible)
            {
               this.lockPlacement = true;
            }
            if(!(Bl.mouseX > 640 || Bl.mouseX < 0 || Bl.mouseY > 470 || Bl.mouseY < 0))
            {
               layer = this.getLayerFromId(Bl.data.brick);
               determinedLayer = layer;
               if(Bl.isMouseJustPressed)
               {
                  if(this.world.getTile(0,xo,yo) != 0)
                  {
                     determinedLayer = 0;
                  }
                  else
                  {
                     determinedLayer = 1;
                  }
                  this.eraserLayerLock = determinedLayer;
               }
               else
               {
                  determinedLayer = this.eraserLayerLock;
               }
               if(Bl.data.brick == 0)
               {
                  layer = determinedLayer;
               }
               clicked = false;
               if(Bl.data.canEdit && xo >= 0 && yo >= 0 && xo < this.world.width && yo < this.world.height)
               {
                  if(Bl.data.brick == 100 && this.world.getTile(0,xo,yo) == 110)
                  {
                     this.setTile(0,xo,yo,100,null);
                  }
                  if(Bl.data.brick == 101 && this.world.getTile(0,xo,yo) == 111)
                  {
                     this.setTile(0,xo,yo,101,null);
                  }
                  clicked = true;
                  numberDown = this.numberKeyDown();
                  if(Global.blockPickerEnabled && numberDown != -1)
                  {
                     this.readBlock(determinedLayer,xo,yo,numberDown);
                  }
                  else if(this.connection.connected && !this.isSame(layer,xo,yo) && Bl.data.brick >= 0 && !this.isPlayerSpectating)
                  {
                     dochange = true;
                     if(xo == this.pastX && yo == this.pastY)
                     {
                        if(new Date().time - this.pastT < 500)
                        {
                           dochange = false;
                        }
                     }
                     if(this.lockPlacement)
                     {
                        dochange = false;
                        if(Bl.isMouseJustPressed)
                        {
                           this.lockPlacement = false;
                        }
                     }
                     if(dochange)
                     {
                        this.pastX = xo;
                        this.pastY = yo;
                        this.pastT = new Date().time;
                        if(ItemId.isBlockRotateable(Bl.data.brick) || ItemId.isNonRotatableHalfBlock(Bl.data.brick) || Bl.data.brick == ItemId.SPIKE)
                        {
                           this.world.updateRotateablesMap(Bl.data.brick,xo,yo);
                           this.connection.send("b",layer,xo,yo,Bl.data.brick,this.world.lookup.getInt(xo,yo) + 1);
                        }
                        else
                        {
                           switch(Bl.data.brick)
                           {
                              case ItemId.COINDOOR:
                              case ItemId.COINGATE:
                              case ItemId.BLUECOINDOOR:
                              case ItemId.BLUECOINGATE:
                                 this.connection.send("b",layer,xo,yo,Bl.data.brick,Bl.data.coincount);
                                 break;
                              case ItemId.SWITCH_PURPLE:
                              case ItemId.DOOR_PURPLE:
                              case ItemId.GATE_PURPLE:
                              case ItemId.SWITCH_ORANGE:
                              case ItemId.DOOR_ORANGE:
                              case ItemId.GATE_ORANGE:
                                 this.connection.send("b",layer,xo,yo,Bl.data.brick,Bl.data.switchId);
                                 break;
                              case ItemId.DEATH_DOOR:
                              case ItemId.DEATH_GATE:
                                 this.connection.send("b",layer,xo,yo,Bl.data.brick,Bl.data.deathcount);
                                 break;
                              case ItemId.PORTAL_INVISIBLE:
                              case ItemId.PORTAL:
                                 this.connection.send("b",layer,xo,yo,Bl.data.brick,this.world.lookup.getPortal(xo,yo).rotation + 1,Bl.data.portal_id,Bl.data.portal_target);
                                 break;
                              case ItemId.WORLD_PORTAL:
                                 if(Bl.data.world_portal_name != null)
                                 {
                                    this.connection.send("b",layer,xo,yo,Bl.data.brick,Bl.data.world_portal_id);
                                 }
                                 break;
                              case ItemId.TEXT_SIGN:
                                 this.connection.send("b",layer,xo,yo,Bl.data.brick,Global.text_sign_text,this.world.lookup.getTextSign(xo,yo).type + 1);
                                 break;
                              case 1000:
                                 this.connection.send("b",layer,xo,yo,Bl.data.brick,Global.default_label_text,Global.default_label_hex,Bl.data.wrapLength);
                                 break;
                              case 83:
                                 this.connection.send("b",layer,xo,yo,Bl.data.brick,Global.drumOffset);
                                 break;
                              case 77:
                                 this.connection.send("b",layer,xo,yo,Bl.data.brick,Global.pianoOffset);
                                 break;
                              case ItemId.EFFECT_TEAM:
                              case ItemId.TEAM_DOOR:
                              case ItemId.TEAM_GATE:
                                 this.connection.send("b",layer,xo,yo,Bl.data.brick,Bl.data.team);
                                 break;
                              case ItemId.EFFECT_GRAVITY:
                                 this.connection.send("b",layer,xo,yo,Bl.data.brick,Bl.data.direction);
                                 break;
                              case ItemId.EFFECT_CURSE:
                              case ItemId.EFFECT_ZOMBIE:
                                 this.connection.send("b",layer,xo,yo,Bl.data.brick,Bl.data.effectDuration);
                                 break;
                              case ItemId.EFFECT_FLY:
                              case ItemId.EFFECT_JUMP:
                              case ItemId.EFFECT_PROTECTION:
                              case ItemId.EFFECT_RUN:
                              case ItemId.EFFECT_LOW_GRAVITY:
                                 this.connection.send("b",layer,xo,yo,Bl.data.brick,!!Bl.data.onStatus?1:0);
                                 break;
                              case ItemId.EFFECT_MULTIJUMP:
                                 this.connection.send("b",layer,xo,yo,Bl.data.brick,Bl.data.jumps);
                                 break;
                              case 1520:
                                 this.connection.send("b",layer,xo,yo,Bl.data.brick,SoundManager.guitarMap[Global.guitarOffset]);
                                 break;
                              default:
                                 this.connection.send("b",layer,xo,yo,Bl.data.brick);
                           }
                        }
                     }
                  }
                  else
                  {
                     clicked = false;
                  }
               }
               if(!clicked && this.isPlayerSpectating && !Global.base.ui2instance.playerActionsVisible)
               {
                  this.stopSpectating();
                  this.lockPlacement = true;
               }
            }
         }
         this.playerOverlaps();
         super.tick();
      }
      
      private function getLayerFromId(param1:int) : int
      {
         return param1 >= 500 && param1 < 1000?1:0;
      }
      
      private function numberKeyDown() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 48;
         while(_loc2_ <= 57)
         {
            if(Bl.isKeyDown(_loc2_))
            {
               return _loc1_;
            }
            _loc1_++;
            _loc2_++;
         }
         return -1;
      }
      
      private function readBlock(param1:int, param2:int, param3:int, param4:int) : void
      {
         var _loc6_:LabelLookup = null;
         var _loc5_:int = this.world.getTile(param1,param2,param3);
         if(!Global.base.canUseBlock(ItemManager.getBrickById(_loc5_)))
         {
            return;
         }
         Bl.data.brick = _loc5_;
         switch(Bl.data.brick)
         {
            case ItemId.COINDOOR:
            case ItemId.COINGATE:
            case ItemId.BLUECOINDOOR:
            case ItemId.BLUECOINGATE:
               Bl.data.coincount = this.world.lookup.getInt(param2,param3);
               break;
            case ItemId.SWITCH_PURPLE:
            case ItemId.DOOR_PURPLE:
            case ItemId.GATE_PURPLE:
            case ItemId.SWITCH_ORANGE:
            case ItemId.DOOR_ORANGE:
            case ItemId.GATE_ORANGE:
               Bl.data.switchId = this.world.lookup.getInt(param2,param3);
               break;
            case ItemId.DEATH_DOOR:
            case ItemId.DEATH_GATE:
               Bl.data.deathcount = this.world.lookup.getInt(param2,param3);
               break;
            case ItemId.PORTAL_INVISIBLE:
            case ItemId.PORTAL:
               Bl.data.portal_id = this.world.lookup.getPortal(param2,param3).id;
               Bl.data.portal_target = this.world.lookup.getPortal(param2,param3).target;
               break;
            case ItemId.WORLD_PORTAL:
               Bl.data.world_portal_name = this.world.lookup.getText(param2,param3);
               break;
            case ItemId.TEXT_SIGN:
               Global.text_sign_text = this.world.lookup.getTextSign(param2,param3).text;
               break;
            case 83:
               Global.drumOffset = this.world.lookup.getInt(param2,param3);
               break;
            case 77:
               Global.pianoOffset = this.world.lookup.getInt(param2,param3);
               break;
            case ItemId.EFFECT_TEAM:
            case ItemId.TEAM_DOOR:
            case ItemId.TEAM_GATE:
               Bl.data.team = this.world.lookup.getInt(param2,param3);
               this.connection.send("b",param1,param2,param3,Bl.data.brick,Bl.data.team);
               break;
            case ItemId.EFFECT_CURSE:
            case ItemId.EFFECT_ZOMBIE:
               Bl.data.effectDuration = this.world.lookup.getInt(param2,param3);
               break;
            case ItemId.EFFECT_FLY:
            case ItemId.EFFECT_JUMP:
            case ItemId.EFFECT_PROTECTION:
            case ItemId.EFFECT_RUN:
            case ItemId.EFFECT_LOW_GRAVITY:
               Bl.data.onStatus = this.world.lookup.getBoolean(param2,param3);
               break;
            case ItemId.EFFECT_MULTIJUMP:
               Bl.data.jumps = this.world.lookup.getInt(param2,param3);
               break;
            case ItemId.EFFECT_GRAVITY:
               Bl.data.direction = this.world.lookup.getInt(param2,param3);
               break;
            case 1520:
               Global.guitarOffset = SoundManager.guitarMap.indexOf(this.world.lookup.getInt(param2,param3));
               break;
            case 1000:
               _loc6_ = this.world.lookup.getLabel(param2,param3);
               Bl.data.wrapLength = _loc6_.WrapLength;
               Global.default_label_text = _loc6_.Text;
               Global.default_label_hex = _loc6_.Color;
         }
         if(param4 == 0)
         {
            param4 = 10;
         }
         Global.base.ui2instance.favoriteBricks.setDefault(param4,ItemManager.getBrickById(Bl.data.brick));
         Global.base.ui2instance.favoriteBricks.select(param4);
      }
      
      private function playerOverlaps() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Boolean = false;
         var _loc3_:Player = null;
         if(this.player.getCanTag())
         {
            _loc1_ = 8;
            _loc2_ = false;
            if(this.touchCooldown == 0)
            {
               _loc2_ = true;
            }
            else
            {
               this.touchCooldown--;
            }
            for each(_loc3_ in this.players)
            {
               if(_loc3_.getCanBeTagged())
               {
                  if(Math.abs(this.player.x - _loc3_.x) < _loc1_ && Math.abs(this.player.y - _loc3_.y) < _loc1_)
                  {
                     if(_loc2_ && this.player.cursed && !_loc3_.cursed)
                     {
                        this.touchCooldown = 100;
                        this.connection.send("touch",_loc3_.id,Config.effectCurse);
                     }
                     if(this.player.zombie && !_loc3_.zombie)
                     {
                        this.connection.send("touch",_loc3_.id,Config.effectZombie);
                     }
                     if(this.player.isInvulnerable && (_loc3_.cursed || _loc3_.zombie))
                     {
                        this.connection.send("touch",_loc3_.id,Config.effectProtection);
                     }
                  }
               }
            }
         }
      }
      
      private function isSame(param1:int, param2:int, param3:int) : Boolean
      {
         if(Bl.data.brick == this.world.getTile(param1,param2,param3))
         {
            if(ItemId.isBackgroundRotateable(Bl.data.brick))
            {
               return false;
            }
            if(ItemId.isBlockRotateable(Bl.data.brick))
            {
               return false;
            }
            switch(Bl.data.brick)
            {
               case ItemId.COINDOOR:
               case ItemId.COINGATE:
               case ItemId.BLUECOINDOOR:
               case ItemId.BLUECOINGATE:
                  if(this.world.lookup.getInt(param2,param3) != Bl.data.coincount)
                  {
                     return false;
                  }
                  break;
               case ItemId.SWITCH_PURPLE:
               case ItemId.DOOR_PURPLE:
               case ItemId.GATE_PURPLE:
               case ItemId.SWITCH_ORANGE:
               case ItemId.DOOR_ORANGE:
               case ItemId.GATE_ORANGE:
                  if(this.world.lookup.getInt(param2,param3) != Bl.data.switchId)
                  {
                     return false;
                  }
                  break;
               case ItemId.DEATH_DOOR:
               case ItemId.DEATH_GATE:
                  if(this.world.lookup.getInt(param2,param3) != Bl.data.deathcount)
                  {
                     return false;
                  }
                  break;
               case 83:
                  if(this.world.lookup.getInt(param2,param3) != Global.drumOffset)
                  {
                     return false;
                  }
                  break;
               case 77:
                  if(this.world.lookup.getInt(param2,param3) != Global.pianoOffset)
                  {
                     return false;
                  }
                  break;
               case ItemId.SPIKE:
               case ItemId.WORLD_PORTAL:
               case ItemId.PORTAL_INVISIBLE:
               case ItemId.TEXT_SIGN:
               case ItemId.PORTAL:
                  return false;
               case ItemId.EFFECT_TEAM:
               case ItemId.TEAM_DOOR:
               case ItemId.TEAM_GATE:
                  if(this.world.lookup.getInt(param2,param3) != Bl.data.team)
                  {
                     return false;
                  }
                  break;
               case ItemId.EFFECT_GRAVITY:
                  if(this.world.lookup.getInt(param2,param3) != Bl.data.direction)
                  {
                     return false;
                  }
                  break;
               case ItemId.EFFECT_CURSE:
               case ItemId.EFFECT_ZOMBIE:
                  if(this.world.lookup.getInt(param2,param3) != Bl.data.effectDuration)
                  {
                     return false;
                  }
                  break;
               case ItemId.EFFECT_FLY:
               case ItemId.EFFECT_JUMP:
               case ItemId.EFFECT_PROTECTION:
               case ItemId.EFFECT_RUN:
               case ItemId.EFFECT_LOW_GRAVITY:
                  if(this.world.lookup.getBoolean(param2,param3) != Bl.data.onStatus)
                  {
                     return false;
                  }
                  break;
               case ItemId.EFFECT_MULTIJUMP:
                  if(this.world.lookup.getInt(param2,param3) != Bl.data.jumps)
                  {
                     return false;
                  }
                  break;
               case 1000:
                  return false;
               case 1520:
                  if(this.world.lookup.getInt(param2,param3) != Global.guitarOffset)
                  {
                     return false;
                  }
                  break;
            }
            return true;
         }
         return false;
      }
      
      override public function draw(param1:BitmapData, param2:int, param3:int) : void
      {
         var _loc6_:* = null;
         var _loc7_:int = 0;
         var _loc9_:Player = null;
         var _loc4_:Number = new Date().time;
         this.startx = -this.x - 90;
         this.starty = -this.y - 90;
         this.endx = this.startx + Bl.width + 180;
         this.endy = this.starty + Bl.height + 180;
         super.draw(param1,param2,param3);
         var _loc5_:Boolean = !this.player.moving || Global.chatIsVisible;
         if(!_loc5_)
         {
            this.chatTime = new Date().time;
         }
         else if(new Date().time - this.chatTime < 1500)
         {
            _loc5_ = false || Global.chatIsVisible;
         }
         this.world.postDraw(param1,param2 + x,param3 + y);
         for(_loc6_ in this.players)
         {
            _loc9_ = this.players[_loc6_] as Player;
            if(_loc9_.x > this.startx && _loc9_.y > this.starty && _loc9_.x < this.endx && _loc9_.y < this.endy)
            {
               _loc9_.drawChat(param1,param2 + x,param3 + y,_loc5_);
               _loc9_.drawGods(param1,param2 + x,param3 + y);
            }
         }
         this.player.drawChat(param1,param2 + x,param3 + y,_loc5_);
         this.player.drawGods(param1,param2 + x,param3 + y);
         Chat.drawAll();
         this.world.drawDialogs(param1,param2 + x,param3 + y);
         _loc7_ = !!Global.showUI?-16:-200;
         var _loc8_:int = 0;
         if(this.player.deaths > 0)
         {
            this.deathcountcontainer.draw(param1,0,_loc8_ + _loc7_);
            _loc8_ = _loc8_ + 15;
         }
         if(this.totalCoins > 0)
         {
            this.cointextcontainer.draw(param1,0,_loc8_ + _loc7_);
            _loc8_ = _loc8_ + 15;
         }
         if(this.bonusCoins > 0)
         {
            this.bcointextcontainer.draw(param1,0,_loc8_ + _loc7_);
            _loc8_ = _loc8_ + 15;
         }
         if(this.isPlayerSpectating)
         {
            this.spectatingText.draw(param1,0,0);
            this.stopSpectatingText.draw(param1,0,0);
         }
         if(Bl.data.showMap)
         {
            this.minimap.draw(param1,0,0);
         }
         else
         {
            this.minimap.clear();
         }
         if(Global.base.overlayContainer.contains(this.debugStats))
         {
            Global.base.overlayContainer.setChildIndex(this.debugStats,Global.base.overlayContainer.numChildren - 1);
         }
         this.lastframe = param1;
      }
      
      override public function get align() : String
      {
         return STATE_ALIGN_LEFT;
      }
      
      public function reset() : void
      {
      }
      
      public function getPlayerScreenPosition(param1:int = -1) : Point
      {
         var _loc2_:Player = null;
         if(param1 < 0)
         {
            _loc2_ = this.player;
         }
         else
         {
            _loc2_ = this.players[param1] as Player;
         }
         if(!_loc2_)
         {
            return new Point(-1,-1);
         }
         return new Point(x + _loc2_.x,y + _loc2_.y);
      }
      
      private function doAnim(param1:Player, param2:String) : void
      {
         var bmd:BitmapData = null;
         var p:Player = param1;
         var type:String = param2;
         if(type == "favorite")
         {
            bmd = AnimationManager.animFavorite;
         }
         if(type == "like")
         {
            bmd = AnimationManager.animLike;
         }
         var anim:AnimatedSprite = new AnimatedSprite(bmd,40);
         anim.x = p.x - 12;
         anim.y = p.y - 13;
         anim.scale = 0;
         add(anim);
         TweenMax.to(anim,0.3,{
            "y":"-30",
            "scale":1,
            "ease":Quint.easeOut
         });
         TweenMax.to(anim,0.1,{
            "scale":0,
            "delay":2,
            "onCompleteParams":[anim],
            "onComplete":function(param1:AnimatedSprite):void
            {
               remove(param1);
            }
         });
      }
      
      public function getPlayers() : Object
      {
         var _loc2_:* = null;
         var _loc3_:Player = null;
         var _loc1_:Object = {};
         _loc1_[this.player.id] = this.player;
         for(_loc2_ in this.players)
         {
            _loc3_ = this.players[_loc2_] as Player;
            _loc1_[_loc3_.id] = _loc3_;
         }
         return _loc1_;
      }
      
      public function getPlayerFromId(param1:int) : Player
      {
         var _loc3_:* = null;
         var _loc4_:Player = null;
         var _loc2_:Object = {};
         _loc2_[this.player.id] = this.player;
         for(_loc3_ in this.players)
         {
            _loc4_ = this.players[_loc3_] as Player;
            _loc2_[_loc4_.id] = _loc4_;
         }
         return _loc2_[param1];
      }
      
      public function getPlayer() : Player
      {
         return this.player;
      }
      
      public function getConnection() : Connection
      {
         return this.connection;
      }
      
      public function playerToId(param1:String) : int
      {
         var _loc3_:* = null;
         var _loc2_:int = 0;
         for(_loc3_ in this.players)
         {
            if(param1 == _loc3_)
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return -1;
      }
      
      public function setBlockPlayerData(param1:int, param2:int, param3:int, param4:int) : void
      {
         if(param4 != -1)
         {
            if(param4 == Global.myId)
            {
               this.world.lookup.setPlacer(param1,param2,param3,this.player.name);
            }
            else if(this.players[param4] as Player)
            {
               this.world.lookup.setPlacer(param1,param2,param3,(this.players[param4] as Player).name);
            }
         }
      }
      
      public function addFakePlayer(param1:int, param2:int, param3:String, param4:Number, param5:Number, param6:Boolean = false, param7:Boolean = false, param8:Boolean = false, param9:Number = -1) : void
      {
         var _loc12_:* = false;
         var _loc13_:Number = NaN;
         var _loc10_:int = this.fPid_++;
         var _loc11_:Player = this.players[_loc10_] as Player;
         if(!_loc11_)
         {
            _loc11_ = new Player(this.world,param3,false,null,this);
            _loc11_.id = _loc10_;
            this.players[_loc10_] = _loc11_;
            _loc11_.isInGodMode = param6;
            _loc11_.isInAdminMode = param7;
            _loc11_.isInModeratorMode = param8;
            _loc11_.SetStaffAura(0);
            _loc11_.worldGravityMultiplier = this.gravityMultiplier;
            _loc11_.x = Math.min(param4,(this.rw - 2) * 16);
            _loc11_.y = Math.min(param5,(this.rh - 2) * 16);
            _loc11_.frame = param1;
            _loc11_.aura = param2;
            _loc11_.coins = 0;
            _loc11_.bcoins = 0;
            _loc11_.deaths = 0;
            _loc11_.isgoldmember = false;
            _loc11_.team = 0;
            _loc12_ = param3.indexOf("-") != -1;
            _loc13_ = 13421772;
            if(_loc12_)
            {
               _loc13_ = 6710886;
            }
            if(Player.isAdmin(_loc11_.name))
            {
               _loc13_ = Config.admin_color;
            }
            if(Player.isModerator(_loc11_.name))
            {
               _loc13_ = Config.moderator_color;
            }
            if(param9 > -1)
            {
               _loc13_ = param9;
            }
            _loc11_.nameColor = _loc13_;
            _loc11_.canEdit = false;
            _loc11_.badge = "";
            _loc11_.isCrewMember = false;
            addBefore(_loc11_,this.player);
         }
      }
      
      public function randInt(param1:Number, param2:Number) : Number
      {
         return param1 + (param2 - param1) * Math.random();
      }
      
      public function get isPlayerSpectating() : Boolean
      {
         return this._isPlayerSpectating;
      }
      
      public function spectate(param1:Player) : void
      {
         this.target = param1;
         this._isPlayerSpectating = true;
      }
      
      public function stopSpectating() : void
      {
         target = this.player;
         this._isPlayerSpectating = false;
      }
      
      private function getIntArrayFromVarint(param1:ByteArray) : Array
      {
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:Array = [];
         var _loc5_:int = 0;
         while(_loc5_ < param1.length)
         {
            _loc6_ = param1[_loc5_];
            _loc7_ = _loc6_ & 127;
            _loc3_ = _loc3_ | _loc7_ << _loc2_;
            if((_loc6_ & 128) != 128)
            {
               _loc4_.push(int(_loc3_));
               _loc3_ = 0;
               _loc2_ = 0;
            }
            else
            {
               _loc2_ = _loc2_ + 7;
            }
            _loc5_++;
         }
         return _loc4_;
      }
   }
}
