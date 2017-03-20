package playerio
{
   import flash.display.Stage;
   import playerio.generated.messages.AuthenticateStartDialog;
   import playerio.generated.messages.KeyValuePair;
   import playerio.generated.messages.PlayerInsightState;
   import playerio.utils.HTTPChannel;
   import playerio.utils.Utilities;
   
   public final class PlayerIO extends playerio.generated.PlayerIO
   {
      
      public namespace inside = "http://playerio.com/inside/";
      
      public static var useSecureApiRequests:Boolean = false;
       
      
      public function PlayerIO()
      {
         super();
      }
      
      static function getChannel() : HTTPChannel
      {
         return new HTTPChannel(useSecureApiRequests);
      }
      
      public static function connect(param1:Stage, param2:String, param3:String, param4:String, param5:String, param6:* = null, param7:* = null, param8:* = null, param9:* = null) : void
      {
         new playerio.PlayerIO().connect(param1,param2,param3,param4,param5,param6,param7,param8,param9);
      }
      
      public static function authenticate(param1:Stage, param2:String, param3:String, param4:Object, param5:* = null, param6:* = null, param7:* = null) : void
      {
         new playerio.PlayerIO().authenticate(param1,param2,param3,param4,param5,param6,param7);
      }
      
      private static function authSuccess(param1:Client, param2:HTTPChannel, param3:Array, param4:Function) : void
      {
         client = param1;
         channel = param2;
         dialogs = param3;
         successCallback = param4;
         if(dialogs == null || dialogs.length == 0)
         {
            if(successCallback != null)
            {
               successCallback(client);
            }
         }
         else
         {
            var dialog:AuthenticateStartDialog = dialogs[0];
            var dialogArgs:Object = {};
            if(dialog.arguments != null)
            {
               var a:int = 0;
               while(a < dialog.arguments.length)
               {
                  var kvp:KeyValuePair = dialog.arguments[a] as KeyValuePair;
                  dialogArgs[kvp.key] = kvp.value;
                  a = Number(a) + 1;
               }
            }
            YahooDialog.showDialog(dialog.name,dialogArgs,channel,function(param1:Object):void
            {
               dialogs.shift();
               authSuccess(client,channel,dialogs,successCallback);
            });
         }
      }
      
      public static function get quickConnect() : QuickConnect
      {
         return new QuickConnect(getChannel());
      }
      
      public static function gameFS(param1:String) : GameFS
      {
         return new GameFS(param1,null);
      }
      
      private function connect(param1:Stage, param2:String, param3:String, param4:String, param5:String, param6:* = null, param7:* = null, param8:* = null, param9:* = null) : void
      {
         stage = param1;
         gameId = param2;
         connectionId = param3;
         userId = param4;
         auth = param5;
         partnerId = param6;
         playerInsightSegments = param7;
         callback = param8;
         errorHandler = param9;
         if(partnerId is Function)
         {
            connect(stage,gameId,connectionId,userId,auth,null,null,partnerId,playerInsightSegments);
            return;
         }
         if(playerInsightSegments is Function)
         {
            connect(stage,gameId,connectionId,userId,auth,partnerId,null,playerInsightSegments,callback);
            return;
         }
         _connect(getChannel(),gameId,connectionId,userId,auth,partnerId,playerInsightSegments,Utilities.clientAPI,Utilities.getSystemInfo(),function(param1:String, param2:String, param3:Boolean, param4:String, param5:String, param6:PlayerInsightState):void
         {
            if(stage && param3 && Minilogo.showLogo)
            {
               stage.addChild(new Minilogo());
            }
            var _loc7_:HTTPChannel = getChannel();
            _loc7_.token = param1;
         },errorHandler);
      }
      
      private function authenticate(param1:Stage, param2:String, param3:String, param4:Object, param5:Array, param6:Function, param7:Function) : void
      {
         stage = param1;
         gameId = param2;
         connectionId = param3;
         authenticationArguments = param4;
         playerInsightSegments = param5;
         callback = param6;
         errorHandler = param7;
         if(authenticationArguments["yahoologin"] != undefined && authenticationArguments["yahoologin"] == "auto")
         {
            YahooDialog.showDialog("login",{
               "gameId":gameId,
               "connectionId":connectionId,
               "__use_usertoken__":"true"
            },null,function(param1:Object):void
            {
               if(param1["error"] != undefined)
               {
                  errorHandler(new PlayerIOError(param1["error"],PlayerIOError.GeneralError.errorID));
               }
               else if(param1["userToken"] == undefined)
               {
                  errorHandler(new PlayerIOError("Missing userToken value in result, but no error message given.",PlayerIOError.GeneralError.errorID));
               }
               else
               {
                  authenticate(stage,gameId,connectionId,{"userToken":param1["userToken"]},playerInsightSegments,callback,errorHandler);
               }
            });
            return;
         }
         _authenticate(getChannel(),gameId,connectionId,authenticationArguments,playerInsightSegments,Utilities.clientAPI,Utilities.getSystemInfo(),null,function(param1:String, param2:String, param3:Boolean, param4:String, param5:PlayerInsightState, param6:Array, param7:Boolean, param8:Array, param9:String):void
         {
            var _loc10_:HTTPChannel = new HTTPChannel(useSecureApiRequests);
            _loc10_.token = param1;
            authSuccess(new Client(stage,_loc10_,gameId,param4,param1,param2,param3,param5),_loc10_,param6,callback);
         },errorHandler);
      }
   }
}
