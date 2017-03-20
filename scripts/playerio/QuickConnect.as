package playerio
{
   import flash.display.Stage;
   import flash.net.LocalConnection;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.net.navigateToURL;
   import playerio.generated.messages.KeyValuePair;
   import playerio.generated.messages.PlayerInsightState;
   import playerio.utils.HTTPChannel;
   import playerio.utils.Utilities;
   
   public class QuickConnect extends playerio.generated.QuickConnect
   {
       
      
      private var connections:Array;
      
      public function QuickConnect(param1:HTTPChannel)
      {
         connections = [];
         super(param1);
      }
      
      public function simpleConnect(param1:Stage, param2:String, param3:String, param4:String, param5:* = null, param6:* = null, param7:* = null) : void
      {
         stage = param1;
         gameId = param2;
         usernameOrEmail = param3;
         password = param4;
         playerInsightSegments = param5;
         callback = param6;
         errorHandler = param7;
         if(stage == null || stage.stage == null)
         {
            throw new Error("Parsed stage is not attached to document stage",2);
         }
         if(playerInsightSegments is Function)
         {
            simpleConnect(stage,gameId,usernameOrEmail,password,null,playerInsightSegments,callback);
            return;
         }
         _simpleConnect(gameId,usernameOrEmail,password,playerInsightSegments,Utilities.clientAPI,Utilities.getSystemInfo(),function(param1:String, param2:String, param3:Boolean, param4:String, param5:String, param6:PlayerInsightState):void
         {
            if(param3 && Minilogo.showLogo)
            {
               stage.addChild(new Minilogo());
            }
            var _loc7_:HTTPChannel = PlayerIO.getChannel();
            _loc7_.token = param1;
         },errorHandler);
      }
      
      public function simpleRegister(param1:Stage, param2:String, param3:String, param4:String, param5:String, param6:String, param7:String, param8:Object, param9:* = null, param10:* = null, param11:* = null, param12:* = null) : void
      {
         stage = param1;
         gameId = param2;
         usernameOrEmail = param3;
         password = param4;
         email = param5;
         captchaKey = param6;
         captchaValue = param7;
         extraData = param8;
         partnerId = param9;
         playerInsightSegments = param10;
         callback = param11;
         errorHandler = param12;
         if(stage == null || stage.stage == null)
         {
            throw new Error("Parsed stage is not attached to document stage",2);
         }
         if(partnerId is Function)
         {
            simpleRegister(stage,gameId,usernameOrEmail,password,email,captchaKey,captchaValue,extraData,null,null,partnerId,playerInsightSegments);
            return;
         }
         if(playerInsightSegments is Function)
         {
            simpleRegister(stage,gameId,usernameOrEmail,password,email,captchaKey,captchaValue,extraData,partnerId,null,playerInsightSegments,callback);
            return;
         }
         _simpleRegister(gameId,usernameOrEmail,password,email,captchaKey,captchaValue,extraData,partnerId,playerInsightSegments,Utilities.clientAPI,Utilities.getSystemInfo(),function(param1:String, param2:String, param3:Boolean, param4:String, param5:String, param6:PlayerInsightState):void
         {
            if(param3 && Minilogo.showLogo)
            {
               stage.addChild(new Minilogo());
            }
            var _loc7_:HTTPChannel = PlayerIO.getChannel();
            _loc7_.token = param1;
         },errorHandler);
      }
      
      override public function simpleGetCaptcha(param1:String, param2:int, param3:int, param4:Function = null, param5:Function = null) : void
      {
         super.simpleGetCaptcha(param1,param2,param3,param4,param5);
      }
      
      override public function simpleRecoverPassword(param1:String, param2:String, param3:Function = null, param4:Function = null) : void
      {
         super.simpleRecoverPassword(param1,param2,param3,param4);
      }
      
      public function facebookConnect(param1:Stage, param2:String, param3:String, param4:String, param5:* = null, param6:* = null, param7:* = null, param8:* = null) : void
      {
         throw new Error("ERROR: facebookConnect is deprecated as Facebook is switching to OAuth. Please use facebookOAuthConnect instead.");
      }
      
      public function facebookOAuthConnect(param1:Stage, param2:String, param3:String, param4:* = null, param5:* = null, param6:* = null, param7:* = null) : void
      {
         stage = param1;
         gameId = param2;
         accessToken = param3;
         partnerId = param4;
         playerInsightSegments = param5;
         callback = param6;
         errorHandler = param7;
         if(stage == null || stage.stage == null)
         {
            throw new Error("Parsed stage is not attached to document stage",2);
         }
         if(partnerId is Function)
         {
            facebookOAuthConnect(stage,gameId,accessToken,null,null,partnerId,playerInsightSegments);
            return;
         }
         if(playerInsightSegments is Function)
         {
            facebookOAuthConnect(stage,gameId,accessToken,partnerId,null,playerInsightSegments,callback);
            return;
         }
         _facebookOAuthConnect(gameId,accessToken,partnerId,playerInsightSegments,Utilities.clientAPI,Utilities.getSystemInfo(),function(param1:String, param2:String, param3:Boolean, param4:String, param5:String, param6:String, param7:PlayerInsightState):void
         {
            if(param3 && Minilogo.showLogo)
            {
               stage.addChild(new Minilogo());
            }
            var _loc8_:HTTPChannel = PlayerIO.getChannel();
            _loc8_.token = param1;
         },errorHandler);
      }
      
      public function kongregateConnect(param1:Stage, param2:String, param3:String, param4:String, param5:* = null, param6:* = null, param7:* = null) : void
      {
         stage = param1;
         gameId = param2;
         userId = param3;
         gameAuthToken = param4;
         playerInsightSegments = param5;
         callback = param6;
         errorHandler = param7;
         if(stage == null || stage.stage == null)
         {
            throw new Error("Parsed stage is not attached to document stage",2);
         }
         if(playerInsightSegments is Function)
         {
            kongregateConnect(stage,gameId,userId,gameAuthToken,null,playerInsightSegments,callback);
            return;
         }
         _kongregateConnect(gameId,userId,gameAuthToken,playerInsightSegments,Utilities.clientAPI,Utilities.getSystemInfo(),function(param1:String, param2:String, param3:Boolean, param4:String, param5:PlayerInsightState):void
         {
            if(param3 && Minilogo.showLogo)
            {
               stage.addChild(new Minilogo());
            }
            var _loc6_:HTTPChannel = PlayerIO.getChannel();
            _loc6_.token = param1;
         },errorHandler);
      }
      
      public function facebookOAuthConnectPopup(param1:Stage, param2:String, param3:String, param4:Array = null, param5:* = null, param6:* = null, param7:* = null, param8:* = null) : void
      {
         stage = param1;
         gameId = param2;
         window = param3;
         permissions = param4;
         partnerId = param5;
         playerInsightSegments = param6;
         callback = param7;
         errorHandler = param8;
         if(stage == null || stage.stage == null)
         {
            throw new Error("Parsed stage is not attached to document stage",2);
         }
         if(partnerId is Function)
         {
            facebookOAuthConnectPopup(stage,gameId,window,permissions,null,partnerId,playerInsightSegments);
            return;
         }
         if(playerInsightSegments is Function)
         {
            facebookOAuthConnectPopup(stage,gameId,window,permissions,partnerId,null,playerInsightSegments,callback);
            return;
         }
         var legacy:Boolean = false;
         if(gameId.substring(0,1) == "@")
         {
            legacy = true;
            var gameId:String = gameId.substring(1);
         }
         if(/\[|\]/gi.test(gameId))
         {
            var e:playerio.generated.PlayerIOError = new playerio.generated.PlayerIOError("The Player.IO Game id \"" + gameId + "\" contains invalid characters, did you insert your game id?",1);
            if(errorHandler != null)
            {
               errorHandler(e);
               return;
            }
            throw e;
         }
         if(legacy)
         {
            var url:String = "http://fb.playerio.com/fb/" + gameId + "/_fb_quickconnect_oauth";
         }
         else
         {
            url = "http://" + gameId + ".fb.playerio.com/fb/_fb_quickconnect_oauth";
         }
         var variables:URLVariables = new URLVariables();
         var commid:String = Math.floor(new Date().getTime()).toString() + (Math.random() * 999999 >> 0).toString();
         variables.req_perms = !!permissions?permissions.join(","):"";
         variables.communicationId = commid;
         variables.partnerId = partnerId;
         variables.clientapi = Utilities.clientAPI;
         variables.clientinfo = Utilities.getSystemInfoString();
         variables.playerinsightsegments = (playerInsightSegments || []).join(",");
         var request:URLRequest = new URLRequest(url);
         request.data = variables;
         request.method = "POST";
         try
         {
            navigateToURL(request,window);
         }
         catch(e:Error)
         {
            trace("Error occurred!");
         }
         var receivingLC:LocalConnection = new LocalConnection();
         connections.push(receivingLC);
         receivingLC.client = {"oauth2":function(param1:String, param2:String, param3:String, param4:String = "", param5:Boolean = true, param6:String = "", param7:String = null, param8:String = "-1", param9:String = ""):void
         {
            var _loc11_:int = 0;
            var _loc13_:* = null;
            var _loc10_:* = null;
            if(param5 && Minilogo.showLogo)
            {
               stage.addChild(new Minilogo());
            }
            var _loc15_:HTTPChannel = PlayerIO.getChannel();
            _loc15_.token = param1;
            var _loc12_:PlayerInsightState = new PlayerInsightState();
            _loc12_.playersOnline = parseInt(param8 || "-1");
            var _loc14_:Array = (param9 || "").split(",");
            _loc11_ = 0;
            while(_loc11_ < _loc14_.length)
            {
               _loc13_ = _loc14_[_loc11_].split(":");
               _loc10_ = new KeyValuePair();
               _loc10_.key = _loc13_[0];
               _loc10_.value = _loc13_[1];
               _loc12_.segments.push(_loc10_);
               _loc11_++;
            }
         }};
         receivingLC.allowDomain("*");
         receivingLC.connect("_facebook_" + commid);
      }
      
      public function facebookConnectPopup(param1:Stage, param2:String, param3:String, param4:Array = null, param5:* = null, param6:* = null, param7:* = null) : void
      {
         throw new Error("FacebookConnectPopup is no longer supported by Facebook. Please use FacebookConnectOAuthPopup");
      }
   }
}
