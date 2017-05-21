package states
{
   import blitter.Bl;
   import blitter.BlState;
   import blitter.BlText;
   import com.greensock.TweenMax;
   import data.SimplePlayerObjectEvent;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.net.URLRequest;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import flash.utils.Timer;
   import mx.utils.StringUtil;
   import playerio.Message;
   import playerio.PlayerIOError;
   import playerio.RoomInfo;
   import ui.LobbyLoginBox;
   import ui.PlayerWorlds;
   import ui.SettingsPage;
   import ui.campaigns.CampaignPage;
   import ui.lobby.Background;
   import ui.lobby.Fog;
   import ui.lobby.GuestWellcome;
   import ui.lobby.News;
   import ui.profile.MainProfile;
   import ui.roomlist.CreateOpenWorldPrompt;
   import ui.roomlist.RoomFilter;
   import ui.roomlist.RoomList;
   import ui.screens.WelcomeBack;
   import ui.screens.WelcomeGold;
   import ui.shop.ShopBar;
   import ui.tutorial.ButtonType;
   import ui.tutorial.Guide;
   import ui.tutorial.Tutorial;
   import ui.tutorial.TutorialManager;
   
   public class LobbyState extends BlState
   {
       
      
      protected var worldScrollOverlay:Class;
      
      protected var banner:Class;
      
      protected var world_image:Sprite;
      
      protected var world_image_overlay:Bitmap;
      
      protected var lobby_banner:BitmapData;
      
      protected var levels:Object;
      
      protected var callback:Function;
      
      public var createCallback:Function;
      
      protected var subtext:BlText;
      
      protected var bm_subtext:Bitmap;
      
      public var roomlist:RoomList;
      
      protected var createroom:CreateOpenWorldPrompt;
      
      protected var loadroom:LoadRoom;
      
      protected var filter:WorldsFilter;
      
      protected var fbtextfield:TextField;
      
      protected var tw:Sprite;
      
      public var shopbar:ShopBar;
      
      protected var myworlds:PlayerWorlds;
      
      protected var loginbox:LobbyLoginBox;
      
      public var newfilter:RoomFilter;
      
      protected var gw:GuestWellcome;
      
      private var _mainProfile:MainProfile;
      
      protected var container:Sprite;
      
      private var handleJoinSaved:Function;
      
      private var myroomsCallback:Function;
      
      private var announce:News;
      
      private var annbg:BlackBG;
      
      private var bm_subtext_holder:Sprite;
      
      private var last_world_reload:Object;
      
      private var loading_worlds:Boolean;
      
      private var refreshtimer:Timer;
      
      private var show_guest_layout:Boolean;
      
      private var firstDailyLogin:Boolean;
      
      public var currentPage:String = "";
      
      private var textTime:int = 0;
      
      private var texts:Array;
      
      private var curText:int = 0;
      
      protected var bannerimg:Sprite;
      
      private var settingsPage:SettingsPage;
      
      private var campaignPage:CampaignPage;
      
      private var campaignPageBorder:Sprite;
      
      private var online:Number;
      
      private var wonline:Number;
      
      public function LobbyState(param1:Array, param2:Function, param3:Function, param4:Function, param5:Boolean, param6:EverybodyEdits, param7:Function, param8:WelcomeBack, param9:Boolean, param10:String)
      {
         var tb:BlText = null;
         var bmtb:Bitmap = null;
         var f:TextFormat = null;
         var f2:TextFormat = null;
         var fog:Fog = null;
         var rooms:Array = param1;
         var callback:Function = param2;
         var createCallback:Function = param3;
         var myroomsCallback:Function = param4;
         var iseecom:Boolean = param5;
         var base:EverybodyEdits = param6;
         var handleJoinSaved:Function = param7;
         var welcomeBack:WelcomeBack = param8;
         var firstDailyLogin:Boolean = param9;
         var tab:String = param10;
         this.worldScrollOverlay = LobbyState_worldScrollOverlay;
         this.banner = LobbyState_banner;
         this.world_image = new Background();
         this.world_image_overlay = new Bitmap(new this.worldScrollOverlay().bitmapData);
         this.lobby_banner = new this.banner().bitmapData;
         this.levels = {};
         this.subtext = new BlText(11,300,11184810);
         this.tw = new Sprite();
         this.shopbar = new ShopBar();
         this.container = new Sprite();
         this.texts = [];
         this.bannerimg = new Sprite();
         this.campaignPageBorder = new Sprite();
         super();
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
         this.container.x = 0;
         Bl.stage.addChild(this.container);
         this.handleJoinSaved = handleJoinSaved;
         this.myroomsCallback = myroomsCallback;
         this.callback = callback;
         this.createCallback = createCallback;
         this.firstDailyLogin = firstDailyLogin;
         this.show_guest_layout = false;
         var t:BlText = new BlText(30,400,14179354);
         t.text = "Every Build Exists";
         var bmt:Bitmap = new Bitmap(t.clone());
         bmt.x = 10;
         bmt.y = 5 + (!this.show_guest_layout?30:0);
         this.container.addChild(bmt);
         this.bm_subtext_holder = new Sprite();
         this.container.addChild(this.bm_subtext_holder);
         if(Global.player_is_beta_member)
         {
            tb = new BlText(11,400,16758528);
            tb.text = !!Bl.data.isbeta?"Beta":"";
            tb.x = 286;
            tb.y = 3 + (!this.show_guest_layout?30:0);
            bmtb = new Bitmap(tb.clone());
            bmtb.x = 286;
            bmtb.y = 3 + (!this.show_guest_layout?30:0);
            this.container.addChild(bmtb);
         }
         var betaonline:int = 0;
         var openonline:int = 0;
         var protectedonline:int = 0;
         this.roomlist = new RoomList(371 - (!!this.show_guest_layout?6:40),this.joinRoom);
         this.roomlist.x = 13;
         this.roomlist.y = 71 + (!this.show_guest_layout?30:0) + 55 >> 0;
         this.newfilter = new RoomFilter(this.roomlist.render,this.reloadRooms);
         this.newfilter.x = 13;
         this.newfilter.y = 10 + (!this.show_guest_layout?30:0) + 55 >> 0;
         this.newfilter.height = 384 - 25 - (!!this.show_guest_layout?6:40);
         this.container.addChild(this.newfilter);
         this.container.addChild(this.roomlist);
         this.roomlist.addEventListener(NavigationEvent.START_OPENWORLD,function(param1:Event):void
         {
            createroom = new CreateOpenWorldPrompt(createRoom);
            createroom.x = (Global.width - 327) / 2;
            container.addChild(createroom);
         });
         this.reloadRooms();
         if(!this.show_guest_layout)
         {
            Shop.setContainer(this.container);
            Shop.addEventListener(ShopEvent.ITEM_AQUIRED,this.handleShopUpdate);
            this._mainProfile = new MainProfile();
            this._mainProfile.x = 324;
            this._mainProfile.y = 10 + (!this.show_guest_layout?30:0) + 55;
            this._mainProfile.width = Global.width - this._mainProfile.x - 13;
            this.container.addChild(this._mainProfile);
            if(Config.displayBanner)
            {
               this.bannerimg.x = 335;
               this.bannerimg.y = 31;
               this.bannerimg.addChild(new Bitmap(this.lobby_banner));
               this.container.addChildAt(this.bannerimg,0);
            }
            this.initNews();
            this.container.addChild(this.shopbar);
         }
         else
         {
            this.gw = new GuestWellcome();
            this.gw.x = 327;
            this.gw.y = this.newfilter.y;
            this.container.addChild(this.gw);
            this.loginbox = new LobbyLoginBox(base);
            this.container.addChild(this.loginbox);
            this.loginbox.x = 327;
            this.loginbox.y = this.gw.y + this.gw.height + 10;
         }
         if(iseecom)
         {
            if(Global.client.connectUserId)
            {
               this.fbtextfield = new TextField();
               this.fbtextfield.width = 200;
               this.fbtextfield.autoSize = TextFieldAutoSize.LEFT;
               f = new TextFormat();
               f.align = TextFormatAlign.RIGHT;
               f.color = 0;
               this.fbtextfield.defaultTextFormat = f;
               this.fbtextfield.text = Global.client.connectUserId;
               this.fbtextfield.x = Global.width - 10;
               this.fbtextfield.y = 500 - this.fbtextfield.height;
               Bl.stage.addChild(this.fbtextfield);
               this.container.addChild(this.fbtextfield);
            }
         }
         else
         {
            this.fbtextfield = new TextField();
            this.fbtextfield.width = 200;
            this.fbtextfield.x = 640 - 210;
            this.fbtextfield.y = 50;
            f2 = new TextFormat();
            f2.align = TextFormatAlign.RIGHT;
            f2.color = 0;
            this.fbtextfield.defaultTextFormat = f2;
            this.fbtextfield.text = ">" + (LoaderInfo(Bl.stage.root.loaderInfo).parameters.nonoba$referer || "") + "<";
            this.container.addChild(this.fbtextfield);
         }
         if(welcomeBack != null)
         {
            Global.base.overlayContainer.addChild(welcomeBack);
         }
         this.campaignPage = new CampaignPage(this,null);
         if(Global.playerObject.tutorialVersion != Config.tutorialVersion)
         {
            if(!Global.player_is_guest)
            {
               this.initializeTutorial();
            }
         }
         Global.stage.addEventListener(SimplePlayerObjectEvent.UPDATE,this.handlePlayerObjectUpdate,false,0,true);
         if(Global.playerObject.goldwelcome)
         {
            this.showWelcomeGold();
         }
         Global.base.addChild(this.world_image);
         Global.base.addChild(this.world_image_overlay);
         Global.stage.frameRate = 120;
         if(Config.displayFog)
         {
            fog = new Fog();
            fog.y = 33;
            this.container.addChildAt(fog,0);
         }
         this.setPage(tab);
      }
      
      public function initializeTutorial() : void
      {
         var tutManager:TutorialManager = null;
         var introTut:Tutorial = null;
         var campaignTut:Tutorial = null;
         var crewTut:Tutorial = null;
         var newsTut:Tutorial = null;
         var settingsTut:Tutorial = null;
         var finalTut:Tutorial = null;
         Global.runningTutorial = true;
         while(Global.base.overlayContainer.numChildren > 0)
         {
            Global.base.overlayContainer.removeChildAt(0);
         }
         tutManager = new TutorialManager();
         introTut = new Tutorial("Welcome newcomer!");
         var disableJoiningWorlds:Function = function():void
         {
            if(roomlist.joiningDisabled == false)
            {
               roomlist.disableJoining();
               introTut.nextGuide();
            }
         };
         var skipIntro:Function = function():void
         {
            disableJoiningWorlds();
            tutManager.nextTutorial();
         };
         var introGuides:Array = [new Guide(-1,-1,introTut.tutorialName,"This interactive guide will help you navigate through the menus and will help you get started with the game.",null,ButtonType.NEXTSKIPCANCEL,disableJoiningWorlds,skipIntro),new Guide(-1,-1,introTut.tutorialName,"During the guide, hover your mouse over some items to get extra information.",null,ButtonType.NEXTSKIPCANCEL,introTut.nextGuide,skipIntro),new Guide(-1,-1,introTut.tutorialName,"You can play the interactive guide again by pressing the \"Replay Tutorial\" button in the settings menu",null,ButtonType.NEXTSKIPCANCEL,tutManager.nextTutorial,skipIntro)];
         introTut.addGuides(introGuides);
         var roomlistTut:Tutorial = new Tutorial("Joining a world");
         var enableJoining:Function = function():void
         {
            tutManager.nextTutorial();
            roomlist.enableJoining();
         };
         var roomlistGuide:Guide = new Guide(370,300,roomlistTut.tutorialName,"To start playing, you can select a world in the rooms list. For the sake of the tutorial, joining worlds is disabled for now. ",this.roomlist,ButtonType.NEXTSKIPCANCEL,enableJoining,enableJoining);
         roomlistTut.addGuide(roomlistGuide);
         var openShop:Function = function():void
         {
            tutManager.nextTutorial();
            if(currentPage != LobbyStatePage.ENERGY_SHOP)
            {
               setPage(LobbyStatePage.ENERGY_SHOP);
            }
         };
         var skipShopTut:Function = function():void
         {
            if(currentPage != LobbyStatePage.CAMPAIGN)
            {
               openShop();
            }
            tutManager.nextTutorial();
         };
         var creatingWorldTut:Tutorial = new Tutorial("Creating a world");
         var creatingWorldGuides:Array = [new Guide(-1,-1,creatingWorldTut.tutorialName,"All worlds are made by the community. Of course that means that you can create your own worlds. You start off with a basic set of tools.",this.shopbar.shopbtn,ButtonType.NEXTSKIPCANCEL,creatingWorldTut.nextGuide,skipShopTut),new Guide(-1,-1,creatingWorldTut.tutorialName,"You can heavily expand your collection of blocks by purchasing them in the shop. There are over 600 blocks to choose from!\n\nLet\'s head over to the shop!",this.shopbar.shopbtn,ButtonType.NEXTSKIPCANCEL,openShop,openShop)];
         creatingWorldTut.addGuides(creatingWorldGuides);
         var purchasingItemsTut:Tutorial = new Tutorial("Purchasing items");
         var purchasingGuides:Array = [new Guide(-1,-1,purchasingItemsTut.tutorialName,"You can purchase items with energy. This regenerates automatically over time, even when you\'re offline.",this.shopbar.energy,ButtonType.NEXTSKIPCANCEL,purchasingItemsTut.nextGuide,tutManager.nextTutorial),new Guide(-1,-1,purchasingItemsTut.tutorialName,"If you don\'t want to wait, you can choose to buy gems with money to buy the items instantly.",this.shopbar.gem,ButtonType.NEXTSKIPCANCEL,purchasingItemsTut.nextGuide,tutManager.nextTutorial),new Guide(-1,10,purchasingItemsTut.tutorialName,"Feel free to look around. Click the next button to continue the tutorial.",new Rectangle(13,95 - 5,Global.playing_on_kongregate || Global.playing_on_armorgames?Number(Config.kongWidth - 27):Number(825),394 + 5),ButtonType.NEXTSKIPCANCEL,tutManager.nextTutorial,tutManager.nextTutorial)];
         purchasingItemsTut.addGuides(purchasingGuides);
         campaignTut = new Tutorial("Campaigns");
         var openCampaign:Function = function():void
         {
            campaignTut.nextGuide();
            if(currentPage != LobbyStatePage.CAMPAIGN)
            {
               setPage(LobbyStatePage.CAMPAIGN);
            }
         };
         var openTutCampaign:Function = function():void
         {
            if(campaignPage.currentCampaign != campaignPage.getCampaignByName("ancient ruins"))
            {
               campaignPage.openCampaign(campaignPage.getCampaignByName("ancient ruins"));
            }
            campaignTut.nextGuide();
         };
         var skipCampaignTut:Function = function():void
         {
            if(currentPage != LobbyStatePage.CAMPAIGN)
            {
               openCampaign();
            }
            tutManager.nextTutorial();
         };
         var rect:Rectangle = new Rectangle(9,93,Global.playing_on_kongregate || Global.playing_on_armorgames?Number(829 - 50):Number(829),402);
         var campaignGuides:Array = [new Guide(-1,-1,campaignTut.tutorialName,"You can increase your maximum amount of energy by beating campaign worlds.",new Rectangle(this.shopbar.campaignbtn.x,this.shopbar.campaignbtn.y,this.shopbar.campaignbtn.width - 4,this.shopbar.campaignbtn.height),ButtonType.NEXTSKIPCANCEL,campaignTut.nextGuide,skipCampaignTut),new Guide(-1,-1,campaignTut.tutorialName,"You can also win energy, or even a couple of gems! Of course this can be used to spend in the shop again.",new Rectangle(this.shopbar.campaignbtn.x,this.shopbar.campaignbtn.y,this.shopbar.campaignbtn.width - 4,this.shopbar.campaignbtn.height),ButtonType.NEXTSKIPCANCEL,openCampaign,skipCampaignTut),new Guide(-1,10,campaignTut.tutorialName,"Campaigns are a series of worlds with a certain theme and similar difficulty.",rect,ButtonType.NEXTSKIPCANCEL,campaignTut.nextGuide,skipCampaignTut),new Guide(-1,10,campaignTut.tutorialName,"Beating an entire campaign will also grant you badges to show off to others!",rect,ButtonType.NEXTSKIPCANCEL,campaignTut.nextGuide,skipCampaignTut),new Guide(-1,10,campaignTut.tutorialName,"Let’s check out the Ancient Ruins campaign!",rect,ButtonType.NEXTSKIPCANCEL,openTutCampaign,skipCampaignTut),new Guide(-1,10,campaignTut.tutorialName,"All of these worlds are made by the community. The amount of campaigns will keep growing.",rect,ButtonType.NEXTSKIPCANCEL,campaignTut.nextGuide,tutManager.nextTutorial),new Guide(-1,10,campaignTut.tutorialName,"The rewards you get for beating each level are displayed under each world.",new Rectangle(22,228,86,50),ButtonType.NEXTSKIPCANCEL,campaignTut.nextGuide,tutManager.nextTutorial),new Guide(-1,10,campaignTut.tutorialName,"You have to beat the worlds in order to unlock the next.",rect,ButtonType.NEXTSKIPCANCEL,tutManager.nextTutorial,tutManager.nextTutorial)];
         campaignTut.addGuides(campaignGuides);
         var backLobby:Tutorial = new Tutorial("Lobby");
         var openLobby:Function = function():void
         {
            if(currentPage != LobbyStatePage.ROOMLIST)
            {
               setPage(LobbyStatePage.ROOMLIST);
            }
            tutManager.nextTutorial();
         };
         var backGuide:Guide = new Guide(-1,-1,backLobby.tutorialName,"For now, let\'s go back to the lobby.",this.shopbar.lobbybtn,ButtonType.NEXTSKIPCANCEL,openLobby,openLobby);
         backLobby.addGuide(backGuide);
         var friendsTut:Tutorial = new Tutorial("Making friends");
         var friendGuide:Guide = new Guide(10,-1,friendsTut.tutorialName,"You may make a friend or two in the game. To easily find them again, you can add them in the Friends menu.",this.mainProfile,ButtonType.NEXTSKIPCANCEL,tutManager.nextTutorial,tutManager.nextTutorial);
         friendsTut.addGuide(friendGuide);
         crewTut = new Tutorial("Teaming up");
         var openCrewTab:Function = function():void
         {
            crewTut.nextGuide();
            if(mainProfile.currentTab != mainProfile.tabbar.tab_crew)
            {
               mainProfile.showContent(mainProfile.tabbar.tab_crew);
            }
         };
         var skipCrew:Function = function():void
         {
            if(mainProfile.currentTab != mainProfile.tabbar.tab_crew)
            {
               openCrewTab();
            }
            tutManager.nextTutorial();
         };
         var openInboxTab:Function = function():void
         {
            if(mainProfile.currentTab != mainProfile.tabbar.tab_inbox)
            {
               mainProfile.showContent(mainProfile.tabbar.tab_inbox);
            }
            tutManager.nextTutorial();
         };
         var crewGuides:Array = [new Guide(10,-1,crewTut.tutorialName,"After you\'ve made some friends, you can form a crew together. This has a few perks that makes building together easier.",this.mainProfile,ButtonType.NEXTSKIPCANCEL,openCrewTab,skipCrew),new Guide(10,-1,crewTut.tutorialName,"You can start a crew by purchasing the Create Crew item from the shop. Or, you can join someone else’s crew.",this.mainProfile,ButtonType.NEXTSKIPCANCEL,openCrewTab,skipCrew),new Guide(10,-1,crewTut.tutorialName,"For some extra explanation, click the Help button in the top right.",this.shopbar.info,ButtonType.NEXTSKIPCANCEL,crewTut.nextGuide,skipCrew),new Guide(10,-1,crewTut.tutorialName,"Crew invites will be displayed under the News tab.",new Rectangle(this.mainProfile.x,this.mainProfile.y,this.mainProfile.width,this.mainProfile.height),ButtonType.NEXTSKIPCANCEL,openInboxTab,openInboxTab)];
         crewTut.addGuides(crewGuides);
         var inboxTut:Tutorial = new Tutorial("Inbox");
         var inboxGuide:Guide = new Guide(10,-1,inboxTut.tutorialName,"You can send messages to your friends, just like email!",new Rectangle(this.mainProfile.x,this.mainProfile.y,this.mainProfile.width,this.mainProfile.height),ButtonType.NEXTSKIPCANCEL,tutManager.nextTutorial,tutManager.nextTutorial);
         inboxTut.addGuide(inboxGuide);
         newsTut = new Tutorial("News");
         var openNewsTab:Function = function():void
         {
            newsTut.nextGuide();
            if(mainProfile.currentTab != mainProfile.tabbar.tab_news)
            {
               mainProfile.showContent(mainProfile.tabbar.tab_news);
            }
         };
         var skipNews:Function = function():void
         {
            if(mainProfile.currentTab != mainProfile.tabbar.tab_news)
            {
               openNewsTab();
            }
            tutManager.nextTutorial();
         };
         var newsGuides:Array = [new Guide(10,-1,newsTut.tutorialName,"Additionally, the staff can send alerts to notify you of important matters in the game.",this.mainProfile,ButtonType.NEXTSKIPCANCEL,openNewsTab,skipNews),new Guide(10,-1,newsTut.tutorialName,"Similarly, if you subscribe to a crew, alerts they send out will be displayed here.",this.mainProfile,ButtonType.NEXTSKIPCANCEL,tutManager.nextTutorial,tutManager.nextTutorial)];
         newsTut.addGuides(newsGuides);
         settingsTut = new Tutorial("Settings");
         var openSettingsMenu:Function = function():void
         {
            settingsTut.nextGuide();
            if(currentPage != LobbyStatePage.SETTINGS)
            {
               setPage(LobbyStatePage.SETTINGS);
            }
         };
         var skipSettings:Function = function():void
         {
            if(currentPage != LobbyStatePage.SETTINGS)
            {
               openSettingsMenu();
            }
            tutManager.nextTutorial();
         };
         var settingsGuides:Array = [new Guide(-1,-1,settingsTut.tutorialName,"Lastly, you can customize your game settings in the Settings menu.",this.shopbar.settingsbtn,ButtonType.NEXTSKIPCANCEL,settingsTut.nextGuide,skipSettings),new Guide(-1,-1,settingsTut.tutorialName,"Let\'s head on over to the settings menu!",this.shopbar.settingsbtn,ButtonType.NEXTSKIPCANCEL,openSettingsMenu,skipSettings),new Guide(-1,10,settingsTut.tutorialName,"Here, you can change all sorts of stuff. Hover over the names of items to see what they do!",rect,ButtonType.NEXTSKIPCANCEL,tutManager.nextTutorial,tutManager.nextTutorial)];
         settingsTut.addGuides(settingsGuides);
         finalTut = new Tutorial("Let\'s get started!");
         var openCampaignPage:Function = function():void
         {
            finalTut.nextGuide();
            if(currentPage != LobbyStatePage.CAMPAIGN)
            {
               setPage(LobbyStatePage.CAMPAIGN);
            }
         };
         var openCampaignTut:Function = function():void
         {
            if(currentPage != LobbyStatePage.CAMPAIGN)
            {
               openCampaignPage();
            }
            finalTut.nextGuide();
            if(campaignPage.currentCampaign != campaignPage.getCampaignByName("tutorials"))
            {
               campaignPage.openCampaign(campaignPage.getCampaignByName("tutorials"));
            }
         };
         var skipFinalGuide:Function = function():void
         {
            if(campaignPage.currentCampaign != campaignPage.getCampaignByName("tutorials"))
            {
               openTutCampaign();
            }
            tutManager.nextTutorial();
         };
         var finalGuides:Array = [new Guide(-1,-1,finalTut.tutorialName,"Go back to the campaign menu to get started.",new Rectangle(this.shopbar.campaignbtn.x,this.shopbar.campaignbtn.y,this.shopbar.campaignbtn.width - 4,this.shopbar.campaignbtn.height),ButtonType.NEXTCANCEL,openCampaignPage),new Guide(-1,10,finalTut.tutorialName,"Let’s start off with the Tutorial campaign to start playing, and learn a thing or two on the way.",rect,ButtonType.NEXTCANCEL,openCampaignTut),new Guide(10,10,finalTut.tutorialName,"For any more questions, discussions, or game suggestions, join the forum!",this.shopbar.info,ButtonType.NEXTCANCEL,finalTut.nextGuide),new Guide(-1,10,finalTut.tutorialName,"Click Tutorial #1 to join the world, or click the close button to end this interactive menu tutorial.",rect,ButtonType.CLOSE)];
         finalTut.addGuides(finalGuides);
         tutManager.addTutorial(introTut);
         tutManager.addTutorial(roomlistTut);
         tutManager.addTutorial(creatingWorldTut);
         tutManager.addTutorial(purchasingItemsTut);
         tutManager.addTutorial(campaignTut);
         tutManager.addTutorial(backLobby);
         tutManager.addTutorial(friendsTut);
         tutManager.addTutorial(crewTut);
         tutManager.addTutorial(inboxTut);
         tutManager.addTutorial(newsTut);
         tutManager.addTutorial(settingsTut);
         tutManager.addTutorial(finalTut);
         tutManager.showTutorial(introTut);
         Global.base.showTutorial(tutManager);
      }
      
      protected function handlePlayerObjectUpdate(param1:Event) : void
      {
         if(Global.playerObject.goldwelcome)
         {
            this.showWelcomeGold();
         }
      }
      
      private function showWelcomeGold() : void
      {
         this.container.addChild(new WelcomeGold());
      }
      
      private function handleShopUpdate(param1:ShopEvent) : void
      {
         var e:ShopEvent = param1;
         if(e.type == ShopEvent.ITEM_AQUIRED)
         {
            Global.base.updatePlayerProperties(function():void
            {
               reloadRooms();
            });
         }
      }
      
      public function reloadRooms() : void
      {
         var to_load:int = 0;
         var all_rooms:Array = null;
         var ready:Function = function():void
         {
            var _loc3_:* = undefined;
            loading_worlds = false;
            if(!Global.player_is_guest)
            {
               PlayerWorlds.addSavedWorlds(all_rooms,Global.base.client);
               PlayerWorlds.addFavorites(all_rooms,Global.base.client);
            }
            enableRefreshButton();
            var _loc1_:Array = [];
            var _loc2_:int = 0;
            while(_loc2_ < all_rooms.length)
            {
               _loc3_ = all_rooms[_loc2_];
               if(_loc3_.data)
               {
                  if(!(_loc3_.data.owned == "true" && !_loc3_.data.name))
                  {
                     if(_loc3_.data.name)
                     {
                        if(!(_loc3_.id != "ChrisWorld" && _loc3_.data.name.replace(/benjaminsen|benjaminson/gi,"") != _loc3_.data.name))
                        {
                           _loc1_.push(_loc3_);
                        }
                     }
                  }
               }
               _loc2_++;
            }
            newfilter.btn_reload.rotator.gotoAndStop(1);
            redrawRooms(_loc1_);
         };
         this.newfilter.btn_reload.rotator.play();
         this.refreshtimer = new Timer(1000,1);
         this.refreshtimer.addEventListener(TimerEvent.TIMER_COMPLETE,function(param1:TimerEvent):void
         {
            if(refreshtimer != null)
            {
               refreshtimer.stop();
               refreshtimer = null;
            }
            enableRefreshButton();
         });
         this.refreshtimer.start();
         this.newfilter.enableRefreshButton(false);
         this.roomlist.setRooms([]);
         this.roomlist.doRender(true);
         this.loading_worlds = true;
         this.last_world_reload = new Date();
         var loaded:int = 0;
         to_load = 1;
         all_rooms = [];
         to_load++;
         Global.client.multiplayer.listRooms(Config.server_type_betaroom,{},0,0,function(param1:Array):void
         {
            all_rooms = all_rooms.concat(param1);
            if(++loaded == to_load)
            {
               ready();
            }
         },this.handleLoadRoomError);
         Global.client.multiplayer.listRooms(Config.server_type_normalroom,{},0,0,function(param1:Array):void
         {
            all_rooms = all_rooms.concat(param1);
            if(++loaded == to_load)
            {
               ready();
            }
         },this.handleLoadRoomError);
      }
      
      private function enableRefreshButton() : void
      {
         this.newfilter.enableRefreshButton(this.refreshtimer == null && !this.loading_worlds);
      }
      
      private function handleLoadRoomError(param1:PlayerIOError) : void
      {
      }
      
      private function redrawRooms(param1:Array) : void
      {
         this.roomlist.setRooms(param1);
         this.roomlist.doRender(false);
         this.refresh(param1);
      }
      
      private function initNews() : void
      {
         Global.base.requestRemoteMethod("getNews",function(param1:Message):void
         {
            var loader:Loader = null;
            var msg:Message = param1;
            announce = new News();
            annbg = new BlackBG();
            announce.tf_header.text = msg.getString(0);
            announce.tf_body.autoSize = TextFieldAutoSize.LEFT;
            announce.tf_body.htmlText = msg.getString(1);
            announce.tf_date.text = msg.getString(2);
            loader = new Loader();
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE,function(param1:Event):void
            {
               announce.imageloader.visible = false;
               loader.y = announce.tf_body.y + announce.tf_body.textHeight + 10;
               loader.x = announce.bg.x + (announce.bg.width - loader.width) / 2;
               announce.addChild(loader);
            });
            loader.load(new URLRequest(msg.getString(3)));
            announce.cacheAsBitmap = true;
            announce.x = (Global.width - 300) / 2;
            announce.btnreadblog.useHandCursor = true;
            announce.btnreadblog.addEventListener(MouseEvent.MOUSE_DOWN,function():void
            {
               Bl.stage.dispatchEvent(new NavigationEvent(NavigationEvent.SHOW_BLOG,true,false));
            });
            announce.btn_close.addEventListener(MouseEvent.MOUSE_DOWN,function():void
            {
               announce.visible = false;
               annbg.visible = false;
               if(!Global.sharedCookie.data.hasOwnProperty("news"))
               {
                  Global.sharedCookie.data.news = "";
               }
               if((Global.sharedCookie.data.news as String).search(announce.tf_date.text) == -1)
               {
                  Global.sharedCookie.data.news = Global.sharedCookie.data.news + ("[" + announce.tf_date.text + "]");
                  Global.sharedCookie.flush();
               }
            });
            if(!Global.sharedCookie.data.hasOwnProperty("news"))
            {
               Global.sharedCookie.data.news = "";
            }
            announce.visible = annbg.visible = firstDailyLogin && (Global.sharedCookie.data.news as String).search(announce.tf_date.text) == -1;
            container.addChild(annbg);
            container.addChild(announce);
         },Config.debug_news || "");
      }
      
      public function validateEmail(param1:String) : Boolean
      {
         var _loc2_:RegExp = /^[a-z0-9][-._a-z0-9]*@([a-z0-9][-_a-z0-9]*\.)+[a-z]{2,6}$/;
         return _loc2_.test(param1);
      }
      
      public function refresh(param1:Array) : void
      {
         var _loc3_:RoomInfo = null;
         this.online = 0;
         this.wonline = 0;
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            _loc3_ = param1[_loc2_] as RoomInfo;
            if(_loc3_)
            {
               this.online = this.online + _loc3_.onlineUsers;
               if(_loc3_.onlineUsers > 0)
               {
                  this.wonline++;
               }
            }
            _loc2_++;
         }
         this.setSubtextArray([this.online + " Players Online - " + this.wonline + " Worlds Online"]);
      }
      
      public function setSubtextArray(param1:Array) : void
      {
         this.texts = param1;
         this.curText = 0;
         if(this.texts.length > 0)
         {
            this.updateText();
         }
      }
      
      override public function draw(param1:BitmapData, param2:int, param3:int) : void
      {
         param1.fillRect(param1.rect,0);
         Global.stage.frameRate = 120;
         if(this.texts.length > 1)
         {
            if(this.textTime++ == 30 * 5)
            {
               this.updateText();
            }
         }
      }
      
      public function updateText() : void
      {
         TweenMax.to(this.bm_subtext_holder,0.3,{
            "alpha":0,
            "onComplete":function():void
            {
               try
               {
                  subtext.text = texts[curText++];
                  if(bm_subtext != null)
                  {
                     bm_subtext_holder.removeChild(bm_subtext);
                  }
                  bm_subtext = new Bitmap(subtext.clone());
                  bm_subtext.y = 42 + (!show_guest_layout?30:0);
                  bm_subtext.x = 10;
                  bm_subtext_holder.addChild(bm_subtext);
                  TweenMax.to(bm_subtext_holder,0.3,{"alpha":1});
                  return;
               }
               catch(e:Error)
               {
                  return;
               }
            }
         });
         this.textTime = 0;
         if(this.curText > this.texts.length - 1)
         {
            this.curText = 0;
         }
      }
      
      private function joinRoomDirectly(param1:String) : void
      {
         this.reset();
         this.callback(param1);
      }
      
      private function joinRoom(param1:String, param2:String, param3:Object) : void
      {
         var _loc4_:Array = null;
         this.reset();
         if(param3.data.myworld)
         {
            if(param1 == "savedworld")
            {
               this.myroomsCallback();
            }
            else if(param1 == "savedbetaworld")
            {
               this.myroomsCallback(true);
            }
            else if(param1.substring(0,2) == "PW" || param1.substring(0,2) == "BW")
            {
               Bl.data.roomname = param2;
               this.callback(param1);
            }
            else
            {
               _loc4_ = param1.split("x");
               this.handleJoinSaved(_loc4_[0],_loc4_[1]);
            }
         }
         else
         {
            Bl.data.roomname = param2;
            this.callback(param1);
         }
      }
      
      private function createRoom(param1:String, param2:String, param3:Boolean = false) : void
      {
         if(param2 != "")
         {
            Bl.data.createdOpenWorldWithKey = true;
         }
         this.reset();
         this.createCallback(param1,param2);
      }
      
      public function showLoadRoom() : void
      {
         var bg:BlackBG = null;
         this.loadroom = new LoadRoom();
         bg = new BlackBG();
         this.loadroom.x = (Global.width - 327) / 2;
         this.loadroom.alpha = 0;
         this.loadroom.roomid.text = "";
         bg.alpha = 0;
         this.container.addChild(bg);
         this.container.addChild(this.loadroom);
         TweenMax.to(this.loadroom,0.3,{"alpha":1});
         TweenMax.to(bg,0.3,{"alpha":1});
         this.loadroom.closebtn.addEventListener(MouseEvent.MOUSE_DOWN,function():void
         {
            TweenMax.to(loadroom,0.3,{
               "alpha":0,
               "onComplete":function():void
               {
                  TweenMax.to(bg,0.25,{
                     "alpha":0,
                     "onComplete":function():void
                     {
                        if(bg.parent)
                        {
                           bg.parent.removeChild(bg);
                        }
                     }
                  });
                  if(loadroom.parent)
                  {
                     loadroom.parent.removeChild(loadroom);
                  }
               }
            });
         });
         this.loadroom.btn_join.addEventListener(MouseEvent.MOUSE_DOWN,function():void
         {
            joinRoomDirectly(StringUtil.trim(loadroom.roomid.text));
         });
      }
      
      override public function resize() : void
      {
         if(this._mainProfile != null)
         {
            this._mainProfile.width = Global.width - this._mainProfile.x - 13;
         }
         this.shopbar.shop.x = 13;
         this.shopbar.shop.y = 116;
         var _loc1_:DisplayObject = this.container.getChildByName("GetGemsNow");
         if(_loc1_)
         {
            _loc1_.x = (Global.width - 606) / 2;
         }
         var _loc2_:DisplayObject = this.container.getChildByName("Thankyou");
         if(_loc2_)
         {
            _loc2_.x = (Global.width - 472) / 2;
         }
         if(this.announce != null)
         {
            this.announce.x = (Global.width - 300) / 2;
         }
         if(this.createroom != null)
         {
            this.createroom.x = (Global.width - 327) / 2;
         }
         if(this.fbtextfield != null)
         {
            this.fbtextfield.x = Global.width - 10;
         }
         if(!this.show_guest_layout)
         {
            this.container.x = Math.round((Bl.stage.stageWidth - Global.width) / 2);
         }
         else
         {
            this.container.x = Math.round((Bl.stage.stageWidth - 640) / 2);
         }
      }
      
      public function reset() : void
      {
         this.removeBackgrounds();
         Global.stage.frameRate = Config.maxFrameRate;
         if(this.fbtextfield && this.fbtextfield.parent)
         {
            this.container.removeChild(this.fbtextfield);
         }
         if(this.roomlist && this.roomlist.parent)
         {
            this.container.removeChild(this.roomlist);
         }
         if(this.createroom && this.createroom.parent)
         {
            this.container.removeChild(this.createroom);
         }
         if(this.tw && this.tw.parent)
         {
            this.tw.parent.removeChild(this.tw);
         }
         if(this.loginbox && this.loginbox.parent)
         {
            this.container.removeChild(this.loginbox);
         }
         if(this.shopbar && this.shopbar.parent)
         {
            this.shopbar.parent.removeChild(this.shopbar);
         }
         if(this.container && this.container.parent)
         {
            this.container.parent.removeChild(this.container);
         }
      }
      
      public function setPage(param1:String) : void
      {
         this.currentPage = param1;
         switch(param1)
         {
            case LobbyStatePage.ROOMLIST:
               this.setSubtextArray([this.online + " Players Online - " + this.wonline + " Worlds Online"]);
               this.shopbar.setHighlight(this.shopbar.lobbybtn);
               break;
            case LobbyStatePage.ENERGY_SHOP:
               this.shopbar.refreshSubtext();
               this.shopbar.setHighlight(this.shopbar.shopbtn.highlight);
               break;
            case LobbyStatePage.CAMPAIGN:
               this.shopbar.setHighlight(this.shopbar.campaignbtn);
               if(this.campaignPage == null)
               {
                  this.campaignPage = new CampaignPage(this,null);
               }
               this.campaignPage.x = 13;
               this.campaignPage.y = 95;
               this.campaignPage.width = Global.playing_on_kongregate || Global.playing_on_armorgames?Number(Config.kongWidth - 27):Number(825);
               this.campaignPage.height = 394;
               if(!this.container.contains(this.campaignPage))
               {
                  this.container.addChild(this.campaignPage);
               }
               if(this.campaignPageBorder == null)
               {
                  this.campaignPageBorder = new Sprite();
               }
               this.campaignPageBorder.graphics.lineStyle(1,10066329);
               this.campaignPageBorder.graphics.drawRoundRect(0,0,Global.playing_on_kongregate || Global.playing_on_armorgames?Number(Config.kongWidth - 29):Number(823),393,5,5);
               this.campaignPageBorder.x = 13;
               this.campaignPageBorder.y = 95;
               if(!this.container.contains(this.campaignPageBorder))
               {
                  this.container.addChild(this.campaignPageBorder);
               }
               this.campaignPage.refreshSubtext();
               break;
            case LobbyStatePage.SETTINGS:
               this.setSubtextArray(["Adjust the games settings to your needs!"]);
               this.shopbar.setHighlight(this.shopbar.settingsbtn);
               if(this.settingsPage == null)
               {
                  this.settingsPage = new SettingsPage();
                  this.settingsPage.x = 13;
                  this.settingsPage.y = 97;
                  this.settingsPage.height = 394;
               }
               if(!this.container.contains(this.settingsPage))
               {
                  this.container.addChild(this.settingsPage);
               }
         }
         this.setObj(this.roomlist,LobbyStatePage.ROOMLIST);
         this.setObj(this.newfilter,LobbyStatePage.ROOMLIST);
         this.setObj(this._mainProfile,LobbyStatePage.ROOMLIST);
         this.setObj(this.campaignPage,LobbyStatePage.CAMPAIGN);
         this.setObj(this.campaignPageBorder,LobbyStatePage.CAMPAIGN);
         this.setObj(this.settingsPage,LobbyStatePage.SETTINGS);
         this.setObj(this.shopbar.shop,LobbyStatePage.ENERGY_SHOP);
      }
      
      public function get mainProfile() : MainProfile
      {
         return this._mainProfile;
      }
      
      public function setObj(param1:Object, param2:String) : void
      {
         if(param1 != null)
         {
            TweenMax.to(param1,0.8,{"alpha":int(this.currentPage == param2)});
            param1.visible = this.currentPage == param2?true:false;
         }
      }
      
      public function removeBackgrounds() : void
      {
         if(Global.base.contains(this.world_image))
         {
            Global.base.removeChild(this.world_image);
         }
         if(Global.base.contains(this.world_image_overlay))
         {
            Global.base.removeChild(this.world_image_overlay);
         }
      }
      
      override public function get align() : String
      {
         return STATE_ALIGN_LEFT;
      }
   }
}
