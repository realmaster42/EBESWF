package
{
   import items.ItemId;
   
   public class InspectTool extends TextBubble
   {
       
      
      private var world:World;
      
      public function InspectTool(param1:World)
      {
         super();
         this.world = param1;
      }
      
      public function updateForBlockAt(param1:int, param2:int) : void
      {
         update(this.getInspectText(param1,param2),0,false);
      }
      
      private function getInspectText(param1:int, param2:int) : String
      {
         var _loc3_:* = "(" + param1 + "," + param2 + ")\n";
         var _loc4_:String = this.getLayerText(0,param1,param2);
         var _loc5_:String = this.getLayerText(1,param1,param2);
         if(_loc4_ != "")
         {
            _loc3_ = _loc3_ + ("\n" + _loc4_ + "\n");
         }
         if(_loc5_ != "")
         {
            _loc3_ = _loc3_ + ("\n" + _loc5_ + "\n");
         }
         if(_loc4_ == "" && _loc5_ == "")
         {
            _loc3_ = _loc3_ + ("\n" + "No placement data\n");
         }
         _loc3_ = _loc3_ + this.getForegroundBlockInfo(param1,param2);
         return _loc3_;
      }
      
      private function getLayerText(param1:int, param2:int, param3:int) : String
      {
         var _loc4_:int = this.world.getTile(param1,param2,param3);
         var _loc5_:String = this.world.lookup.getPlacer(param2,param3,param1);
         if(_loc5_ == "")
         {
            return "";
         }
         var _loc6_:String = param1 == 0?"Foreground":"Background";
         return _loc6_ + ":\n" + this.getPlacerText(_loc5_,_loc4_);
      }
      
      private function getForegroundBlockInfo(param1:int, param2:int) : String
      {
         var _loc4_:Portal = null;
         var _loc3_:int = this.world.getTile(0,param1,param2);
         if(_loc3_ == ItemId.WORLD_PORTAL)
         {
            return "\nWorld Portal:\nDestination: " + this.world.lookup.getText(param1,param2);
         }
         if(_loc3_ == ItemId.PORTAL || _loc3_ == ItemId.PORTAL_INVISIBLE)
         {
            _loc4_ = this.world.lookup.getPortal(param1,param2);
            return "\nPortal:\nID: " + _loc4_.id + "\nPortal Target: " + _loc4_.target + "\nRotation: " + _loc4_.rotation;
         }
         if(_loc3_ == 77 || _loc3_ == 83)
         {
            return "\nNote Block:\nSound: #" + this.world.lookup.getInt(param1,param2);
         }
         if(ItemId.isBlockRotateable(_loc3_) || _loc3_ == ItemId.TEXT_SIGN || _loc3_ == ItemId.SPIKE)
         {
            return "\nMorph:\nVariant: " + this.world.lookup.getInt(param1,param2);
         }
         return "";
      }
      
      private function getPlacerText(param1:String, param2:int) : String
      {
         return (param2 == 0?"Removed":"Placed") + " by " + param1;
      }
   }
}
