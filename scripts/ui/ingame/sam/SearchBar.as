package ui.ingame.sam
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.text.AntiAliasType;
   import flash.text.TextField;
   import flash.text.TextFieldType;
   import flash.text.TextFormat;
   import flash.ui.Keyboard;
   import mx.utils.StringUtil;
   
   public class SearchBar extends Sprite
   {
       
      
      private var smileyAuraMenu:SmileyAuraMenu;
      
      private var search:TextField;
      
      private var searchSprite:Sprite;
      
      private var ow:int;
      
      public var oh:int = 28;
      
      private var searchSmileys:Array = null;
      
      public function SearchBar(param1:SmileyAuraMenu, param2:int)
      {
         super();
         this.smileyAuraMenu = param1;
         this.ow = param2;
         addEventListener(Event.ADDED_TO_STAGE,this.handleAttach);
      }
      
      protected function updateFilter(param1:Event) : void
      {
         var _loc2_:String = null;
         var _loc3_:SmileyInstance = null;
         var _loc4_:String = null;
         this.searchSmileys = [];
         if(this.search.text.length > 0)
         {
            _loc2_ = StringUtil.trim(this.search.text.toLowerCase());
            for each(_loc3_ in this.smileyAuraMenu.smilies)
            {
               _loc4_ = _loc3_.item.name.toLowerCase();
               if(_loc4_.indexOf(_loc2_) >= 0 || _loc3_.item.id.toString().indexOf(_loc2_) >= 0)
               {
                  if(this.searchSmileys.indexOf(_loc3_) == -1)
                  {
                     this.searchSmileys.push(_loc3_);
                  }
               }
            }
         }
         this.smileyAuraMenu.redraw(this.searchSmileys,this.search.text);
      }
      
      private function redraw() : void
      {
         graphics.clear();
         graphics.lineStyle(1,8092539);
         graphics.beginFill(3289650);
         graphics.drawRect(0,0,this.ow,this.oh);
         graphics.endFill();
         graphics.beginFill(4473924);
         graphics.drawRoundRect(this.search.x,this.search.y,this.search.width,this.search.height,5,5);
         graphics.endFill();
         this.searchSprite.graphics.clear();
         this.searchSprite.graphics.lineStyle(2,13421772);
         this.searchSprite.graphics.drawCircle(0,0,3.4);
         this.searchSprite.graphics.moveTo(3,4);
         this.searchSprite.graphics.lineTo(6,8);
         this.searchSprite.graphics.endFill();
         this.searchSprite.x = this.ow - 15;
         this.searchSprite.y = 12;
      }
      
      protected function handleAttach(param1:Event) : void
      {
         var e:Event = param1;
         removeEventListener(Event.ADDED_TO_STAGE,this.handleAttach);
         this.searchSmileys = [];
         this.search = new TextField();
         this.search.defaultTextFormat = new TextFormat("Arial",11,16777215);
         this.search.antiAliasType = AntiAliasType.NORMAL;
         this.search.restrict = "a-zA-Z0-9^ ";
         this.search.maxChars = 25;
         this.search.selectable = true;
         this.search.type = TextFieldType.INPUT;
         this.search.width = this.ow - 32;
         this.search.height = this.oh - 12;
         this.search.x = 5;
         this.search.y = (this.oh - this.search.height) / 2;
         addChild(this.search);
         this.search.addEventListener(Event.CHANGE,this.updateFilter);
         this.search.addEventListener(MouseEvent.MOUSE_DOWN,function(param1:MouseEvent):void
         {
            param1.preventDefault();
            param1.stopImmediatePropagation();
            param1.stopPropagation();
         });
         this.search.addEventListener(KeyboardEvent.KEY_DOWN,function(param1:KeyboardEvent):void
         {
            param1.preventDefault();
            param1.stopImmediatePropagation();
            param1.stopPropagation();
            if(param1.keyCode == Keyboard.ESCAPE)
            {
               if(search.text == "")
               {
                  Global.base.ui2instance.hideAll();
               }
               else
               {
                  search.text = "";
                  updateFilter(param1);
               }
            }
         });
         this.search.addEventListener(KeyboardEvent.KEY_UP,function(param1:KeyboardEvent):void
         {
            param1.preventDefault();
            param1.stopImmediatePropagation();
            param1.stopPropagation();
         });
         this.searchSprite = new Sprite();
         addChild(this.searchSprite);
         this.redraw();
      }
   }
}
