package ui.shop
{
   import data.ShopItemData;
   import flash.events.MouseEvent;
   import ui.Tab;
   import ui.TabBar;
   
   public class MainShop extends BaseShop
   {
      
      private static const ALL:int = -1;
      
      public static const TAB_FEATURED:int = 0;
      
      public static const TAB_SMILEYS:int = 1;
      
      public static const TAB_BLOCKS:int = 2;
      
      public static const TAB_WORLDS:int = 3;
      
      public static const TAB_CLASSIC:int = 4;
      
      public static const TAB_AURA:int = 5;
      
      public static const TAB_CREW:int = 6;
      
      public static const TAB_SERVICES:int = 7;
       
      
      private var tabbar:TabBar;
      
      private var current_content_id:int;
      
      public function MainShop()
      {
         super(4);
         setContentSize(10,40,Global.playing_on_kongregate || Global.playing_on_armorgames?Number(Config.kongWidth - 58):Number(800),349);
         this.tabbar = new TabBar();
         addChildAt(this.tabbar,0);
         this.tabbar.spacing = 4;
         this.tabbar.addTab(TAB_FEATURED,"Featured",Tab.ICON_CROWN);
         this.tabbar.addTab(TAB_SMILEYS,"Smileys",Tab.ICON_SMILEY);
         this.tabbar.addTab(TAB_BLOCKS,"Blocks",Tab.ICON_BRICK);
         this.tabbar.addTab(TAB_WORLDS,"Worlds",Tab.ICON_WORLD);
         this.tabbar.addTab(TAB_AURA,"Auras",Tab.ICON_AURA);
         this.tabbar.addTab(TAB_CLASSIC,"Classic",Tab.ICON_BOOK);
         this.tabbar.addTab(TAB_CREW,"Crew",Tab.ICON_CREW);
         this.tabbar.addTab(TAB_SERVICES,"Services",Tab.ICON_SERVICES);
         this.tabbar.addEventListener(MouseEvent.MOUSE_DOWN,this.handleMouseTab,false,0,true);
         this.tabbar.setSelected(0);
         this.tabbar.width = Global.playing_on_kongregate || Global.playing_on_armorgames?Number(Config.kongWidth - 45):Number(805);
         this.showContent(0);
      }
      
      protected function handleMouseTab(param1:MouseEvent) : void
      {
         var _loc2_:Tab = param1.target as Tab;
         this.showContent(_loc2_.id);
      }
      
      public function refreshTab() : void
      {
         this.showTab(this.current_content_id);
      }
      
      public function showTab(param1:int) : void
      {
         this.tabbar.setSelected(param1);
         this.showContent(param1);
      }
      
      private function showContent(param1:int) : void
      {
         if(!Shop.isInitiallyRefreshed())
         {
            return;
         }
         refreshShopItems();
         this.current_content_id = param1;
         var _loc2_:Vector.<ShopItemData> = new Vector.<ShopItemData>();
         var _loc3_:int = 0;
         while(_loc3_ < all_items.length)
         {
            switch(param1)
            {
               case -1:
                  _loc2_.push(all_items[_loc3_]);
                  break;
               case TAB_FEATURED:
                  if(all_items[_loc3_].isFeatured)
                  {
                     _loc2_.push(all_items[_loc3_]);
                  }
                  break;
               case TAB_SMILEYS:
                  if(all_items[_loc3_].type == ShopItemData.TYPE_SMILEY && !all_items[_loc3_].isClassic)
                  {
                     _loc2_.push(all_items[_loc3_]);
                  }
                  break;
               case TAB_BLOCKS:
                  if(all_items[_loc3_].type == ShopItemData.TYPE_BRICK && !all_items[_loc3_].isClassic)
                  {
                     _loc2_.push(all_items[_loc3_]);
                  }
                  break;
               case TAB_WORLDS:
                  if(all_items[_loc3_].type == ShopItemData.TYPE_WORLD && !all_items[_loc3_].isClassic)
                  {
                     _loc2_.push(all_items[_loc3_]);
                  }
                  break;
               case TAB_CREW:
                  if(all_items[_loc3_].type == ShopItemData.TYPE_CREW && !all_items[_loc3_].isClassic)
                  {
                     _loc2_.push(all_items[_loc3_]);
                  }
                  break;
               case TAB_AURA:
                  if((all_items[_loc3_].type == ShopItemData.TYPE_AURA_COLOR || all_items[_loc3_].type == ShopItemData.TYPE_AURA_SHAPE) && !all_items[_loc3_].isClassic)
                  {
                     _loc2_.push(all_items[_loc3_]);
                  }
                  break;
               case TAB_CLASSIC:
                  if(all_items[_loc3_].isClassic)
                  {
                     _loc2_.push(all_items[_loc3_]);
                  }
                  break;
               case TAB_SERVICES:
                  if(all_items[_loc3_].type == ShopItemData.TYPE_SERVICE || all_items[_loc3_].type == ShopItemData.TYPE_GOLD)
                  {
                     _loc2_.push(all_items[_loc3_]);
                  }
                  break;
               case TAB_CREW:
                  if(all_items[_loc3_].isCrewOnly)
                  {
                     _loc2_.push(all_items[_loc3_]);
                  }
            }
            _loc3_++;
         }
         showItems(_loc2_);
      }
   }
}
