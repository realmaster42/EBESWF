package playerio
{
   import playerio.generated.messages.PayVaultContents;
   import playerio.utils.Converter;
   import playerio.utils.HTTPChannel;
   
   public class PayVault extends playerio.generated.PayVault
   {
       
      
      private var _version:String = null;
      
      private var _coins:Number = 0;
      
      private var _items:Array;
      
      public function PayVault(param1:HTTPChannel, param2:Client)
      {
         _items = [];
         super(param1,param2);
      }
      
      public function get coins() : Number
      {
         if(_version !== null)
         {
            return _coins;
         }
         throw new playerio.generated.PlayerIOError("Cannot access coins before vault has been loaded. Please refresh the vault first",50);
      }
      
      public function get items() : Array
      {
         if(_version !== null)
         {
            return _items;
         }
         throw new playerio.generated.PlayerIOError("Cannot access items before vault has been loaded. Please refresh the vault first",50);
      }
      
      public function readHistory(param1:uint, param2:uint, param3:Function = null, param4:Function = null) : void
      {
         page = param1;
         pageSize = param2;
         callback = param3;
         errorHandler = param4;
         _payVaultReadHistory(page,pageSize,function(param1:Array):void
         {
            if(callback != null)
            {
               callback(Converter.toPayVaultHistoryEntryArray(param1));
            }
         },errorHandler);
      }
      
      public function refresh(param1:Function = null, param2:Function = null) : void
      {
         callback = param1;
         errorHandler = param2;
         _payVaultRefresh(_version,function(param1:PayVaultContents):void
         {
            parseVault(param1);
            if(callback != null)
            {
               callback();
            }
         },errorHandler);
      }
      
      public function credit(param1:uint, param2:String, param3:Function = null, param4:Function = null) : void
      {
         amount = param1;
         reason = param2;
         callback = param3;
         errorHandler = param4;
         _payVaultCredit(amount,reason,function(param1:PayVaultContents):void
         {
            parseVault(param1);
            if(callback != null)
            {
               callback();
            }
         },errorHandler);
      }
      
      public function debit(param1:uint, param2:String, param3:Function = null, param4:Function = null) : void
      {
         amount = param1;
         reason = param2;
         callback = param3;
         errorHandler = param4;
         _payVaultDebit(amount,reason,function(param1:PayVaultContents):void
         {
            parseVault(param1);
            if(callback != null)
            {
               callback();
            }
         },errorHandler);
      }
      
      public function consume(param1:Array, param2:Function = null, param3:Function = null) : void
      {
         items = param1;
         callback = param2;
         errorHandler = param3;
         var ids:Array = [];
         var a:int = 0;
         while(a < items.length)
         {
            var item:VaultItem = items[a] as VaultItem;
            if(item == null)
            {
               throw new playerio.generated.PlayerIOError("Element is not a VaultItem: " + items[a],2);
            }
            ids.push(item.id);
            a = Number(a) + 1;
         }
         _payVaultConsume(ids,function(param1:PayVaultContents):void
         {
            parseVault(param1);
            if(callback != null)
            {
               callback();
            }
         },errorHandler);
      }
      
      public function getBuyDirectInfo(param1:String, param2:Object, param3:Array, param4:Function = null, param5:Function = null) : void
      {
         _payVaultPaymentInfo(param1,param2,Converter.toBuyItemInfoArray(param3),param4,param5);
      }
      
      public function getBuyCoinsInfo(param1:String, param2:Object, param3:Function = null, param4:Function = null) : void
      {
         _payVaultPaymentInfo(param1,param2,null,param3,param4);
      }
      
      public function buy(param1:Array, param2:Boolean, param3:Function = null, param4:Function = null) : void
      {
         items = param1;
         storeItems = param2;
         callback = param3;
         errorHandler = param4;
         _payVaultBuy(Converter.toBuyItemInfoArray(items),storeItems,function(param1:PayVaultContents):void
         {
            parseVault(param1);
            if(callback != null)
            {
               callback();
            }
         },errorHandler);
      }
      
      public function give(param1:Array, param2:Function = null, param3:Function = null) : void
      {
         items = param1;
         callback = param2;
         errorHandler = param3;
         _payVaultGive(Converter.toBuyItemInfoArray(items),function(param1:PayVaultContents):void
         {
            parseVault(param1);
            if(callback != null)
            {
               callback();
            }
         },errorHandler);
      }
      
      public function usePaymentInfo(param1:String, param2:Object, param3:Function = null, param4:Function = null) : void
      {
         provider = param1;
         providerArguments = param2;
         callback = param3;
         errorHandler = param4;
         _payVaultUsePaymentInfo(provider,providerArguments,function(param1:Object, param2:PayVaultContents):void
         {
            parseVault(param2);
            if(callback != null)
            {
               callback(param1);
            }
         },errorHandler);
      }
      
      public function has(param1:String) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         _loc3_ = 0;
         while(_loc3_ < items.length)
         {
            _loc2_ = items[_loc3_] as VaultItem;
            if(_loc2_.itemKey == param1)
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      public function first(param1:String) : VaultItem
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         _loc3_ = 0;
         while(_loc3_ < items.length)
         {
            _loc2_ = items[_loc3_] as VaultItem;
            if(_loc2_.itemKey == param1)
            {
               return _loc2_;
            }
            _loc3_++;
         }
         return null;
      }
      
      public function count(param1:String) : uint
      {
         var _loc4_:int = 0;
         var _loc2_:* = null;
         var _loc3_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < items.length)
         {
            _loc2_ = items[_loc4_] as VaultItem;
            if(_loc2_.itemKey == param1)
            {
               _loc3_++;
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      private function parseVault(param1:PayVaultContents) : void
      {
         if(param1 != null)
         {
            _version = param1.version;
            _coins = param1.coins;
            _items = Converter.toVaultItemArray(param1.items);
         }
      }
   }
}
