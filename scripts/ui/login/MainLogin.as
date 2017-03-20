package ui.login
{
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import playerio.Client;
   import playerio.DatabaseObject;
   import playerio.PlayerIO;
   
   public class MainLogin extends assets_loginsimple
   {
       
      
      private var loginwindow:LoginWindow;
      
      public function MainLogin()
      {
         var armor_auth_token:String = null;
         var armor_user_id:String = null;
         var mb_auth_token:String = null;
         super();
         stop();
         filters = [new DropShadowFilter(0,45,0,1,12,12,1,1)];
         PlayerIO.quickConnect.simpleConnect(Global.base.stage,Config.playerio_game_id,"guest","guest",function(param1:Client):void
         {
            var c:Client = param1;
            c.bigDB.loadSingle("news","current",[],function(param1:DatabaseObject):void
            {
               var ldr:Loader = null;
               var dbo:DatabaseObject = param1;
               if(dbo == null)
               {
                  news.title.text = "Error";
                  news.subtitle.text = "";
                  news.body.text = "Oh no, the news isn\'t working!";
                  news.loader.visible = false;
                  return;
               }
               news.title.text = dbo["header"];
               news.subtitle.text = dbo["date"];
               news.body.text = dbo["body"];
               ldr = new Loader();
               ldr.contentLoaderInfo.addEventListener(Event.COMPLETE,function(param1:Event):void
               {
                  var e:Event = param1;
                  news.loader.visible = false;
                  ldr.y = news.loader.y - ldr.height / 2;
                  ldr.x = (news.width - ldr.width) / 2;
                  ldr.filters = filters;
                  ldr.mouseEnabled = true;
                  ldr.addEventListener(MouseEvent.CLICK,function():void
                  {
                     navigateToURL(new URLRequest(Config.url_blog),"_blank");
                  });
                  news.addChild(ldr);
               });
               ldr.load(new URLRequest(dbo["image"]));
            },function():void
            {
            });
         },function():void
         {
         });
         if(Global.playing_on_kongregate)
         {
            gotoAndStop(2);
            btn_kongregate.addEventListener(MouseEvent.CLICK,function():void
            {
               Global.base.showKongregateLoginWindow();
            });
         }
         else if(Global.playing_on_armorgames)
         {
            gotoAndStop(4);
            armor_auth_token = LoaderInfo(Global.stage.root.loaderInfo).parameters.auth_token || Config.armor_authtoken;
            armor_user_id = LoaderInfo(Global.stage.root.loaderInfo).parameters.user_id || Config.armor_userid;
            if(armor_auth_token != null && armor_user_id != null)
            {
               btn_armorgames.gotoAndStop(2);
               Global.base.authenticateWithArmorgames(armor_auth_token,armor_user_id,function(param1:Client):void
               {
                  var c:Client = param1;
                  btn_armorgames.gotoAndStop(3);
                  btn_armorgames.buttonMode = true;
                  btn_armorgames.mouseEnabled = true;
                  btn_armorgames.addEventListener(MouseEvent.CLICK,function(param1:MouseEvent):void
                  {
                     Global.base.clearOverlayContainer();
                     Global.base.simpleConnect(c);
                  });
               });
            }
            else
            {
               btn_armorgames.gotoAndStop(1);
            }
         }
         else if(Global.playing_on_mousebreaker)
         {
            gotoAndStop(4);
            btn_armorgames.gotoAndStop(2);
            mb_auth_token = LoaderInfo(Global.stage.root.loaderInfo).parameters.token;
            Global.base.authenticateWithMouseBreaker(mb_auth_token,function(param1:Client):void
            {
               var c:Client = param1;
               btn_armorgames.gotoAndStop(3);
               btn_armorgames.buttonMode = true;
               btn_armorgames.mouseEnabled = true;
               btn_armorgames.addEventListener(MouseEvent.CLICK,function(param1:MouseEvent):void
               {
                  Global.base.clearOverlayContainer();
                  Global.base.simpleConnect(c);
               });
            });
         }
         else
         {
            btn_login.addEventListener(MouseEvent.CLICK,this.handleLoginButton,false,0,true);
            btn_register.addEventListener(MouseEvent.CLICK,function():void
            {
               Global.base.showRegister();
            });
            btn_recoverpass.addEventListener(MouseEvent.CLICK,function():void
            {
               Global.base.showRecoverPassword();
            });
            btn_guestlogin.addEventListener(MouseEvent.CLICK,function():void
            {
               Global.base.authenticateAsGuest();
            });
         }
         addEventListener(Event.REMOVED_FROM_STAGE,this.handleRemovedFromStage,false,0,true);
         addEventListener(MouseEvent.MOUSE_DOWN,function(param1:MouseEvent):void
         {
            param1.preventDefault();
            param1.stopImmediatePropagation();
            param1.stopPropagation();
         });
      }
      
      protected function handleRemovedFromStage(param1:Event) : void
      {
         this.stopAll();
      }
      
      protected function handleLoginButton(param1:MouseEvent) : void
      {
         Global.base.showLoginWindow();
      }
      
      protected function handleAdded(param1:Event) : void
      {
         param1.stopImmediatePropagation();
         param1.stopPropagation();
      }
      
      override public function get width() : Number
      {
         return bg.width;
      }
      
      public function stopAll() : void
      {
      }
   }
}
