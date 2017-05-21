package ui.campaigns
{
   import com.greensock.TweenMax;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import items.ItemBrick;
   import items.ItemManager;
   import items.ItemSmiley;
   import sample.ui.components.Label;
   
   public class CampaignReward extends Sprite
   {
       
      
      protected var GemClass:Class;
      
      private var gemBMD:BitmapData;
      
      private var energy:MovieClip;
      
      private var gem:Bitmap;
      
      private var _type:String;
      
      private var label:Label;
      
      public function CampaignReward(param1:String, param2:uint)
      {
         var _loc3_:* = null;
         var _loc4_:ItemBrick = null;
         var _loc5_:Bitmap = null;
         var _loc6_:ItemSmiley = null;
         var _loc7_:Bitmap = null;
         this.GemClass = CampaignReward_GemClass;
         this.gemBMD = new this.GemClass().bitmapData;
         super();
         this._type = param1;
         this.label = new Label("+" + param2.toString(),8,"left",16777215,false,"system");
         switch(param1)
         {
            case "maxEnergy":
            case "energyRefill":
            case "energy":
               _loc3_ = "";
               if(param1 == "maxEnergy")
               {
                  _loc3_ = "+" + param2 + " Max";
               }
               if(param1 == "energyRefill")
               {
                  _loc3_ = "Refill";
               }
               if(param1 == "energy")
               {
                  _loc3_ = "+" + param2;
               }
               this.label.text = _loc3_;
               this.energy = new assets_lightning();
               this.energy.width = 16;
               this.energy.height = 27;
               this.label.x = (this.energy.width - this.label.width) / 2;
               this.label.y = this.energy.height;
               addChild(this.energy);
               break;
            case "gems":
               this.gem = new Bitmap(this.gemBMD);
               this.gem.x = this.gem.x - 5;
               this.gem.scaleX = 2;
               this.gem.scaleY = 2;
               this.label.x = this.gem.x + (this.gem.width - this.label.width) / 2;
               this.label.y = this.gem.height + 3;
               addChild(this.gem);
               break;
            default:
               if(param1.substring(0,5) == "brick")
               {
                  _loc4_ = ItemManager.getBrickByPayvaultId(param1);
                  if(_loc4_ == null)
                  {
                     _loc4_ = ItemManager.getBrickById(9);
                  }
                  _loc5_ = new Bitmap(_loc4_.bmd);
                  _loc5_.y = 5;
                  this.label.text = "Block";
                  this.label.x = (_loc5_.width - this.label.width) / 2 + 2;
                  this.label.y = _loc5_.y + _loc5_.height + 5;
                  addChild(_loc5_);
               }
               else if(param1.substring(0,6) == "smiley")
               {
                  _loc6_ = ItemManager.getSmileyByPayvaultId(param1);
                  if(_loc6_ == null)
                  {
                     _loc6_ = ItemManager.getSmileyById(18);
                     this.label.text = "Unknown";
                  }
                  else
                  {
                     this.label.text = _loc6_.name;
                  }
                  _loc7_ = new Bitmap(_loc6_.bmd);
                  _loc7_.y = _loc7_.y + 3;
                  _loc7_.x = _loc7_.x + 3;
                  this.label.x = _loc7_.x + (_loc7_.width - this.label.width) / 2 + 2;
                  this.label.y = _loc7_.y + _loc7_.height - 2;
                  addChild(_loc7_);
               }
               else if(param1.substring(0,5) == "world")
               {
                  this.label = new Label("+" + this.getWorldSizeByType(param1),8,"left",16777215,false,"system");
               }
         }
         addChild(this.label);
      }
      
      public function getWorldSizeByType(param1:String) : String
      {
         switch(param1)
         {
            case "world0":
               return "30x30 World";
            case "world1":
               return "50x50 World";
            case "world2":
               return "100x100 World";
            case "world3":
               return "200x200 World";
            case "world4":
               return "400x50 World";
            case "world5":
               return "400x200 World";
            case "world6":
               return "100x400 World";
            case "world7":
               return "636x50 World";
            case "world8":
               return "50x50 World";
            case "world9":
               return "25x25 World";
            case "world10":
               return "400x200 World";
            case "world11":
               return "300x300 World";
            case "world12":
               return "200x400 World";
            default:
               return "";
         }
      }
      
      public function beginAnimation() : void
      {
         y = 500;
         TweenMax.to(this,0.8,{"y":415});
      }
      
      public function get type() : String
      {
         return this._type;
      }
   }
}
