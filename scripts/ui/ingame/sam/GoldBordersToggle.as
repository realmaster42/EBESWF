package ui.ingame.sam
{
   import blitter.BlText;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   
   public class GoldBordersToggle extends Sprite
   {
      
      private static var checkmarkBM:Class = GoldBordersToggle_checkmarkBM;
      
      private static var checkmarkBMD:BitmapData = new checkmarkBM().bitmapData;
       
      
      private var text:BlText;
      
      private var textBM:Bitmap;
      
      private var checkBox:Sprite;
      
      public var checkmark:Bitmap;
      
      public function GoldBordersToggle()
      {
         super();
         graphics.lineStyle(1,8092539);
         graphics.beginFill(3289650);
         graphics.drawRect(0,0,128,20);
         graphics.endFill();
         this.checkBox = new Sprite();
         this.checkBox.graphics.lineStyle(1,8092539);
         this.checkBox.graphics.beginFill(4473924);
         this.checkBox.graphics.drawRect(0,0,13,13);
         this.checkBox.graphics.endFill();
         this.checkBox.x = 3;
         this.checkBox.y = 3;
         addChild(this.checkBox);
         this.checkmark = new Bitmap(checkmarkBMD);
         this.checkBox.addChild(this.checkmark);
      }
      
      public function setActive(param1:Boolean) : void
      {
         if(this.textBM && contains(this.textBM))
         {
            removeChild(this.textBM);
         }
         this.checkmark.visible = param1;
         this.text = new BlText(8,!!param1?Number(110):Number(105));
         this.text.text = "Enable Gold Borders";
         this.textBM = new Bitmap(this.text.clone());
         this.textBM.x = this.checkBox.x + 18;
         this.textBM.y = 3;
         addChild(this.textBM);
      }
   }
}
