package ui.roomlist
{
   import com.greensock.TweenMax;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.clearInterval;
   import flash.utils.setTimeout;
   import states.LobbyState;
   import ui.HoverLabel;
   
   public class RoomFilter extends asset_roomfilter
   {
       
      
      private var callback:Function;
      
      private var showopen:Boolean = false;
      
      private var showlocked:Boolean = false;
      
      private var showsaved:Boolean = false;
      
      private var showmyworlds:Boolean = false;
      
      private var betaonly:Boolean = false;
      
      private var favoriteOnly:Boolean = false;
      
      private var sort_buttons:Vector.<MovieClip>;
      
      private var sortby:int;
      
      private var currentTab:MovieClip;
      
      private var currentSort:MovieClip;
      
      private var canReloadRooms:Boolean = true;
      
      private var hoverlabel:HoverLabel;
      
      private var hovertimer:uint;
      
      private var currentHover;
      
      public function RoomFilter(param1:Function, param2:Function)
      {
         var callback:Function = param1;
         var reloadWorldsCallback:Function = param2;
         super();
         this.callback = callback;
         this.showlocked = true;
         this.currentTab = tabbar.tab_rooms;
         tabbar.tab_rooms.gotoAndStop(2);
         tabbar.tab_favorites.gotoAndStop(1);
         tabbar.sortselector.gotoAndStop(1);
         tabbar.tab_rooms.buttonMode = true;
         tabbar.tab_rooms.useHandCursor = true;
         tabbar.tab_rooms.addEventListener(MouseEvent.CLICK,this.handleTabClick);
         tabbar.tab_rooms.addEventListener(MouseEvent.MOUSE_OVER,this.handleTabOver);
         tabbar.tab_rooms.addEventListener(MouseEvent.MOUSE_OUT,this.handleTabOut);
         tabbar.tab_favorites.buttonMode = true;
         tabbar.tab_favorites.useHandCursor = true;
         tabbar.tab_favorites.addEventListener(MouseEvent.CLICK,this.handleTabClick);
         tabbar.tab_favorites.addEventListener(MouseEvent.MOUSE_OVER,this.handleTabOver);
         tabbar.tab_favorites.addEventListener(MouseEvent.MOUSE_OUT,this.handleTabOut);
         this.initSortButtons();
         this.hoverlabel = new HoverLabel();
         this.hoverlabel.visible = false;
         if(Global.cookie.data.hasOwnProperty("sortby"))
         {
            this.sortby = Global.cookie.data.sortby;
            this.currentSort = this.getSortByIndex(this.sortby);
         }
         else
         {
            this.sortby = RoomList.SORT_BY_ONLINE;
            this.currentSort = tabbar.sortselector.btn_online;
         }
         this.updateFilter();
         btn_reload.buttonMode = true;
         btn_reload.useHandCursor = true;
         btn_reload.addEventListener(MouseEvent.MOUSE_DOWN,function():void
         {
            if(canReloadRooms)
            {
               enableRefreshButton(false);
               reloadWorldsCallback();
            }
         });
         btn_id.buttonMode = true;
         btn_id.useHandCursor = true;
         btn_id.addEventListener(MouseEvent.MOUSE_DOWN,function():void
         {
            (Global.base.state as LobbyState).showLoadRoom();
         });
         tf_search.addEventListener(Event.CHANGE,function():void
         {
            updateFilter();
         });
      }
      
      protected function handleTabOver(param1:MouseEvent) : void
      {
         if((param1.target as MovieClip).currentFrame != 2)
         {
            (param1.target as MovieClip).gotoAndStop(3);
         }
      }
      
      protected function handleTabOut(param1:MouseEvent) : void
      {
         if(this.currentTab != param1.target as MovieClip)
         {
            (param1.target as MovieClip).gotoAndStop(1);
         }
      }
      
      protected function handleTabClick(param1:MouseEvent) : void
      {
         switch(param1.target)
         {
            case tabbar.tab_rooms:
               tabbar.sortselector.gotoAndStop(1);
               this.favoriteOnly = false;
               break;
            case tabbar.tab_favorites:
               tabbar.sortselector.gotoAndStop(2);
               if(this.sortby == RoomList.SORT_BY_MYWORLDS || this.sortby == RoomList.SORT_BY_OPEN)
               {
                  this.sortby = RoomList.SORT_BY_ONLINE;
               }
               this.favoriteOnly = true;
         }
         this.currentTab = param1.target as MovieClip;
         this.currentSort = this.getSortByIndex(this.sortby);
         if(this.currentTab == tabbar.tab_favorites)
         {
            tabbar.tab_rooms.gotoAndStop(1);
         }
         else if(this.currentTab == tabbar.tab_rooms)
         {
            tabbar.tab_favorites.gotoAndStop(1);
         }
         this.currentTab.gotoAndStop(2);
         this.initSortButtons();
      }
      
      private function initSortButtons() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(this.currentTab == tabbar.tab_rooms)
         {
            this.sort_buttons = new Vector.<MovieClip>();
            this.sort_buttons.push(tabbar.sortselector.btn_online);
            this.sort_buttons.push(tabbar.sortselector.btn_myworlds);
            this.sort_buttons.push(tabbar.sortselector.btn_plays);
            this.sort_buttons.push(tabbar.sortselector.btn_likes);
            this.sort_buttons.push(tabbar.sortselector.btn_beta);
            this.sort_buttons.push(tabbar.sortselector.btn_open);
            this.sort_buttons.push(tabbar.sortselector.btn_featured);
            _loc1_ = 0;
            while(_loc1_ < this.sort_buttons.length)
            {
               this.sort_buttons[_loc1_].buttonMode = true;
               this.sort_buttons[_loc1_].mouseChildren = false;
               this.sort_buttons[_loc1_].addEventListener(MouseEvent.CLICK,this.handleMouseClick,false,0,true);
               _loc1_++;
            }
         }
         else if(this.currentTab == tabbar.tab_favorites)
         {
            this.sort_buttons = new Vector.<MovieClip>();
            this.sort_buttons.push(tabbar.sortselector.btn_online);
            this.sort_buttons.push(tabbar.sortselector.btn_plays);
            this.sort_buttons.push(tabbar.sortselector.btn_likes);
            this.sort_buttons.push(tabbar.sortselector.btn_beta);
            this.sort_buttons.push(tabbar.sortselector.btn_featured);
            _loc2_ = 0;
            while(_loc2_ < this.sort_buttons.length)
            {
               this.sort_buttons[_loc2_].buttonMode = true;
               this.sort_buttons[_loc2_].mouseChildren = false;
               this.sort_buttons[_loc2_].addEventListener(MouseEvent.CLICK,this.handleMouseClick,false,0,true);
               _loc2_++;
            }
         }
         this.updateFilter();
      }
      
      protected function handleMouseClick(param1:MouseEvent) : void
      {
         this.currentSort = param1.target as MovieClip;
         switch(param1.target)
         {
            case tabbar.sortselector.btn_online:
               this.sortby = RoomList.SORT_BY_ONLINE;
               break;
            case tabbar.sortselector.btn_plays:
               this.sortby = RoomList.SORT_BY_PLAYS;
               break;
            case tabbar.sortselector.btn_beta:
               this.sortby = RoomList.SORT_BY_BETA;
               break;
            case tabbar.sortselector.btn_likes:
               this.sortby = RoomList.SORT_BY_LIKES;
               break;
            case tabbar.sortselector.btn_myworlds:
               this.sortby = RoomList.SORT_BY_MYWORLDS;
               break;
            case tabbar.sortselector.btn_open:
               this.sortby = RoomList.SORT_BY_OPEN;
               break;
            case tabbar.sortselector.btn_featured:
               this.sortby = RoomList.SORT_BY_FEATURED;
         }
         Global.cookie.data.sortby = this.sortby;
         this.updateFilter();
      }
      
      private function getSortByIndex(param1:int) : MovieClip
      {
         switch(param1)
         {
            case 1:
               return tabbar.sortselector.btn_online;
            case 3:
               return tabbar.sortselector.btn_plays;
            case 5:
               return tabbar.sortselector.btn_beta;
            case 4:
               return tabbar.sortselector.btn_likes;
            case 2:
               return tabbar.sortselector.btn_myworlds;
            case 6:
               return tabbar.sortselector.btn_open;
            case 7:
               return tabbar.sortselector.btn_featured;
            default:
               return null;
         }
      }
      
      public function enableRefreshButton(param1:Boolean) : void
      {
         var value:Boolean = param1;
         TweenMax.delayedCall(!!value?Number(3):Number(0),function():void
         {
            canReloadRooms = value;
            TweenMax.to(btn_reload,0.5,{"alpha":(!!value?1:0.5)});
         });
      }
      
      private function reset() : void
      {
         this.showopen = false;
         this.showlocked = false;
         this.betaonly = false;
         this.favoriteOnly = false;
         this.showmyworlds = false;
      }
      
      override public function set height(param1:Number) : void
      {
      }
      
      private function updateFilter() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         if(this.sort_buttons)
         {
            _loc1_ = 0;
            while(_loc1_ < this.sort_buttons.length)
            {
               _loc2_ = this.sort_buttons[_loc1_] as MovieClip;
               _loc2_.mouseEnabled = this.currentSort != _loc2_;
               (_loc2_.getChildByName("underline") as MovieClip).visible = this.currentSort == _loc2_;
               _loc1_++;
            }
            this.callback(tf_search.text,this.sortby,this.betaonly,this.favoriteOnly);
         }
      }
      
      private function handleMouse(param1:MouseEvent) : void
      {
         if(param1.type == MouseEvent.MOUSE_OVER)
         {
            if(this.currentHover != param1.target)
            {
               this.currentHover = param1.target;
            }
            this.hovertimer = setTimeout(this.showHoverLabel,800);
         }
         else
         {
            this.hoverlabel.visible = false;
            clearInterval(this.hovertimer);
         }
         if(param1.type == MouseEvent.MOUSE_OUT)
         {
            this.currentHover = null;
         }
      }
      
      protected function handleMouseMove(param1:MouseEvent = null) : void
      {
         if(this.hoverlabel.visible)
         {
            if(this.currentHover != null)
            {
               this.hoverlabel.draw(this.getTextFromCurrentObject(this.currentHover));
            }
            this.hoverlabel.x = parent.mouseX;
            if(this.hoverlabel.x > parent.width / 2)
            {
               this.hoverlabel.x = this.hoverlabel.x - (this.hoverlabel.w + 12);
            }
            else
            {
               this.hoverlabel.x = this.hoverlabel.x + 12;
            }
            this.hoverlabel.y = parent.mouseY - this.hoverlabel.height / 2;
         }
      }
      
      public function showHoverLabel() : void
      {
         parent.addChild(this.hoverlabel);
         this.hoverlabel.alpha = 0;
         TweenMax.to(this.hoverlabel,0.25,{"alpha":1});
         if(this.currentHover != null)
         {
            this.hoverlabel.draw("" + this.getTextFromCurrentObject(this.currentHover));
         }
         this.hoverlabel.visible = true;
         this.handleMouseMove();
      }
      
      public function getTextFromCurrentObject(param1:*) : String
      {
         switch(param1)
         {
            case tabbar.sortselector.btn_online:
               return "Sort worlds by the most amount of players online.";
            case tabbar.sortselector.btn_plays:
               return "Sort worlds by the most amount of plays.";
            case tabbar.sortselector.btn_beta:
               return "Show beta only worlds. These are worlds which only beta members can join.";
            case tabbar.sortselector.btn_likes:
               return "Sort worlds by the most amount of likes.";
            case tabbar.sortselector.btn_myworlds:
               return "Only display worlds owned by you.";
            case tabbar.sortselector.btn_open:
               return "Only display open worlds. These are worlds which anyone can edit.";
            default:
               return "";
         }
      }
   }
}
