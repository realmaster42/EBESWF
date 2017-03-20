package ui.campaigns
{
   import com.greensock.TweenMax;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.net.URLRequest;
   import sample.ui.components.Box;
   import sample.ui.components.Label;
   
   public class CampaignWorld extends Box
   {
       
      
      protected var Lock:Class;
      
      private var lockImage:BitmapData;
      
      protected var Check:Class;
      
      private var checkImage:BitmapData;
      
      public var worldImage:Bitmap;
      
      private var wImage:Loader;
      
      private var _lock:Bitmap;
      
      private var _check:Bitmap;
      
      private var _locked:Boolean;
      
      private var _complete:Boolean;
      
      private var _worldName:String;
      
      private var worldOwner:String;
      
      private var _worldId:String;
      
      private var tierInfo:String;
      
      private var _imageLink:String;
      
      private var worldWidth:int;
      
      private var worldHeight:int;
      
      private var difficulty:int;
      
      private var _tier:int;
      
      private var label:Label;
      
      private var byLabel:Label;
      
      private var tierLabel:Label;
      
      private var _rewards:Array;
      
      private var imageLoaded:Function;
      
      public function CampaignWorld(param1:String, param2:String, param3:String, param4:int, param5:int, param6:Boolean, param7:Boolean, param8:String, param9:Array, param10:Function)
      {
         var miniLoading:assets_miniloading = null;
         var loader:Loader = null;
         var worldId:String = param1;
         var name:String = param2;
         var owner:String = param3;
         var diff:int = param4;
         var tier:int = param5;
         var locked:Boolean = param6;
         var complete:Boolean = param7;
         var imageLink:String = param8;
         var rewards:Array = param9;
         var imageLoadedCallback:Function = param10;
         this.Lock = CampaignWorld_Lock;
         this.lockImage = new this.Lock().bitmapData;
         this.Check = CampaignWorld_Check;
         this.checkImage = new this.Check().bitmapData;
         super();
         border(1,10066329,1);
         fill(1118481,1,5);
         this._locked = locked;
         this._complete = complete;
         this._worldName = name;
         this._worldId = worldId;
         this.worldOwner = owner;
         this.difficulty = diff;
         this.worldWidth = 200;
         this.worldHeight = 200;
         this._imageLink = imageLink;
         this._tier = tier;
         this._rewards = rewards;
         this.label = new Label(this._worldName + "\nBy: " + this.worldOwner,12,"left",16777215,false,"visitor");
         this.label.x = 2;
         this.label.y = 3;
         width = this.label.width > this.worldWidth?Number(this.label.width):Number(this.worldWidth + 6);
         height = this.worldHeight;
         addChild(this.label);
         miniLoading = new assets_miniloading();
         miniLoading.x = width - miniLoading.width + 10;
         miniLoading.y = height - miniLoading.height - 10;
         addChild(miniLoading);
         loader = new Loader();
         loader.contentLoaderInfo.addEventListener(Event.COMPLETE,function(param1:Event):void
         {
            removeChild(miniLoading);
            worldImage = new Bitmap(new BitmapData(loader.width > 305?305:int(loader.width),loader.height > 117?117:int(loader.height)));
            worldImage.bitmapData.draw(Bitmap(loader.content));
            removeChild(label);
            wImage = loader;
            worldWidth = wImage.width;
            worldHeight = wImage.height;
            width = label.width > wImage.width?Number(label.width):Number(wImage.width + 6);
            height = wImage.height + 28;
            addChild(label);
            wImage.x = (width - wImage.width) / 2;
            wImage.y = (height - wImage.height) / 2 + label.height - 10;
            addChild(wImage);
            if(imageLoaded != null)
            {
               imageLoaded(worldImage);
            }
            if(locked)
            {
               _lock = new Bitmap(lockImage);
               _lock.height = wImage.height / 2 > 100?Number(100):Number(wImage.height / 2);
               _lock.width = _lock.height;
               _lock.x = wImage.x + (wImage.width - _lock.width) / 2;
               _lock.y = wImage.y + (wImage.height - _lock.height) / 2;
               addChild(_lock);
               wImage.alpha = 0.25;
            }
            if(complete)
            {
               AddCheckMark(false);
            }
            drawRewards();
            imageLoadedCallback();
         });
         loader.load(new URLRequest(imageLink));
         this.useHandCursor = true;
         this.buttonMode = true;
      }
      
      public function setImageLoadedCallback(param1:Function) : void
      {
         this.imageLoaded = param1;
      }
      
      private function drawRewards() : void
      {
         var _loc6_:CampaignReward = null;
         var _loc1_:int = height + 10;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         while(_loc3_ < this._rewards.length)
         {
            if(this._rewards[_loc3_].type.substring(0,5) != "world")
            {
               _loc2_ = _loc2_ + this._rewards[_loc3_].width;
            }
            _loc3_++;
         }
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         while(_loc5_ < this._rewards.length)
         {
            _loc6_ = this._rewards[_loc5_];
            if(_loc6_ != null)
            {
               if(_loc6_.type.substring(0,5) != "world")
               {
                  _loc6_.y = _loc1_;
                  _loc6_.x = _loc4_ * 45 + (width - _loc2_) / 2 + 6;
                  _loc4_++;
               }
               else
               {
                  _loc6_.y = _loc1_ + 55;
                  _loc6_.x = (width - _loc6_.width) / 2 + 5;
               }
               addChild(_loc6_);
            }
            _loc5_++;
         }
      }
      
      public function getFirstReward() : CampaignReward
      {
         if(this._rewards.length > 0)
         {
            return this._rewards[0] as CampaignReward;
         }
         return null;
      }
      
      private function AddCheckMark(param1:Boolean) : void
      {
         this._check = new Bitmap(this.checkImage);
         this._check.width = !!param1?Number(this.wImage.height):this.wImage.height / 2 > 100?Number(100):Number(this.wImage.height / 2);
         this._check.height = !!param1?Number(this.wImage.height):this.wImage.height / 2 > 100?Number(100):Number(this.wImage.height / 2);
         this._check.x = this.wImage.x + (this.wImage.width - this._check.width) / 2;
         this._check.y = this.wImage.y + (this.wImage.height - this._check.height) / 2;
         this._check.alpha = !!param1?Number(0):Number(1);
         addChild(this._check);
         if(param1)
         {
            TweenMax.to(this._check,0.3,{
               "x":this.wImage.x + (this.wImage.width - this._check.width) / 2,
               "y":this.wImage.y + (this.wImage.height - this._check.height) / 2,
               "width":100,
               "height":100,
               "alpha":1
            });
         }
      }
      
      private function Unlock() : void
      {
         TweenMax.to(this._lock,0.3,{
            "x":this.wImage.x + (this.wImage.width - this._lock.width + 10) / 2,
            "y":this.wImage.y + (this.wImage.height - this._lock.height + 10) / 2,
            "width":this._lock.width + 10,
            "height":this._lock.height + 10,
            "onComplete":function():void
            {
               TweenMax.to(_lock,0.2,{
                  "x":wImage.x + (wImage.width - 10) / 2,
                  "y":wImage.y + (wImage.height - 10) / 2,
                  "width":10,
                  "height":10,
                  "alpha":0,
                  "onComplete":function():void
                  {
                     TweenMax.to(wImage,0.2,{"alpha":1});
                     removeChild(_lock);
                  }
               });
            }
         });
      }
      
      public function set complete(param1:Boolean) : void
      {
         this._complete = param1;
         if(this._complete)
         {
            this.AddCheckMark(true);
         }
      }
      
      public function get tier() : int
      {
         return this._tier;
      }
      
      public function get imageLink() : String
      {
         return this._imageLink;
      }
      
      public function get completed() : Boolean
      {
         return this._complete;
      }
      
      public function get worldName() : String
      {
         return this._worldName;
      }
      
      public function get worldId() : String
      {
         return this._worldId;
      }
      
      public function get locked() : Boolean
      {
         return this._locked;
      }
      
      public function set locked(param1:Boolean) : void
      {
         this._locked = param1;
         if(this._locked == false)
         {
            this.Unlock();
         }
      }
   }
}
