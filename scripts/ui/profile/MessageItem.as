package ui.profile
{
   import flash.events.MouseEvent;
   import io.player.tools.Badwords;
   import states.LobbyState;
   
   public class MessageItem extends assets_message
   {
       
      
      private var key:String;
      
      private var sender:String;
      
      private var subject:String;
      
      private var message:String;
      
      private var closeCallback:Function;
      
      public function MessageItem(param1:String, param2:String, param3:String, param4:String, param5:Function = null)
      {
         super();
         this.key = param1;
         this.sender = param2;
         this.subject = param3;
         this.message = param4;
         this.closeCallback = param5;
         messageHeader.buttonMode = true;
         messageHeader.useHandCursor = true;
         messageHeader.gotoAndStop(1);
         messageHeader.msg_sender.text = param2.toUpperCase();
         messageHeader.msg_subject.text = Badwords.Filter(param3);
         gotoAndStop(1);
         messageHeader.addEventListener(MouseEvent.CLICK,this.handleMouseClick);
         messageHeader.addEventListener(MouseEvent.MOUSE_OVER,this.handleMouseOver);
         messageHeader.addEventListener(MouseEvent.MOUSE_OUT,this.handleMouseOut);
      }
      
      private function handleMouseClick(param1:MouseEvent) : void
      {
         if(currentFrame != 2)
         {
            gotoAndStop(2);
            messageContainer.buttonMode = false;
            messageContainer.useHandCursor = false;
            messageContainer.mouseChildren = false;
            messageContainer.mouseEnabled = false;
            msg_text.text = Badwords.Filter(this.message);
            btn_reply.addEventListener(MouseEvent.CLICK,this.handleReplyMessage);
            btn_delete.addEventListener(MouseEvent.CLICK,this.handleDeleteMessage);
         }
         else
         {
            gotoAndStop(1);
         }
      }
      
      protected function handleReplyMessage(param1:MouseEvent) : void
      {
         (Global.base.state as LobbyState).mainProfile.myInbox.sendNewMessage(this.sender,"RE: " + this.subject);
      }
      
      private function handleMouseOver(param1:MouseEvent) : void
      {
         if(messageHeader.currentFrame != 2)
         {
            messageHeader.gotoAndStop(2);
         }
      }
      
      private function handleMouseOut(param1:MouseEvent) : void
      {
         if(messageHeader.currentFrame != 1)
         {
            messageHeader.gotoAndStop(1);
         }
      }
      
      private function handleDeleteMessage(param1:MouseEvent) : void
      {
         Global.base.requestRemoteMethod("deleteMail",null,this.key);
         this.closeCallback(this);
      }
   }
}
