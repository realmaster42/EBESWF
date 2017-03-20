package playerio
{
   import playerio.utils.Converter;
   
   class YahooPayments
   {
       
      
      private var _client:Client;
      
      function YahooPayments(param1:Client)
      {
         super();
         this._client = param1;
      }
      
      public function showBuyCoinsDialog(param1:int, param2:Object, param3:Function, param4:Function) : void
      {
         cointamount = param1;
         purchaseArguments = param2;
         callback = param3;
         errorCallback = param4;
         if(purchaseArguments == null)
         {
            var purchaseArguments:Object = {};
         }
         purchaseArguments["coinamount"] = cointamount.toString();
         _client.payVault.getBuyCoinsInfo("yahoo",purchaseArguments,function(param1:Object):void
         {
            info = param1;
            Yahoo._internal_showDialog("buy",info,_client.channel,function(param1:Object):void
            {
               if(param1["error"] != undefined && errorCallback != null)
               {
                  errorCallback(new PlayerIOError(param1["error"],PlayerIOError.GeneralError.errorID));
               }
               else if(callback != null)
               {
                  callback(param1);
               }
            });
         },errorCallback);
      }
      
      public function showBuyItemsDialog(param1:Array, param2:Object, param3:Function, param4:Function) : void
      {
         items = param1;
         purchaseArguments = param2;
         callback = param3;
         errorCallback = param4;
         _client.payVault.getBuyDirectInfo("yahoo",purchaseArguments,Converter.toBuyItemInfoArray(items),function(param1:Object):void
         {
            info = param1;
            Yahoo._internal_showDialog("buy",info,_client.channel,function(param1:Object):void
            {
               if(param1["error"] != undefined && errorCallback != null)
               {
                  errorCallback(new PlayerIOError(param1["error"],PlayerIOError.GeneralError.errorID));
               }
               else if(callback != null)
               {
                  callback(param1);
               }
            });
         },errorCallback);
      }
   }
}
