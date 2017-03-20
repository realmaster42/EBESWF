package ui
{
   import blitter.Bl;
   import flash.display.Loader;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.net.URLRequest;
   import flash.system.Security;
   
   public class LoginBox extends asset_loginbox
   {
       
      
      private var player:Object;
      
      private var loader:Loader;
      
      private var vx:int;
      
      private var vy:int = -236;
      
      private var vw:int = 488;
      
      private var vh:int = 274;
      
      private var unloaded:Boolean = false;
      
      public function LoginBox()
      {
         var _loc1_:Sprite = null;
         var _loc2_:Sprite = null;
         this.loader = new Loader();
         super();
         Security.allowDomain("www.youtube.com");
         if(!Bl.data.isbeta)
         {
            try
            {
               this.vx = (606 - this.vw) / 2;
               this.loader.contentLoaderInfo.addEventListener(Event.INIT,this.onLoaderInit);
               this.loader.load(new URLRequest("https://youtube.googleapis.com/apiplayer?version=3&enablejsapi=1"));
               this.loader.x = this.vx;
               this.loader.y = this.vy;
               _loc1_ = new Sprite();
               _loc1_.graphics.lineStyle(1,8947848,1);
               _loc1_.graphics.beginFill(1118481,0.2);
               _loc1_.graphics.drawRect(0,0,this.vw + 1,this.vh + 1);
               _loc1_.x = this.vx - 1;
               _loc1_.y = this.vy - 1;
               addChild(_loc1_);
               _loc2_ = new Sprite();
               _loc2_.graphics.beginFill(16777215,1);
               _loc2_.graphics.drawRect(0,0,this.vw,this.vh);
               _loc2_.x = this.vx;
               _loc2_.y = this.vy;
               this.loader.mask = _loc2_;
               addChild(_loc2_);
               return;
            }
            catch(e:Error)
            {
               return;
            }
         }
      }
      
      public function stopAll() : void
      {
         this.unloaded = true;
         if(this.player)
         {
            this.player.stopVideo();
         }
         if(this.loader != null)
         {
            this.loader.unloadAndStop(true);
            this.loader = null;
         }
      }
      
      private function onLoaderInit(param1:Event) : void
      {
         if(this.unloaded)
         {
            return;
         }
         addChild(this.loader);
         this.loader.content.addEventListener("onReady",this.onPlayerReady);
         this.loader.content.addEventListener("onError",this.onPlayerError);
         this.loader.content.addEventListener("onStateChange",this.onPlayerStateChange);
         this.loader.content.addEventListener("onPlaybackQualityChange",this.onVideoPlaybackQualityChange);
      }
      
      private function onPlayerReady(param1:Event) : void
      {
         try
         {
            if(this.unloaded)
            {
               return;
            }
            this.player = this.loader.content;
            this.player.mute();
            this.player.playVideo();
            this.player.setSize(this.vw,this.vh);
            return;
         }
         catch(e:Error)
         {
            return;
         }
      }
      
      private function onPlayerError(param1:Event) : void
      {
      }
      
      private function onPlayerStateChange(param1:Event) : void
      {
      }
      
      private function onVideoPlaybackQualityChange(param1:Event) : void
      {
      }
   }
}
