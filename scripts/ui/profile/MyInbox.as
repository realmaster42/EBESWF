package ui.profile
{
   import com.greensock.TweenMax;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerio.Message;
   import sample.ui.components.Box;
   import sample.ui.components.Label;
   import sample.ui.components.scroll.ScrollBox;
   
   public class MyInbox extends Sprite
   {
      
      private static const UPDATE:int = 750;
       
      
      private var messages:Box;
      
      private var messagesBox:Box;
      
      private var messagesList:FillBox;
      
      private var messagesScrollBox:ScrollBox;
      
      private var refreshDate:Date;
      
      private var isLoading:Boolean = false;
      
      private var messageItems:Array;
      
      public var friendNames:Array;
      
      private var lastMail:String;
      
      public function MyInbox()
      {
         this.messageItems = [];
         this.friendNames = [];
         super();
         addEventListener(Event.EXIT_FRAME,this.handleUpdateInboxScrollBox,false,0,true);
      }
      
      public function refreshMessages(param1:Function = null) : void
      {
         var callback:Function = param1;
         this.refreshDate = new Date();
         this.isLoading = true;
         if(this.messages)
         {
            removeChild(this.messages);
         }
         this.messages = new Box();
         addChild(this.messages);
         this.messages.margin(0,0,0,0);
         this.messagesList = new FillBox(5);
         this.messagesList.forceScale = false;
         var topBar:FillBox = new FillBox(3,3);
         topBar.addChild(new assets_sendbtn());
         topBar.addChild(new assets_messagesbtn());
         topBar.addEventListener(MouseEvent.MOUSE_DOWN,this.handleTopBarButton,false,0,true);
         var topBarBox:Box = new Box();
         topBarBox.margin(2,2,0,Global.playing_on_kongregate || Global.playing_on_armorgames?Number(175 - 25):Number(175));
         topBarBox.add(topBar);
         this.messages.add(topBarBox);
         this.messagesScrollBox = new ScrollBox().margin(0,0,0,3);
         this.messagesScrollBox.scrollMultiplier = 8;
         this.messagesScrollBox.add(this.messagesList);
         this.messagesBox = new Box();
         this.messagesBox.margin(28,0,0,Global.playing_on_kongregate || Global.playing_on_armorgames?Number(0):Number(25));
         this.messagesBox.add(this.messagesScrollBox);
         this.messages.add(this.messagesBox);
         this.messageItems = [];
         Global.base.requestRemoteMethod("getMails",function(param1:Message):void
         {
            var _loc3_:String = null;
            var _loc2_:int = 0;
            while(_loc2_ < param1.length)
            {
               _loc3_ = param1.getString(_loc2_);
               if(_loc2_ == 0)
               {
                  lastMail = _loc3_;
               }
               messageItems.push(new MessageItem(_loc3_,param1.getString(_loc2_ + 1),param1.getString(_loc2_ + 2),param1.getString(_loc2_ + 3),handleMailRemoved));
               _loc2_ = _loc2_ + 4;
            }
            renderMessages(messageItems);
            if(callback != null)
            {
               callback(true);
            }
         });
         this.messagesScrollBox.refresh();
      }
      
      public function refresh(param1:Function) : void
      {
         if(!this.isLoading && this.refreshDate == null || new Date().time - this.refreshDate.time > UPDATE)
         {
            this.refreshMessages(param1);
         }
         else if(param1 != null)
         {
            param1();
         }
      }
      
      private function handleTopBarButton(param1:MouseEvent) : void
      {
         this.messagesList.removeAllChildren();
         if(param1.target is assets_sendbtn)
         {
            this.messagesBox.margin(28,0,0,Global.playing_on_kongregate || Global.playing_on_armorgames?Number(65 - 25):Number(65));
            this.messagesList.addChild(new NewMessage(this.friendNames));
            this.messagesScrollBox.scrollDisabled = true;
         }
         else if(param1.target is assets_messagesbtn)
         {
            this.messagesBox.margin(28,0,0,Global.playing_on_kongregate || Global.playing_on_armorgames?Number(0):Number(25));
            this.renderMessages(this.messageItems);
            this.messagesScrollBox.scrollDisabled = false;
         }
         this.messagesScrollBox.refresh();
      }
      
      public function sendNewMessage(param1:String, param2:String) : void
      {
         this.messagesList.removeAllChildren();
         this.messagesBox.margin(28,0,0,Global.playing_on_kongregate || Global.playing_on_armorgames?Number(50 - 25):Number(50));
         this.messagesList.addChild(new NewMessage(this.friendNames,param1,param2));
         this.messagesScrollBox.refresh();
      }
      
      private function renderMessages(param1:Array) : void
      {
         this.isLoading = false;
         if(param1.length == 0)
         {
            this.addNoMail();
            return;
         }
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            if(param1[_loc2_] != null)
            {
               this.messagesList.addChild(param1[_loc2_]);
               (param1[_loc2_] as MessageItem).messageHeader.addEventListener(MouseEvent.CLICK,this.handleMessageItemClick);
            }
            _loc2_++;
         }
         this.messagesScrollBox.refresh();
      }
      
      public function get hasSeenNewest() : Boolean
      {
         return Global.sharedCookie.data.lastMail == this.lastMail || this.messageItems.length == 0;
      }
      
      public function setSeenNewest() : void
      {
         Global.sharedCookie.data.lastMail = this.lastMail;
      }
      
      private function handleMessageItemClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.messageItems.length)
         {
            if(this.messageItems[_loc2_] != null)
            {
               if(this.messagesList.contains(this.messageItems[_loc2_]))
               {
                  this.messagesList.removeChild(this.messageItems[_loc2_]);
                  (this.messageItems[_loc2_] as MessageItem).messageHeader.removeEventListener(MouseEvent.CLICK,this.handleMessageItemClick);
               }
            }
            _loc2_++;
         }
         this.renderMessages(this.messageItems);
         this.messagesScrollBox.refresh();
      }
      
      private function handleMailRemoved(param1:MessageItem) : void
      {
         var message:MessageItem = param1;
         this.messagesScrollBox.refresh();
         if(this.messagesList.contains(message))
         {
            TweenMax.to(message,0.4,{
               "alpha":0,
               "onComplete":function():void
               {
                  if(stage)
                  {
                     stage.stageFocusRect = false;
                     stage.focus = Global.base;
                  }
                  messagesList.removeChild(message);
                  if(messagesList.numChildren == 0)
                  {
                     addNoMail();
                  }
                  var _loc1_:* = 0;
                  while(_loc1_ < messageItems.length)
                  {
                     if(messageItems[_loc1_] as MessageItem == message)
                     {
                        messageItems[_loc1_] = null;
                     }
                     _loc1_++;
                  }
                  messagesScrollBox.refresh();
                  renderMessages(messageItems);
               }
            });
         }
      }
      
      private function addNoMail() : void
      {
         this.messagesList.removeAllChildren();
         this.messagesBox.margin(28,0,0,Global.playing_on_kongregate || Global.playing_on_armorgames?Number(150 - 25):Number(150));
         this.messagesList.addChild(new Label("You have no mail!",16,"left",16777215,false,"system"));
         this.messagesScrollBox.refresh();
      }
      
      private function handleUpdateInboxScrollBox(param1:Event) : void
      {
         removeEventListener(Event.EXIT_FRAME,this.handleUpdateInboxScrollBox);
         this.messagesScrollBox.refresh();
      }
      
      override public function set width(param1:Number) : void
      {
         this.messages.width = param1;
      }
      
      override public function set height(param1:Number) : void
      {
         this.messages.height = param1;
      }
   }
}
