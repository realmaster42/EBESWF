package ui.tutorial
{
   import flash.display.Sprite;
   import sample.ui.components.Label;
   
   public class Guide extends Sprite
   {
       
      
      private var borderSpacing:Number = 3;
      
      private var maxBodyWidth:Number = 320;
      
      private var ox:Number;
      
      private var oy:Number;
      
      private var ow:Number;
      
      private var oh:Number;
      
      private var headerLabel:Label;
      
      private var bodyLabel:Label;
      
      private var buttons:Buttons;
      
      private var okCallback:Function;
      
      private var nextCallback:Function;
      
      private var skipCallback:Function;
      
      private var _focusObject;
      
      public function Guide(param1:Number, param2:Number, param3:String, param4:String, param5:* = null, param6:int = 8, param7:Function = null, param8:Function = null)
      {
         super();
         this.ox = param1;
         this.oy = param2;
         this.headerLabel = new Label(param3,14,"left",16777215,false,"system");
         this.headerLabel.y = 3;
         addChild(this.headerLabel);
         this.bodyLabel = new Label(param4,12,"left",16777215,true,"visitor");
         this.bodyLabel.width = this.maxBodyWidth;
         this.bodyLabel.x = 8;
         this.bodyLabel.y = this.headerLabel.y + this.headerLabel.height + 3;
         addChild(this.bodyLabel);
         if(param5 != null)
         {
            this._focusObject = param5;
         }
         this.buttons = new Buttons(param6,this.okCallback,param7,param8);
         this.buttons.y = this.bodyLabel.y + this.bodyLabel.height + 3;
         addChild(this.buttons);
         this.redraw();
      }
      
      public function redraw() : void
      {
         this.ow = this.headerLabel.x + this.headerLabel.width > this.bodyLabel.x + this.bodyLabel.width?Number(this.headerLabel.x + this.headerLabel.width):Number(this.bodyLabel.x + this.bodyLabel.width);
         this.oh = this.buttons.y + this.buttons.height;
         graphics.clear();
         graphics.lineStyle(1,8092539,1);
         graphics.beginFill(3289649,1);
         graphics.drawRect(0,0,this.ow + this.borderSpacing,this.oh + this.borderSpacing);
         this.headerLabel.x = (this.ow - this.headerLabel.width) / 2;
         this.buttons.x = (this.ow - this.buttons.width) / 2;
         x = this.ox == -1?Number((850 - this.width) / 2):Number(this.ox);
         y = this.oy == -1?Number((500 - this.height) / 2):Number(this.oy);
      }
      
      override public function get width() : Number
      {
         return this.ow + this.borderSpacing;
      }
      
      override public function get height() : Number
      {
         return this.oh + this.borderSpacing;
      }
      
      public function get focusObject() : *
      {
         return this._focusObject;
      }
   }
}
