package playerio
{
   import playerio.generated.messages.WaitingGameRequest;
   import playerio.utils.HTTPChannel;
   import playerio.utils.Utilities;
   
   public class GameRequests extends playerio.generated.GameRequests
   {
       
      
      private var _waitingRequests:Array;
      
      public function GameRequests(param1:HTTPChannel, param2:Client)
      {
         super(param1,param2);
      }
      
      public function get waitingRequests() : Array
      {
         if(_waitingRequests == null)
         {
            throw new playerio.generated.PlayerIOError("Cannot access requests before refresh() has been called.",playerio.PlayerIOError.GameRequestsNotLoaded.errorID);
         }
         return _waitingRequests;
      }
      
      public function send(param1:String, param2:Object, param3:Array, param4:Function, param5:Function) : void
      {
         _gameRequestsSend(param1,param2,param3,param4,param5);
      }
      
      public function refresh(param1:Function, param2:Function) : void
      {
         callback = param1;
         errorCallback = param2;
         _gameRequestsRefresh(null,function(param1:Array, param2:Boolean, param3:Array):void
         {
            read(param1,param2);
            if(callback != null)
            {
               callback();
            }
         },errorCallback);
      }
      
      public function remove(param1:Array, param2:Function, param3:Function) : void
      {
         requests = param1;
         callback = param2;
         errorCallback = param3;
         _gameRequestsDelete(requestArrayToRequestIdArray(requests),function(param1:Array, param2:Boolean):void
         {
            read(param1,param2);
            if(callback != null)
            {
               callback();
            }
         },errorCallback);
      }
      
      public function showSendDialog(param1:String, param2:Object, param3:Function) : void
      {
         requestType = param1;
         requestData = param2;
         callback = param3;
         var args:Object = {};
         args["requestType"] = requestType;
         args["requestData"] = StringForm.encodeStringDictionary(requestData);
         Yahoo._internal_showDialog("sendgamerequest",args,channel,function(param1:Object):void
         {
            var _loc2_:* = null;
            if(callback != null)
            {
               _loc2_ = new GameRequestSendDialogResult();
               _loc2_._internal_initialize(param1["recipients"] != undefined?StringForm.decodeStringArray(param1["recipients"]):[],param1["recipientCountExternal"] != undefined?int(param1["recipientCountExternal"]):0);
               callback(_loc2_);
            }
         });
      }
      
      private function requestArrayToRequestIdArray(param1:Array) : Array
      {
         var _loc3_:int = 0;
         var _loc2_:Array = [];
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_.push((param1[_loc3_] as GameRequest)._internal_id);
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function read(param1:Array, param2:Boolean) : Boolean
      {
         requests = param1;
         moreRequestsWaiting = param2;
         var anyNew:Boolean = false;
         var array:Array = [];
         if(requests != null)
         {
            var i:int = 0;
            while(i < requests.length)
            {
               var item:WaitingGameRequest = requests[i];
               var gr:GameRequest = new GameRequest();
               gr._internal_initialize(item);
               array.push(gr);
               if(_waitingRequests != null)
               {
                  anyNew = anyNew || Utilities.find(_waitingRequests,function(param1:GameRequest):Boolean
                  {
                     return param1._internal_id == item.id;
                  }) == null;
               }
               i = Number(i) + 1;
            }
         }
         this._waitingRequests = array;
         return anyNew;
      }
   }
}
