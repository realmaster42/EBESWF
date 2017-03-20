package playerio
{
   import playerio.generated.messages.SocialProfile;
   import playerio.utils.HTTPChannel;
   import playerio.utils.Utilities;
   
   class Social extends playerio.generated.Social
   {
       
      
      function Social(param1:HTTPChannel, param2:Client)
      {
         super(param1,param2);
      }
      
      public function refresh(param1:Function, param2:Function) : void
      {
         callback = param1;
         errorCallback = param2;
         _socialRefresh(function(param1:SocialProfile, param2:Array, param3:Array):void
         {
            if(callback != null)
            {
               callback(param1,param2,param3);
            }
         },errorCallback);
      }
      
      public function loadProfile(param1:Array, param2:Function, param3:Function) : void
      {
         userIds = param1;
         callback = param2;
         errorCallback = param3;
         if(callback != null)
         {
            _socialLoadProfiles(userIds,function(param1:Array):void
            {
               profiles = param1;
               var resultProfile:Array = [];
               var i:int = 0;
               while(i < userIds.length)
               {
                  var found:SocialProfile = (profiles != null?Utilities.find(profiles,function(param1:SocialProfile):Boolean
                  {
                     return param1.userId == userIds[i];
                  }):null) as SocialProfile;
                  if(found != null)
                  {
                     var yp:YahooProfile = new YahooProfile();
                     yp._internal_initialize(found);
                     resultProfile.push(yp);
                  }
                  else
                  {
                     resultProfile.push(null);
                  }
                  i = Number(i) + 1;
               }
            },errorCallback);
         }
         else
         {
            callback([]);
         }
      }
   }
}
