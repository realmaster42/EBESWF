package ui
{
   import flash.globalization.DateTimeFormatter;
   import playerio.Client;
   import playerio.RoomInfo;
   
   public class PlayerWorlds
   {
      
      public static var roomSizes:Object = [];
       
      
      public function PlayerWorlds()
      {
         super();
      }
      
      public static function addFavorites(param1:Array, param2:Client) : void
      {
         var _loc4_:* = null;
         var _loc5_:RoomInfo = null;
         var _loc6_:String = null;
         var _loc7_:Object = null;
         var _loc3_:Object = Global.playerObject.favorites;
         for(_loc4_ in _loc3_)
         {
            _loc5_ = findWorld(param1,_loc4_);
            if(_loc5_)
            {
               _loc5_.data.inFavorites = true;
            }
            else
            {
               _loc6_ = _loc3_[_loc4_] as String;
               _loc7_ = {
                  "id":_loc4_,
                  "data":{
                     "name":(!!_loc5_?_loc5_.data.name:_loc6_),
                     "owned":true,
                     "needskey":true,
                     "inFavorites":true,
                     "beta":false
                  }
               };
               param1.push(_loc7_);
            }
         }
      }
      
      public static function addSavedWorlds(param1:Array, param2:Client) : void
      {
         var _loc3_:RoomInfo = null;
         if(Global.playerObject.room0 != null)
         {
            _loc3_ = findWorld(param1,Global.playerObject.room0);
            if(_loc3_ != null)
            {
               _loc3_.data.myworld = true;
            }
            else
            {
               param1.push({
                  "id":"savedworld",
                  "data":{
                     "name":"Beta Saved World",
                     "owned":true,
                     "needskey":true,
                     "myworld":true,
                     "beta":false,
                     "size":"200x200 - Beta"
                  }
               });
            }
         }
         if(Global.playerObject.betaonlyroom != null)
         {
            _loc3_ = findWorld(param1,Global.playerObject.betaonlyroom);
            if(_loc3_ != null)
            {
               _loc3_.data.myworld = true;
            }
            else
            {
               param1.push({
                  "id":"savedbetaworld",
                  "data":{
                     "name":"Beta Only Saved World",
                     "beta":true,
                     "owned":true,
                     "needskey":true,
                     "myworld":true,
                     "plays":600,
                     "Favorites":0,
                     "Likes":0,
                     "size":"200x200 - Beta Only"
                  }
               });
            }
         }
         if(Global.playerObject.homeworld != null)
         {
            _loc3_ = findWorld(param1,Global.playerObject.homeworld);
            if(_loc3_ != null)
            {
               _loc3_.data.myworld = true;
            }
            else
            {
               param1.push({
                  "id":Global.playerObject.homeworld,
                  "data":{
                     "name":Global.playerObject.getRoomName(Global.playerObject.homeworld),
                     "beta":false,
                     "owned":true,
                     "needskey":true,
                     "myworld":true,
                     "size":"40x30 - Home World"
                  }
               });
            }
         }
         roomSizes = {};
         addWorlds(param1,"0",param2.payVault.count("world0"),"Small","30x30");
         addWorlds(param1,"1",param2.payVault.count("world1"),"Medium","50x50");
         addWorlds(param1,"2",param2.payVault.count("world2"),"Large","100x100");
         addWorlds(param1,"3",param2.payVault.count("world3"),"Massive","200x200");
         addWorlds(param1,"4",param2.payVault.count("world4"),"Wide","400x50");
         addWorlds(param1,"5",param2.payVault.count("world5"),"Great","400x200");
         addWorlds(param1,"6",param2.payVault.count("world6"),"Tall","100x400");
         addWorlds(param1,"7",param2.payVault.count("world7"),"Ultra Wide","636x50");
         addWorlds(param1,"8",param2.payVault.count("world8"),"Sky Medium","50x50");
         addWorlds(param1,"9",param2.payVault.count("world9"),"Tiny","25x25");
         addWorlds(param1,"10",param2.payVault.count("world10"),"Sky Great","400x200");
         addWorlds(param1,"11",param2.payVault.count("world11"),"Huge","300x300");
         addWorlds(param1,"12",param2.payVault.count("world12"),"Vertical Great","200x400");
         addWorlds(param1,"13",param2.payVault.count("world13"),"Sky Wide","400x50");
      }
      
      private static function findWorld(param1:Array, param2:String) : RoomInfo
      {
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            if(param1[_loc3_].id == param2)
            {
               return param1[_loc3_];
            }
            _loc3_++;
         }
         return null;
      }
      
      private static function addWorlds(param1:Array, param2:String, param3:int, param4:String, param5:String) : Array
      {
         var _loc8_:RoomInfo = null;
         var _loc9_:String = null;
         var _loc10_:String = null;
         var _loc11_:Object = null;
         var _loc6_:Array = [];
         var _loc7_:int = 0;
         while(_loc7_ < param3)
         {
            _loc8_ = findWorld(param1,Global.playerObject.rooms["world" + param2 + "x" + _loc7_]);
            if(_loc8_)
            {
               _loc8_.data.myworld = true;
            }
            else
            {
               _loc8_ = findWorld(param1,param2 + "x" + _loc7_);
               if(_loc8_ == null)
               {
                  _loc9_ = Global.playerObject.roomnames["world" + param2 + "x" + _loc7_] || param4 + " " + (_loc7_ + 1);
                  _loc10_ = param5 + " - " + param4 + " " + (_loc7_ + 1);
                  _loc11_ = {
                     "id":param2 + "x" + _loc7_,
                     "data":{
                        "name":(!!_loc8_?_loc8_.data.name:_loc9_),
                        "owned":true,
                        "needskey":true,
                        "myworld":true,
                        "beta":false,
                        "size":_loc10_
                     }
                  };
                  param1.push(_loc11_);
                  _loc6_.push(_loc11_);
               }
            }
            _loc7_++;
         }
         return _loc6_;
      }
      
      public static function getHistory(param1:Array) : void
      {
         var _loc2_:DateTimeFormatter = null;
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:Object = null;
         var _loc6_:Object = null;
         if(!Config.disableCookie)
         {
            _loc2_ = new DateTimeFormatter("en-US");
            _loc2_.setDateTimePattern("f");
            _loc3_ = [];
            if(Global.cookie.data.history != null)
            {
               _loc3_ = Global.cookie.data.history;
            }
            _loc4_ = 0;
            while(_loc4_ < _loc3_.length)
            {
               _loc5_ = _loc3_[_loc4_];
               _loc6_ = {
                  "id":_loc5_.id,
                  "data":{
                     "name":_loc5_.name,
                     "owned":true,
                     "needskey":true,
                     "time":_loc5_.time,
                     "size":_loc2_.format(_loc5_.time),
                     "isHistory":true
                  }
               };
               param1.push(_loc6_);
               _loc4_++;
            }
         }
      }
   }
}
