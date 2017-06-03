package ui.roomlist
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import io.player.tools.Badwords;
   import playerio.Client;
   import playerio.DatabaseObject;
   import sample.ui.components.Box;
   import sample.ui.components.Label;
   import sample.ui.components.Rows;
   import ui.WorldPreview;
   import ui.profile.FillBox;
   
   public class MinimapPreview extends Sprite
   {
       
      
      private var world:FillBox;
      
      private var minimapBox:Rows;
      
      private var worldLabel:Label;
      
      private var loadingLabel:Label;
      
      private var base:Box;
      
      private var content:Box;
      
      private var button:ProfileCloseButton;
      
      private var closeButton:Box;
      
      private var loadingText:Box;
      
      private var wWidth:int;
      
      private var wHeight:int;
      
      private var plays:int;
      
      private var wname:String;
      
      private var owner:String;
      
      private var rid:String;
      
      private var description:String;
      
      private var ownerLabel:Label;
      
      public function MinimapPreview(param1:String, param2:String, param3:String)
      {
         var lastChar:int = 0;
         var wname:String = param1;
         var rid:String = param2;
         var desc:String = param3;
         this.base = new Box();
         this.content = new Box();
         this.minimapBox = new Rows();
         this.button = new ProfileCloseButton();
         this.loadingText = new Box();
         this.world = new FillBox(2);
         this.wWidth = 200;
         this.wHeight = 200;
         this.description = Badwords.Filter(desc);
         super();
         this.wname = wname;
         this.owner = this.owner;
         this.plays = this.plays;
         this.rid = rid;
         this.base.margin(10,-10,0,-10);
         this.base.add(new Box().fill(2236962,1,10).margin(5,5,5,5).add(this.content));
         this.content.margin(0,0,0,0);
         addChild(this.base);
         addEventListener(MouseEvent.MOUSE_DOWN,function(param1:MouseEvent):void
         {
            param1.preventDefault();
            param1.stopImmediatePropagation();
            param1.stopPropagation();
         });
         this.base.filters = [new GlowFilter(0,1,6,6,1,10)];
         addEventListener(Event.ADDED_TO_STAGE,this.handleAttach);
         this.loadingLabel = new Label("Loading...",14,"center",16777215,false,"system");
         this.loadingLabel.y = this.loadingLabel.y + 30;
         this.content.addChild(this.loadingLabel);
         this.worldLabel = new Label("",12,"center",16777215,false,"Arial");
         this.worldLabel.text = wname + "\n\n " + this.description;
         this.worldLabel.setTextFormat(new TextFormat("system",13,16777215,null,null,null,null,null,"center"),0,wname.length);
         this.worldLabel.multiline = true;
         this.worldLabel.wordWrap = true;
         this.worldLabel.autoSize = TextFieldAutoSize.CENTER;
         if(this.worldLabel.numLines > 4)
         {
            lastChar = this.worldLabel.getLineOffset(4) - 1;
            lastChar = this.worldLabel.text.substring(0,lastChar + 1).search(/\S\s*$/);
            this.worldLabel.text = this.worldLabel.text.substring(0,lastChar + 1);
         }
         this.minimapBox.addChild(this.world);
         this.loadLevel(Global.base.client);
         this.button.addEventListener(MouseEvent.MOUSE_DOWN,this.handleCloseMinimapPreview,false,0,true);
         this.closeButton = new Box().margin(2,2,NaN,NaN).add(this.button);
         this.content.addChild(this.closeButton);
      }
      
      protected function handleCloseMinimapPreview(param1:MouseEvent) : void
      {
         Global.base.removeMapPreview();
      }
      
      private function loadLevel(param1:Client) : void
      {
         var c:Client = param1;
         if(this.rid == "")
         {
            return;
         }
         c.bigDB.load("Worlds",this.rid,function(param1:DatabaseObject):void
         {
            renderWorld(param1);
         },this.handleError);
         this.handleResize();
      }
      
      private function renderWorld(param1:DatabaseObject) : void
      {
         var o:DatabaseObject = param1;
         if(o == null || o.blocks == null)
         {
            return;
         }
         if(!o.width || !o.height)
         {
            return;
         }
         this.content.removeChild(this.closeButton);
         var pworld:WorldPreview = new WorldPreview(o,true,false,function():void
         {
            Global.base.removeMapPreview();
         });
         this.world.addChild(pworld);
         if(pworld.width >= 200)
         {
            this.wWidth = pworld.width;
         }
         else
         {
            this.wWidth = 220;
         }
         this.wHeight = o.height;
         this.content.removeChild(this.loadingLabel);
         this.content.addChild(this.worldLabel);
         this.worldLabel.width = this.wWidth;
         this.base.width = this.worldLabel.width;
         this.content.add(new Box().margin(this.worldLabel.textHeight + 5,0,0,0).add(new Box().fill(0,1,10).add(this.minimapBox)));
         this.content.addChild(this.closeButton);
         this.handleResize();
      }
      
      private function handleAttach(param1:Event) : void
      {
         stage.addEventListener(Event.RESIZE,this.handleResize);
         this.handleResize();
      }
      
      private function handleRemove(param1:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.handleAttach);
         stage.removeEventListener(Event.RESIZE,this.handleResize);
      }
      
      private function handleError(param1:Error) : void
      {
      }
      
      private function handleResize(param1:Event = null) : void
      {
         if(stage != null)
         {
            this.base.width = this.wWidth + 17;
            this.base.height = this.wHeight + this.worldLabel.textHeight + 35;
            this.base.x = 850 / 2 - this.base.width / 2;
            this.base.y = 500 / 2 - this.base.height / 2;
         }
      }
   }
}
