package playerio.generated.messages
{
   import com.protobuf.Message;
   
   public final class PayVaultBuyOutput extends Message
   {
       
      
      public var vaultContents:PayVaultContents;
      
      public var vaultContentsDummy:PayVaultContents = null;
      
      public function PayVaultBuyOutput()
      {
         super();
         registerField("vaultContents","playerio.generated.messages.PayVaultContents",11,1,1);
      }
   }
}
