package playerio.generated
{
   import flash.events.EventDispatcher;
   import playerio.generated.messages.FacebookOAuthConnectArgs;
   import playerio.generated.messages.FacebookOAuthConnectError;
   import playerio.generated.messages.FacebookOAuthConnectOutput;
   import playerio.generated.messages.KongregateConnectArgs;
   import playerio.generated.messages.KongregateConnectError;
   import playerio.generated.messages.KongregateConnectOutput;
   import playerio.generated.messages.SimpleConnectArgs;
   import playerio.generated.messages.SimpleConnectError;
   import playerio.generated.messages.SimpleConnectOutput;
   import playerio.generated.messages.SimpleGetCaptchaArgs;
   import playerio.generated.messages.SimpleGetCaptchaError;
   import playerio.generated.messages.SimpleGetCaptchaOutput;
   import playerio.generated.messages.SimpleRecoverPasswordArgs;
   import playerio.generated.messages.SimpleRecoverPasswordError;
   import playerio.generated.messages.SimpleRecoverPasswordOutput;
   import playerio.generated.messages.SimpleRegisterArgs;
   import playerio.generated.messages.SimpleRegisterError;
   import playerio.generated.messages.SimpleRegisterOutput;
   import playerio.generated.messages.SimpleUserGetSecureLoginInfoArgs;
   import playerio.generated.messages.SimpleUserGetSecureLoginInfoError;
   import playerio.generated.messages.SimpleUserGetSecureLoginInfoOutput;
   import playerio.generated.messages.SteamConnectArgs;
   import playerio.generated.messages.SteamConnectError;
   import playerio.generated.messages.SteamConnectOutput;
   import playerio.utils.Converter;
   import playerio.utils.HTTPChannel;
   
   public class QuickConnect extends EventDispatcher
   {
       
      
      protected var channel:HTTPChannel;
      
      public function QuickConnect(param1:HTTPChannel)
      {
         super();
         this.channel = param1;
      }
      
      public function simpleUserGetSecureLoginInfo(param1:Function = null, param2:Function = null) : void
      {
         callback = param1;
         errorHandler = param2;
         var input:SimpleUserGetSecureLoginInfoArgs = new SimpleUserGetSecureLoginInfoArgs();
         var output:SimpleUserGetSecureLoginInfoOutput = new SimpleUserGetSecureLoginInfoOutput();
         channel.Request(424,input,output,new SimpleUserGetSecureLoginInfoError(),function(param1:SimpleUserGetSecureLoginInfoOutput):void
         {
            if(callback != null)
            {
               callback(param1.publicKey,param1.nonce);
            }
         },function(param1:SimpleUserGetSecureLoginInfoError):void
         {
            var _loc2_:PlayerIOError = new PlayerIOError(param1.message,param1.errorCode);
            if(errorHandler != null)
            {
               errorHandler(_loc2_);
               return;
            }
            throw _loc2_;
         });
      }
      
      protected function _simpleConnect(param1:String, param2:String, param3:String, param4:Array, param5:String, param6:Object, param7:Function = null, param8:Function = null) : void
      {
         gameId = param1;
         usernameOrEmail = param2;
         password = param3;
         playerInsightSegments = param4;
         clientAPI = param5;
         clientInfo = param6;
         callback = param7;
         errorHandler = param8;
         var input:SimpleConnectArgs = new SimpleConnectArgs(gameId,usernameOrEmail,password,playerInsightSegments,clientAPI,Converter.toKeyValueArray(clientInfo));
         var output:SimpleConnectOutput = new SimpleConnectOutput();
         channel.Request(400,input,output,new SimpleConnectError(),function(param1:SimpleConnectOutput):void
         {
            if(callback != null)
            {
               callback(param1.token,param1.userId,param1.showBranding,param1.gameFSRedirectMap,param1.partnerId,param1.playerInsightState);
            }
         },function(param1:SimpleConnectError):void
         {
            var _loc2_:PlayerIOError = new PlayerIOError(param1.message,param1.errorCode);
            if(errorHandler != null)
            {
               errorHandler(_loc2_);
               return;
            }
            throw _loc2_;
         });
      }
      
      public function simpleGetCaptcha(param1:String, param2:int, param3:int, param4:Function = null, param5:Function = null) : void
      {
         gameId = param1;
         width = param2;
         height = param3;
         callback = param4;
         errorHandler = param5;
         var input:SimpleGetCaptchaArgs = new SimpleGetCaptchaArgs(gameId,width,height);
         var output:SimpleGetCaptchaOutput = new SimpleGetCaptchaOutput();
         channel.Request(415,input,output,new SimpleGetCaptchaError(),function(param1:SimpleGetCaptchaOutput):void
         {
            if(callback != null)
            {
               callback(param1.captchaKey,param1.captchaImageUrl);
            }
         },function(param1:SimpleGetCaptchaError):void
         {
            var _loc2_:PlayerIOError = new PlayerIOError(param1.message,param1.errorCode);
            if(errorHandler != null)
            {
               errorHandler(_loc2_);
               return;
            }
            throw _loc2_;
         });
      }
      
      protected function _simpleRegister(param1:String, param2:String, param3:String, param4:String, param5:String, param6:String, param7:Object, param8:String, param9:Array, param10:String, param11:Object, param12:Function = null, param13:Function = null) : void
      {
         gameId = param1;
         username = param2;
         password = param3;
         email = param4;
         captchaKey = param5;
         captchaValue = param6;
         extraData = param7;
         partnerId = param8;
         playerInsightSegments = param9;
         clientAPI = param10;
         clientInfo = param11;
         callback = param12;
         errorHandler = param13;
         var input:SimpleRegisterArgs = new SimpleRegisterArgs(gameId,username,password,email,captchaKey,captchaValue,Converter.toKeyValueArray(extraData),partnerId,playerInsightSegments,clientAPI,Converter.toKeyValueArray(clientInfo));
         var output:SimpleRegisterOutput = new SimpleRegisterOutput();
         channel.Request(403,input,output,new SimpleRegisterError(),function(param1:SimpleRegisterOutput):void
         {
            if(callback != null)
            {
               callback(param1.token,param1.userId,param1.showBranding,param1.gameFSRedirectMap,param1.partnerId,param1.playerInsightState);
            }
         },function(param1:SimpleRegisterError):void
         {
            var _loc2_:PlayerIORegistrationError = new PlayerIORegistrationError(param1.message,param1.errorCode,param1.usernameError,param1.passwordError,param1.emailError,param1.captchaError);
            if(errorHandler != null)
            {
               errorHandler(_loc2_);
               return;
            }
            throw _loc2_;
         });
      }
      
      public function simpleRecoverPassword(param1:String, param2:String, param3:Function = null, param4:Function = null) : void
      {
         gameId = param1;
         usernameOrEmail = param2;
         callback = param3;
         errorHandler = param4;
         var input:SimpleRecoverPasswordArgs = new SimpleRecoverPasswordArgs(gameId,usernameOrEmail);
         var output:SimpleRecoverPasswordOutput = new SimpleRecoverPasswordOutput();
         channel.Request(406,input,output,new SimpleRecoverPasswordError(),function(param1:SimpleRecoverPasswordOutput):void
         {
            if(callback != null)
            {
               callback();
            }
         },function(param1:SimpleRecoverPasswordError):void
         {
            var _loc2_:PlayerIOError = new PlayerIOError(param1.message,param1.errorCode);
            if(errorHandler != null)
            {
               errorHandler(_loc2_);
               return;
            }
            throw _loc2_;
         });
      }
      
      protected function _kongregateConnect(param1:String, param2:String, param3:String, param4:Array, param5:String, param6:Object, param7:Function = null, param8:Function = null) : void
      {
         gameId = param1;
         userId = param2;
         gameAuthToken = param3;
         playerInsightSegments = param4;
         clientAPI = param5;
         clientInfo = param6;
         callback = param7;
         errorHandler = param8;
         var input:KongregateConnectArgs = new KongregateConnectArgs(gameId,userId,gameAuthToken,playerInsightSegments,clientAPI,Converter.toKeyValueArray(clientInfo));
         var output:KongregateConnectOutput = new KongregateConnectOutput();
         channel.Request(412,input,output,new KongregateConnectError(),function(param1:KongregateConnectOutput):void
         {
            if(callback != null)
            {
               callback(param1.token,param1.userId,param1.showBranding,param1.gameFSRedirectMap,param1.playerInsightState);
            }
         },function(param1:KongregateConnectError):void
         {
            var _loc2_:PlayerIOError = new PlayerIOError(param1.message,param1.errorCode);
            if(errorHandler != null)
            {
               errorHandler(_loc2_);
               return;
            }
            throw _loc2_;
         });
      }
      
      protected function _facebookOAuthConnect(param1:String, param2:String, param3:String, param4:Array, param5:String, param6:Object, param7:Function = null, param8:Function = null) : void
      {
         gameId = param1;
         accessToken = param2;
         partnerId = param3;
         playerInsightSegments = param4;
         clientAPI = param5;
         clientInfo = param6;
         callback = param7;
         errorHandler = param8;
         var input:FacebookOAuthConnectArgs = new FacebookOAuthConnectArgs(gameId,accessToken,partnerId,playerInsightSegments,clientAPI,Converter.toKeyValueArray(clientInfo));
         var output:FacebookOAuthConnectOutput = new FacebookOAuthConnectOutput();
         channel.Request(418,input,output,new FacebookOAuthConnectError(),function(param1:FacebookOAuthConnectOutput):void
         {
            if(callback != null)
            {
               callback(param1.token,param1.userId,param1.showBranding,param1.gameFSRedirectMap,param1.facebookUserId,param1.partnerId,param1.playerInsightState);
            }
         },function(param1:FacebookOAuthConnectError):void
         {
            var _loc2_:PlayerIOError = new PlayerIOError(param1.message,param1.errorCode);
            if(errorHandler != null)
            {
               errorHandler(_loc2_);
               return;
            }
            throw _loc2_;
         });
      }
      
      public function steamConnect(param1:String, param2:String, param3:String, param4:Array, param5:String, param6:Object, param7:Function = null, param8:Function = null) : void
      {
         gameId = param1;
         steamAppId = param2;
         steamSessionTicket = param3;
         playerInsightSegments = param4;
         clientAPI = param5;
         clientInfo = param6;
         callback = param7;
         errorHandler = param8;
         var input:SteamConnectArgs = new SteamConnectArgs(gameId,steamAppId,steamSessionTicket,playerInsightSegments,clientAPI,Converter.toKeyValueArray(clientInfo));
         var output:SteamConnectOutput = new SteamConnectOutput();
         channel.Request(421,input,output,new SteamConnectError(),function(param1:SteamConnectOutput):void
         {
            if(callback != null)
            {
               callback(param1.token,param1.userId,param1.showBranding,param1.gameFSRedirectMap,param1.partnerId,param1.playerInsightState);
            }
         },function(param1:SteamConnectError):void
         {
            var _loc2_:PlayerIOError = new PlayerIOError(param1.message,param1.errorCode);
            if(errorHandler != null)
            {
               errorHandler(_loc2_);
               return;
            }
            throw _loc2_;
         });
      }
   }
}
