package playerio.utils
{
   import com.protobuf.Message;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLRequestHeader;
   import flash.utils.ByteArray;
   
   public class HTTPChannel
   {
       
      
      private var useSSL:Boolean = false;
      
      private var _token:String = "";
      
      private var _headers:Array;
      
      public function HTTPChannel(param1:Boolean = false)
      {
         _headers = [];
         super();
         this.useSSL = param1;
      }
      
      private function get endpoint() : String
      {
         return !!this.useSSL?"https://api.playerio.com/api":"http://api.playerio.com/api";
      }
      
      public function set headers(param1:Array) : void
      {
         _headers = param1;
      }
      
      public function Request(param1:int, param2:Message, param3:Message, param4:Message, param5:Function, param6:Function) : void
      {
         RPCMethod = param1;
         messageInput = param2;
         messageOutput = param3;
         messageError = param4;
         success = param5;
         error = param6;
         var loader:URLLoader = new URLLoader();
         loader.dataFormat = "binary";
         loader.addEventListener("complete",function(param1:Event):void
         {
            var _loc3_:int = 0;
            var _loc4_:ByteArray = loader.data;
            _loc4_.position = 0;
            if(_loc4_.readUnsignedByte() != 0)
            {
               _loc3_ = _loc4_.readUnsignedShort();
               _token = _loc4_.readUTFBytes(_loc3_);
            }
            var _loc2_:int = _loc4_.readUnsignedByte();
            if(_loc2_ == 0)
            {
               messageError.readFromDataOutput(_loc4_);
               error(messageError);
            }
            else if(_loc2_ == 1)
            {
               messageOutput.readFromDataOutput(_loc4_);
               success(messageOutput);
            }
         });
         loader.addEventListener("ioError",function(param1:IOErrorEvent):void
         {
            try
            {
               (messageError as Object).message = "[PlayerIOError] " + param1.text;
            }
            catch(e:Error)
            {
            }
         });
         loader.addEventListener("securityError",function(param1:SecurityError):void
         {
            try
            {
               (messageError as Object).message = "[PlayerIOError] " + param1.message;
            }
            catch(e:Error)
            {
            }
         });
         var r:URLRequest = new URLRequest(this.endpoint + "/" + RPCMethod);
         r.requestHeaders = _headers;
         r.method = "POST";
         if(_token != "")
         {
            r.requestHeaders = [new URLRequestHeader("playertoken",_token)];
         }
         var b:ByteArray = new ByteArray();
         messageInput.writeToDataOutput(b);
         if(b.length == 0)
         {
            var tba:ByteArray = new ByteArray();
            tba.writeByte(8);
            tba.writeByte(0);
            r.data = tba;
         }
         else
         {
            r.data = b;
         }
         loader.load(r);
      }
      
      public function set token(param1:String) : void
      {
         _token = param1;
      }
      
      public function get token() : String
      {
         return _token;
      }
   }
}
