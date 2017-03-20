package ui.brickoverlays
{
   import blitter.Bl;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.text.TextField;
   import flash.text.TextFieldType;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import flash.utils.Timer;
   import playerio.DatabaseObject;
   import ui2.ui2minusbtn;
   import ui2.ui2plusbtn;
   
   public class WorldPortalProperties extends PropertiesBackground
   {
       
      
      private var worldname_timer:Timer;
      
      private var tfwn:TextField;
      
      private var tfwname:TextField;
      
      private var myWorldOffset:int = 0;
      
      public function WorldPortalProperties()
      {
         var container:Sprite = null;
         var inptf:TextField = null;
         var sub:ui2minusbtn = null;
         super();
         this.worldname_timer = new Timer(1000,1);
         this.worldname_timer.addEventListener(TimerEvent.TIMER,this.delayedLoadWorldName,false,0,true);
         setSize(320,75);
         container = new Sprite();
         addChild(container);
         var tff:TextFormat = new TextFormat("system",12,16777215);
         var tf:TextField = new TextField();
         tf.embedFonts = true;
         tf.selectable = false;
         tf.sharpness = 100;
         tf.multiline = false;
         tf.wordWrap = false;
         tf.defaultTextFormat = tff;
         tf.width = 150;
         tf.x = -150;
         tf.y = -39 - 25;
         tf.text = "Target World ID:";
         tf.height = tf.textHeight;
         container.addChild(tf);
         inptf = new TextField();
         inptf.type = TextFieldType.INPUT;
         inptf.x = 13;
         inptf.y = -39 - 25;
         inptf.width = 120;
         inptf.height = tf.height + 3;
         inptf.selectable = true;
         inptf.sharpness = 100;
         inptf.multiline = false;
         inptf.borderColor = 16777215;
         inptf.backgroundColor = 11184810;
         inptf.background = true;
         inptf.border = true;
         var inptff:TextFormat = new TextFormat("Arial",12,0);
         inptff.blockIndent = 5;
         inptf.defaultTextFormat = inptff;
         inptf.text = Bl.data.world_portal_id;
         container.addChild(inptf);
         inptf.addEventListener(KeyboardEvent.KEY_DOWN,function(param1:KeyboardEvent):void
         {
            param1.preventDefault();
            param1.stopImmediatePropagation();
            param1.stopPropagation();
         });
         inptf.addEventListener(KeyboardEvent.KEY_UP,function(param1:KeyboardEvent):void
         {
            param1.preventDefault();
            param1.stopImmediatePropagation();
            param1.stopPropagation();
         });
         var add:ui2plusbtn = new ui2plusbtn();
         add.y = inptf.y + 9;
         add.x = inptf.x + inptf.width + 12;
         container.addChild(add);
         add.addEventListener(MouseEvent.MOUSE_DOWN,function():void
         {
            myWorldOffset++;
            myWorldOffset = myWorldOffset % Global.playerObject.roomids.length;
            Bl.data.world_portal_id = inptf.text = Global.playerObject.roomids[myWorldOffset];
            var _loc1_:String = Global.playerObject.roomnames[Global.playerObject.roomkeys[myWorldOffset]];
            Bl.data.world_portal_name = tfwname.text = _loc1_ != ""?_loc1_:"Untitled World";
         });
         sub = new ui2minusbtn();
         sub.y = inptf.y + 9;
         sub.x = 0;
         container.addChild(sub);
         sub.addEventListener(MouseEvent.MOUSE_DOWN,function():void
         {
            myWorldOffset--;
            if(myWorldOffset < 0)
            {
               myWorldOffset = Global.playerObject.roomids.length - 1;
            }
            Bl.data.world_portal_id = inptf.text = Global.playerObject.roomids[myWorldOffset];
            var _loc1_:String = Global.playerObject.roomnames[Global.playerObject.roomkeys[myWorldOffset]];
            Bl.data.world_portal_name = tfwname.text = _loc1_ != ""?_loc1_:"Untitled World";
         });
         inptf.addEventListener(Event.CHANGE,function():void
         {
            tfwn.text = "World Name: ";
            Bl.data.world_portal_id = inptf.text;
            loadWorldName();
         });
         this.tfwn = new TextField();
         this.tfwn.embedFonts = true;
         this.tfwn.selectable = false;
         this.tfwn.sharpness = 100;
         this.tfwn.multiline = false;
         this.tfwn.wordWrap = false;
         tff.align = TextFormatAlign.LEFT;
         this.tfwn.defaultTextFormat = tff;
         this.tfwn.text = "World Name:";
         this.tfwn.width = 150;
         this.tfwn.height = this.tfwn.textHeight;
         this.tfwn.x = -150;
         this.tfwn.y = -39;
         container.addChild(this.tfwn);
         this.tfwname = new TextField();
         this.tfwname.embedFonts = true;
         this.tfwname.selectable = false;
         this.tfwname.sharpness = 100;
         this.tfwname.multiline = false;
         this.tfwname.wordWrap = false;
         tff.align = TextFormatAlign.RIGHT;
         this.tfwname.defaultTextFormat = tff;
         this.tfwname.width = 200;
         this.tfwname.height = 30;
         this.tfwname.x = -50;
         this.tfwname.y = -39;
         container.addChild(this.tfwname);
         this.updateWorldNameTf();
      }
      
      private function loadWorldName() : void
      {
         this.tfwname.text = "";
         if(this.worldname_timer.running)
         {
            this.worldname_timer.reset();
         }
         this.worldname_timer.start();
      }
      
      private function delayedLoadWorldName(param1:Event) : void
      {
         var e:Event = param1;
         if(Bl.data.world_portal_id == "")
         {
            return;
         }
         Global.base.client.bigDB.load("Worlds",Bl.data.world_portal_id,function(param1:DatabaseObject):void
         {
            if(param1 != null && param1.name != null)
            {
               Bl.data.world_portal_name = param1.name;
            }
            updateWorldNameTf();
         });
      }
      
      private function updateWorldNameTf() : void
      {
         if(Bl.data.world_portal_name != "")
         {
            this.tfwname.text = Bl.data.world_portal_name;
         }
         else
         {
            this.tfwname.text = "no such world";
         }
      }
      
      private function updateMyWorldOffset() : void
      {
         this.myWorldOffset = 0;
         var _loc1_:int = 0;
         while(_loc1_ < Global.playerObject.roomids.length)
         {
            if(Bl.data.world_portal_id == Global.playerObject.roomids[_loc1_])
            {
               this.myWorldOffset = _loc1_;
            }
            _loc1_++;
         }
      }
   }
}
