package ui.crews
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class Faceplate extends Sprite
   {
       
      
      private var Dots:Class;
      
      private var dotsBMD:BitmapData;
      
      private var Electric:Class;
      
      private var electricBMD:BitmapData;
      
      private var Confetti:Class;
      
      private var confettiBMD:BitmapData;
      
      private var Fog:Class;
      
      private var fogBMD:BitmapData;
      
      private var Paint:Class;
      
      private var paintBMD:BitmapData;
      
      private var Stripes:Class;
      
      private var stripesBMD:BitmapData;
      
      private var Code:Class;
      
      private var codeBMD:BitmapData;
      
      private var Tile:Class;
      
      private var tileBMD:BitmapData;
      
      private var Gold:Class;
      
      private var goldBMD:BitmapData;
      
      private var faceplates:Object;
      
      private var bmd:BitmapData;
      
      private var _type:String;
      
      private var _color:int;
      
      public function Faceplate(param1:String = "", param2:int = 0)
      {
         this.Dots = Faceplate_Dots;
         this.dotsBMD = new this.Dots().bitmapData;
         this.Electric = Faceplate_Electric;
         this.electricBMD = new this.Electric().bitmapData;
         this.Confetti = Faceplate_Confetti;
         this.confettiBMD = new this.Confetti().bitmapData;
         this.Fog = Faceplate_Fog;
         this.fogBMD = new this.Fog().bitmapData;
         this.Paint = Faceplate_Paint;
         this.paintBMD = new this.Paint().bitmapData;
         this.Stripes = Faceplate_Stripes;
         this.stripesBMD = new this.Stripes().bitmapData;
         this.Code = Faceplate_Code;
         this.codeBMD = new this.Code().bitmapData;
         this.Tile = Faceplate_Tile;
         this.tileBMD = new this.Tile().bitmapData;
         this.Gold = Faceplate_Gold;
         this.goldBMD = new this.Gold().bitmapData;
         this.faceplates = {
            "dots":this.dotsBMD,
            "electric":this.electricBMD,
            "confetti":this.confettiBMD,
            "fog":this.fogBMD,
            "paint":this.paintBMD,
            "stripes":this.stripesBMD,
            "code":this.codeBMD,
            "tile":this.tileBMD,
            "gold":this.goldBMD
         };
         this.bmd = new BitmapData(830,65,true,0);
         super();
         this.setFaceplate(param1,param2);
         addChild(new Bitmap(this.bmd));
      }
      
      public function setFaceplate(param1:String, param2:int) : void
      {
         var _loc3_:BitmapData = this.faceplates[param1.toLowerCase()];
         if(_loc3_ != null)
         {
            this.bmd.copyPixels(_loc3_,new Rectangle(830 * param2,0,830,65),new Point(0,0));
         }
         this._type = param1;
         this._color = param2;
         visible = param1 != "None" && param1 != "";
      }
      
      public function get type() : String
      {
         return this._type;
      }
      
      public function get color() : int
      {
         return this._color;
      }
   }
}
