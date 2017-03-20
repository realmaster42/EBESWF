package ui.profile
{
   import playerio.Achievement;
   import sample.ui.components.Box;
   import sample.ui.components.Label;
   import ui.BadgeInstance;
   
   public class ProfileBadge extends Box
   {
       
      
      public function ProfileBadge(param1:Achievement)
      {
         super();
         margin(NaN,NaN,0);
         var _loc2_:BadgeInstance = Badges.getBadge(param1.id);
         _loc2_.x = 23;
         _loc2_.y = 0;
         addChild(_loc2_);
         var _loc3_:Label = new Label(param1.title,13,"center",16777215,false,"visitor");
         _loc3_.width = 100;
         _loc3_.y = 64;
         _loc3_.x = 55 - _loc3_.width / 2;
         addChild(_loc3_);
      }
   }
}
