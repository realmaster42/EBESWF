package playerio
{
   class StringForm
   {
       
      
      function StringForm()
      {
         super();
      }
      
      static function decodeStringDictionary(param1:String) : Object
      {
         var _loc2_:* = null;
         var _loc6_:* = null;
         var _loc7_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:* = null;
         try
         {
            _loc2_ = {};
            _loc6_ = null;
            _loc7_ = 2;
            while(_loc7_ < param1.length)
            {
               _loc4_ = param1.indexOf(":",_loc7_);
               _loc5_ = param1.substr(_loc7_,_loc4_ - _loc7_);
               _loc3_ = param1.substr(_loc4_ + 1,_loc5_);
               _loc7_ = _loc4_ + 1 + _loc5_ + 1;
               if(_loc6_ == null)
               {
                  _loc6_ = _loc3_;
               }
               else
               {
                  _loc2_[_loc6_] = _loc3_;
                  _loc6_ = null;
               }
            }
            var _loc9_:* = _loc2_;
            return _loc9_;
         }
         catch(e:Error)
         {
            var _loc10_:* = {"error":e.message};
            return _loc10_;
         }
         return null;
      }
      
      static function encodeStringDictionary(param1:Object) : String
      {
         var _loc2_:* = "A";
         if(param1 != null)
         {
            var _loc5_:int = 0;
            var _loc4_:* = param1;
            for(var _loc3_ in param1)
            {
               if(param1[_loc3_] != undefined)
               {
                  _loc2_ = _loc2_ + ":";
                  _loc2_ = _loc2_ + _loc3_.length;
                  _loc2_ = _loc2_ + ":";
                  _loc2_ = _loc2_ + _loc3_;
                  _loc2_ = _loc2_ + ":";
                  _loc2_ = _loc2_ + (param1[_loc3_] as String).length;
                  _loc2_ = _loc2_ + ":";
                  _loc2_ = _loc2_ + (param1[_loc3_] as String);
               }
            }
         }
         return _loc2_;
      }
      
      static function decodeStringArray(param1:String) : Array
      {
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:* = null;
         var _loc2_:Array = [];
         _loc6_ = 2;
         while(_loc6_ < param1.length)
         {
            _loc4_ = param1.indexOf(":",_loc6_);
            _loc5_ = param1.substr(_loc6_,_loc4_ - _loc6_);
            _loc3_ = param1.substr(_loc4_ + 1,_loc5_);
            _loc6_ = _loc4_ + 1 + _loc5_ + 1;
            _loc2_.push(_loc3_);
         }
         return _loc2_;
      }
   }
}
