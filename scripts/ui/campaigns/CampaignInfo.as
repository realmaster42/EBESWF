package ui.campaigns
{
   public class CampaignInfo extends ui2.CampaignInfo
   {
       
      
      private var _difficulty:int = 0;
      
      private var _tier:int = 1;
      
      private var _maxTier:int = 1;
      
      private var _campaignName:String;
      
      public function CampaignInfo()
      {
         super();
         this.displayLockedInfo("UNKNOWN");
      }
      
      public function displayInfo(param1:String, param2:int, param3:int, param4:int, param5:Boolean) : void
      {
         this._campaignName = param1;
         this._difficulty = param2;
         this._tier = param3;
         this._maxTier = param4;
         gotoAndStop(2);
         campaignNameTF.text = param1;
         tierTF.text = param3 + 1 + "/" + param4;
         if(0 <= param2 && param2 < 9)
         {
            difficultyIcon.gotoAndStop(param2 + 1);
         }
         else
         {
            difficultyIcon.gotoAndStop(1);
         }
         this.updateStatus(param5);
      }
      
      public function updateStatus(param1:Boolean) : void
      {
         statusIcon.gotoAndStop(!!param1?2:1);
      }
      
      public function displayLockedInfo(param1:String) : void
      {
         gotoAndStop(1);
         infoTF.text = "This world is part of the " + param1 + " campaign.\nYou need to unlock it in order to be able to track your progress.";
      }
      
      public function displayGuestInfo(param1:String) : void
      {
         gotoAndStop(1);
         infoTF.text = "This world is part of the " + param1 + " campaign.\nYou need to register in order to be able to track your progress.";
      }
      
      public function displayBetaOnlyInfo(param1:String) : void
      {
         gotoAndStop(1);
         infoTF.text = "This world is part of a campaign, which currently is only available to beta members. Come back later or buy beta to play it now.";
      }
      
      public function get campaignName() : String
      {
         return this._campaignName;
      }
      
      public function get difficulty() : int
      {
         return this._difficulty;
      }
      
      public function get tier() : int
      {
         return this._tier;
      }
      
      public function get maxTier() : int
      {
         return this._maxTier;
      }
   }
}
