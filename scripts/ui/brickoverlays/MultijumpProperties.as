package ui.brickoverlays
{
   import blitter.Bl;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldType;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import ui2.ui2minusbtn;
   import ui2.ui2plusbtn;
   
   public class MultijumpProperties extends PropertiesBackground
   {
       
      
      public function MultijumpProperties()
      {
         var inptf:TextField = null;
         super();
         var tf:TextField = new TextField();
         tf.embedFonts = true;
         tf.selectable = false;
         tf.sharpness = 100;
         tf.multiline = false;
         tf.wordWrap = false;
         var tff:TextFormat = new TextFormat("system",12,16777215);
         tf.defaultTextFormat = tff;
         tf.width = 324;
         tf.x = -150;
         tf.y = -38;
         tf.text = "Number of jumps";
         tf.height = tf.textHeight;
         addChild(tf);
         inptf = new TextField();
         inptf.selectable = true;
         inptf.sharpness = 100;
         inptf.multiline = false;
         inptf.borderColor = 16777215;
         inptf.backgroundColor = 11184810;
         inptf.background = true;
         inptf.border = true;
         inptf.restrict = "0-9";
         inptf.maxChars = 2;
         inptf.type = TextFieldType.INPUT;
         inptf.addEventListener(Event.CHANGE,function(param1:Event):void
         {
            var _loc2_:int = parseInt(inptf.text);
            if(!isNaN(_loc2_) && _loc2_ >= 0 && _loc2_ <= 2)
            {
               if(_loc2_ == 0)
               {
                  _loc2_++;
               }
               Bl.data.jumps = _loc2_;
            }
         });
         var inptff:TextFormat = new TextFormat("Arial",12,0,null,null,null,null,null,TextFormatAlign.CENTER);
         inptf.defaultTextFormat = inptff;
         inptf.text = Bl.data.jumps;
         inptf.height = tf.height + 3;
         inptf.width = 30;
         inptf.y = -38;
         inptf.x = 130 - 35;
         inptf.addEventListener(FocusEvent.FOCUS_IN,function(param1:Event):void
         {
            param1.preventDefault();
            param1.stopImmediatePropagation();
            param1.stopPropagation();
         });
         inptf.addEventListener(KeyboardEvent.KEY_DOWN,function(param1:KeyboardEvent):void
         {
            param1.preventDefault();
            param1.stopImmediatePropagation();
            param1.stopPropagation();
         });
         var add:ui2plusbtn = new ui2plusbtn();
         add.y = -29;
         add.x = 130 + 10;
         addChild(add);
         add.addEventListener(MouseEvent.MOUSE_DOWN,function():void
         {
            if(Bl.data.jumps < 2)
            {
               Bl.data.jumps++;
            }
            inptf.text = Bl.data.jumps;
         });
         var sub:ui2minusbtn = new ui2minusbtn();
         sub.y = -29;
         sub.x = 130 - 34 - 16;
         addChild(sub);
         sub.addEventListener(MouseEvent.MOUSE_DOWN,function():void
         {
            if(Bl.data.jumps > 0)
            {
               Bl.data.jumps--;
            }
            inptf.text = Bl.data.jumps;
         });
         addChild(inptf);
         setSize(325,50);
      }
   }
}
