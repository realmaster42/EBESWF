package ui.ingame.sam
{
   import blitter.Bl;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.ui.Mouse;
   import items.ItemAuraColor;
   import items.ItemAuraShape;
   import sample.ui.components.Label;
   import states.PlayState;
   
   public class SmileyAuraMenu extends Sprite
   {
       
      
      private var smileyContainer:Sprite;
      
      private var auraContainer:Sprite;
      
      private var smileyContainerWidth:int = 224;
      
      private var auraContainerHeight:int = 65;
      
      private var hotbarContainerHeight:int = 35;
      
      private var smileyContainerHeight:Number;
      
      private var horSpacing:int = 5;
      
      private var verSpacing:int = 5;
      
      public var smilies:Array;
      
      private var auras:Array;
      
      public var auraSelector:AuraSelector;
      
      private var ui2:UI2;
      
      private var movingSmiley:SmileyInstance;
      
      private var movingSmileyFromHotbar:Boolean;
      
      private var mouseDown:Boolean;
      
      private var hotbar:Hotbar;
      
      private var searchBar:SearchBar;
      
      private var goldBordersToggle:GoldBordersToggle;
      
      public function SmileyAuraMenu(param1:UI2)
      {
         super();
         this.ui2 = param1;
         this.smilies = [];
         this.auras = [];
         if(Global.playerObject.goldmember)
         {
            this.goldBordersToggle = new GoldBordersToggle();
            this.goldBordersToggle.useHandCursor = true;
            this.goldBordersToggle.mouseEnabled = true;
            this.goldBordersToggle.buttonMode = true;
            this.goldBordersToggle.addEventListener(MouseEvent.CLICK,this.toggleGoldBorders);
            addChild(this.goldBordersToggle);
            this.updateGoldBordersButton();
         }
         this.searchBar = new SearchBar(this,this.smileyContainerWidth);
         addChild(this.searchBar);
         this.smileyContainer = new Sprite();
         addChild(this.smileyContainer);
         this.auraContainer = new Sprite();
         addChild(this.auraContainer);
         this.hotbar = new Hotbar(this.ui2,this.handleSmileyDown);
         addChild(this.hotbar);
         this.auraSelector = new AuraSelector(this.ui2);
         addChild(this.auraSelector);
         addEventListener(Event.ADDED_TO_STAGE,this.handleAddedToStage);
      }
      
      private function updateGoldBordersButton() : void
      {
         this.goldBordersToggle.setActive(Global.playerInstance.wearsGoldSmiley);
      }
      
      public function addSmiley(param1:SmileyInstance) : void
      {
         var sm:SmileyInstance = param1;
         var i:int = 0;
         while(i < this.smilies.length)
         {
            if((this.smilies[i] as SmileyInstance).item.id == sm.item.id)
            {
               return;
            }
            i++;
         }
         this.smilies.push(sm);
         this.smileyContainer.addChild(sm);
         sm.hitBox.addEventListener(MouseEvent.MOUSE_DOWN,function(param1:MouseEvent):void
         {
            handleSmileyDown(param1,false);
         });
      }
      
      public function addAura(param1:ItemAuraShape) : void
      {
         this.auraSelector.addAura(new AuraInstance(param1,this.ui2));
      }
      
      public function addColor(param1:ItemAuraColor) : void
      {
         var that:* = undefined;
         var color:ItemAuraColor = param1;
         that = this;
         this.auraSelector.addColor(new AuraColorButton(color,function(param1:MouseEvent):void
         {
            that.ui2.setSelectedAuraColor(color.id);
         }));
      }
      
      public function setSelectedSmiley(param1:int) : void
      {
         if(this.smilies[param1] == null)
         {
            param1 = 0;
         }
      }
      
      public function doEmpty() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.smilies.length)
         {
            if(this.smilies[_loc1_])
            {
               SmileyInstance(this.smilies[_loc1_]).destroy();
            }
            _loc1_++;
         }
         this.smilies = [];
      }
      
      public function getSmileyInstanceByItemId(param1:int) : SmileyInstance
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.smilies.length)
         {
            if(this.smilies[_loc2_])
            {
               if(SmileyInstance(this.smilies[_loc2_]).item.id == param1)
               {
                  return SmileyInstance(this.smilies[_loc2_]);
               }
            }
            _loc2_++;
         }
         return this.smilies[0] as SmileyInstance;
      }
      
      public function redraw(param1:Array = null, param2:String = "") : void
      {
         var _loc5_:Label = null;
         while(this.smileyContainer.numChildren > 0)
         {
            this.smileyContainer.removeChildAt(0);
         }
         if(param2.length == 0)
         {
            this.redrawSmileyPositions(this.smilies);
         }
         else if(param1.length <= 0 && param2.length > 0)
         {
            _loc5_ = new Label("No smileys found...",12,"left",16777215,false,"visitor");
            _loc5_.x = (this.smileyContainerWidth - _loc5_.width) / 2;
            _loc5_.y = 3;
            this.smileyContainer.addChild(_loc5_);
            this.smileyContainerHeight = _loc5_.height + 5;
         }
         else
         {
            this.redrawSmileyPositions(param1);
         }
         this.searchBar.y = -this.searchBar.oh;
         if(Global.playerObject.goldmember)
         {
            this.goldBordersToggle.y = this.searchBar.y - (this.goldBordersToggle.height - 1);
         }
         this.smileyContainer.graphics.clear();
         this.smileyContainer.graphics.lineStyle(1,8092539,1);
         this.smileyContainer.graphics.beginFill(3289650,1);
         this.smileyContainer.graphics.drawRect(0,0,this.smileyContainerWidth,this.smileyContainerHeight);
         this.smileyContainer.graphics.endFill();
         var _loc3_:Boolean = Bl.data.canToggleGodMode && !Global.player_is_guest;
         var _loc4_:PlayState = Global.base.state as PlayState;
         if(_loc4_ != null && _loc4_.player.isInGodMode)
         {
            _loc3_ = true;
         }
         this.auraContainer.graphics.clear();
         if(_loc3_)
         {
            this.auraContainer.graphics.lineStyle(1,8092539,1);
            this.auraContainer.graphics.beginFill(3289650,1);
            this.auraContainer.graphics.drawRect(0,this.smileyContainerHeight,this.smileyContainerWidth,this.auraContainerHeight);
            this.auraContainer.graphics.endFill();
         }
         this.auraSelector.x = this.horSpacing;
         this.auraSelector.y = this.smileyContainerHeight;
         this.auraSelector.visible = _loc3_;
         this.hotbar.graphics.clear();
         this.hotbar.graphics.lineStyle(1,8092539);
         this.hotbar.graphics.beginFill(3289650,1);
         this.hotbar.y = this.smileyContainerHeight + (!!_loc3_?this.auraContainerHeight:0);
         this.hotbar.graphics.drawRect(0,0,this.smileyContainerWidth,this.hotbarContainerHeight);
         this.hotbar.graphics.endFill();
         x = 35;
         y = -(this.smileyContainer.y + (this.hotbar.y + this.hotbar.height) + 29);
      }
      
      private function redrawSmileyPositions(param1:Array) : void
      {
         var _loc4_:int = 0;
         var _loc5_:SmileyInstance = null;
         var _loc2_:int = this.verSpacing;
         var _loc3_:int = this.smileyContainer.y + this.horSpacing;
         if(param1.length > 0)
         {
            _loc4_ = 0;
            while(_loc4_ < param1.length)
            {
               if(param1[_loc4_] != null)
               {
                  _loc5_ = param1[_loc4_] as SmileyInstance;
                  _loc5_.updateBorder(Global.playerInstance.wearsGoldSmiley);
                  _loc5_.scaleImage(_loc5_,1,0);
                  if(_loc5_ != null)
                  {
                     if(_loc2_ + 16 + this.horSpacing >= this.smileyContainerWidth)
                     {
                        _loc2_ = this.horSpacing;
                        _loc3_ = _loc3_ + (16 + this.verSpacing);
                     }
                     _loc5_.x = _loc2_;
                     _loc5_.y = _loc3_;
                     _loc2_ = _loc2_ + (16 + this.horSpacing);
                     this.smileyContainer.addChild(_loc5_);
                  }
               }
               _loc4_++;
            }
            this.smileyContainerHeight = param1[param1.length - 1].y + 16 + this.verSpacing * 3;
         }
      }
      
      private function toggleGoldBorders(param1:MouseEvent) : void
      {
         if(Global.playerObject.goldmember)
         {
            Global.base.setGoldBorder(!Global.playerInstance.wearsGoldSmiley);
         }
      }
      
      protected function handleSmileyDown(param1:MouseEvent, param2:Boolean) : void
      {
         this.mouseDown = true;
         this.movingSmileyFromHotbar = param2;
         var _loc3_:SmileyInstance = param1.target.parent as SmileyInstance;
         if(this.movingSmiley)
         {
            this.movingSmiley.destroy(true);
         }
         this.movingSmiley = new SmileyInstance(_loc3_.item,this.ui2,Global.playerInstance.wearsGoldSmiley,_loc3_.index,false);
         this.ui2.setSelectedSmiley(_loc3_.item.id);
      }
      
      protected function handleSmileyMove(param1:MouseEvent) : void
      {
         if(this.mouseDown)
         {
            if(this.movingSmiley)
            {
               Mouse.hide();
               this.movingSmiley.x = mouseX - this.movingSmiley.width / 2;
               this.movingSmiley.y = mouseY - this.movingSmiley.height / 2;
               if(this.movingSmiley.scaleX != 2)
               {
                  this.movingSmiley.scaleX = 2;
               }
               if(this.movingSmiley.scaleY != 2)
               {
                  this.movingSmiley.scaleY = 2;
               }
               if(!contains(this.movingSmiley))
               {
                  addChild(this.movingSmiley);
               }
            }
         }
         else if(this.movingSmiley)
         {
            this.movingSmiley.destroy(true);
         }
      }
      
      protected function handleSmileyLetGo(param1:MouseEvent) : void
      {
         var _loc3_:Rectangle = null;
         var _loc4_:Boolean = false;
         if(!this.mouseDown)
         {
            return;
         }
         Mouse.show();
         var _loc2_:SmileyInstance = param1.target.parent as SmileyInstance;
         if(_loc2_)
         {
            _loc3_ = new Rectangle(0,0,this.smileyContainerWidth,this.hotbarContainerHeight);
            _loc4_ = false;
            if(_loc3_.contains(this.hotbar.mouseX,this.hotbar.mouseY))
            {
               _loc4_ = this.hotbar.addSmiley(_loc2_,this.hotbar.mouseX,this.hotbar.mouseY);
            }
            else if(this.movingSmileyFromHotbar)
            {
               this.hotbar.removeSmiley(_loc2_);
            }
            if(contains(_loc2_) && !this.smileyContainer.contains(_loc2_) && !this.hotbar.contains(_loc2_))
            {
               _loc2_.destroy(!_loc4_);
            }
         }
         this.mouseDown = false;
      }
      
      protected function handleAddedToStage(param1:Event) : void
      {
         this.redraw();
         this.hotbar.redrawHotbarSmileys();
         removeEventListener(Event.ADDED_TO_STAGE,this.handleAddedToStage);
         stage.addEventListener(MouseEvent.MOUSE_MOVE,this.handleSmileyMove);
         stage.addEventListener(MouseEvent.MOUSE_UP,this.handleSmileyLetGo);
      }
      
      public function updateAllSmileyBorders() : void
      {
         this.ui2.smileyAuraButton.smiley.updateBorder(Global.playerInstance.wearsGoldSmiley);
         this.hotbar.redrawHotbarSmileys();
         this.updateGoldBordersButton();
         var _loc1_:int = 0;
         while(_loc1_ < this.smileyContainer.numChildren)
         {
            if(this.smileyContainer && this.smileyContainer.getChildAt(_loc1_) && this.smileyContainer.getChildAt(_loc1_) is SmileyInstance)
            {
               (this.smileyContainer.getChildAt(_loc1_) as SmileyInstance).updateBorder(Global.playerInstance.wearsGoldSmiley);
            }
            _loc1_++;
         }
      }
   }
}
