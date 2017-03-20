package playerio
{
   import playerio.generated.messages.SocialProfile;
   import playerio.utils.Utilities;
   
   class YahooRelations
   {
       
      
      private var _client:Client;
      
      private var _friends:Array;
      
      private var _friendLookup:Object;
      
      private var _blockedLookup:Object;
      
      private var _yahoo:Yahoo;
      
      function YahooRelations(param1:Client, param2:Yahoo)
      {
         super();
         this._client = param1;
         this._yahoo = param2;
      }
      
      function _internal_refreshed(param1:SocialProfile, param2:Array, param3:Array) : void
      {
         myProfile = param1;
         friends = param2;
         blocked = param3;
         this._friends = Utilities.converter(friends,function(param1:SocialProfile):YahooProfile
         {
            var _loc2_:YahooProfile = new YahooProfile();
            _loc2_._internal_initialize(param1);
            return _loc2_;
         });
         _friendLookup = {};
         var _loc5_:int = 0;
         var _loc4_:* = this._friends;
         for each(friend in this._friends)
         {
            _friendLookup[friend.userId] = true;
         }
         _blockedLookup = {};
         if(blocked != null)
         {
            var _loc8_:int = 0;
            var _loc7_:* = blocked;
            for each(ignored in blocked)
            {
               _blockedLookup[ignored] = true;
            }
         }
      }
      
      public function get friends() : Array
      {
         if(_friends == null)
         {
            throw new playerio.generated.PlayerIOError("Cannot access friends before Yahoo has loaded. Please call client.Yahoo.Refresh() first.",playerio.PlayerIOError.YahooNotLoaded.errorID);
         }
         return _friends;
      }
      
      public function isFiend(param1:String) : Boolean
      {
         if(_friendLookup == null)
         {
            throw new playerio.generated.PlayerIOError("Cannot access friends before Yahoo has loaded. Please call client.Yahoo.Refresh() first.",playerio.PlayerIOError.YahooNotLoaded.errorID);
         }
         return _friendLookup[param1] != undefined;
      }
      
      public function isBlocked(param1:String) : Boolean
      {
         if(_blockedLookup == null)
         {
            throw new playerio.generated.PlayerIOError("Cannot access friends before Yahoo has loaded. Please call client.Yahoo.Refresh() first.",playerio.PlayerIOError.YahooNotLoaded.errorID);
         }
         return _blockedLookup[param1] != undefined;
      }
      
      public function showRequestFriendshipDialog(param1:String, param2:Function) : void
      {
         userId = param1;
         closedCallback = param2;
         Yahoo._internal_showDialog("requestfriendship",{"userId":userId},_client.channel,function():void
         {
            if(closedCallback != null)
            {
               closedCallback();
            }
         });
      }
      
      public function showRequestBlockUserDialog(param1:String, param2:Function) : void
      {
         userId = param1;
         closedCallback = param2;
         Yahoo._internal_showDialog("requestblockuser",{"userId":userId},_client.channel,function():void
         {
            _yahoo.refresh(function():void
            {
               if(closedCallback != null)
               {
                  closedCallback();
               }
            },function():void
            {
               if(closedCallback != null)
               {
                  closedCallback();
               }
            });
         });
      }
      
      public function showFriendsManager(param1:Function) : void
      {
         closedCallback = param1;
         Yahoo._internal_showDialog("friendsmanager",{},_client.channel,function(param1:Object):void
         {
            result = param1;
            if(result["updated"] != undefined)
            {
               _yahoo.refresh(function():void
               {
                  if(closedCallback != null)
                  {
                     closedCallback();
                  }
               },function():void
               {
                  if(closedCallback != null)
                  {
                     closedCallback();
                  }
               });
            }
            else if(closedCallback != null)
            {
               closedCallback();
            }
         });
      }
      
      public function showBlockedUsersManager(param1:Function) : void
      {
         closedCallback = param1;
         Yahoo._internal_showDialog("blockedusersmanager",{},_client.channel,function(param1:Object):void
         {
            result = param1;
            if(result["updated"] != undefined)
            {
               _yahoo.refresh(function():void
               {
                  if(closedCallback != null)
                  {
                     closedCallback();
                  }
               },function():void
               {
                  if(closedCallback != null)
                  {
                     closedCallback();
                  }
               });
            }
            else if(closedCallback != null)
            {
               closedCallback();
            }
         });
      }
   }
}
