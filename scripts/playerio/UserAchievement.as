package playerio
{
   class UserAchievement
   {
       
      
      private var _userId:String = "";
      
      private var _achievements:Array;
      
      function UserAchievement(param1:String, param2:Array)
      {
         _achievements = [];
         super();
         _achievements = param2;
         _userId = param1;
      }
      
      public function get userId() : String
      {
         return _userId;
      }
      
      public function get achievements() : Array
      {
         return _achievements;
      }
   }
}
