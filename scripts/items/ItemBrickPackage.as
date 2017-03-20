package items
{
   public class ItemBrickPackage
   {
       
      
      public var name:String;
      
      public var description:String;
      
      public var tags:Array;
      
      public var bricks:Vector.<ItemBrick>;
      
      public function ItemBrickPackage(param1:String, param2:String, param3:Array = null)
      {
         this.bricks = new Vector.<ItemBrick>();
         super();
         this.name = param1;
         this.description = param2;
         this.tags = param3 || [];
      }
      
      public function addBrick(param1:ItemBrick) : void
      {
         this.bricks.push(param1);
      }
   }
}
