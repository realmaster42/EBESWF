package ui.campaigns
{
   import com.greensock.TweenMax;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.text.TextFieldAutoSize;
   import playerio.Message;
   import sample.ui.components.Box;
   import sample.ui.components.Label;
   import sample.ui.components.Rows;
   import sample.ui.components.scroll.ScrollBox;
   import states.LobbyState;
   import states.LobbyStatePage;
   import ui.ConfirmPrompt;
   import ui.profile.FillBox;
   
   public class CampaignPage extends asset_MainProfile
   {
       
      
      private var content:Box;
      
      private var headerBox:Box;
      
      private var campaign_items:Rows;
      
      private var campaignsFillBox:FillBox;
      
      private var worldsFillBox:FillBox;
      
      private var campaignItemsScroll:ScrollBox;
      
      private var campaigns:Array;
      
      private var campaignItems:Array;
      
      private var campaignWorlds:Array;
      
      private var headerLabel:Label;
      
      private var backButton:assets_backbutton;
      
      private var innerShadow:GlowFilter;
      
      private var lobbystate:LobbyState;
      
      private var currentPage:String = "campaigns";
      
      private var loadingFinishedCallback:Function;
      
      public var currentCampaign:CampaignItem;
      
      public function CampaignPage(param1:LobbyState, param2:Function)
      {
         this.content = new Box();
         this.headerBox = new Box();
         this.campaign_items = new Rows();
         this.campaignsFillBox = new FillBox(20,20);
         this.worldsFillBox = new FillBox(0,20);
         this.campaignItemsScroll = new ScrollBox();
         this.campaigns = [];
         this.campaignItems = [];
         this.campaignWorlds = [];
         super();
         if(param2 != null)
         {
            this.loadingFinishedCallback = param2;
         }
         this.lobbystate = param1;
         this.worldsFillBox.horizontal = true;
         tabbar.visible = false;
         bg_upper.visible = false;
         this.headerBox.margin(10,10,10,10);
         this.content.margin(50,10,5,10);
         this.innerShadow = new GlowFilter();
         this.innerShadow.inner = true;
         this.innerShadow.color = 0;
         this.innerShadow.blurX = 50;
         var _loc3_:Sprite = new Sprite();
         _loc3_.graphics.lineStyle(1,10066329);
         _loc3_.graphics.drawRoundRect(0,0,Global.playing_on_kongregate || Global.playing_on_armorgames?Number(Config.kongWidth - 27):Number(823),393,5,5);
         _loc3_.x = 13;
         _loc3_.y = 95;
         _loc3_.filters = [this.innerShadow];
         addChild(_loc3_);
         this.initCampaigns();
         addChild(this.headerBox);
         addChild(this.content);
      }
      
      public function initCampaigns() : void
      {
         this.campaign_items.spacing(30);
         this.campaignItemsScroll.scrollMultiplier = 6;
         this.backButton = new assets_backbutton();
         this.backButton.visible = false;
         this.backButton.mouseEnabled = true;
         this.backButton.x = bg.x + 23;
         this.backButton.y = bg.y + 58;
         this.backButton.addEventListener(MouseEvent.CLICK,this.handleButtons);
         addChild(this.backButton);
         this.content.add(new Box().margin(10,0,0,0).add(this.campaignItemsScroll.add(new Box().margin(0,0,0,0).add(this.campaign_items))));
         this.campaignsFillBox.forceScale = false;
         this.campaignsFillBox.x = Global.playing_on_kongregate || Global.playing_on_armorgames?Number(28):Number(56);
         this.headerLabel = new Label("Select Your Campaign",15,"center",16777215,false,"system");
         this.headerLabel.autoSize = TextFieldAutoSize.CENTER;
         this.headerBox.add(new Box().margin(5,10,10,10).add(this.headerLabel));
         this.getCampaigns();
         this.content.add(this.campaignItemsScroll);
      }
      
      private function getCampaigns() : void
      {
         if(this.lobbystate.currentPage == LobbyStatePage.CAMPAIGN)
         {
            Global.base.showLoadingScreen("Loading Campaigns");
         }
         Global.base.requestRemoteMethod("getCampaigns",function(param1:Message):void
         {
            var _loc3_:CampaignItem = null;
            var _loc4_:int = 0;
            var _loc5_:int = 0;
            var _loc6_:String = null;
            var _loc7_:String = null;
            var _loc8_:String = null;
            var _loc9_:String = null;
            var _loc10_:int = 0;
            var _loc11_:int = 0;
            var _loc12_:String = null;
            var _loc13_:int = 0;
            var _loc14_:Array = null;
            var _loc15_:int = 0;
            var _loc16_:int = 0;
            var _loc17_:CampaignWorld = null;
            var _loc2_:int = 0;
            campaigns = [];
            while(_loc2_ < param1.length)
            {
               _loc3_ = new CampaignItem(param1.getString(_loc2_++),param1.getString(_loc2_++),param1.getString(_loc2_++),param1.getInt(_loc2_++),param1.getBoolean(_loc2_++));
               _loc3_.addEventListener(MouseEvent.CLICK,handleCampaignClick,false,0,true);
               campaigns.push(_loc3_);
               _loc4_ = param1.getInt(_loc2_++);
               _loc5_ = 0;
               while(_loc5_ < _loc4_)
               {
                  _loc7_ = param1.getString(_loc2_++);
                  _loc8_ = param1.getString(_loc2_++);
                  _loc9_ = param1.getString(_loc2_++);
                  _loc10_ = param1.getInt(_loc2_++);
                  _loc11_ = param1.getInt(_loc2_++);
                  _loc12_ = param1.getString(_loc2_++);
                  _loc13_ = param1.getInt(_loc2_++);
                  _loc14_ = [];
                  _loc15_ = param1.getInt(_loc2_++);
                  _loc16_ = 0;
                  while(_loc16_ < _loc15_)
                  {
                     _loc14_.push(new CampaignReward(param1.getString(_loc2_++),param1.getUInt(_loc2_++)));
                     _loc16_++;
                  }
                  _loc17_ = new CampaignWorld(_loc7_,_loc8_,_loc9_,_loc10_,_loc11_,_loc13_ == -1,_loc13_ == 1,_loc12_,_loc14_,refreshScrollBox);
                  _loc17_.addEventListener(MouseEvent.CLICK,handleCampaignWorldClick,false,0,true);
                  _loc3_.addWorld(_loc17_);
                  _loc5_++;
               }
               _loc6_ = param1.getString(_loc2_++);
            }
            switchTo("campaigns","Select Your Campaign");
            if(lobbystate.currentPage == LobbyStatePage.CAMPAIGN)
            {
               Global.base.hideLoadingScreen();
            }
            if(loadingFinishedCallback != null)
            {
               loadingFinishedCallback();
            }
         });
      }
      
      public function getCampaignByName(param1:String) : CampaignItem
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.campaigns.length)
         {
            if((this.campaigns[_loc2_] as CampaignItem).campaignName.text.toLowerCase() == param1)
            {
               return this.campaigns[_loc2_] as CampaignItem;
            }
            _loc2_++;
         }
         return null;
      }
      
      public function showTutorialOnly() : void
      {
         this.campaignsFillBox.removeAllChildren();
         var _loc1_:int = 0;
         while(_loc1_ < this.campaigns.length)
         {
            if((this.campaigns[_loc1_] as CampaignItem).campaignName.text.toLowerCase() == "tutorials")
            {
               this.campaignItems.push(this.campaigns[_loc1_]);
               this.campaignsFillBox.addChild(this.campaigns[_loc1_]);
               this.campaigns[_loc1_].alpha = 0;
               TweenMax.to(this.campaigns[_loc1_],0.6 * (_loc1_ < 5?_loc1_:5),{"alpha":1});
            }
            _loc1_++;
         }
         this.campaignsFillBox.refresh();
         this.campaignItemsScroll.refresh();
      }
      
      public function openCampaign(param1:CampaignItem) : void
      {
         this.switchTo("worlds",param1.campaignName.text,param1.id);
      }
      
      private function refreshScrollBox() : void
      {
         if(this.currentPage == "worlds")
         {
            this.campaignItemsScroll.refresh();
            this.worldsFillBox.refresh();
         }
      }
      
      private function initCampaignItems() : void
      {
         this.campaignItems = [];
         this.campaignsFillBox.clear();
         this.campaigns.sort(function(param1:CampaignItem, param2:CampaignItem):int
         {
            if(param1.completed && !param2.completed)
            {
               return 1;
            }
            if(!param1.completed && param2.completed)
            {
               return -1;
            }
            if(param1.difficulty > param2.difficulty)
            {
               return 1;
            }
            if(param1.difficulty < param2.difficulty)
            {
               return -1;
            }
            return 0;
         });
         var i:int = 0;
         while(i < this.campaigns.length)
         {
            this.campaignItems.push(this.campaigns[i]);
            this.campaignsFillBox.addChild(this.campaigns[i]);
            this.campaigns[i].alpha = 0;
            TweenMax.to(this.campaigns[i],0.5,{
               "delay":0.075 * i,
               "alpha":1
            });
            i++;
         }
      }
      
      private function initCampaignWorlds(param1:String) : void
      {
         var _loc3_:CampaignItem = null;
         var _loc4_:int = 0;
         var _loc5_:CampaignWorld = null;
         this.campaignWorlds = [];
         this.worldsFillBox.clear();
         var _loc2_:int = 0;
         while(_loc2_ < this.campaigns.length)
         {
            _loc3_ = this.campaigns[_loc2_] as CampaignItem;
            if(_loc3_.id == param1)
            {
               _loc4_ = 0;
               while(_loc4_ < _loc3_.campaignWorlds.length)
               {
                  _loc5_ = _loc3_.campaignWorlds[_loc4_];
                  this.campaignWorlds.push(_loc5_);
                  this.worldsFillBox.addChild(_loc5_);
                  _loc5_.alpha = 0;
                  TweenMax.to(_loc5_,0.5,{
                     "delay":0.075 * _loc4_,
                     "alpha":1
                  });
                  _loc4_++;
               }
               break;
            }
            _loc2_++;
         }
      }
      
      private function handleCampaignClick(param1:MouseEvent) : void
      {
         var _loc2_:CampaignItem = param1.target as CampaignItem || param1.target.parent as CampaignItem;
         this.switchTo("worlds",_loc2_.campaignName.text,_loc2_.id);
         this.currentCampaign = _loc2_;
      }
      
      private function handleCampaignWorldClick(param1:MouseEvent) : void
      {
         var cWorld:CampaignWorld = null;
         var conf:ConfirmPrompt = null;
         var e:MouseEvent = param1;
         var loadWorld:Function = function():void
         {
            var _loc1_:NavigationEvent = new NavigationEvent(NavigationEvent.JOIN_WORLD,true,false);
            _loc1_.world_id = cWorld.worldId;
            Global.base.dispatchEvent(_loc1_);
         };
         cWorld = e.target as CampaignWorld || e.target.parent as CampaignWorld;
         var cont:Boolean = !cWorld.locked;
         if(!cont)
         {
            conf = new ConfirmPrompt("Are you sure you want to join this world? Locked worlds will not track your progress and won\'t reward you!",false);
            conf.ben_yes.addEventListener(MouseEvent.CLICK,function(param1:MouseEvent):void
            {
               conf.close();
               loadWorld();
            });
            Global.base.showConfirmPrompt(conf);
         }
         else
         {
            loadWorld();
         }
      }
      
      private function handleButtons(param1:MouseEvent) : void
      {
         if(param1.target == this.backButton)
         {
            if(this.currentPage == "worlds")
            {
               this.switchTo("campaigns","Select Your Campaign");
            }
         }
      }
      
      public function switchTo(param1:String, param2:String, param3:String = null) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         this.headerLabel.alpha = 0;
         TweenMax.to(this.headerLabel,1,{"alpha":1});
         this.headerLabel.x = this.headerLabel.x - 3;
         this.headerLabel.text = param2;
         switch(param1.toLowerCase())
         {
            case "campaigns":
               if(this.campaign_items.contains(this.worldsFillBox))
               {
                  this.campaign_items.removeChild(this.worldsFillBox);
               }
               if(!this.campaign_items.contains(this.campaignsFillBox))
               {
                  this.campaign_items.addChild(this.campaignsFillBox);
               }
               this.initCampaignItems();
               this.currentPage = "campaigns";
               this.innerShadow.blurX = 0;
               this.backButton.visible = false;
               this.campaignItemsScroll.horizontal = false;
               _loc4_ = 0;
               _loc5_ = 0;
               while(_loc5_ < this.campaignItems.length)
               {
                  if(this.campaignItems[_loc5_].completed)
                  {
                     _loc4_++;
                  }
                  _loc5_++;
               }
               if(this.lobbystate.currentPage == LobbyStatePage.CAMPAIGN)
               {
                  this.lobbystate.setSubtextArray([this.campaignItems.length + " Campaign" + (this.campaignItems.length == 1?"":"s") + " available",_loc4_ + " Campaign" + (_loc4_ == 1?"":"s") + " completed"]);
               }
               break;
            case "worlds":
               if(this.campaign_items.contains(this.campaignsFillBox))
               {
                  this.campaign_items.removeChild(this.campaignsFillBox);
               }
               if(!this.campaign_items.contains(this.worldsFillBox))
               {
                  this.campaign_items.addChild(this.worldsFillBox);
               }
               this.initCampaignWorlds(param3);
               this.currentPage = "worlds";
               this.innerShadow.blurX = 50;
               this.backButton.visible = true;
               this.campaignItemsScroll.horizontal = true;
               _loc6_ = 0;
               _loc7_ = 0;
               _loc8_ = 0;
               while(_loc8_ < this.campaignWorlds.length)
               {
                  if(this.campaignWorlds[_loc8_].completed)
                  {
                     _loc6_++;
                  }
                  if(this.campaignWorlds[_loc8_].locked)
                  {
                     _loc7_++;
                  }
                  _loc8_++;
               }
               _loc9_ = this.campaignWorlds.length - _loc7_;
               if(this.lobbystate.currentPage == LobbyStatePage.CAMPAIGN)
               {
                  this.lobbystate.setSubtextArray([_loc6_ + " World" + (_loc6_ == 1?"":"s") + " completed",_loc7_ + " World" + (_loc7_ == 1?"":"s") + " locked",_loc9_ + " World" + (_loc9_ == 1?"":"s") + " available"]);
               }
         }
         filters = [this.innerShadow];
      }
      
      public function refreshSubtext() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         switch(this.currentPage.toLowerCase())
         {
            case "campaigns":
               _loc1_ = 0;
               _loc2_ = 0;
               while(_loc2_ < this.campaignItems.length)
               {
                  if(this.campaignItems[_loc2_].completed)
                  {
                     _loc1_++;
                  }
                  _loc2_++;
               }
               if(this.lobbystate.currentPage == LobbyStatePage.CAMPAIGN)
               {
                  this.lobbystate.setSubtextArray([this.campaignItems.length + " Campaign" + (this.campaignItems.length == 1?"":"s") + " available",_loc1_ + " Campaign" + (_loc1_ == 1?"":"s") + " completed"]);
               }
               break;
            case "worlds":
               _loc3_ = 0;
               _loc4_ = 0;
               _loc5_ = 0;
               while(_loc5_ < this.campaignWorlds.length)
               {
                  if(this.campaignWorlds[_loc5_].completed)
                  {
                     _loc3_++;
                  }
                  if(this.campaignWorlds[_loc5_].locked)
                  {
                     _loc4_++;
                  }
                  _loc5_++;
               }
               _loc6_ = this.campaignWorlds.length - _loc4_;
               if(this.lobbystate.currentPage == LobbyStatePage.CAMPAIGN)
               {
                  this.lobbystate.setSubtextArray([_loc3_ + " World" + (_loc3_ == 1?"":"s") + " completed",_loc4_ + " World" + (_loc4_ == 1?"":"s") + " locked",_loc6_ + " World" + (_loc6_ == 1?"":"s") + " available"]);
               }
         }
      }
      
      override public function set x(param1:Number) : void
      {
         bg.x = param1;
         this.content.x = bg.x;
         this.headerBox.x = bg.x;
      }
      
      override public function set y(param1:Number) : void
      {
         bg.y = param1;
         this.content.y = bg.y;
         this.headerBox.y = bg.y;
      }
      
      override public function set width(param1:Number) : void
      {
         bg.width = param1;
         this.content.width = bg.width;
         this.headerBox.width = bg.width;
      }
      
      override public function set height(param1:Number) : void
      {
         bg.height = param1;
         this.content.height = bg.height;
         this.headerBox.height = bg.height;
      }
   }
}
