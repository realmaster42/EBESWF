package playerio.generated
{
   import flash.events.EventDispatcher;
   import playerio.Client;
   import playerio.generated.messages.CreateJoinRoomArgs;
   import playerio.generated.messages.CreateJoinRoomError;
   import playerio.generated.messages.CreateJoinRoomOutput;
   import playerio.generated.messages.CreateRoomArgs;
   import playerio.generated.messages.CreateRoomError;
   import playerio.generated.messages.CreateRoomOutput;
   import playerio.generated.messages.JoinRoomArgs;
   import playerio.generated.messages.JoinRoomError;
   import playerio.generated.messages.JoinRoomOutput;
   import playerio.generated.messages.ListRoomsArgs;
   import playerio.generated.messages.ListRoomsError;
   import playerio.generated.messages.ListRoomsOutput;
   import playerio.utils.Converter;
   import playerio.utils.HTTPChannel;
   
   public class Multiplayer extends EventDispatcher
   {
       
      
      protected var channel:HTTPChannel;
      
      protected var client:Client;
      
      public function Multiplayer(param1:HTTPChannel, param2:Client)
      {
         super();
         this.channel = param1;
         this.client = param2;
      }
      
      protected function _createRoom(param1:String, param2:String, param3:Boolean, param4:Object, param5:Boolean, param6:Function = null, param7:Function = null) : void
      {
         roomId = param1;
         roomType = param2;
         visible = param3;
         roomData = param4;
         isDevRoom = param5;
         callback = param6;
         errorHandler = param7;
         var input:CreateRoomArgs = new CreateRoomArgs(roomId,roomType,visible,Converter.toKeyValueArray(roomData),isDevRoom);
         var output:CreateRoomOutput = new CreateRoomOutput();
         channel.Request(21,input,output,new CreateRoomError(),function(param1:CreateRoomOutput):void
         {
            if(callback != null)
            {
               try
               {
                  callback(param1.roomId);
                  return;
               }
               catch(e:Error)
               {
                  client.handleCallbackError("Multiplayer.createRoom",e);
                  throw e;
               }
            }
         },function(param1:CreateRoomError):void
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
      
      protected function _joinRoom(param1:String, param2:Object, param3:Boolean, param4:Function = null, param5:Function = null) : void
      {
         roomId = param1;
         joinData = param2;
         isDevRoom = param3;
         callback = param4;
         errorHandler = param5;
         var input:JoinRoomArgs = new JoinRoomArgs(roomId,Converter.toKeyValueArray(joinData),isDevRoom);
         var output:JoinRoomOutput = new JoinRoomOutput();
         channel.Request(24,input,output,new JoinRoomError(),function(param1:JoinRoomOutput):void
         {
            if(callback != null)
            {
               try
               {
                  callback(param1.joinKey,param1.endpoints);
                  return;
               }
               catch(e:Error)
               {
                  client.handleCallbackError("Multiplayer.joinRoom",e);
                  throw e;
               }
            }
         },function(param1:JoinRoomError):void
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
      
      protected function _listRooms(param1:String, param2:Object, param3:int, param4:int, param5:Boolean, param6:Function = null, param7:Function = null) : void
      {
         roomType = param1;
         searchCriteria = param2;
         resultLimit = param3;
         resultOffset = param4;
         onlyDevRooms = param5;
         callback = param6;
         errorHandler = param7;
         var input:ListRoomsArgs = new ListRoomsArgs(roomType,Converter.toKeyValueArray(searchCriteria),resultLimit,resultOffset,onlyDevRooms);
         var output:ListRoomsOutput = new ListRoomsOutput();
         channel.Request(30,input,output,new ListRoomsError(),function(param1:ListRoomsOutput):void
         {
            if(callback != null)
            {
               try
               {
                  callback(Converter.toRoomInfoArray(param1.rooms));
                  return;
               }
               catch(e:Error)
               {
                  client.handleCallbackError("Multiplayer.listRooms",e);
                  throw e;
               }
            }
         },function(param1:ListRoomsError):void
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
      
      protected function _createJoinRoom(param1:String, param2:String, param3:Boolean, param4:Object, param5:Object, param6:Boolean, param7:Function = null, param8:Function = null) : void
      {
         roomId = param1;
         roomType = param2;
         visible = param3;
         roomData = param4;
         joinData = param5;
         isDevRoom = param6;
         callback = param7;
         errorHandler = param8;
         var input:CreateJoinRoomArgs = new CreateJoinRoomArgs(roomId,roomType,visible,Converter.toKeyValueArray(roomData),Converter.toKeyValueArray(joinData),isDevRoom);
         var output:CreateJoinRoomOutput = new CreateJoinRoomOutput();
         channel.Request(27,input,output,new CreateJoinRoomError(),function(param1:CreateJoinRoomOutput):void
         {
            if(callback != null)
            {
               try
               {
                  callback(param1.roomId,param1.joinKey,param1.endpoints);
                  return;
               }
               catch(e:Error)
               {
                  client.handleCallbackError("Multiplayer.createJoinRoom",e);
                  throw e;
               }
            }
         },function(param1:CreateJoinRoomError):void
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
