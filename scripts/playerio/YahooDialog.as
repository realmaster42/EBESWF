package playerio
{
   import flash.external.ExternalInterface;
   import flash.system.Capabilities;
   import mx.utils.UIDUtil;
   import playerio.utils.HTTPChannel;
   
   class YahooDialog
   {
      
      private static var _savedCallbacks:Object = {};
      
      private static var _addedCallbackGlue:Boolean = false;
       
      
      function YahooDialog()
      {
         super();
      }
      
      public static function showDialog(param1:String, param2:Object, param3:HTTPChannel, param4:Function) : void
      {
         var _loc5_:* = Capabilities.playerType;
         if("ActiveX" !== _loc5_)
         {
            if("PlugIn" !== _loc5_)
            {
               throw new playerio.generated.PlayerIOError("Cannot show the \'" + param1 + "\' dialog. Dialogs aren\'t supported in the current runtime environment:" + Capabilities.playerType,playerio.PlayerIOError.GeneralError.errorID);
            }
         }
         javascriptDialog(param1,param2,param3 == null?null:param3.token,param4);
      }
      
      private static function javascriptDialog(param1:String, param2:Object, param3:String, param4:Function) : void
      {
         var _loc5_:* = null;
         if(!ExternalInterface.available)
         {
            throw new playerio.generated.PlayerIOError("ExternalInterface is not available!",0);
         }
         var _loc7_:String = UIDUtil.createUID().replace("-","").toLowerCase();
         _savedCallbacks[_loc7_] = param4;
         if(!_addedCallbackGlue)
         {
            ExternalInterface.addCallback("JavascriptPlayerIOCallback",javascriptPlayerIOCallback);
            _loc5_ = "";
            _loc5_ = _loc5_ + "window.__PlayerIO_Flash_Callback__ = function(callbackId, result){";
            _loc5_ = _loc5_ + "\nvar resultStr = \'A\';";
            _loc5_ = _loc5_ + "\nresult[\'__PlayerIO_Flash_CallbackId__\'] = callbackId;";
            _loc5_ = _loc5_ + "\nfor(var x in result){resultStr+=\':\'+x.length+\':\'+x+\':\'+result[x].length+\':\'+result[x]};";
            _loc5_ = _loc5_ + "\n\tfor(var tag in {embed:1,object:1}){";
            _loc5_ = _loc5_ + "\n\t\tvar list=document.getElementsByTagName(tag);";
            _loc5_ = _loc5_ + "\n\t\tfor(var i=0;i!=list.length;i++){";
            _loc5_ = _loc5_ + "\n\t\t\ttry{list[i].JavascriptPlayerIOCallback(resultStr)}catch(e){};";
            _loc5_ = _loc5_ + "\n\t\t}";
            _loc5_ = _loc5_ + "\n\t}";
            _loc5_ = _loc5_ + "\n}";
            ExternalInterface.call("eval",_loc5_);
            _addedCallbackGlue = true;
         }
         var _loc6_:* = "";
         var _loc8_:* = "function(r){window.__PlayerIO_Flash_Callback__(\'" + _loc7_ + "\',r)}";
         _loc6_ = _loc6_ + "if(!document.getElementById(\'yahooscript\')){alert(\'When using yahoologin:auto, the containing html page must include the yahoo.js script\')};";
         _loc6_ = _loc6_ + "\nif(window.Yahoo){";
         _loc6_ = _loc6_ + ("\n\twindow.Yahoo._.dialog(" + jsonEncode(param1) + "," + getJavascriptLiteral(param2) + "," + jsonEncode(param3) + "," + _loc8_ + ");");
         _loc6_ = _loc6_ + "\n}else{";
         _loc6_ = _loc6_ + "\n\tif(!window.Yahoo_WaitingCalls){window.Yahoo_WaitingCalls=[]};";
         _loc6_ = _loc6_ + ("\n\twindow.Yahoo_WaitingCalls.push([\'_.dialog\'," + jsonEncode(param1) + "," + getJavascriptLiteral(param2) + "," + jsonEncode(param3) + "," + _loc8_ + "])");
         _loc6_ = _loc6_ + "\n}";
         ExternalInterface.call("eval",_loc6_);
      }
      
      private static function getJavascriptLiteral(param1:Object) : String
      {
         var _loc2_:* = "{";
         if(param1 != null)
         {
            var _loc5_:int = 0;
            var _loc4_:* = param1;
            for(var _loc3_ in param1)
            {
               _loc2_ = _loc2_ + (_loc2_.length == 1?"":",");
               _loc2_ = _loc2_ + jsonEncode(_loc3_);
               _loc2_ = _loc2_ + ":";
               _loc2_ = _loc2_ + jsonEncode(param1[_loc3_]);
            }
         }
         _loc2_ = _loc2_ + "}";
         return _loc2_;
      }
      
      private static function jsonEncode(param1:String) : String
      {
         var _loc5_:* = null;
         var _loc8_:int = 0;
         var _loc3_:Boolean = false;
         var _loc4_:* = null;
         var _loc6_:* = 0;
         var _loc7_:int = 0;
         var _loc2_:int = 0;
         if(param1 == null)
         {
            return "null";
         }
         _loc5_ = "";
         _loc5_ = _loc5_ + "\"";
         _loc8_ = 0;
         for(; _loc8_ < param1.length; _loc8_++)
         {
            var _loc9_:* = param1.charAt(_loc8_);
            if("\n" !== _loc9_)
            {
               if("\r" !== _loc9_)
               {
                  if("\t" !== _loc9_)
                  {
                     if("\"" !== _loc9_)
                     {
                        if("\\" !== _loc9_)
                        {
                           if("\f" !== _loc9_)
                           {
                              if("\b" !== _loc9_)
                              {
                                 if(param1.charCodeAt(_loc8_) >= 32 && param1.charCodeAt(_loc8_) <= 126)
                                 {
                                    _loc5_ = _loc5_ + param1.charAt(_loc8_);
                                 }
                                 else
                                 {
                                    _loc3_ = param1.charCodeAt(_loc8_) < 55296 || param1.charCodeAt(_loc8_) > 57343;
                                    if(_loc3_)
                                    {
                                       _loc4_ = [];
                                       _loc6_ = int(param1.charCodeAt(_loc8_));
                                       _loc7_ = 0;
                                       while(_loc7_ < 4)
                                       {
                                          _loc2_ = _loc6_ % 16;
                                          _loc4_[3 - _loc7_] = _loc2_ < 10?String.fromCharCode("0".charCodeAt(0) + _loc2_):String.fromCharCode("A".charCodeAt(0) + (_loc2_ - 10));
                                          _loc6_ = _loc6_ >> 4;
                                          _loc7_++;
                                       }
                                       _loc5_ = _loc5_ + "\\u";
                                       _loc5_ = _loc5_ + _loc4_.join();
                                       continue;
                                    }
                                 }
                              }
                              else
                              {
                                 _loc5_ = _loc5_ + "\\b";
                              }
                           }
                           else
                           {
                              _loc5_ = _loc5_ + "\\f";
                           }
                           continue;
                        }
                     }
                     _loc5_ = _loc5_ + "\\";
                     _loc5_ = _loc5_ + param1[_loc8_];
                  }
                  else
                  {
                     _loc5_ = _loc5_ + "\\t";
                  }
               }
               else
               {
                  _loc5_ = _loc5_ + "\\r";
               }
            }
            else
            {
               _loc5_ = _loc5_ + "\\n";
            }
         }
         _loc5_ = _loc5_ + "\"";
         return _loc5_;
      }
      
      private static function javascriptPlayerIOCallback(param1:String) : void
      {
         var _loc4_:* = null;
         var _loc2_:Object = StringForm.decodeStringDictionary(param1);
         var _loc3_:String = _loc2_["__PlayerIO_Flash_CallbackId__"];
         if(_savedCallbacks[_loc3_] != undefined)
         {
            _loc4_ = _savedCallbacks[_loc3_];
            delete _loc2_["__PlayerIO_Flash_CallbackId__"];
            delete _savedCallbacks[_loc3_];
            _loc4_(_loc2_);
         }
      }
   }
}
