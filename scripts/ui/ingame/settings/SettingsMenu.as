package ui.ingame.settings
{
   import blitter.Bl;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.display.StageDisplayState;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import ui.LevelOptions;
   import ui.SettingsPage;
   
   public class SettingsMenu extends SettingsButton
   {
      
      private static var Sound:Class = SettingsMenu_Sound;
      
      private static var soundBMD:BitmapData = new Sound().bitmapData;
      
      private static var FullScreen:Class = SettingsMenu_FullScreen;
      
      private static var fullScreenBMD:BitmapData = new FullScreen().bitmapData;
       
      
      private var soundButton:SettingsButton;
      
      private var fullScreenButton:SettingsButton;
      
      private var buttonsContainer:Sprite;
      
      private var ui2:UI2;
      
      private var that:SettingsMenu;
      
      private var lastButtons:Array;
      
      public var levelOptions:LevelOptions;
      
      public function SettingsMenu(param1:String, param2:UI2)
      {
         var text:String = param1;
         var ui2:UI2 = param2;
         this.lastButtons = [];
         this.that = this;
         super(text,null,function():void
         {
            toggleVisible(!buttonsContainer.visible);
         });
         this.that.ui2 = ui2;
         this.buttonsContainer = new Sprite();
         this.buttonsContainer.visible = false;
         this.ui2.above.addChild(this.buttonsContainer);
         this.addButton(new SettingsButton("Game\nSettings",null,this.handleSettings));
         if(Bl.data.canChangeWorldOptions)
         {
            this.addButton(new SettingsButton("World\nOptions",null,this.handleWorldOptions));
            this.addButton(new SettingsButton("Save\nWorld",null,this.handleSaveWorld));
         }
         this.soundButton = new SettingsButton("",soundBMD,this.handleSoundClick);
         this.soundButton.x = 49;
         this.addButton(this.soundButton);
         this.lastButtons.push(this.soundButton);
         this.toggleSound(Global.play_sounds);
         this.fullScreenButton = new SettingsButton("",fullScreenBMD,this.handleFullScreenClick);
         this.fullScreenButton.x = 49;
         this.fullScreenButton.y = -29;
         this.addButton(this.fullScreenButton);
         this.lastButtons.push(this.fullScreenButton);
      }
      
      public function addButton(param1:SettingsButton) : void
      {
         this.buttonsContainer.addChild(param1);
         this.redraw();
      }
      
      public function removeButton(param1:SettingsButton) : void
      {
         this.buttonsContainer.removeChild(param1);
         this.redraw();
      }
      
      protected function handleSoundClick(param1:MouseEvent) : void
      {
         this.toggleSound(!Global.play_sounds);
      }
      
      private function toggleSound(param1:Boolean) : void
      {
         Global.play_sounds = param1;
         var _loc2_:BitmapData = new BitmapData(soundBMD.width / 2,soundBMD.height,true,0);
         _loc2_.copyPixels(soundBMD,new Rectangle(!!Global.play_sounds?Number(0):Number(soundBMD.width / 2),0,_loc2_.width,_loc2_.height),new Point());
         this.soundButton.updateImage(_loc2_);
      }
      
      protected function handleFullScreenClick(param1:MouseEvent) : void
      {
         if(!Config.isMobile)
         {
            try
            {
               if(Bl.stage.displayState == StageDisplayState.NORMAL)
               {
                  Bl.stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
               }
               else
               {
                  Bl.stage.displayState = StageDisplayState.NORMAL;
               }
               return;
            }
            catch(e:Error)
            {
               return;
            }
         }
      }
      
      protected function handleSaveWorld(param1:MouseEvent) : void
      {
         this.toggleVisible(false);
         Global.base.showLoadingScreen("Saving World");
         this.that.ui2.connection.send("save");
      }
      
      protected function handleSettings(param1:MouseEvent) : void
      {
         var _loc2_:SettingsPage = null;
         this.toggleVisible(false);
         _loc2_ = new SettingsPage(true,this.ui2);
         _loc2_.x = ((Global.playing_on_kongregate || Global.playing_on_armorgames?Config.kongWidth:Config.maxwidth) - _loc2_.bg.width) / 2;
         _loc2_.y = (500 - _loc2_.bg.height) / 2;
         Global.base.overlayContainer.addChild(_loc2_);
      }
      
      protected function handleWorldOptions(param1:MouseEvent) : void
      {
         this.toggleVisible(false);
         var _loc2_:Boolean = Global.playerObject.goldmember;
         this.levelOptions = new LevelOptions(this.that.ui2.connection,Global.currentLevelname,this.that.ui2.editKey,this.that.ui2.roomVisible,this.that.ui2.roomHiddenFromLobby,this.that.ui2.allowSpectating,this.that.ui2.description,this.that.ui2.curseLimit,this.that.ui2.zombieLimit,this.that.ui2.minimapEnabled,this.that.ui2.lobbyPreviewEnabled,_loc2_ || Global.base.client.payVault.has("brickeffectcurse"),_loc2_ || Global.base.client.payVault.has("brickeffectzombie"),this.that.ui2);
         Global.base.showLevelOptions(this.levelOptions);
      }
      
      public function toggleVisible(param1:Boolean) : void
      {
         if(param1)
         {
            this.that.ui2.hideAll();
         }
         this.buttonsContainer.visible = param1;
      }
      
      public function redraw() : void
      {
         var _loc3_:SettingsButton = null;
         if(this.ui2.settingsMenu)
         {
            this.buttonsContainer.x = this.ui2.settingsMenu.x;
            this.buttonsContainer.y = this.ui2.settingsMenu.y - 29;
         }
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         while(_loc2_ < this.buttonsContainer.numChildren)
         {
            _loc3_ = this.buttonsContainer.getChildAt(_loc2_) as SettingsButton;
            if(_loc3_.x == 0)
            {
               _loc3_.y = _loc1_ * -29;
               _loc1_++;
            }
            _loc2_++;
         }
      }
   }
}
