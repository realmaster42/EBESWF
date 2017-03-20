package playerio.generated
{
   import flash.display.MovieClip;
   import playerio.generated.messages.AuthenticateArgs;
   import playerio.generated.messages.AuthenticateError;
   import playerio.generated.messages.AuthenticateOutput;
   import playerio.generated.messages.ConnectArgs;
   import playerio.generated.messages.ConnectError;
   import playerio.generated.messages.ConnectOutput;
   import playerio.utils.Converter;
   import playerio.utils.HTTPChannel;
   
   public class PlayerIO extends MovieClip
   {
       
      
      public function PlayerIO()
      {
         super();
      }
      
      protected function _connect(param1:HTTPChannel, param2:String, param3:String, param4:String, param5:String, param6:String, param7:Array, param8:String, param9:Object, param10:Function = null, param11:Function = null) : void
      {
         channel = param1;
         gameId = param2;
         connectionId = param3;
         userId = param4;
         auth = param5;
         partnerId = param6;
         playerInsightSegments = param7;
         clientAPI = param8;
         clientInfo = param9;
         callback = param10;
         errorHandler = param11;
         var input:ConnectArgs = new ConnectArgs(gameId,connectionId,userId,auth,partnerId,playerInsightSegments,clientAPI,Converter.toKeyValueArray(clientInfo));
         var output:ConnectOutput = new ConnectOutput();
         channel.Request(10,input,output,new ConnectError(),function(param1:ConnectOutput):void
         {
            if(callback != null)
            {
               callback(param1.token,param1.userId,param1.showBranding,param1.gameFSRedirectMap,param1.partnerId,param1.playerInsightState);
            }
         },function(param1:ConnectError):void
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
      
      protected function _authenticate(param1:HTTPChannel, param2:String, param3:String, param4:Object, param5:Array, param6:String, param7:Object, param8:Array, param9:Function = null, param10:Function = null) : void
      {
         channel = param1;
         gameId = param2;
         connectionId = param3;
         authenticationArguments = param4;
         playerInsightSegments = param5;
         clientAPI = param6;
         clientInfo = param7;
         playCodes = param8;
         callback = param9;
         errorHandler = param10;
         var input:AuthenticateArgs = new AuthenticateArgs(gameId,connectionId,Converter.toKeyValueArray(authenticationArguments),playerInsightSegments,clientAPI,Converter.toKeyValueArray(clientInfo),playCodes);
         var output:AuthenticateOutput = new AuthenticateOutput();
         channel.Request(13,input,output,new AuthenticateError(),function(param1:AuthenticateOutput):void
         {
            if(callback != null)
            {
               callback(param1.token,param1.userId,param1.showBranding,param1.gameFSRedirectMap,param1.playerInsightState,param1.startDialogs,param1.isSocialNetworkUser,param1.newPlayCodes,param1.notificationClickPayload);
            }
         },function(param1:AuthenticateError):void
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
