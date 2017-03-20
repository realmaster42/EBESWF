package ui.tutorial
{
   import com.greensock.TweenMax;
   import flash.display.Sprite;
   
   public class TutorialManager extends Sprite
   {
       
      
      private var tutorials:Array;
      
      private var _currentTutorial:Tutorial;
      
      public function TutorialManager()
      {
         this.tutorials = [];
         super();
      }
      
      public function addTutorial(param1:Tutorial) : void
      {
         this.tutorials.push(param1);
      }
      
      public function showTutorial(param1:Tutorial) : void
      {
         if(this._currentTutorial != null)
         {
            if(contains(this._currentTutorial))
            {
               removeChild(this._currentTutorial);
            }
         }
         this._currentTutorial = param1;
         param1.startAt(0);
         param1.alpha = 0;
         addChild(param1);
         TweenMax.to(param1,0.4,{"alpha":1});
      }
      
      public function nextTutorial() : void
      {
         if(this._currentTutorial != null)
         {
            this._currentTutorial.alpha = 1;
            TweenMax.to(this._currentTutorial,0.4,{
               "alpha":0,
               "onComplete":function():void
               {
                  var _loc2_:* = undefined;
                  var _loc1_:* = tutorials.indexOf(_currentTutorial) + 1;
                  if(_loc1_ != -1)
                  {
                     _loc2_ = tutorials[_loc1_] as Tutorial;
                     showTutorial(_loc2_);
                  }
               }
            });
         }
      }
      
      public function get currentTutorial() : Tutorial
      {
         return this._currentTutorial;
      }
   }
}
