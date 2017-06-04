package ui.profile
{
   import data.SimplePlayerObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import input.KeyState;
   import playerio.DatabaseObject;
   import sample.ui.components.Box;
   import sample.ui.components.Label;
   import sample.ui.components.scroll.ScrollBox;
   
   public class MyWorlds extends Sprite
   {
       
      
      private var worldlist:Array;
      
      private var rooms:Array;
      
      private var worlds:FillBox;
      
      private var worldcontent:Box;
      
      private var worldscrollbox:ScrollBox;
      
      private var renderedWorlds:int = 0;
      
      private var loadinganim:Box;
      
      public function MyWorlds()
      {
         super();
         this.worldlist = [];
         this.worldcontent = new Box();
         this.worlds = new FillBox(2);
         this.worlds.forceScale = true;
         this.worldcontent.margin(0,0,0,0);
         this.worldscrollbox = new ScrollBox().margin(0,0,0,0).add(new Box().margin(0,0,0,0).add(this.worlds));
         this.worldcontent.add(new Box().margin(0,0,0,0).add(this.worldscrollbox));
         this.worldscrollbox.scrollMultiplier = 6;
         this.loadinganim = new Box().margin(150,NaN,NaN,250);
         this.loadinganim.add(new assets_miniloading());
         this.worldscrollbox.addChild(this.loadinganim);
         this.loadRooms();
         addChild(this.worldcontent);
      }
      
      private function loadRooms() : void
      {
         while(this.worlds.numChildren > 0)
         {
            this.worlds.removeChildAt(0);
         }
         var _loc1_:SimplePlayerObject = Global.playerObject;
         this.rooms = _loc1_.roomids.concat();
         if(_loc1_.room0)
         {
            this.rooms.push(_loc1_.room0);
         }
         if(_loc1_.betaonlyroom)
         {
            this.rooms.push(_loc1_.betaonlyroom);
         }
         this.loadNextLevel();
      }
      
      private function loadNextLevel() : void
      {
         if(this.rooms.length == 0)
         {
            if(this.renderedWorlds == 0)
            {
               this.worldscrollbox.addChild(new Box().margin(25,NaN,NaN,0).add(new Label("You have not created any worlds yet",10,"left",16777215,false,"system")));
            }
            return;
         }
         if(this.renderedWorlds > 0)
         {
            if(this.worldscrollbox.contains(this.loadinganim))
            {
               this.worldscrollbox.removeChild(this.loadinganim);
            }
         }
         var toload:String = this.rooms.pop();
         if(toload == "")
         {
            this.loadNextLevel();
            return;
         }
         Global.client.bigDB.load("Worlds",toload,function(param1:DatabaseObject):void
         {
            renderWorld(param1);
            loadNextLevel();
         },this.handleError);
      }
      
      private function handleError(param1:Error) : void
      {
      }
      
      private function renderWorld(param1:DatabaseObject) : void
      {
         if(param1 == null || param1.worlddata == null)
         {
            return;
         }
         this.renderedWorlds++;
         var _loc2_:ProfileWorld = new ProfileWorld(param1,true,KeyState.isKeyDown(16));
         this.worldlist.push(_loc2_);
         this.worldlist.sortOn(["plays"],Array.NUMERIC | Array.DESCENDING);
         var _loc3_:int = 0;
         while(_loc3_ < this.worldlist.length)
         {
            this.worlds.addChild(this.worldlist[_loc3_]);
            _loc3_++;
         }
         this.worldscrollbox.refresh();
      }
      
      protected function handleWorldClicked(param1:MouseEvent) : void
      {
         var _loc2_:ProfileWorld = param1.target as ProfileWorld;
         var _loc3_:NavigationEvent = new NavigationEvent(NavigationEvent.JOIN_WORLD,true,false);
         _loc3_.world_id = _loc2_.key;
         dispatchEvent(_loc3_);
      }
      
      override public function set width(param1:Number) : void
      {
         this.worldcontent.width = param1;
      }
      
      override public function set height(param1:Number) : void
      {
         this.worldcontent.height = param1;
      }
   }
}
