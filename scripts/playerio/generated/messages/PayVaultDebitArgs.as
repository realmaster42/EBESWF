package playerio.generated.messages
{
   import com.protobuf.Message;
   
   public final class PayVaultDebitArgs extends Message
   {
       
      
      public var amount:uint;
      
      public var reason:String;
      
      public function PayVaultDebitArgs(param1:uint, param2:String)
      {
         super();
         registerField("amount","",13,1,1);
         registerField("reason","",9,1,2);
         this.amount = param1;
         this.reason = param2;
      }
   }
}
