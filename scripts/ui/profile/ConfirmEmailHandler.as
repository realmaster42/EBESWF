package ui.profile
{
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import items.ItemManager;
   import sample.ui.components.Box;
   import sample.ui.components.Label;
   
   public class ConfirmEmailHandler extends Sprite
   {
       
      
      protected var img_ee:Class;
      
      protected var img_kongregate:Class;
      
      protected var img_armor:Class;
      
      private var confirmKey:String;
      
      private var base:Box;
      
      private var content:Box;
      
      private var btn_ee:Box;
      
      private var btn_kongregate:Box;
      
      private var btn_armorgames:Box;
      
      private var mainLabel:Label;
      
      public function ConfirmEmailHandler(param1:String)
      {
         var _loc2_:Box = null;
         this.img_ee = ConfirmEmailHandler_img_ee;
         this.img_kongregate = ConfirmEmailHandler_img_kongregate;
         this.img_armor = ConfirmEmailHandler_img_armor;
         this.base = new Box();
         this.content = new Box();
         super();
         this.confirmKey = param1;
         this.base.margin(10,0,0,0);
         this.base.add(new Box().fill(2236962,0.8,10).margin(5,5,5,5).add(this.content));
         this.base.filters = [new GlowFilter(0,1,20,20,2)];
         addChild(this.base);
         Global.sharedCookie.data.confirmkey = param1;
         this.content.margin(40);
         _loc2_ = new Box();
         _loc2_.margin(20,0,0,0);
         _loc2_.fill(3355443,1,10);
         _loc2_.width = 615;
         _loc2_.height = 390;
         _loc2_.filters = [new GlowFilter(0,0.3,20,20,2)];
         this.content.add(_loc2_);
         var _loc3_:Box = new Box();
         _loc3_.margin(0,NaN,NaN,NaN);
         var _loc4_:FriendSmiley = new FriendSmiley(ItemManager.smiliesBMD);
         _loc4_.frame = 34;
         var _loc5_:Bitmap = _loc4_.getAsBitmap(2);
         _loc3_.addChild(_loc5_);
         _loc2_.add(_loc3_);
         this.mainLabel = new Label("Your email has been confirmed.\nLog in to Everybody Edits to activate chat\nand reviece the Postman smiley.\nCookies must be turned on.",15,"center",16777215,false,"system");
         _loc2_.add(new Box().margin(65,0,0,0).add(this.mainLabel));
         this.btn_ee = new Box().margin(0,0,0,0).add(new Box().add(new Label("Play on:",10,"center",16777215,false,"system")),new Box().add(new this.img_ee()));
         this.btn_ee.buttonMode = true;
         this.btn_ee.mouseEnabled = true;
         this.btn_ee.mouseChildren = false;
         this.btn_ee.useHandCursor = true;
         this.btn_kongregate = new Box().margin(0,0,0,0).add(new Box().add(new Label("Play on:",10,"center",16777215,false,"system")),new Box().margin(15).add(new this.img_kongregate()));
         this.btn_armorgames = new Box().margin(0,0,0,0).add(new Box().add(new Label("Play on:",10,"center",16777215,false,"system")),new Box().margin(15).add(new this.img_armor()));
         this.btn_kongregate.filters = this.btn_armorgames.filters = [new DropShadowFilter(3,45,0,0.4,10,10)];
         this.btn_kongregate.buttonMode = this.btn_armorgames.buttonMode = true;
         this.btn_kongregate.mouseEnabled = this.btn_armorgames.mouseEnabled = true;
         this.btn_kongregate.mouseChildren = this.btn_armorgames.mouseChildren = false;
         this.btn_kongregate.useHandCursor = this.btn_armorgames.useHandCursor = true;
         var _loc6_:Box = new Box().margin(0,0,0,0);
         _loc6_.add();
         _loc6_.width = 615;
         _loc6_.height = 400;
         _loc6_.add(new Box().margin(0,NaN,NaN,NaN).add(this.btn_ee));
         _loc6_.add(new Box().margin(this.btn_ee.height + 15,NaN,NaN,NaN).add(new Box().add(this.btn_armorgames,new Box().margin(NaN,NaN,NaN,this.btn_kongregate.width + 20).add(this.btn_kongregate))));
         _loc2_.add(new Box().margin(130,0,0,0).add(_loc6_));
         _loc6_.addEventListener(MouseEvent.MOUSE_DOWN,this.handleButton,false,0,true);
         this.base.height++;
         this.handleResize();
         addEventListener(Event.ADDED_TO_STAGE,this.handleAttach);
      }
      
      protected function handleButton(param1:MouseEvent) : void
      {
         var _loc2_:String = "";
         switch(param1.target)
         {
            case this.btn_ee:
               _loc2_ = "http://everybodyedits.com/";
               break;
            case this.btn_kongregate:
               _loc2_ = "http://www.kongregate.com/games/QRious/everybody-edits/";
               break;
            case this.btn_armorgames:
               _loc2_ = "http://armorgames.com/play/11986/everybody-edits";
         }
         navigateToURL(new URLRequest(_loc2_),"_top");
      }
      
      private function handleAttach(param1:Event) : void
      {
         stage.addEventListener(Event.RESIZE,this.handleResize);
         this.handleResize();
      }
      
      private function handleResize(param1:Event = null) : void
      {
         if(stage != null)
         {
            this.base.x = 0;
            this.base.y = 0;
            this.base.width = Global.width - 20;
            this.base.height = Global.height - 20;
         }
      }
   }
}
