package ui.shop
{
   import com.greensock.TweenMax;
   import data.ShopItemData;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextFieldAutoSize;
   import states.LobbyState;
   import states.LobbyStatePage;
   
   public class ShopBar extends assets_shopbar
   {
       
      
      private var mainshop:MainShop;
      
      private var spacing:int = 13;
      
      private var spacing_2:int = 10;
      
      private var spacing_3:int = 5;
      
      private var lastenergy:int = -1;
      
      private var lastgems:int = -1;
      
      public function ShopBar()
      {
         super();
         shop.visible = false;
         shop.gotoAndStop(Global.playing_on_kongregate || Global.playing_on_armorgames?2:1);
         shopbtn.buttonMode = true;
         this.mainshop = new MainShop();
         this.mainshop.x = 10;
         this.mainshop.y = -21;
         shop.addChild(this.mainshop);
         energy.timetonext.autoSize = TextFieldAutoSize.LEFT;
         energy.energy.autoSize = TextFieldAutoSize.LEFT;
         gem.gems.autoSize = TextFieldAutoSize.LEFT;
         username.tf_username.autoSize = TextFieldAutoSize.LEFT;
         crewname.tf_crewname.autoSize = TextFieldAutoSize.LEFT;
         logout_btn.visible = !(Global.playing_on_kongregate || Global.playing_on_armorgames || Global.playing_on_faceboook || Global.playing_on_mousebreaker);
         logout_btn.addEventListener(MouseEvent.CLICK,this.handleLogoutButton,false,0,true);
         info.help_btn.mouseChildren = false;
         info.help_btn.mouseEnabled = true;
         info.help_btn.buttonMode = true;
         info.help_btn.addEventListener(MouseEvent.CLICK,this.handleHelpButton,false,0,true);
         info.blog_btn.mouseChildren = false;
         info.blog_btn.mouseEnabled = true;
         info.blog_btn.buttonMode = true;
         info.blog_btn.addEventListener(MouseEvent.CLICK,this.handleBlogButton,false,0,true);
         info.terms_btn.mouseChildren = false;
         info.terms_btn.mouseEnabled = true;
         info.terms_btn.buttonMode = true;
         info.terms_btn.addEventListener(MouseEvent.CLICK,this.handleTermsButton,false,0,true);
         info.forums_btn.mouseChildren = false;
         info.forums_btn.mouseEnabled = true;
         info.forums_btn.buttonMode = true;
         info.forums_btn.addEventListener(MouseEvent.CLICK,this.handleForumsButton,false,0,true);
         lobbybtn.buttonMode = true;
         lobbybtn.useHandCursor = true;
         campaignbtn.buttonMode = true;
         campaignbtn.useHandCursor = true;
         settingsbtn.buttonMode = true;
         settingsbtn.useHandCursor = true;
         this.setHighlight(lobbybtn);
         addEventListener(Event.ADDED_TO_STAGE,this.handleAddedToStage,false,0,true);
      }
      
      protected function handleLogoutButton(param1:MouseEvent) : void
      {
         var _loc2_:NavigationEvent = new NavigationEvent(NavigationEvent.LOGOUT,true,false);
         dispatchEvent(_loc2_);
      }
      
      protected function handleHelpButton(param1:MouseEvent) : void
      {
         var _loc2_:NavigationEvent = new NavigationEvent(NavigationEvent.SHOW_HELP,true,false);
         dispatchEvent(_loc2_);
      }
      
      protected function handleBlogButton(param1:MouseEvent) : void
      {
         var _loc2_:NavigationEvent = new NavigationEvent(NavigationEvent.SHOW_BLOG,true,false);
         dispatchEvent(_loc2_);
      }
      
      protected function handleTermsButton(param1:MouseEvent) : void
      {
         var _loc2_:NavigationEvent = new NavigationEvent(NavigationEvent.SHOW_TERMS,true,false);
         dispatchEvent(_loc2_);
      }
      
      protected function handleForumsButton(param1:MouseEvent) : void
      {
         var _loc2_:NavigationEvent = new NavigationEvent(NavigationEvent.SHOW_FORUMS,true,false);
         dispatchEvent(_loc2_);
      }
      
      public function resize() : void
      {
         bg.width = Global.width + 4;
         logout_btn.x = bg.width - logout_btn.width;
         if(logout_btn.visible)
         {
            energy.x = logout_btn.x - energy.width - 5;
         }
         else
         {
            energy.x = bg.width - energy.width - 5;
         }
         gem.div.x = gem.gems.width + gem.gems.x + 5;
         gem.x = energy.x - gem.width - 12;
         username.x = bg.width - username.width - 13;
         if(crewname.visible)
         {
            crewname.div.x = crewname.tf_crewname.width + 5;
            crewname.x = username.x - crewname.width - 5;
         }
         info.x = bg.width - info.width - 13;
      }
      
      protected function handleAddedToStage(param1:Event) : void
      {
         var lobbystate:LobbyState = null;
         var event:Event = param1;
         removeEventListener(Event.ADDED_TO_STAGE,this.handleAddedToStage);
         addEventListener(Event.REMOVED_FROM_STAGE,this.handleRemovedFromStage,false,0,true);
         gem.addEventListener(MouseEvent.CLICK,function():void
         {
            Shop.getMoreGems();
         });
         username.gotoAndStop(1);
         username.buttonMode = true;
         username.useHandCursor = true;
         username.mouseChildren = false;
         username.addEventListener(MouseEvent.CLICK,function(param1:MouseEvent):void
         {
            var _loc2_:NavigationEvent = new NavigationEvent(NavigationEvent.SHOW_PROFILE,true);
            _loc2_.username = Global.playerObject.name;
            dispatchEvent(_loc2_);
         });
         username.addEventListener(MouseEvent.MOUSE_OVER,function(param1:MouseEvent):void
         {
            username.gotoAndStop(2);
            username.highlight.width = username.tf_username.width - 3;
         });
         username.addEventListener(MouseEvent.MOUSE_OUT,function(param1:MouseEvent):void
         {
            username.gotoAndStop(1);
         });
         crewname.gotoAndStop(1);
         crewname.buttonMode = true;
         crewname.useHandCursor = true;
         crewname.mouseChildren = false;
         crewname.addEventListener(MouseEvent.CLICK,function(param1:MouseEvent):void
         {
            var _loc2_:NavigationEvent = new NavigationEvent(NavigationEvent.SHOW_CREW_PROFILE,true);
            _loc2_.crewname = Global.currentCrew.substring(4);
            dispatchEvent(_loc2_);
         });
         crewname.addEventListener(MouseEvent.MOUSE_OVER,function(param1:MouseEvent):void
         {
            crewname.gotoAndStop(2);
            crewname.highlight.width = crewname.tf_crewname.width - 3;
         });
         crewname.addEventListener(MouseEvent.MOUSE_OUT,function(param1:MouseEvent):void
         {
            crewname.gotoAndStop(1);
         });
         this.refreshTopBar();
         shopbtn.gotoAndStop(!!Shop.hasSeenNewest()?1:3);
         lobbybtn.addEventListener(MouseEvent.CLICK,function():void
         {
            lobbystate = Global.base.state as LobbyState;
            lobbystate.setPage(LobbyStatePage.ROOMLIST);
            lobbystate.reloadRooms();
            setHighlight(lobbybtn);
         });
         campaignbtn.addEventListener(MouseEvent.CLICK,function():void
         {
            lobbystate = Global.base.state as LobbyState;
            lobbystate.setPage(LobbyStatePage.CAMPAIGN);
            setHighlight(campaignbtn);
         });
         settingsbtn.addEventListener(MouseEvent.CLICK,function():void
         {
            lobbystate = Global.base.state as LobbyState;
            lobbystate.setPage(LobbyStatePage.SETTINGS);
            setHighlight(settingsbtn);
         });
         shopbtn.addEventListener(MouseEvent.CLICK,function():void
         {
            lobbystate = Global.base.state as LobbyState;
            lobbystate.setPage(LobbyStatePage.ENERGY_SHOP);
            mainshop.refreshTab();
            refreshSubtext();
            if(shopbtn.currentFrame == 3)
            {
               shopbtn.gotoAndStop(1);
            }
            Shop.setSeenNewest();
            setHighlight(shopbtn.highlight);
         });
         stage.addEventListener(ShopEvent.OPEN_MAINSHOP,this.handleOpenMainShopRequest,false,0,true);
         shopbtn.addEventListener(MouseEvent.MOUSE_MOVE,function():void
         {
            if(shopbtn.highlight.currentFrame == 1)
            {
               shopbtn.highlight.gotoAndStop(2);
            }
         },false,0);
         shopbtn.addEventListener(MouseEvent.MOUSE_OUT,function():void
         {
            if(shopbtn.highlight.currentFrame == 2)
            {
               shopbtn.highlight.gotoAndStop(1);
            }
         },false,0);
         lobbybtn.addEventListener(MouseEvent.MOUSE_MOVE,function():void
         {
            if(lobbybtn.currentFrame == 1)
            {
               lobbybtn.gotoAndStop(2);
            }
         },false,0);
         lobbybtn.addEventListener(MouseEvent.MOUSE_OUT,function():void
         {
            if(lobbybtn.currentFrame == 2)
            {
               lobbybtn.gotoAndStop(1);
            }
         },false,0);
         settingsbtn.addEventListener(MouseEvent.MOUSE_MOVE,function():void
         {
            if(settingsbtn.currentFrame == 1)
            {
               settingsbtn.gotoAndStop(2);
            }
         },false,0);
         settingsbtn.addEventListener(MouseEvent.MOUSE_OUT,function():void
         {
            if(settingsbtn.currentFrame == 2)
            {
               settingsbtn.gotoAndStop(1);
            }
         },false,0);
         campaignbtn.addEventListener(MouseEvent.MOUSE_MOVE,function():void
         {
            if(campaignbtn.currentFrame == 1)
            {
               campaignbtn.gotoAndStop(2);
            }
         },false,0);
         campaignbtn.addEventListener(MouseEvent.MOUSE_OUT,function():void
         {
            if(campaignbtn.currentFrame == 2)
            {
               campaignbtn.gotoAndStop(1);
            }
         },false,0);
         this.resize();
         addEventListener(Event.ENTER_FRAME,this.handleEnterFrame,false,0,true);
      }
      
      public function refreshSubtext() : void
      {
         var _loc4_:String = null;
         var _loc1_:Array = [];
         var _loc2_:Vector.<ShopItemData> = Shop.getImportantShopItems();
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc4_ = "NEW";
            if(_loc2_[_loc3_].isOnSale)
            {
               _loc4_ = "SALE";
            }
            _loc1_.push(_loc4_ + " - " + _loc2_[_loc3_].text_header);
            _loc3_++;
         }
         (Global.base.state as LobbyState).setSubtextArray(_loc1_);
      }
      
      public function setHighlight(param1:*) : void
      {
         lobbybtn.gotoAndStop(param1 == lobbybtn?3:1);
         campaignbtn.gotoAndStop(param1 == campaignbtn?3:1);
         settingsbtn.gotoAndStop(param1 == settingsbtn?3:1);
         shopbtn.highlight.gotoAndStop(param1 == shopbtn.highlight?3:1);
      }
      
      protected function handleOpenMainShopRequest(param1:ShopEvent) : void
      {
         this.openShop();
         this.mainshop.showTab(param1.tab);
      }
      
      private function openShop() : void
      {
         shop.visible = true;
      }
      
      protected function handleRemovedFromStage(param1:Event) : void
      {
         removeEventListener(Event.ENTER_FRAME,this.handleEnterFrame);
      }
      
      protected function handleEnterFrame(param1:Event) : void
      {
         this.refreshTopBar();
      }
      
      public function glowEnergy() : void
      {
         TweenMax.to(energy.bolt,0.7,{
            "glowFilter":{
               "color":16514925,
               "alpha":1,
               "blurX":10,
               "blurY":10
            },
            "onComplete":function():void
            {
               TweenMax.to(energy.bolt,0.7,{"glowFilter":{
                  "color":16514925,
                  "alpha":0,
                  "blurX":10,
                  "blurY":10,
                  "remove":true
               }});
            }
         });
      }
      
      public function glowGems() : void
      {
         TweenMax.to(gem.gem,0.7,{
            "glowFilter":{
               "color":16711680,
               "alpha":1,
               "blurX":10,
               "blurY":10
            },
            "onComplete":function():void
            {
               TweenMax.to(gem.gem,0.7,{"glowFilter":{
                  "color":16711680,
                  "alpha":0,
                  "blurX":10,
                  "blurY":10,
                  "remove":true
               }});
            }
         });
      }
      
      public function setCrewName(param1:String) : void
      {
         if(crewname)
         {
            if(!crewname.visible)
            {
               crewname.visible = true;
            }
            crewname.tf_crewname.text = param1;
         }
      }
      
      public function refreshTopBar() : void
      {
         var _loc1_:* = false;
         if(!Global.player_is_guest)
         {
            if(!Shop.isInitiallyRefreshed())
            {
               return;
            }
            _loc1_ = Shop.energy != Shop.totalEnergy;
            gem.gems.text = "Gems: " + Shop.gems;
            username.tf_username.text = Global.playerObject.name.toUpperCase();
            if(Global.currentCrewName)
            {
               crewname.tf_crewname.text = Global.currentCrewName;
            }
            else
            {
               crewname.visible = false;
            }
            energy.energy.text = "Energy: " + Shop.energy + "/" + Shop.totalEnergy;
            if(Shop.energy < Shop.totalEnergy)
            {
               energy.timetonext.text = "More in: " + Shop.prettyTimeToNext;
               energy.timetonext.visible = true;
            }
            else
            {
               energy.timetonext.visible = false;
            }
            energy.energy.y = !!energy.timetonext.visible?Number(0):Number(5);
            if(this.lastenergy != Shop.energy && this.lastenergy != -1)
            {
               this.glowEnergy();
            }
            if(this.lastgems != Shop.gems && this.lastgems != -1)
            {
               this.glowGems();
            }
            this.lastenergy = Shop.energy;
            this.lastgems = Shop.gems;
         }
         else
         {
            gem.gems.text = "Gems: 0";
            gem.visible = false;
            username.visible = false;
            crewname.visible = false;
            this.campaignbtn.visible = false;
            this.shopbtn.visible = false;
            this.settingsbtn.visible = false;
            energy.energy.text = "No Energy!";
            energy.timetonext.text = "Register to use";
            energy.energy.y = !!energy.timetonext.visible?Number(0):Number(5);
         }
         this.resize();
      }
   }
}
