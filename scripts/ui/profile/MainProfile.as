package ui.profile
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import sample.ui.components.Box;
   import ui.profile.Alerts.MyNews;
   import ui.profile.Crew.MyCrew;
   
   public class MainProfile extends asset_MainProfile
   {
       
      
      public var currentTab:MovieClip;
      
      private var content:Box;
      
      private var currentcontent:Sprite;
      
      private var myworlds:MyWorlds;
      
      private var myfriends:MyFriends;
      
      private var _myCrew:MyCrew;
      
      private var myinbox:MyInbox;
      
      private var mynews:MyNews;
      
      private var loadinganim:Box;
      
      private var newAlert:Boolean = false;
      
      private var newMail:Boolean = false;
      
      private var names:Array;
      
      private var tabTimer:Timer;
      
      public function MainProfile()
      {
         this.content = new Box();
         this.loadinganim = new Box();
         this.names = ["friends","crew","worlds","inbox","news"];
         super();
         this.content.y = 50;
         this.content.margin(10,10,10,10);
         this.loadinganim.addChild(new assets_miniloading());
         this.loadinganim.forceScale = false;
         this.loadinganim.margin(150,NaN,NaN,Global.playing_on_kongregate || Global.playing_on_armorgames?Number(250 - 25):Number(250));
         this.tabTimer = new Timer(1000,0);
         this.tabTimer.addEventListener(TimerEvent.TIMER,function(param1:TimerEvent):void
         {
            tabTimer.stop();
         });
         if(!Global.player_is_guest)
         {
            this.initTabs();
            this.showContent(tabbar.tab_friends);
         }
         else
         {
            tabbar.visible = false;
            bg.height = bg.height + bg.y;
            bg.y = bg_upper.y;
            this.content.margin(10,0,0,0);
            this.content.add(new RegisterAd());
         }
         addChild(this.content);
         addEventListener(Event.ADDED_TO_STAGE,this.handleAddedToStage);
      }
      
      private function initTabs() : void
      {
         var _loc2_:MovieClip = null;
         var _loc1_:int = 0;
         while(_loc1_ < 5)
         {
            _loc2_ = tabbar.getChildByName("tab_" + this.names[_loc1_]) as MovieClip;
            _loc2_.gotoAndStop(1);
            _loc2_.buttonMode = true;
            _loc2_.useHandCursor = true;
            _loc2_.addEventListener(MouseEvent.MOUSE_OVER,this.handleMouseOver);
            _loc2_.addEventListener(MouseEvent.MOUSE_OUT,this.handleMouseOut);
            _loc1_++;
         }
         tabbar.tab_news.tf_text.mouseEnabled = false;
         tabbar.tab_news.alertIcon.mouseEnabled = false;
         tabbar.tab_news.alertIcon.mouseChildren = false;
         tabbar.tab_inbox.tf_text.mouseEnabled = false;
         tabbar.tab_inbox.alertIcon.mouseEnabled = false;
         tabbar.tab_inbox.alertIcon.mouseChildren = false;
         tabbar.addEventListener(MouseEvent.CLICK,this.handleMouseClick);
         this.hideNewAlert();
         this.hideNewMail();
      }
      
      protected function handleMouseOver(param1:MouseEvent) : void
      {
         (param1.target as MovieClip).gotoAndStop(2);
      }
      
      protected function handleMouseOut(param1:MouseEvent) : void
      {
         if(this.currentTab != param1.target as MovieClip)
         {
            (param1.target as MovieClip).gotoAndStop(1);
         }
      }
      
      protected function handleMouseClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         if(!this.tabTimer.running)
         {
            _loc2_ = 0;
            while(_loc2_ < 5)
            {
               _loc3_ = tabbar.getChildByName("tab_" + this.names[_loc2_]) as MovieClip;
               _loc3_.gotoAndStop(1);
               _loc2_++;
            }
            this.tabTimer.start();
            this.showContent(param1.target as MovieClip);
         }
      }
      
      public function showContent(param1:MovieClip) : void
      {
         var t:MovieClip = null;
         var tab:MovieClip = param1;
         if(this.currentcontent != null && this.currentcontent.stage != null)
         {
            this.content.removeChild(this.currentcontent);
         }
         this.content.add(this.loadinganim);
         var i:int = 0;
         while(i < 5)
         {
            t = tabbar.getChildByName("tab_" + this.names[i]) as MovieClip;
            t.gotoAndStop(1);
            i++;
         }
         this.currentTab = tab;
         this.currentTab.gotoAndStop(2);
         switch(tab)
         {
            case tabbar.tab_friends:
               if(!this.myfriends)
               {
                  this.myfriends = new MyFriends();
               }
               this.myfriends.refresh(function():void
               {
                  onContentReady(myfriends);
                  if(myinbox)
                  {
                     myinbox.friendNames = myfriends.friendNames;
                  }
               });
               break;
            case tabbar.tab_worlds:
               if(!this.myworlds)
               {
                  this.myworlds = new MyWorlds();
               }
               this.onContentReady(this.myworlds);
               break;
            case tabbar.tab_crew:
               if(!this._myCrew)
               {
                  this._myCrew = new MyCrew();
               }
               this._myCrew.refresh(function():void
               {
                  onContentReady(_myCrew);
               });
               break;
            case tabbar.tab_inbox:
               if(this.newMail)
               {
                  this.hideNewMail();
               }
               if(!this.myinbox)
               {
                  this.myinbox = new MyInbox();
               }
               this.myinbox.refresh(function():void
               {
                  onContentReady(myinbox);
                  if(myfriends)
                  {
                     myinbox.friendNames = myfriends.friendNames;
                  }
                  myinbox.setSeenNewest();
                  hideNewMail();
               });
               break;
            case tabbar.tab_news:
               if(this.newAlert)
               {
                  this.hideNewAlert();
               }
               if(!this.mynews)
               {
                  this.mynews = new MyNews();
               }
               this.mynews.refresh(function():void
               {
                  onContentReady(mynews);
                  mynews.setSeenNewest();
                  hideNewAlert();
               });
         }
      }
      
      public function get myCrew() : MyCrew
      {
         return this._myCrew;
      }
      
      public function get myInbox() : MyInbox
      {
         return this.myinbox;
      }
      
      private function onContentReady(param1:Sprite) : void
      {
         if(this.currentcontent == null || this.currentcontent.stage == null)
         {
            if(this.content.contains(this.loadinganim))
            {
               this.content.removeChild(this.loadinganim);
            }
            this.currentcontent = param1;
            this.content.add(param1);
         }
      }
      
      public function showNewAlert() : void
      {
         this.newAlert = true;
         if(tabbar.tab_news.alertIcon.visible != true)
         {
            tabbar.tab_news.alertIcon.visible = true;
         }
         if(tabbar.tab_news.tf_text.x != 30)
         {
            tabbar.tab_news.tf_text.x = 30;
         }
      }
      
      public function hideNewAlert() : void
      {
         this.newAlert = false;
         if(tabbar.tab_news.alertIcon.visible != false)
         {
            tabbar.tab_news.alertIcon.visible = false;
         }
         if(tabbar.tab_news.tf_text.x != 18)
         {
            tabbar.tab_news.tf_text.x = 18;
         }
      }
      
      public function showNewMail() : void
      {
         this.newMail = true;
         if(tabbar.tab_inbox.alertIcon.visible != true)
         {
            tabbar.tab_inbox.alertIcon.visible = true;
         }
         if(tabbar.tab_inbox.tf_text.x != 26)
         {
            tabbar.tab_inbox.tf_text.x = 26;
         }
      }
      
      public function hideNewMail() : void
      {
         this.newMail = false;
         if(tabbar.tab_inbox.alertIcon.visible != false)
         {
            tabbar.tab_inbox.alertIcon.visible = false;
         }
         if(tabbar.tab_inbox.tf_text.x != 14)
         {
            tabbar.tab_inbox.tf_text.x = 14;
         }
      }
      
      private function handleAddedToStage(param1:Event) : void
      {
         var e:Event = param1;
         removeEventListener(Event.ADDED_TO_STAGE,this.handleAddedToStage);
         this.mynews = new MyNews();
         this.mynews.refresh(function(param1:Boolean = false):void
         {
            if(param1)
            {
               if(mynews.hasSeenNewest)
               {
                  hideNewAlert();
               }
               else
               {
                  showNewAlert();
               }
            }
         });
         this.myinbox = new MyInbox();
         this.myinbox.refresh(function(param1:Boolean = false):void
         {
            if(param1)
            {
               if(myinbox.hasSeenNewest)
               {
                  hideNewMail();
               }
               else
               {
                  showNewMail();
               }
            }
         });
      }
      
      override public function set width(param1:Number) : void
      {
         bg.width = bg_upper.width = param1;
         if(!Global.player_is_guest)
         {
            tabbar.width = param1;
         }
         this.content.width = bg.width;
         this.content.height = bg.height;
      }
   }
}
