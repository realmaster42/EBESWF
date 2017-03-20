package ui.profile
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import sample.ui.components.Box;
   
   public class RegisterAd extends Sprite
   {
       
      
      private var content:Box;
      
      private var ad:asset_registeradd;
      
      private var mainmask:Sprite;
      
      public function RegisterAd()
      {
         super();
         this.content = new Box();
         this.content.margin(0,5,0,5);
         addChild(this.content);
         this.ad = new asset_registeradd();
         this.ad.gotoAndStop(2);
         this.ad.btnRegister.gotoAndStop(1);
         this.ad.btnRegister.buttonMode = true;
         this.ad.btnRegister.useHandCursor = true;
         this.ad.btnRegister.addEventListener(MouseEvent.CLICK,this.handleRegister,false,0,true);
         this.ad.btnKongregate.addEventListener(MouseEvent.CLICK,this.handleRegister,false,0,true);
         this.ad.btnKongregate.visible = Global.playing_on_kongregate;
         this.content.add(new Box().margin(0,NaN,NaN,NaN).add(this.ad));
         this.mainmask = new Sprite();
         addChild(this.mainmask);
         this.updateMask();
      }
      
      protected function handleRegister(param1:MouseEvent) : void
      {
         Global.base.showRegister(90);
      }
      
      override public function set width(param1:Number) : void
      {
         this.content.width = param1;
         this.mainmask.width = param1;
      }
      
      override public function set height(param1:Number) : void
      {
         this.content.height = param1;
         this.mainmask.height = param1;
      }
      
      public function updateMask() : void
      {
         this.mainmask.graphics.clear();
         this.mainmask.graphics.beginFill(0,1);
         this.mainmask.graphics.drawRect(0,0,100,100);
         this.content.mask = this.mainmask;
      }
   }
}
