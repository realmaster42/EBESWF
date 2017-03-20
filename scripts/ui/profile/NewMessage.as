package ui.profile
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerio.Message;
   import ui.DropDownList;
   
   public class NewMessage extends assets_newmessage
   {
       
      
      private var optionsList:DropDownList;
      
      private var friends:Array;
      
      private var friendsBank:Array;
      
      public function NewMessage(param1:Array, param2:String = "", param3:String = "")
      {
         var _loc4_:int = 0;
         this.friends = [];
         this.friendsBank = [];
         super();
         if(param1.length > 0)
         {
            gotoAndStop(1);
            this.friends = param1;
            _loc4_ = 0;
            while(_loc4_ < this.friends.length)
            {
               this.friends[_loc4_] = this.friends[_loc4_].toString().toUpperCase();
               _loc4_++;
            }
            tf_subject.maxChars = 50;
            tf_subject.text = param3;
            tf_message.maxChars = 420;
            tf_message.text = "";
            tf_error.visible = false;
            this.btn_dropdown.rankBox.visible = false;
            this.btn_dropdown.visible = false;
            this.dropdownContainer.visible = false;
            this.optionsList = new DropDownList(dropdownContainer.width,this.friends,true);
            this.optionsList.x = btn_dropdown.x;
            this.optionsList.y = Math.round(btn_dropdown.y) - 1;
            this.optionsList.inputBox.maxChars = 20;
            this.optionsList.inputBox.restrict = "0-9A-Z";
            this.optionsList.inputBox.addEventListener(Event.CHANGE,this.predictFriend);
            addChild(this.optionsList);
            if(param2 != "")
            {
               this.optionsList.inputBox.text = param2.toUpperCase();
            }
            btn_send.addEventListener(MouseEvent.CLICK,this.handleSendMessage);
         }
         else
         {
            gotoAndStop(2);
            tf_text.text = "It looks like you don\'t have anyone to send messages to. To be able to send messages you need to add someone via the friends tab.";
         }
      }
      
      private function predictFriend(param1:Event) : void
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         this.friendsBank = [];
         if(this.optionsList.inputBox.length > 0)
         {
            _loc2_ = this.optionsList.inputBox.text.toLowerCase();
            _loc3_ = 0;
            while(_loc3_ < this.friends.length)
            {
               _loc4_ = this.friends[_loc3_].toLowerCase();
               _loc4_ = _loc4_.slice(0,_loc2_.length);
               if(_loc2_ == _loc4_)
               {
                  this.friendsBank.push(this.friends[_loc3_].toString().toUpperCase());
               }
               _loc3_++;
            }
            if(this.friendsBank.length > 0)
            {
               this.optionsList.setItemsArray(this.friendsBank);
            }
            else
            {
               this.optionsList.showItemNotFound("No user found...");
            }
         }
         else
         {
            this.optionsList.setItemsArray(this.friends);
         }
         if(!this.optionsList.dropDownListContainer.visible)
         {
            this.optionsList.showDropDownList(true);
         }
      }
      
      protected function handleSendMessage(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         var target:String = this.optionsList.inputBox.text;
         var subject:String = tf_subject.text;
         var message:String = tf_message.text;
         if(target == "" || subject == "" || message == "")
         {
            tf_error.text = "Please fill in all fields.";
            tf_error.visible = true;
            return;
         }
         Global.base.requestRemoteMethod("sendMail",function(param1:Message):void
         {
            if(!param1.getBoolean(0))
            {
               tf_error.text = param1.getString(1);
               tf_error.visible = true;
            }
            else
            {
               tf_subject.text = "";
               tf_message.text = "";
               tf_error.visible = false;
            }
         },target,subject,message);
      }
   }
}
