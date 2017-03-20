package ui.roomlist
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import io.player.tools.Badwords;
   import sample.ui.components.Rows;
   import sample.ui.components.scroll.ScrollBox;
   
   public class RoomList extends asset_roomlist
   {
      
      public static const SORT_BY_NAME:int = 0;
      
      public static const SORT_BY_ONLINE:int = 1;
      
      public static const SORT_BY_MYWORLDS:int = 2;
      
      public static const SORT_BY_PLAYS:int = 3;
      
      public static const SORT_BY_LIKES:int = 4;
      
      public static const SORT_BY_BETA:int = 5;
      
      public static const SORT_BY_OPEN:int = 6;
      
      public static const SORT_BY_FEATURED:int = 7;
      
      public static const SORT_BY_FAVORITES:int = 8;
       
      
      private var container:Rows;
      
      private var rooms:Array;
      
      private var callback:Function;
      
      private var base:ScrollBox;
      
      private var preferred_height:int;
      
      private var history:String = "notsettosomething";
      
      public var showopen:Boolean = false;
      
      public var showlocked:Boolean = false;
      
      public var showmyworlds:Boolean = false;
      
      public var betaonly:Boolean = false;
      
      public var favoriteOnly:Boolean = false;
      
      private var sortby:int = 0;
      
      private var overlay:Sprite;
      
      public var joiningDisabled:Boolean = false;
      
      public function RoomList(param1:int, param2:Function)
      {
         this.container = new Rows();
         this.rooms = [];
         super();
         this.base = new ScrollBox().margin(0,1,1,1).add(this.container);
         this.container.spacing(0);
         this.base.scrollMultiplier = 10;
         addChild(this.base);
         this.callback = param2;
         this.preferred_height = param1;
         this.doRender(true);
         this.base.width = 301 - 3;
         this.base.height = param1 - 3;
         this.base.x = 2;
         this.base.y = 2;
         bg.height = param1 + 1;
      }
      
      public function setRooms(param1:Array) : void
      {
         this.rooms = param1;
         this.sortRoomsBy(this.sortby);
      }
      
      public function render(param1:String = "", param2:int = 7, param3:Boolean = false, param4:Boolean = false) : void
      {
         this.history = param1;
         this.betaonly = param3;
         this.favoriteOnly = param4;
         this.showmyworlds = param2 == SORT_BY_MYWORLDS;
         this.sortRoomsBy(param2);
         this.doRender();
      }
      
      private function sortRoomsBy(param1:int = 7) : void
      {
         var sortby:int = param1;
         this.sortby = sortby;
         this.rooms.sort(function(param1:Object, param2:Object):int
         {
            var _loc5_:int = 0;
            var _loc6_:int = 0;
            var _loc7_:int = 0;
            var _loc8_:int = 0;
            var _loc9_:int = 0;
            var _loc10_:int = 0;
            var _loc11_:int = 0;
            var _loc12_:int = 0;
            if(sortby == SORT_BY_MYWORLDS)
            {
               if(param1.data.myworld && !param2.data.myworld)
               {
                  return -1;
               }
               if(!param1.data.myworld && param2.data.myworld)
               {
                  return 1;
               }
            }
            else
            {
               if(param1.data.myworld && !param2.data.myworld && (param1.onlineUsers || 0) < 1)
               {
                  return 1;
               }
               if(!param1.data.myworld && param2.data.myworld && (param2.onlineUsers || 0) < 1)
               {
                  return -1;
               }
               if(param1.onlineUsers >= 45)
               {
                  return 1;
               }
               if(param2.onlineUsers >= 45)
               {
                  return -1;
               }
            }
            if(sortby == SORT_BY_BETA)
            {
               if(param1.data.beta || param2.data.beta)
               {
                  return param1.data.beta == "True"?1:-1;
               }
            }
            if(sortby == SORT_BY_FAVORITES)
            {
               _loc5_ = int(parseInt(param1.data.Favorite)) || 0;
               _loc6_ = int(parseInt(param2.data.Favorite)) || 0;
               if(_loc5_ != _loc6_)
               {
                  return _loc5_ > _loc6_?-1:1;
               }
            }
            if(sortby == SORT_BY_LIKES)
            {
               _loc7_ = int(parseInt(param1.data.Likes)) || 0;
               _loc8_ = int(parseInt(param2.data.Likes)) || 0;
               if(_loc7_ != _loc8_)
               {
                  return _loc7_ > _loc8_?-1:1;
               }
            }
            if(sortby == SORT_BY_ONLINE || sortby == SORT_BY_MYWORLDS)
            {
               _loc9_ = int(param1.onlineUsers) || 0;
               _loc10_ = int(param2.onlineUsers) || 0;
               if(_loc9_ != _loc10_)
               {
                  return _loc9_ > _loc10_?-1:1;
               }
            }
            if(sortby == SORT_BY_PLAYS && !param1.data.myworld)
            {
               _loc11_ = int(parseInt(param1.data.plays)) || 0;
               _loc12_ = int(parseInt(param2.data.plays)) || 0;
               if(_loc11_ != _loc12_)
               {
                  return _loc11_ > _loc12_?-1:1;
               }
            }
            if(sortby == SORT_BY_OPEN && !param1.data.myworld)
            {
               if(param1.data.openworld || param2.data.openworld)
               {
                  return !!param1.data.openworld?-1:1;
               }
            }
            if(sortby == SORT_BY_FEATURED)
            {
               if(param1.data.IsFeatured || param2.data.IsFeatured)
               {
                  return param1.data.IsFeatured == "True"?-1:1;
               }
            }
            var _loc3_:String = param1.data.name || param1.id;
            var _loc4_:String = param2.data.name || param2.id;
            return _loc3_ < _loc4_?-1:1;
         });
      }
      
      public function doRender(param1:Boolean = false) : void
      {
         var to:Object = null;
         var na:String = null;
         var si:String = null;
         var r:Room = null;
         var showload:Boolean = param1;
         var debug:Date = new Date();
         while(this.container.numChildren)
         {
            this.container.removeChild(this.container.getChildAt(0));
         }
         var used:int = 0;
         if(this.sortby == SORT_BY_FEATURED)
         {
            this.rooms.sort(function(param1:Object, param2:Object):int
            {
               var _loc3_:int = int(parseInt(param1.data.Favorites)) || 0;
               var _loc4_:int = int(parseInt(param2.data.Favorites)) || 0;
               if(_loc3_ != _loc4_)
               {
                  return _loc3_ > _loc4_?-1:1;
               }
               return -1;
            });
         }
         var a:int = 0;
         while(a < this.rooms.length)
         {
            to = this.rooms[a];
            na = to.data.name || to.id;
            si = to.data.size || "";
            if((this.history == "" || na.toLocaleLowerCase().indexOf(this.history.toLocaleLowerCase()) != -1 || si.toLocaleLowerCase().indexOf(this.history.toLocaleLowerCase()) != -1) && (!this.containsBadwords(na) || to.data.myworld))
            {
               if(!(to.data.beta && !Global.player_is_beta_member))
               {
                  if(!(this.favoriteOnly && !to.data.inFavorites || !this.favoriteOnly && to.data.inFavorites && (to.onlineUsers || 0) < 1))
                  {
                     if(!(this.sortby == SORT_BY_MYWORLDS && !to.data.myworld))
                     {
                        if(!(this.sortby != SORT_BY_MYWORLDS && to.data.myworld && (to.onlineUsers || 0) < 1))
                        {
                           if(!(this.sortby == SORT_BY_OPEN && !to.data.openworld))
                           {
                              if(!(this.sortby == SORT_BY_FEATURED && to.data.IsFeatured != "True"))
                              {
                                 if(!(this.sortby == SORT_BY_BETA && !to.data.beta))
                                 {
                                    if(!(this.sortby == SORT_BY_BETA && !Global.player_is_beta_member))
                                    {
                                       r = new Room(to.id,this.makePrettyName(na),to.data.description,to.data.size || "200x200",int(to.onlineUsers) || 0,int(parseInt(to.data.plays)) || 1,int(parseInt(to.data.Favorites)) || 0,int(parseInt(to.data.Likes)) || 0,to.data.inFavorites,to.data.IsCampaign == "True",!!to.data.myworld?true:false,to.data.owned,to.data.needskey || false,to.data.LobbyPreviewEnabled != "False",to,this.callback,this.unfavorite);
                                       used++;
                                       this.container.addChild(r);
                                    }
                                 }
                              }
                           }
                        }
                     }
                  }
               }
            }
            a++;
         }
         if(this.sortby == SORT_BY_MYWORLDS)
         {
            if(!Global.player_is_guest)
            {
               this.container.addChild(new BuyWorld());
            }
            else
            {
               this.container.addChild(new GuestRegisterForWorlds());
            }
            used++;
         }
         if(used == 0)
         {
            this.container.addChild(!!showload?new loadingrooms():new norooms());
         }
         if(this.sortby == SORT_BY_OPEN)
         {
            this.container.addChild(new CreateOpenWorld());
         }
         this.base.refresh();
         this.base.scrollY = 1;
      }
      
      private function unfavorite(param1:String) : void
      {
         var _loc3_:Room = null;
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         while(_loc2_ < this.container.numChildren)
         {
            _loc3_ = this.container.getChildAt(_loc2_) as Room;
            if(_loc3_ != null && _loc3_.key == param1)
            {
               this.container.removeChild(_loc3_);
               _loc4_ = this.rooms.length - 1;
               while(_loc4_ >= 0)
               {
                  if(this.rooms[_loc4_].id == param1)
                  {
                     this.rooms.splice(_loc2_,1);
                     break;
                  }
                  _loc4_--;
               }
               break;
            }
            _loc2_++;
         }
         Global.playerObject.removeFavorite(param1);
      }
      
      public function disableJoining() : void
      {
         this.overlay = new Sprite();
         this.overlay.graphics.beginFill(0,0);
         this.overlay.graphics.drawRect(0,0,width,height);
         this.overlay.graphics.endFill();
         addChild(this.overlay);
         this.joiningDisabled = true;
      }
      
      public function enableJoining() : void
      {
         if(contains(this.overlay))
         {
            removeChild(this.overlay);
            this.joiningDisabled = false;
         }
      }
      
      private function containsBadwords(param1:String) : Boolean
      {
         return Badwords.Filter(param1) != param1;
      }
      
      private function makePrettyName(param1:String) : String
      {
         return param1.replace(/[ \t]{2,}/gi," ");
      }
   }
}
