package playerio.generated.messages
{
   import com.protobuf.Message;
   
   public final class FacebookOAuthConnectOutput extends Message
   {
       
      
      public var token:String;
      
      public var userId:String;
      
      public var showBranding:Boolean;
      
      public var gameFSRedirectMap:String;
      
      public var facebookUserId:String;
      
      public var partnerId:String;
      
      public var playerInsightState:PlayerInsightState;
      
      public var playerInsightStateDummy:PlayerInsightState = null;
      
      public function FacebookOAuthConnectOutput()
      {
         super();
         registerField("token","",9,1,1);
         registerField("userId","",9,1,2);
         registerField("showBranding","",8,1,3);
         registerField("gameFSRedirectMap","",9,1,4);
         registerField("facebookUserId","",9,1,5);
         registerField("partnerId","",9,1,6);
         registerField("playerInsightState","playerio.generated.messages.PlayerInsightState",11,1,7);
      }
   }
}
