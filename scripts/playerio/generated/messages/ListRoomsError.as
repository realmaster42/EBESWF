package playerio.generated.messages
{
   import com.protobuf.Message;
   
   public final class ListRoomsError extends Message
   {
       
      
      public var errorCode:int;
      
      public var message:String;
      
      public function ListRoomsError()
      {
         super();
         registerField("errorCode","",5,1,1);
         registerField("message","",9,1,2);
      }
   }
}
