package ui.tutorial
{
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   
   public class HighlightObject extends Sprite
   {
       
      
      private var boxes:Array;
      
      private var rects:Array;
      
      private var object;
      
      public function HighlightObject()
      {
         super();
      }
      
      public function setFocus(param1:*) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Sprite = null;
         var _loc4_:Sprite = null;
         while(numChildren > 0)
         {
            removeChild(getChildAt(0));
         }
         if(param1 != null)
         {
            this.boxes = [];
            this.rects = [];
            this.rects.push(new Rectangle(0,0,param1.x,param1.y + param1.height));
            this.rects.push(new Rectangle(0,param1.y + param1.height,param1.x + param1.width,500 - (param1.y + param1.height)));
            this.rects.push(new Rectangle(param1.x + param1.width,param1.y,850 - (param1.x + param1.width),500 - param1.y));
            this.rects.push(new Rectangle(param1.x,0,850 - param1.x,param1.y));
            _loc2_ = 0;
            while(_loc2_ < 4)
            {
               _loc3_ = new Sprite();
               _loc3_.graphics.beginFill(0,0.7);
               _loc3_.graphics.drawRect(this.rects[_loc2_].x,this.rects[_loc2_].y,this.rects[_loc2_].width,this.rects[_loc2_].height);
               _loc3_.graphics.endFill();
               this.boxes.push(_loc3_);
               addChild(_loc3_);
               _loc2_++;
            }
         }
         else
         {
            _loc4_ = new Sprite();
            _loc4_.graphics.beginFill(0,0.7);
            _loc4_.graphics.drawRect(0,0,850,500);
            _loc4_.graphics.endFill();
            addChild(_loc4_);
         }
      }
   }
}
