package ui.profile
{
   import com.greensock.TweenMax;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerio.Message;
   import sample.ui.components.Box;
   import sample.ui.components.Label;
   import sample.ui.components.Rows;
   import sample.ui.components.scroll.ScrollBox;
   
   public class MyFriends extends Sprite
   {
      
      private static const UPDATE:int = 750;
       
      
      private var friends:Box;
      
      private var friendsList:Rows;
      
      private var friendsScrollBox:ScrollBox;
      
      private var friendsRefreshDate:Date;
      
      private var isLoading:Boolean = false;
      
      private var invitationItems:Array;
      
      private var friendItems:Array;
      
      private var pendingItems:Array;
      
      private var blockedItems:Array;
      
      public var friendNames:Array;
      
      private var topBar:FillBox;
      
      private var buttons:Array;
      
      public function MyFriends()
      {
         this.friendNames = [];
         this.topBar = new FillBox(3,0);
         this.buttons = [new asset_friendrequest(),new asset_showfriends(),new asset_showpending(),new asset_showblocked()];
         super();
         addEventListener(FriendItem.DELETE,this.handleFriendItemDeleted,false,0,true);
      }
      
      private function refreshContentFriends(param1:Function = null) : void
      {
         var callback:Function = param1;
         var ready:Function = function():void
         {
            isLoading = false;
            renderFriendContent(invitationItems,friendItems,pendingItems);
            if(callback != null)
            {
               callback();
            }
         };
         this.friendsRefreshDate = new Date();
         this.isLoading = true;
         if(this.friends)
         {
            removeChild(this.friends);
         }
         this.friends = new Box();
         addChild(this.friends);
         this.friends.margin(0,0,0,0);
         this.friendsList = new Rows();
         this.friendsList.spacing(5);
         this.friendsList.addEventListener(Event.REMOVED,this.handleFriendItemRemoved,false,0,true);
         this.friendsList.addEventListener(Event.CHANGE,this.handleFriendItemRemoved,false,0,true);
         this.topBar.addChild(this.buttons[0]);
         this.topBar.addChild(this.buttons[1]);
         this.topBar.addChild(this.buttons[2]);
         this.topBar.addChild(this.buttons[3]);
         this.topBar.addEventListener(MouseEvent.MOUSE_DOWN,this.handleTopBarButton,false,0,true);
         var topBarBox:Box = new Box();
         topBarBox.margin(2,2,0,100);
         topBarBox.add(this.topBar);
         this.friends.add(topBarBox);
         this.friendsScrollBox = new ScrollBox();
         this.friendsScrollBox.scrollMultiplier = 8;
         this.friendsScrollBox.add(this.friendsList);
         var friendsBox:Box = new Box();
         friendsBox.margin(25,0,0,0);
         friendsBox.add(this.friendsScrollBox);
         this.friends.add(friendsBox);
         this.invitationItems = [];
         this.friendItems = [];
         this.pendingItems = [];
         this.blockedItems = [];
         this.friendNames = [];
         var loaded:int = 0;
         Global.base.requestRemoteMethod("getInvitesToMe",function(param1:Message):void
         {
            var _loc2_:int = 0;
            while(_loc2_ < param1.length)
            {
               invitationItems.push(new FriendItem(FriendItem.INVITATION,param1.getString(_loc2_)));
               _loc2_++;
            }
            if(++loaded == 4)
            {
               ready();
            }
         });
         Global.base.requestRemoteMethod("getFriends",function(param1:Message):void
         {
            var _loc3_:String = null;
            var _loc4_:FriendItem = null;
            var _loc2_:int = 0;
            while(_loc2_ < param1.length)
            {
               _loc3_ = param1.getString(_loc2_);
               _loc4_ = new FriendItem(FriendItem.FRIEND,_loc3_);
               _loc4_.setOnlineStatus(param1.getBoolean(_loc2_ + 1),param1.getInt(_loc2_ + 4),param1.getBoolean(_loc2_ + 6),param1.getString(_loc2_ + 2),param1.getString(_loc2_ + 3),param1.getNumber(_loc2_ + 5));
               friendItems.push(_loc4_);
               friendNames.push(_loc3_);
               _loc2_ = _loc2_ + 7;
            }
            sortFriendItems();
            if(++loaded == 4)
            {
               ready();
            }
         });
         Global.base.requestRemoteMethod("getPending",function(param1:Message):void
         {
            var _loc3_:int = 0;
            var _loc4_:String = null;
            var _loc5_:FriendItem = null;
            var _loc2_:int = 0;
            while(_loc2_ < param1.length)
            {
               _loc3_ = param1.getInt(_loc2_ + 1);
               _loc4_ = FriendItem.PENDING;
               if(_loc3_ == 1)
               {
                  _loc4_ = FriendItem.ACCEPTED;
               }
               if(_loc3_ == 2)
               {
                  _loc4_ = FriendItem.REJECTED;
               }
               _loc5_ = new FriendItem(_loc4_,param1.getString(_loc2_));
               if(_loc3_ == 0)
               {
                  pendingItems.push(_loc5_);
               }
               else
               {
                  friendItems.push(_loc5_);
               }
               _loc2_ = _loc2_ + 2;
            }
            sortFriendItems();
            if(++loaded == 4)
            {
               ready();
            }
         });
         Global.base.requestRemoteMethod("getBlockedUsers",function(param1:Message):void
         {
            var _loc3_:FriendItem = null;
            var _loc2_:int = 0;
            while(_loc2_ < param1.length)
            {
               _loc3_ = new FriendItem(FriendItem.BLOCKED,param1.getString(_loc2_));
               blockedItems.push(_loc3_);
               _loc2_ = _loc2_ + 2;
            }
            if(++loaded == 4)
            {
               ready();
            }
         });
      }
      
      private function sortFriendItems() : void
      {
         var itm:FriendItem = null;
         this.friendItems.sort(function(param1:FriendItem, param2:FriendItem):int
         {
            if(param1.type == FriendItem.ACCEPTED && param2.type != FriendItem.ACCEPTED)
            {
               return -1;
            }
            if(param1.type != FriendItem.ACCEPTED && param2.type == FriendItem.ACCEPTED)
            {
               return 1;
            }
            if(param1.type == FriendItem.REJECTED && param2.type != FriendItem.REJECTED)
            {
               return -1;
            }
            if(param1.type != FriendItem.REJECTED && param2.type == FriendItem.REJECTED)
            {
               return 1;
            }
            if(param1.onlineInWorld && !param2.onlineInWorld)
            {
               return -1;
            }
            if(!param1.onlineInWorld && param2.onlineInWorld)
            {
               return 1;
            }
            if(param1.online && !param2.online)
            {
               return -1;
            }
            if(!param1.online && param2.online)
            {
               return 1;
            }
            return param1.lastSeen > param2.lastSeen?-1:1;
         });
         var i:int = 0;
         while(i < Math.min(this.friendItems.length,10))
         {
            itm = this.friendItems[i];
            itm.x = -itm.width % 75;
            itm.alpha = 0;
            TweenMax.to(itm,0.45,{
               "delay":0.075 * i,
               "x":0,
               "alpha":1
            });
            i++;
         }
         this.topBar.alpha = 0;
         TweenMax.to(this.topBar,0.3,{"alpha":1});
      }
      
      private function createAddFriendInfoBox() : Box
      {
         var _loc1_:Box = new Box();
         _loc1_.fill(10066329,1);
         _loc1_.margin(15,NaN,NaN,5);
         _loc1_.add(new Label("Invite friends by clicking +Add",12,"left",16777215,false,"system"));
         return _loc1_;
      }
      
      private function handleTopBarButton(param1:MouseEvent) : void
      {
         var _loc4_:FriendItem = null;
         var _loc5_:int = 0;
         this.friendsList.removeAllChildren();
         var _loc2_:Array = [];
         if(param1.target is asset_friendrequest)
         {
            _loc4_ = new FriendItem(FriendItem.INVITE,"");
            this.pendingItems.unshift(_loc4_);
            _loc2_.push(_loc4_);
         }
         else if(param1.target is asset_showfriends)
         {
            _loc2_ = this.invitationItems.concat(this.friendItems);
            if(_loc2_.length == 0)
            {
               _loc2_.push(this.createAddFriendInfoBox());
            }
         }
         else if(param1.target is asset_showpending)
         {
            _loc5_ = 0;
            while(_loc5_ < this.pendingItems.length)
            {
               if((this.pendingItems[_loc5_] as FriendItem).type == FriendItem.INVITE)
               {
                  this.pendingItems.splice(_loc5_,1);
               }
               _loc5_++;
            }
            _loc2_ = this.pendingItems;
         }
         else if(param1.target is asset_showblocked)
         {
            _loc2_ = this.blockedItems;
         }
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_.length)
         {
            if(_loc2_[_loc3_] != null)
            {
               this.friendsList.addChild(_loc2_[_loc3_]);
            }
            _loc3_++;
         }
         this.friendsScrollBox.refresh();
      }
      
      private function handleFriendItemDeleted(param1:Event) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc2_:FriendItem = param1.target as FriendItem;
         switch(_loc2_.type)
         {
            case FriendItem.FRIEND:
            case FriendItem.CONFIRM:
            case FriendItem.ACCEPTED:
            case FriendItem.REJECTED:
               _loc3_ = 0;
               while(_loc3_ < this.friendItems.length)
               {
                  if(this.friendItems[_loc3_] == _loc2_)
                  {
                     this.friendItems.splice(_loc3_,1);
                     break;
                  }
                  _loc3_++;
               }
               break;
            case FriendItem.INVITE:
            case FriendItem.PENDING:
               _loc4_ = 0;
               while(_loc4_ < this.pendingItems.length)
               {
                  if(this.pendingItems[_loc4_] == _loc2_)
                  {
                     this.pendingItems.splice(_loc4_,1);
                     break;
                  }
                  _loc4_++;
               }
               break;
            case FriendItem.INVITATION:
               _loc5_ = 0;
               while(_loc5_ < this.invitationItems.length)
               {
                  if(this.invitationItems[_loc5_] == _loc2_)
                  {
                     this.invitationItems.splice(_loc5_,1);
                     break;
                  }
                  _loc5_++;
               }
               break;
            case FriendItem.BLOCKED:
               _loc6_ = 0;
               while(_loc6_ < this.blockedItems.length)
               {
                  if(this.blockedItems[_loc6_] == _loc2_)
                  {
                     this.blockedItems.splice(_loc6_,1);
                     break;
                  }
                  _loc6_++;
               }
         }
      }
      
      private function handleFriendItemRemoved(param1:Event) : void
      {
         addEventListener(Event.EXIT_FRAME,this.handleExitFrame,false,0,true);
      }
      
      private function handleExitFrame(param1:Event) : void
      {
         removeEventListener(Event.EXIT_FRAME,this.handleExitFrame);
         this.friendsList.spacing(5);
         this.friendsScrollBox.refresh();
      }
      
      private function renderFriendContent(param1:Array, param2:Array, param3:Array) : void
      {
         var _loc4_:uint = 0;
         while(_loc4_ < param1.length)
         {
            this.friendsList.addChild(param1[_loc4_]);
            _loc4_++;
         }
         var _loc5_:uint = 0;
         while(_loc5_ < param2.length)
         {
            this.friendsList.addChild(param2[_loc5_]);
            _loc5_++;
         }
         if(param1.length + param2.length == 0)
         {
            this.friendsList.addChild(this.createAddFriendInfoBox());
         }
      }
      
      protected function handleAddFriend(param1:MouseEvent) : void
      {
         var _loc2_:FriendItem = new FriendItem(FriendItem.INVITE,"");
         this.friendsList.addChildAt(_loc2_,0);
         this.friendsScrollBox.refresh();
      }
      
      public function refresh(param1:Function = null) : void
      {
         if(!this.isLoading && this.friendsRefreshDate == null || new Date().time - this.friendsRefreshDate.time > UPDATE)
         {
            this.refreshContentFriends(param1);
         }
         else if(param1 != null)
         {
            param1();
         }
      }
      
      override public function set width(param1:Number) : void
      {
         this.friends.width = param1;
      }
      
      override public function set height(param1:Number) : void
      {
         this.friends.height = param1;
      }
   }
}
