package ui.tutorial
{
   import com.greensock.TweenMax;
   import flash.display.Sprite;
   
   public class Tutorial extends Sprite
   {
       
      
      private var blackBG:HighlightObject;
      
      private var guides:Array;
      
      private var layerMask:Sprite;
      
      private var _currentGuide:Guide;
      
      private var _tutorialName:String;
      
      public function Tutorial(param1:String)
      {
         this.guides = [];
         super();
         this._tutorialName = param1;
         this.blackBG = new HighlightObject();
         addChild(this.blackBG);
      }
      
      public function addGuide(param1:Guide) : void
      {
         this.guides.push(param1);
      }
      
      public function addGuides(param1:Array) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            this.guides.push(param1[_loc2_]);
            _loc2_++;
         }
      }
      
      public function startAt(param1:int) : void
      {
         if(this.guides[param1] != null)
         {
            this.showGuide(this.guides[param1] as Guide);
         }
      }
      
      public function showGuide(param1:Guide, param2:Number = -1, param3:Number = -1) : void
      {
         if(this._currentGuide != null)
         {
            if(contains(this._currentGuide))
            {
               removeChild(this.currentGuide);
            }
         }
         param1.x = param2 == -1?Number(param1.x):Number(param2);
         param1.y = param3 == -1?Number(param1.y):Number(param3);
         param1.alpha = 0;
         addChild(param1);
         TweenMax.to(param1,0.4,{"alpha":1});
         this._currentGuide = param1;
         this.setFocus(this._currentGuide.focusObject);
      }
      
      public function nextGuide() : void
      {
         if(this._currentGuide != null)
         {
            this._currentGuide.alpha = 1;
            TweenMax.to(this._currentGuide,0.4,{
               "alpha":0,
               "onComplete":function():void
               {
                  var _loc2_:* = undefined;
                  var _loc1_:* = guides.indexOf(_currentGuide) + 1;
                  if(_loc1_ != -1)
                  {
                     _loc2_ = guides[_loc1_] as Guide;
                     showGuide(_loc2_);
                  }
               }
            });
         }
      }
      
      public function setFocus(param1:*, param2:Number = 0, param3:Number = 0, param4:Number = 850, param5:Number = 500) : void
      {
         this.blackBG.setFocus(param1);
      }
      
      public function get currentGuide() : Guide
      {
         return this._currentGuide;
      }
      
      public function get tutorialName() : String
      {
         return this._tutorialName;
      }
   }
}
