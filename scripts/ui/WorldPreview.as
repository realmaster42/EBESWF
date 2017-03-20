package ui
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import playerio.DatabaseObject;
   import sample.ui.components.Box;
   
   public class WorldPreview extends Box
   {
       
      
      private var _key:String;
      
      private var _plays:int;
      
      private var _bitmap:Bitmap;
      
      public function WorldPreview(param1:DatabaseObject, param2:Boolean, param3:Boolean = false, param4:Function = null)
      {
         var o:DatabaseObject = param1;
         var joinOnClick:Boolean = param2;
         var joinNewTab:Boolean = param3;
         var onClick:Function = param4;
         super();
         this._key = o.key || "";
         this._plays = int(o.plays) || 0;
         var world:World = new World(false);
         world.deserializeFromDatabaseObject(o);
         var bmd:BitmapData = new BitmapData(world.width,world.height,true);
         this._bitmap = new Bitmap(bmd,"auto",true);
         addChild(this._bitmap);
         var m:MiniMap = new MiniMap(world,world.width,world.height);
         this._bitmap.x = 0;
         m.drawDirect(bmd);
         world = null;
         m = null;
         if(joinOnClick)
         {
            addEventListener(MouseEvent.CLICK,function(param1:MouseEvent):void
            {
               var _loc2_:NavigationEvent = null;
               if(joinNewTab)
               {
                  navigateToURL(new URLRequest("http://everybodyedits.com/games/" + key),"_blank");
               }
               else
               {
                  _loc2_ = new NavigationEvent(NavigationEvent.JOIN_WORLD,true,false);
                  _loc2_.world_id = key;
                  Global.base.dispatchEvent(_loc2_);
                  if(onClick != null)
                  {
                     onClick();
                  }
               }
            });
            useHandCursor = true;
            buttonMode = true;
         }
      }
      
      public function get key() : String
      {
         return this._key;
      }
      
      public function get plays() : int
      {
         return this._plays;
      }
      
      public function get bitmap() : Bitmap
      {
         return this._bitmap;
      }
   }
}
