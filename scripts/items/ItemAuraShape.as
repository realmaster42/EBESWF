package items
{
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class ItemAuraShape
   {
       
      
      public var id:int;
      
      public var name:String;
      
      public var payvaultid:String;
      
      public var bmd:BitmapData;
      
      public var auras:Vector.<ItemAura>;
      
      public function ItemAuraShape(param1:int, param2:String, param3:BitmapData, param4:String, param5:int = 1, param6:Number = 0.2, param7:Boolean = false)
      {
         var _loc9_:BitmapData = null;
         var _loc10_:ItemAura = null;
         var _loc11_:BitmapData = null;
         this.auras = new Vector.<ItemAura>();
         super();
         this.id = param1;
         this.name = param2;
         this.bmd = param3;
         this.payvaultid = param4;
         var _loc8_:int = 0;
         while(_loc8_ < param3.width / 64)
         {
            _loc9_ = new BitmapData(64,64,true,0);
            _loc9_.copyPixels(param3,new Rectangle(_loc8_ * 64,0,64,64),new Point(0,0));
            _loc10_ = new ItemAura(param1,_loc8_,_loc9_);
            this.auras.push(_loc10_);
            if(param5 > 1)
            {
               _loc11_ = new BitmapData(64,64 * param5,true,0);
               _loc11_.copyPixels(param3,new Rectangle(_loc8_ * 64,0,64,64 * param5),new Point(0,0));
               _loc10_.setFramedAnimation(_loc11_,param5,param6);
            }
            else if(param7)
            {
               _loc10_.setRotationAnimation(14,84);
            }
            _loc8_++;
         }
      }
   }
}
