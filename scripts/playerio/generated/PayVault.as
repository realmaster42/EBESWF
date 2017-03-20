package playerio.generated
{
   import flash.events.EventDispatcher;
   import playerio.Client;
   import playerio.generated.messages.PayVaultBuyArgs;
   import playerio.generated.messages.PayVaultBuyError;
   import playerio.generated.messages.PayVaultBuyOutput;
   import playerio.generated.messages.PayVaultConsumeArgs;
   import playerio.generated.messages.PayVaultConsumeError;
   import playerio.generated.messages.PayVaultConsumeOutput;
   import playerio.generated.messages.PayVaultCreditArgs;
   import playerio.generated.messages.PayVaultCreditError;
   import playerio.generated.messages.PayVaultCreditOutput;
   import playerio.generated.messages.PayVaultDebitArgs;
   import playerio.generated.messages.PayVaultDebitError;
   import playerio.generated.messages.PayVaultDebitOutput;
   import playerio.generated.messages.PayVaultGiveArgs;
   import playerio.generated.messages.PayVaultGiveError;
   import playerio.generated.messages.PayVaultGiveOutput;
   import playerio.generated.messages.PayVaultPaymentInfoArgs;
   import playerio.generated.messages.PayVaultPaymentInfoError;
   import playerio.generated.messages.PayVaultPaymentInfoOutput;
   import playerio.generated.messages.PayVaultReadHistoryArgs;
   import playerio.generated.messages.PayVaultReadHistoryError;
   import playerio.generated.messages.PayVaultReadHistoryOutput;
   import playerio.generated.messages.PayVaultRefreshArgs;
   import playerio.generated.messages.PayVaultRefreshError;
   import playerio.generated.messages.PayVaultRefreshOutput;
   import playerio.generated.messages.PayVaultUsePaymentInfoArgs;
   import playerio.generated.messages.PayVaultUsePaymentInfoError;
   import playerio.generated.messages.PayVaultUsePaymentInfoOutput;
   import playerio.utils.Converter;
   import playerio.utils.HTTPChannel;
   
   public class PayVault extends EventDispatcher
   {
       
      
      protected var channel:HTTPChannel;
      
      protected var client:Client;
      
      public function PayVault(param1:HTTPChannel, param2:Client)
      {
         super();
         this.channel = param1;
         this.client = param2;
      }
      
      protected function _payVaultReadHistory(param1:uint, param2:uint, param3:Function = null, param4:Function = null) : void
      {
         page = param1;
         pageSize = param2;
         callback = param3;
         errorHandler = param4;
         var input:PayVaultReadHistoryArgs = new PayVaultReadHistoryArgs(page,pageSize);
         var output:PayVaultReadHistoryOutput = new PayVaultReadHistoryOutput();
         channel.Request(160,input,output,new PayVaultReadHistoryError(),function(param1:PayVaultReadHistoryOutput):void
         {
            if(callback != null)
            {
               try
               {
                  callback(param1.entries);
                  return;
               }
               catch(e:Error)
               {
                  client.handleCallbackError("PayVault.payVaultReadHistory",e);
                  throw e;
               }
            }
         },function(param1:PayVaultReadHistoryError):void
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
      
      protected function _payVaultRefresh(param1:String, param2:Function = null, param3:Function = null) : void
      {
         lastVersion = param1;
         callback = param2;
         errorHandler = param3;
         var input:PayVaultRefreshArgs = new PayVaultRefreshArgs(lastVersion);
         var output:PayVaultRefreshOutput = new PayVaultRefreshOutput();
         channel.Request(163,input,output,new PayVaultRefreshError(),function(param1:PayVaultRefreshOutput):void
         {
            if(callback != null)
            {
               try
               {
                  callback(param1.vaultContents);
                  return;
               }
               catch(e:Error)
               {
                  client.handleCallbackError("PayVault.payVaultRefresh",e);
                  throw e;
               }
            }
         },function(param1:PayVaultRefreshError):void
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
      
      protected function _payVaultConsume(param1:Array, param2:Function = null, param3:Function = null) : void
      {
         ids = param1;
         callback = param2;
         errorHandler = param3;
         var input:PayVaultConsumeArgs = new PayVaultConsumeArgs(ids);
         var output:PayVaultConsumeOutput = new PayVaultConsumeOutput();
         channel.Request(166,input,output,new PayVaultConsumeError(),function(param1:PayVaultConsumeOutput):void
         {
            if(callback != null)
            {
               try
               {
                  callback(param1.vaultContents);
                  return;
               }
               catch(e:Error)
               {
                  client.handleCallbackError("PayVault.payVaultConsume",e);
                  throw e;
               }
            }
         },function(param1:PayVaultConsumeError):void
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
      
      protected function _payVaultCredit(param1:uint, param2:String, param3:Function = null, param4:Function = null) : void
      {
         amount = param1;
         reason = param2;
         callback = param3;
         errorHandler = param4;
         var input:PayVaultCreditArgs = new PayVaultCreditArgs(amount,reason);
         var output:PayVaultCreditOutput = new PayVaultCreditOutput();
         channel.Request(169,input,output,new PayVaultCreditError(),function(param1:PayVaultCreditOutput):void
         {
            if(callback != null)
            {
               try
               {
                  callback(param1.vaultContents);
                  return;
               }
               catch(e:Error)
               {
                  client.handleCallbackError("PayVault.payVaultCredit",e);
                  throw e;
               }
            }
         },function(param1:PayVaultCreditError):void
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
      
      protected function _payVaultDebit(param1:uint, param2:String, param3:Function = null, param4:Function = null) : void
      {
         amount = param1;
         reason = param2;
         callback = param3;
         errorHandler = param4;
         var input:PayVaultDebitArgs = new PayVaultDebitArgs(amount,reason);
         var output:PayVaultDebitOutput = new PayVaultDebitOutput();
         channel.Request(172,input,output,new PayVaultDebitError(),function(param1:PayVaultDebitOutput):void
         {
            if(callback != null)
            {
               try
               {
                  callback(param1.vaultContents);
                  return;
               }
               catch(e:Error)
               {
                  client.handleCallbackError("PayVault.payVaultDebit",e);
                  throw e;
               }
            }
         },function(param1:PayVaultDebitError):void
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
      
      protected function _payVaultBuy(param1:Array, param2:Boolean, param3:Function = null, param4:Function = null) : void
      {
         items = param1;
         storeItems = param2;
         callback = param3;
         errorHandler = param4;
         var input:PayVaultBuyArgs = new PayVaultBuyArgs(items,storeItems);
         var output:PayVaultBuyOutput = new PayVaultBuyOutput();
         channel.Request(175,input,output,new PayVaultBuyError(),function(param1:PayVaultBuyOutput):void
         {
            if(callback != null)
            {
               try
               {
                  callback(param1.vaultContents);
                  return;
               }
               catch(e:Error)
               {
                  client.handleCallbackError("PayVault.payVaultBuy",e);
                  throw e;
               }
            }
         },function(param1:PayVaultBuyError):void
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
      
      protected function _payVaultGive(param1:Array, param2:Function = null, param3:Function = null) : void
      {
         items = param1;
         callback = param2;
         errorHandler = param3;
         var input:PayVaultGiveArgs = new PayVaultGiveArgs(items);
         var output:PayVaultGiveOutput = new PayVaultGiveOutput();
         channel.Request(178,input,output,new PayVaultGiveError(),function(param1:PayVaultGiveOutput):void
         {
            if(callback != null)
            {
               try
               {
                  callback(param1.vaultContents);
                  return;
               }
               catch(e:Error)
               {
                  client.handleCallbackError("PayVault.payVaultGive",e);
                  throw e;
               }
            }
         },function(param1:PayVaultGiveError):void
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
      
      protected function _payVaultPaymentInfo(param1:String, param2:Object, param3:Array, param4:Function = null, param5:Function = null) : void
      {
         provider = param1;
         purchaseArguments = param2;
         items = param3;
         callback = param4;
         errorHandler = param5;
         var input:PayVaultPaymentInfoArgs = new PayVaultPaymentInfoArgs(provider,Converter.toKeyValueArray(purchaseArguments),items);
         var output:PayVaultPaymentInfoOutput = new PayVaultPaymentInfoOutput();
         channel.Request(181,input,output,new PayVaultPaymentInfoError(),function(param1:PayVaultPaymentInfoOutput):void
         {
            if(callback != null)
            {
               try
               {
                  callback(Converter.toKeyValueObject(param1.providerArguments));
                  return;
               }
               catch(e:Error)
               {
                  client.handleCallbackError("PayVault.payVaultPaymentInfo",e);
                  throw e;
               }
            }
         },function(param1:PayVaultPaymentInfoError):void
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
      
      protected function _payVaultUsePaymentInfo(param1:String, param2:Object, param3:Function = null, param4:Function = null) : void
      {
         provider = param1;
         providerArguments = param2;
         callback = param3;
         errorHandler = param4;
         var input:PayVaultUsePaymentInfoArgs = new PayVaultUsePaymentInfoArgs(provider,Converter.toKeyValueArray(providerArguments));
         var output:PayVaultUsePaymentInfoOutput = new PayVaultUsePaymentInfoOutput();
         channel.Request(184,input,output,new PayVaultUsePaymentInfoError(),function(param1:PayVaultUsePaymentInfoOutput):void
         {
            if(callback != null)
            {
               try
               {
                  callback(Converter.toKeyValueObject(param1.providerResults),param1.vaultContents);
                  return;
               }
               catch(e:Error)
               {
                  client.handleCallbackError("PayVault.payVaultUsePaymentInfo",e);
                  throw e;
               }
            }
         },function(param1:PayVaultUsePaymentInfoError):void
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
