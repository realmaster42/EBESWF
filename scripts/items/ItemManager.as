package items
{
   import blitter.BlSprite;
   import blitter.BlockSprite;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.filters.GlowFilter;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class ItemManager
   {
      
      private static var blockTextBM:Class = ItemManager_blockTextBM;
      
      private static var blockTextBMD:BitmapData = new blockTextBM().bitmapData;
      
      private static var smiliesBM:Class = ItemManager_smiliesBM;
      
      public static var smiliesBMD:BitmapData = new smiliesBM().bitmapData;
      
      private static var aurasBM:Class = ItemManager_aurasBM;
      
      public static var aurasBMD:BitmapData = new aurasBM().bitmapData;
      
      private static var worldsBM:Class = ItemManager_worldsBM;
      
      public static var worldsBMD:BitmapData = new worldsBM().bitmapData;
      
      private static var shopBM:Class = ItemManager_shopBM;
      
      public static var shopBMD:BitmapData = new shopBM().bitmapData;
      
      private static var shopAurasBM:Class = ItemManager_shopAurasBM;
      
      public static var shopAurasBMD:BitmapData = new shopAurasBM().bitmapData;
      
      private static var forgroundBricksBM:Class = ItemManager_forgroundBricksBM;
      
      private static var forgroundBricksBMD:BitmapData = new forgroundBricksBM().bitmapData;
      
      private static var decorationsBM:Class = ItemManager_decorationsBM;
      
      private static var decorationsBMD:BitmapData = new decorationsBM().bitmapData;
      
      private static var backgroundBricksBM:Class = ItemManager_backgroundBricksBM;
      
      private static var backgroundBricksBMD:BitmapData = new backgroundBricksBM().bitmapData;
      
      protected static var specialBricksBM:Class = ItemManager_specialBricksBM;
      
      private static var specialBricksBMD:BitmapData = new specialBricksBM().bitmapData;
      
      protected static var mudBM:Class = ItemManager_mudBM;
      
      private static var mudBMD:BitmapData = new mudBM().bitmapData;
      
      protected static var favoriteBM:Class = ItemManager_favoriteBM;
      
      private static var favoriteBMD:BitmapData = new favoriteBM().bitmapData;
      
      protected static var likeBM:Class = ItemManager_likeBM;
      
      private static var likeBMD:BitmapData = new likeBM().bitmapData;
      
      protected static var completeBM:Class = ItemManager_completeBM;
      
      private static var completeBMD:BitmapData = new completeBM().bitmapData;
      
      protected static var doorsBM:Class = ItemManager_doorsBM;
      
      private static var doorsBMD:BitmapData = new doorsBM().bitmapData;
      
      private static var effectBricksBM:Class = ItemManager_effectBricksBM;
      
      private static var effectBricksBMD:BitmapData = new effectBricksBM().bitmapData;
      
      private static var teamEffectBricksBM:Class = ItemManager_teamEffectBricksBM;
      
      private static var teamEffectBricksBMD:BitmapData = new teamEffectBricksBM().bitmapData;
      
      protected static var particlesBM:Class = ItemManager_particlesBM;
      
      public static var allParticles:BitmapData = new particlesBM().bitmapData;
      
      private static var bounds:Array = [];
      
      private static var coinDoorsBMD:BitmapData = new BitmapData(18000,18,true,0);
      
      private static var coinGatesBMD:BitmapData = new BitmapData(18000,18,true,0);
      
      private static var blueCoinDoorsBMD:BitmapData = new BitmapData(18000,18,true,0);
      
      private static var blueCoinGatesBMD:BitmapData = new BitmapData(18000,18,true,0);
      
      private static var switchDoorsBMD:BitmapData = new BitmapData(18000,18,true,0);
      
      private static var switchGatesBMD:BitmapData = new BitmapData(18000,18,true,0);
      
      private static var switchSwitchUpBMD:BitmapData = new BitmapData(18000,18,true,0);
      
      private static var switchSwitchDownBMD:BitmapData = new BitmapData(18000,18,true,0);
      
      private static var switchOrangeDoorsBMD:BitmapData = new BitmapData(18000,18,true,0);
      
      private static var switchOrangeGatesBMD:BitmapData = new BitmapData(18000,18,true,0);
      
      private static var switchOrangeSwitchUpBMD:BitmapData = new BitmapData(18000,18,true,0);
      
      private static var switchOrangeSwitchDownBMD:BitmapData = new BitmapData(18000,18,true,0);
      
      private static var deathDoorBMD:BitmapData = new BitmapData(18000,18,true,0);
      
      private static var deathGateBMD:BitmapData = new BitmapData(18000,18,true,0);
      
      public static var smilies:Vector.<ItemSmiley> = new Vector.<ItemSmiley>();
      
      public static var auraShapes:Vector.<ItemAuraShape> = new Vector.<ItemAuraShape>();
      
      public static var auraColors:Vector.<ItemAuraColor> = new Vector.<ItemAuraColor>();
      
      public static var brickPackages:Vector.<ItemBrickPackage> = new Vector.<ItemBrickPackage>();
      
      public static var bmdBricks:Vector.<BitmapData> = new Vector.<BitmapData>(4001);
      
      public static var bricks:Vector.<ItemBrick> = new Vector.<ItemBrick>(4001);
      
      public static var bmdBadge:Vector.<BitmapData> = new Vector.<BitmapData>(12);
      
      public static var badgeFullBMD:BitmapData;
      
      public static var sprSwitch:BlockSprite = new BlockSprite(specialBricksBMD,310,0,16,16,2);
      
      public static var sprCheckpoint:BlockSprite = new BlockSprite(specialBricksBMD,154,0,16,16,2);
      
      public static var sprHazards:BlockSprite = new BlockSprite(specialBricksBMD,156,0,16,16,4);
      
      public static var sprDoors:BlockSprite = new BlockSprite(doorsBMD,0,0,16,16,doorsBMD.width / 16);
      
      public static var sprDoorsTime:BlockSprite = new BlockSprite(specialBricksBMD,332,0,16,16,10,true);
      
      public static var sprSecret:BlockSprite = new BlockSprite(specialBricksBMD,139,0,16,16,3);
      
      public static var sprPortal:BlockSprite = new BlockSprite(specialBricksBMD,52,0,16,16,61);
      
      public static var sprPortalWorld:BlockSprite = new BlockSprite(specialBricksBMD,113,0,16,16,21);
      
      public static var sprCoin:BlockSprite = new BlockSprite(specialBricksBMD,0,0,16,16,12);
      
      public static var sprCoinShadow:BlockSprite = new BlockSprite(specialBricksBMD,26,0,16,16,12);
      
      public static var sprBonusCoin:BlockSprite = new BlockSprite(specialBricksBMD,13,0,16,16,12);
      
      public static var sprBonusCoinShadow:BlockSprite = new BlockSprite(specialBricksBMD,39,0,16,16,12);
      
      public static var sprWater:BlockSprite = new BlockSprite(specialBricksBMD,196,0,16,16,22);
      
      public static var sprWave:BlockSprite = new BlockSprite(specialBricksBMD,234,0,16,16,8);
      
      public static var sprMud:BlockSprite = new BlockSprite(mudBMD,0,0,16,16,mudBMD.width / 16);
      
      public static var sprMudBubble:BlockSprite = new BlockSprite(specialBricksBMD,244,0,16,16,19);
      
      public static var sprFavoriteStar:BlockSprite = new BlockSprite(favoriteBMD,0,0,16,16,favoriteBMD.width / 16);
      
      public static var sprLikeHeart:BlockSprite = new BlockSprite(likeBMD,0,0,16,16,likeBMD.width / 16);
      
      public static var sprDiamond:BlockSprite = new BlockSprite(specialBricksBMD,284,0,16,16,14,true);
      
      public static var sprCake:BlockSprite = new BlockSprite(specialBricksBMD,298,0,16,16,12,true);
      
      public static var sprPianoBlink:BlockSprite = new BlockSprite(specialBricksBMD,148,0,16,16,6);
      
      public static var sprDrumsBlink:BlockSprite = new BlockSprite(specialBricksBMD,142,0,16,16,6);
      
      public static var sprInvGravityBlink:BlockSprite = new BlockSprite(specialBricksBMD,312,0,16,16,20);
      
      public static var sprInvDotBlink:BlockSprite = new BlockSprite(specialBricksBMD,466,0,16,16,5);
      
      public static var sprCoinDoors:BlockSprite;
      
      public static var sprCoinGates:BlockSprite;
      
      public static var sprBlueCoinDoors:BlockSprite;
      
      public static var sprBlueCoinGates:BlockSprite;
      
      public static var sprPurpleDoors:BlockSprite;
      
      public static var sprPurpleGates:BlockSprite;
      
      public static var sprOrangeDoors:BlockSprite;
      
      public static var sprOrangeGates:BlockSprite;
      
      public static var sprSwitchUP:BlockSprite;
      
      public static var sprSwitchDOWN:BlockSprite;
      
      public static var sprOrangeSwitchUP:BlockSprite;
      
      public static var sprOrangeSwitchDOWN:BlockSprite;
      
      public static var sprDeathDoor:BlockSprite;
      
      public static var sprDeathGate:BlockSprite;
      
      public static var sprBadge:BlockSprite;
      
      public static var sprFireHazard:BlockSprite = new BlockSprite(specialBricksBMD,184,0,16,16,12);
      
      public static var sprHologram:BlockSprite = new BlockSprite(specialBricksBMD,279,0,16,16,5,true);
      
      public static var sprLava:BlockSprite = new BlockSprite(specialBricksBMD,218,0,16,16,16);
      
      public static var sprTeamEffect:BlockSprite = new BlockSprite(teamEffectBricksBMD,0,0,16,16,teamEffectBricksBMD.width / 16,true);
      
      public static var sprEffect:BlockSprite = new BlockSprite(effectBricksBMD,0,0,16,16,effectBricksBMD.width / 16,true);
      
      public static var sprSign:BlockSprite = new BlockSprite(specialBricksBMD,513,0,16,16,8);
      
      public static var sprParticles:BlSprite = new BlSprite(allParticles,0,0,5,5,allParticles.width / 5);
      
      public static var sprOnewayCyan:BlockSprite = new BlockSprite(specialBricksBMD,263,0,16,16,4,true);
      
      public static var sprOnewayOrange:BlockSprite = new BlockSprite(specialBricksBMD,271,0,16,16,4,true);
      
      public static var sprOnewayYellow:BlockSprite = new BlockSprite(specialBricksBMD,267,0,16,16,4,true);
      
      public static var sprOnewayPink:BlockSprite = new BlockSprite(specialBricksBMD,275,0,16,16,4,true);
      
      public static var sprOnewayGray:BlockSprite = new BlockSprite(specialBricksBMD,471,0,16,16,4,true);
      
      public static var sprOnewayBlue:BlockSprite = new BlockSprite(specialBricksBMD,475,0,16,16,4,true);
      
      public static var sprOnewayRed:BlockSprite = new BlockSprite(specialBricksBMD,479,0,16,16,4,true);
      
      public static var sprOnewayGreen:BlockSprite = new BlockSprite(specialBricksBMD,483,0,16,16,4,true);
      
      public static var sprOnewayBlack:BlockSprite = new BlockSprite(specialBricksBMD,487,0,16,16,4,true);
      
      public static var sprOnewayWhite:BlockSprite = new BlockSprite(specialBricksBMD,565,0,16,16,4,true);
      
      public static var sprGlowylineBlueSlope:BlockSprite = new BlockSprite(specialBricksBMD,176,0,16,16,4);
      
      public static var sprGlowylineBlueStraight:BlockSprite = new BlockSprite(specialBricksBMD,180,0,16,16,4);
      
      public static var sprGlowylineGreenSlope:BlockSprite = new BlockSprite(specialBricksBMD,168,0,16,16,4);
      
      public static var sprGlowylineGreenStraight:BlockSprite = new BlockSprite(specialBricksBMD,172,0,16,16,4);
      
      public static var sprGlowylineYellowSlope:BlockSprite = new BlockSprite(specialBricksBMD,160,0,16,16,4);
      
      public static var sprGlowylineYellowStraight:BlockSprite = new BlockSprite(specialBricksBMD,164,0,16,16,4);
      
      public static var sprGlowylineRedSlope:BlockSprite = new BlockSprite(specialBricksBMD,408,0,16,16,4);
      
      public static var sprGlowylineRedStraight:BlockSprite = new BlockSprite(specialBricksBMD,412,0,16,16,4);
      
      public static var sprMedievalAxe:BlockSprite = new BlockSprite(specialBricksBMD,364,0,16,16,4);
      
      public static var sprMedievalBanner:BlockSprite = new BlockSprite(specialBricksBMD,368,0,16,16,4);
      
      public static var sprMedievalShield:BlockSprite = new BlockSprite(specialBricksBMD,372,0,16,16,4);
      
      public static var sprMedievalSword:BlockSprite = new BlockSprite(specialBricksBMD,376,0,16,16,4);
      
      public static var sprMedievalCoatOfArms:BlockSprite = new BlockSprite(specialBricksBMD,404,0,16,16,4);
      
      public static var sprMedievalTimber:BlockSprite = new BlockSprite(specialBricksBMD,416,0,16,16,6);
      
      public static var sprToothSmall:BlockSprite = new BlockSprite(specialBricksBMD,380,0,16,16,4);
      
      public static var sprToothBig:BlockSprite = new BlockSprite(specialBricksBMD,384,0,16,16,4);
      
      public static var sprToothTriple:BlockSprite = new BlockSprite(specialBricksBMD,400,0,16,16,4);
      
      public static var sprDojoLightLeft:BlockSprite = new BlockSprite(specialBricksBMD,388,0,16,16,3);
      
      public static var sprDojoLightRight:BlockSprite = new BlockSprite(specialBricksBMD,391,0,16,16,3);
      
      public static var sprDojoDarkLeft:BlockSprite = new BlockSprite(specialBricksBMD,394,0,16,16,3);
      
      public static var sprDojoDarkRight:BlockSprite = new BlockSprite(specialBricksBMD,397,0,16,16,3);
      
      public static var sprDomesticLightBulb:BlockSprite = new BlockSprite(specialBricksBMD,424,0,16,16,4);
      
      public static var sprDomesticTap:BlockSprite = new BlockSprite(specialBricksBMD,428,0,16,16,4);
      
      public static var sprDomesticPainting:BlockSprite = new BlockSprite(specialBricksBMD,432,0,16,16,4);
      
      public static var sprDomesticVase:BlockSprite = new BlockSprite(specialBricksBMD,436,0,16,16,4);
      
      public static var sprDomesticTV:BlockSprite = new BlockSprite(specialBricksBMD,440,0,16,16,4);
      
      public static var sprDomesticWindow:BlockSprite = new BlockSprite(specialBricksBMD,444,0,16,16,4);
      
      public static var sprHalfBlockDomesticYellow:BlockSprite = new BlockSprite(specialBricksBMD,448,0,16,16,4,true);
      
      public static var sprHalfBlockDomesticBrown:BlockSprite = new BlockSprite(specialBricksBMD,452,0,16,16,4,true);
      
      public static var sprHalfBlockDomesticWhite:BlockSprite = new BlockSprite(specialBricksBMD,456,0,16,16,4,true);
      
      public static var sprHalloween2015WindowRect:BlockSprite = new BlockSprite(specialBricksBMD,460,0,16,16,2);
      
      public static var sprHalloween2015WindowCircle:BlockSprite = new BlockSprite(specialBricksBMD,462,0,16,16,2);
      
      public static var sprHalloween2015Lamp:BlockSprite = new BlockSprite(specialBricksBMD,464,0,16,16,2);
      
      public static var sprNewYear2015Balloon:BlockSprite = new BlockSprite(specialBricksBMD,491,0,16,16,5);
      
      public static var sprNewYear2015Streamer:BlockSprite = new BlockSprite(specialBricksBMD,496,0,16,16,5);
      
      public static var sprPortalInvisible:BlockSprite = new BlockSprite(specialBricksBMD,134,0,16,16,5);
      
      public static var sprIce:BlockSprite = new BlockSprite(specialBricksBMD,501,0,16,16,12,true);
      
      public static var sprHalfBlockFairytaleRed:BlockSprite = new BlockSprite(specialBricksBMD,521,0,16,16,4,true);
      
      public static var sprHalfBlockFairytaleGreen:BlockSprite = new BlockSprite(specialBricksBMD,525,0,16,16,4,true);
      
      public static var sprHalfBlockFairytaleBlue:BlockSprite = new BlockSprite(specialBricksBMD,529,0,16,16,4,true);
      
      public static var sprHalfBlockFairytalePink:BlockSprite = new BlockSprite(specialBricksBMD,533,0,16,16,4,true);
      
      public static var sprFairytaleFlowers:BlockSprite = new BlockSprite(specialBricksBMD,537,0,16,16,3,true);
      
      public static var sprSpringDaisy:BlockSprite = new BlockSprite(specialBricksBMD,540,0,16,16,3,true);
      
      public static var sprSpringTulip:BlockSprite = new BlockSprite(specialBricksBMD,543,0,16,16,3,true);
      
      public static var sprSpringDaffodil:BlockSprite = new BlockSprite(specialBricksBMD,546,0,16,16,3,true);
      
      public static var sprSummerFlag:BlockSprite = new BlockSprite(specialBricksBMD,549,0,16,16,6,true);
      
      public static var sprSummerAwning:BlockSprite = new BlockSprite(specialBricksBMD,555,0,16,16,6,true);
      
      public static var sprSummerIceCream:BlockSprite = new BlockSprite(specialBricksBMD,561,0,16,16,4,true);
      
      public static var sprCaveCrystal:BlockSprite = new BlockSprite(specialBricksBMD,569,0,16,16,6,true);
      
      public static var sprCaveTorch:BlockSprite = new BlockSprite(specialBricksBMD,575,0,16,16,12,false);
      
      public static var sprRestaurantCup:BlockSprite = new BlockSprite(specialBricksBMD,587,0,16,16,4,true);
      
      public static var sprRestaurantPlate:BlockSprite = new BlockSprite(specialBricksBMD,591,0,16,16,4,true);
      
      public static var sprRestaurantBowl:BlockSprite = new BlockSprite(specialBricksBMD,595,0,16,16,4,true);
      
      public static var sprHalloweenEyes:BlockSprite = new BlockSprite(specialBricksBMD,605,0,16,16,24,false);
      
      public static var sprHalloweenPumpkin:BlockSprite = new BlockSprite(specialBricksBMD,603,0,16,16,2,true);
      
      public static var sprHalloweenRot:BlockSprite = new BlockSprite(specialBricksBMD,599,0,16,16,4,false);
      
      public static var sprChristmas2016LightsDown:BlockSprite = new BlockSprite(specialBricksBMD,629,0,16,16,5,false);
      
      public static var sprChristmas2016LightsUp:BlockSprite = new BlockSprite(specialBricksBMD,634,0,16,16,5,false);
      
      public static var sprChristmas2016Candle:BlockSprite = new BlockSprite(specialBricksBMD,639,0,16,16,12,false);
      
      private static var totalBricks:int = 0;
      
      private static var totalSmilies:int = 0;
      
      private static var totalAuraColors:int = 0;
      
      private static var auraImagesId:int = 0;
      
      private static var totalAuraShapes:int = 0;
      
      public static var sprInvDownArrow:BlockSprite = new BlockSprite(specialBricksBMD,651,0,16,16,5);
      
      public static var sprCacile:BlockSprite = new BlockSprite(specialBricksBMD,656,0,16,16,8);
       
      
      public function ItemManager()
      {
         super();
      }
      
      public static function init() : void
      {
         var _loc108_:BitmapData = null;
         var _loc109_:BitmapData = null;
         var _loc110_:Matrix = null;
         var _loc111_:Bitmap = null;
         var _loc112_:ColorTransform = null;
         addSmiley(0,"Smiley","",smiliesBMD,"");
         addSmiley(1,"Grin","",smiliesBMD,"");
         addSmiley(2,"Tongue","",smiliesBMD,"");
         addSmiley(3,"Happy","",smiliesBMD,"");
         addSmiley(4,"Annoyed","",smiliesBMD,"");
         addSmiley(5,"Sad","",smiliesBMD,"");
         addSmiley(6,"Crying","",smiliesBMD,"pro");
         addSmiley(7,"Wink","",smiliesBMD,"pro");
         addSmiley(8,"Frustrated","",smiliesBMD,"pro");
         addSmiley(9,"Shades","",smiliesBMD,"pro");
         addSmiley(10,"Devil","",smiliesBMD,"pro");
         addSmiley(11,"Inquisitive","",smiliesBMD,"pro");
         addSmiley(12,"Ninja","",smiliesBMD,"smileyninja",0);
         addSmiley(13,"Santa","",smiliesBMD,"smileysanta");
         addSmiley(14,"Worker","",smiliesBMD,"");
         addSmiley(15,"Big Spender","",smiliesBMD,"smileybigspender");
         addSmiley(16,"Superman","",smiliesBMD,"smileysuper",4293787648);
         addSmiley(17,"Surprise","",smiliesBMD,"smileysupprice");
         addSmiley(18,"Indifferent","",smiliesBMD,"");
         addSmiley(19,"Girl","",smiliesBMD,"");
         addSmiley(20,"New Year 2010","",smiliesBMD,"mixednewyear2010");
         addSmiley(21,"Coy","",smiliesBMD,"");
         addSmiley(22,"Wizard","",smiliesBMD,"smileywizard");
         addSmiley(23,"Fan Boy","",smiliesBMD,"smileyfanboy");
         addSmiley(24,"Terminator","",smiliesBMD,"");
         addSmiley(25,"Extra Grin","",smiliesBMD,"smileyxd");
         addSmiley(26,"Bully","",smiliesBMD,"smileybully");
         addSmiley(27,"Commando","",smiliesBMD,"smileycommando");
         addSmiley(28,"Kissing","",smiliesBMD,"smileyvalentines2011");
         addSmiley(29,"Bird","",smiliesBMD,"smileybird");
         addSmiley(30,"Bunny","",smiliesBMD,"smileybunni");
         addSmiley(31,"Diamond Touch","",smiliesBMD,"unobtainable");
         addSmiley(32,"Fire Wizard","",smiliesBMD,"smileywizard2");
         addSmiley(33,"Extra Tongue","",smiliesBMD,"smileyxdp");
         addSmiley(34,"Postman","",smiliesBMD,"smileypostman");
         addSmiley(35,"Templar","",smiliesBMD,"smileytemplar");
         addSmiley(36,"Angel","",smiliesBMD,"");
         addSmiley(37,"Nurse","",smiliesBMD,"smileynurse");
         addSmiley(38,"Vampire","",smiliesBMD,"smileyhw2011vampire");
         addSmiley(39,"Ghost","",smiliesBMD,"smileyhw2011ghost");
         addSmiley(40,"Frankenstein","",smiliesBMD,"smileyhw2011frankenstein");
         addSmiley(41,"Witch","",smiliesBMD,"smileywitch");
         addSmiley(42,"Indian","",smiliesBMD,"smileytg2011indian");
         addSmiley(43,"Pilgrim","",smiliesBMD,"smileytg2011pilgrim");
         addSmiley(44,"Pumpkin","",smiliesBMD,"smileypumpkin1");
         addSmiley(45,"Lit Pumpkin","",smiliesBMD,"smileypumpkin2");
         addSmiley(46,"Snowman","",smiliesBMD,"smileyxmassnowman");
         addSmiley(47,"Reindeer","",smiliesBMD,"smileyxmasreindeer");
         addSmiley(48,"Grinch","",smiliesBMD,"smileyxmasgrinch");
         addSmiley(49,"Maestro","",smiliesBMD,"bricknode");
         addSmiley(50,"DJ","",smiliesBMD,"brickdrums");
         addSmiley(51,"Sigh","",smiliesBMD,"");
         addSmiley(52,"Robber","",smiliesBMD,"",0);
         addSmiley(53,"Police","",smiliesBMD,"",4279002358);
         addSmiley(54,"Purple Ghost","",smiliesBMD,"smileypurpleghost");
         addSmiley(55,"Pirate","",smiliesBMD,"");
         addSmiley(56,"Viking","",smiliesBMD,"");
         addSmiley(57,"Karate","",smiliesBMD,"");
         addSmiley(58,"Cowboy","",smiliesBMD,"");
         addSmiley(59,"Diver","",smiliesBMD,"smileydiver");
         addSmiley(60,"Tanned","",smiliesBMD,"smileytanned");
         addSmiley(61,"Propeller Hat","",smiliesBMD,"");
         addSmiley(62,"Hard Hat","",smiliesBMD,"smileyhardhat");
         addSmiley(63,"Gas Mask","",smiliesBMD,"smileygasmask");
         addSmiley(64,"Robot","",smiliesBMD,"");
         addSmiley(65,"Peasant","",smiliesBMD,"");
         addSmiley(66,"Guard","",smiliesBMD,"");
         addSmiley(67,"Blacksmith","",smiliesBMD,"");
         addSmiley(68,"LOL","",smiliesBMD,"");
         addSmiley(69,"Dog","",smiliesBMD,"");
         addSmiley(70,"Alien","",smiliesBMD,"smileyalien");
         addSmiley(71,"Astronaut","",smiliesBMD,"smileyastronaut");
         addSmiley(72,"PartyOrange","",smiliesBMD,"unobtainable");
         addSmiley(73,"PartyGreen","",smiliesBMD,"unobtainable");
         addSmiley(74,"PartyBlue","",smiliesBMD,"unobtainable");
         addSmiley(75,"PartyRed","",smiliesBMD,"unobtainable");
         addSmiley(76,"Daredevil","",smiliesBMD,"");
         addSmiley(77,"Monster","",smiliesBMD,"smileymonster");
         addSmiley(78,"Skeleton","",smiliesBMD,"smileyskeleton");
         addSmiley(79,"Mad Scientist","",smiliesBMD,"smileymadscientist");
         addSmiley(80,"Headhunter","",smiliesBMD,"smileyheadhunter");
         addSmiley(81,"Safari","",smiliesBMD,"smileysafari");
         addSmiley(82,"Archaeologist","",smiliesBMD,"smileyarchaeologist");
         addSmiley(83,"New Year 2013","",smiliesBMD,"smileynewyear2012");
         addSmiley(84,"Winter Hat","",smiliesBMD,"smileywinter");
         addSmiley(85,"Fire demon","",smiliesBMD,"smileyfiredeamon");
         addSmiley(86,"Bishop","",smiliesBMD,"smileybishop");
         addSmiley(87,"Zombie","",smiliesBMD,"unobtainable");
         addSmiley(88,"Bruce","",smiliesBMD,"smileyzombieslayer");
         addSmiley(89,"Unit","",smiliesBMD,"smileyunit");
         addSmiley(90,"Spartan","",smiliesBMD,"smileyspartan");
         addSmiley(91,"Lady","",smiliesBMD,"smileyhelen");
         addSmiley(92,"Cow","",smiliesBMD,"smileycow");
         addSmiley(93,"Scarecrow","",smiliesBMD,"smileyscarecrow");
         addSmiley(94,"Dark Wizard","",smiliesBMD,"smileydarkwizard");
         addSmiley(95,"Kung Fu Master","",smiliesBMD,"smileykungfumaster");
         addSmiley(96,"Fox","",smiliesBMD,"smileyfox");
         addSmiley(97,"Night Vision","",smiliesBMD,"smileynightvision");
         addSmiley(98,"Summer Girl","",smiliesBMD,"smileysummergirl");
         addSmiley(99,"Fan Boy II","",smiliesBMD,"smileyfanboy2");
         addSmiley(100,"Sci-Fi Hologram","",smiliesBMD,"unobtainable");
         addSmiley(101,"Gingerbread","",smiliesBMD,"smileygingerbread");
         addSmiley(102,"Caroler","",smiliesBMD,"smileycaroler");
         addSmiley(103,"Elf","",smiliesBMD,"smileyelf");
         addSmiley(104,"Nutcracker","",smiliesBMD,"smileynutcracker");
         addSmiley(105,"Blushing","",smiliesBMD,"brickvalentines2015");
         addSmiley(106,"Artist","",smiliesBMD,"smileyartist");
         addSmiley(107,"Princess","",smiliesBMD,"");
         addSmiley(108,"Chef","",smiliesBMD,"");
         addSmiley(109,"Clown","",smiliesBMD,"");
         addSmiley(110,"Red Ninja","",smiliesBMD,"smileyninjared");
         addSmiley(111,"3D Glasses","",smiliesBMD,"smiley3dglasses");
         addSmiley(112,"Sunburned","",smiliesBMD,"smileysunburned");
         addSmiley(113,"Tourist","",smiliesBMD,"smileytourist");
         addSmiley(114,"Graduate","",smiliesBMD,"smileygraduate");
         addSmiley(115,"Sombrero","",smiliesBMD,"smileysombrero");
         addSmiley(116,"Cat","",smiliesBMD,"");
         addSmiley(117,"Scared","",smiliesBMD,"");
         addSmiley(118,"Ghoul","",smiliesBMD,"smileyghoul");
         addSmiley(119,"Mummy","",smiliesBMD,"smileymummy");
         addSmiley(120,"Bat","",smiliesBMD,"smileybat");
         addSmiley(121,"Eyeball","",smiliesBMD,"smileyeyeball");
         addSmiley(122,"Light Wizard","",smiliesBMD,"smileylightwizard");
         addSmiley(123,"Hooded","",smiliesBMD,"smileyhooded");
         addSmiley(124,"Earmuffs","",smiliesBMD,"smileyearmuffs");
         addSmiley(125,"Penguin","",smiliesBMD,"smileypenguin");
         addSmiley(126,"Gold Smiley","",smiliesBMD,"goldmember");
         addSmiley(127,"Gold Ninja","",smiliesBMD,"goldmember");
         addSmiley(128,"Gold Robot","",smiliesBMD,"goldmember");
         addSmiley(129,"Gold Top Hat","",smiliesBMD,"goldmember");
         addSmiley(130,"Sick","",smiliesBMD,"");
         addSmiley(131,"Unsure","",smiliesBMD,"");
         addSmiley(132,"Goofy","",smiliesBMD,"smileygoofy");
         addSmiley(133,"Raindrop","",smiliesBMD,"smileyraindrop");
         addSmiley(134,"Bee","",smiliesBMD,"smileybee");
         addSmiley(135,"Butterfly","",smiliesBMD,"smileybutterfly");
         addSmiley(136,"Sea Captain","",smiliesBMD,"smileyseacaptain");
         addSmiley(137,"Soda Clerk","",smiliesBMD,"smileysodaclerk");
         addSmiley(138,"Lifeguard","",smiliesBMD,"smileylifeguard");
         addSmiley(139,"Aviator","",smiliesBMD,"smileyaviator");
         addSmiley(140,"Sleepy","",smiliesBMD,"smileysleepy");
         addSmiley(141,"Seagull","",smiliesBMD,"smileyseagull");
         addSmiley(142,"Werewolf","",smiliesBMD,"smileywerewolf");
         addSmiley(143,"Swamp Creature","",smiliesBMD,"smileyswampcreature");
         addSmiley(144,"Fairy","",smiliesBMD,"smileyfairy");
         addSmiley(145,"Firefighter","",smiliesBMD,"smileyfirefighter");
         addSmiley(146,"Spy","",smiliesBMD,"smileyspy",0);
         addSmiley(147,"Devil Skull","",smiliesBMD,"smileydevilskull");
         addSmiley(148,"Clockwork Robot","",smiliesBMD,"smileyclockwork");
         addSmiley(149,"Teddy Bear","",smiliesBMD,"smileyteddybear");
         addSmiley(150,"Christmas Soldier","",smiliesBMD,"smileychristmassoldier");
         addSmiley(151,"Scrooge","",smiliesBMD,"smileyscrooge");
         addSmiley(152,"Boy","",smiliesBMD,"");
         addSmiley(153,"Pigtails","",smiliesBMD,"smileypigtails");
         addSmiley(154,"Doctor","",smiliesBMD,"smileydoctor");
         addSmiley(155,"Turban","",smiliesBMD,"smileyturban");
         addSmiley(156,"Hazmat Suit","",smiliesBMD,"smileyhazmatsuit");
         addSmiley(157,"Leprechaun","",smiliesBMD,"smileyleprechaun");
         addSmiley(158,"Patient","",smiliesBMD,"smileypatient");
         addAuraColor(0,"White","");
         addAuraColor(1,"Red","aurared");
         addAuraColor(2,"Blue","aurablue");
         addAuraColor(3,"Yellow","aurayellow");
         addAuraColor(4,"Green","auragreen");
         addAuraColor(5,"Purple","aurapurple");
         addAuraColor(6,"Orange","auraorange");
         addAuraColor(7,"Cyan","auracyan");
         addAuraColor(8,"Gold","goldmember");
         addAuraColor(9,"Pink","aurapink");
         addAuraColor(10,"Indigo","auraindigo");
         addAuraColor(11,"Lime","auralime");
         addAuraColor(12,"Black","aurablack");
         addAuraColor(13,"Silver","aurasilver");
         addAuraShape(0,"Default",aurasBMD,"");
         addAuraShape(1,"Pinwheel",aurasBMD,"aurashapepinwheel",1,0.2,true);
         addAuraShape(2,"Torus",aurasBMD,"aurashapetorus");
         addAuraShape(3,"Ornate",aurasBMD,"goldmember",6);
         addAuraShape(4,"Spiral",aurasBMD,"aurashapespiral",6,0.15);
         addAuraShape(5,"Star",aurasBMD,"aurashapestar");
         var _loc1_:ItemBrickPackage = new ItemBrickPackage("basic","Basic Blocks",["Primary","Simple","Standard","Default"]);
         _loc1_.addBrick(createBrick(1088,ItemLayer.FORGROUND,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,260,-1,["White","Light"]));
         _loc1_.addBrick(createBrick(9,ItemLayer.FORGROUND,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,9,4285427310,["Grey","Gray","Taupe"]));
         _loc1_.addBrick(createBrick(182,ItemLayer.FORGROUND,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,156,4280821800,["Black","Dark","Coal","Road"]));
         _loc1_.addBrick(createBrick(12,ItemLayer.FORGROUND,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,12,4289213780,["Red","Magenta","Vermillion","Ruby"]));
         _loc1_.addBrick(createBrick(1018,ItemLayer.FORGROUND,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,205,-1,["Orange","Persimmon","Copper"]));
         _loc1_.addBrick(createBrick(13,ItemLayer.FORGROUND,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,13,4287866933,["Yellow","Lime","Chartreuse","Light green","Citrine","Citrus"]));
         _loc1_.addBrick(createBrick(14,ItemLayer.FORGROUND,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,14,4282558518,["Green","Kelly","Emerald","Grass"]));
         _loc1_.addBrick(createBrick(15,ItemLayer.FORGROUND,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,15,4281704102,["Blue","Cyan","Light Blue","Aquamarine","Sky Blue"]));
         _loc1_.addBrick(createBrick(10,ItemLayer.FORGROUND,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,10,4281684648,["Blue","Dark Blue","Cobalt"]));
         _loc1_.addBrick(createBrick(11,ItemLayer.FORGROUND,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,11,4288099751,["Purple","Pink","Plum","Violet"]));
         brickPackages.push(_loc1_);
         var _loc2_:ItemBrickPackage = new ItemBrickPackage("beta","Beta Access",["Exclusive"]);
         _loc2_.addBrick(createBrick(1089,ItemLayer.FORGROUND,forgroundBricksBMD,"pro","",ItemTab.BLOCK,false,true,261,4293256677,["White","Light"]));
         _loc2_.addBrick(createBrick(42,ItemLayer.FORGROUND,forgroundBricksBMD,"pro","",ItemTab.BLOCK,false,true,42,4288256409,["Grey","Gray","Taupe"]));
         _loc2_.addBrick(createBrick(1021,ItemLayer.FORGROUND,forgroundBricksBMD,"pro","",ItemTab.BLOCK,false,true,208,4282861383,["Black","Dark","Onyx"]));
         _loc2_.addBrick(createBrick(40,ItemLayer.FORGROUND,forgroundBricksBMD,"pro","",ItemTab.BLOCK,false,true,40,4291782224,["Red","Ruby","Garnet"]));
         _loc2_.addBrick(createBrick(1020,ItemLayer.FORGROUND,forgroundBricksBMD,"pro","",ItemTab.BLOCK,false,true,207,4291722832,["Orange","Copper"]));
         _loc2_.addBrick(createBrick(41,ItemLayer.FORGROUND,forgroundBricksBMD,"pro","",ItemTab.BLOCK,false,true,41,4291995973,["Yellow","Gold","Jasmine"]));
         _loc2_.addBrick(createBrick(38,ItemLayer.FORGROUND,forgroundBricksBMD,"pro","",ItemTab.BLOCK,false,true,38,4283091074,["Green","Emerald","Malachite"]));
         _loc2_.addBrick(createBrick(1019,ItemLayer.FORGROUND,forgroundBricksBMD,"pro","",ItemTab.BLOCK,false,true,206,4283024070,["Blue","Cyan","Light blue","Aquamarine","Turquoise"]));
         _loc2_.addBrick(createBrick(39,ItemLayer.FORGROUND,forgroundBricksBMD,"pro","",ItemTab.BLOCK,false,true,39,4283270342,["Blue","Sapphire"]));
         _loc2_.addBrick(createBrick(37,ItemLayer.FORGROUND,forgroundBricksBMD,"pro","",ItemTab.BLOCK,false,true,37,4291715791,["Purple","Pink","Magenta","Violet","Amethyst"]));
         brickPackages.push(_loc2_);
         var _loc3_:ItemBrickPackage = new ItemBrickPackage("brick","Brick Blocks",["Standard","Wall"]);
         _loc3_.addBrick(createBrick(1090,ItemLayer.FORGROUND,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,262,4287137928,["White","Light"]));
         _loc3_.addBrick(createBrick(1022,ItemLayer.FORGROUND,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,209,4283190348,["Gray","Grey","Concrete","Stone"]));
         _loc3_.addBrick(createBrick(1024,ItemLayer.FORGROUND,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,211,-1,["Black","Dark","Coal"]));
         _loc3_.addBrick(createBrick(20,ItemLayer.FORGROUND,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,20,4285473833,["Red","Maroon","Hell"]));
         _loc3_.addBrick(createBrick(16,ItemLayer.FORGROUND,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,16,4287315465,["Brown","Orange","Soil","Dirt","Mahogany"]));
         _loc3_.addBrick(createBrick(21,ItemLayer.FORGROUND,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,21,4285488420,["Beige","Tan","Olive","Brown","Ecru","Yellow"]));
         _loc3_.addBrick(createBrick(19,ItemLayer.FORGROUND,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,19,4282614544,["Green","Grass"]));
         _loc3_.addBrick(createBrick(17,ItemLayer.FORGROUND,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,17,4280577869,["Blue","Cyan","Turquoise","Teal","Skobeloff","Dark Green"]));
         _loc3_.addBrick(createBrick(1023,ItemLayer.FORGROUND,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,210,-1,["Blue","Dark","Zaffre"]));
         _loc3_.addBrick(createBrick(18,ItemLayer.FORGROUND,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,18,4283311215,["Purple","Dark","Violet"]));
         brickPackages.push(_loc3_);
         var _loc4_:ItemBrickPackage = new ItemBrickPackage("metal","Metal Blocks",["Ore","Standard"]);
         _loc4_.addBrick(createBrick(29,ItemLayer.FORGROUND,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,29,4288783269,["Silver","White","Iron","Platinum"]));
         _loc4_.addBrick(createBrick(30,ItemLayer.FORGROUND,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,30,4292835905,["Orange","Bronze","Amber"]));
         _loc4_.addBrick(createBrick(31,ItemLayer.FORGROUND,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,31,4293962023,["Yellow","Gold","Jasmine"]));
         brickPackages.push(_loc4_);
         var _loc5_:ItemBrickPackage = new ItemBrickPackage("grass","Grass Blocks",["Environment","Nature","Standard","Soil","Ground","Dirt","Flora"]);
         _loc5_.addBrick(createBrick(34,ItemLayer.DECORATION,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,34,4282737427,["Left","Soil"]));
         _loc5_.addBrick(createBrick(35,ItemLayer.FORGROUND,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,35,4282737427,["Middle","Soil"]));
         _loc5_.addBrick(createBrick(36,ItemLayer.DECORATION,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,36,4282737427,["Right","Soil"]));
         brickPackages.push(_loc5_);
         var _loc6_:ItemBrickPackage = new ItemBrickPackage("generic","Generic Blocks",["Special"]);
         _loc6_.addBrick(createBrick(22,ItemLayer.DECORATION,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,22,4287191826,["Caution","Warning","Hazard","Stripes","Yellow","Black","Standard"]));
         _loc6_.addBrick(createBrick(1057,ItemLayer.DECORATION,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,235,-1,["Neutral","Yellow","Body","No face"]));
         _loc6_.addBrick(createBrick(32,ItemLayer.DECORATION,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,32,4291792930,["Face","Smiley","Yellow","Standard"]));
         _loc6_.addBrick(createBrick(1058,ItemLayer.DECORATION,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,236,-1,["Caution","Warning","Hazard","Stripes","Black","Yellow"]));
         _loc6_.addBrick(createBrick(33,ItemLayer.DECORATION,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,33,4278190080,["Black","Dark","Standard"]));
         brickPackages.push(_loc6_);
         var _loc7_:ItemBrickPackage = new ItemBrickPackage("factory","Factory Package");
         _loc7_.addBrick(createBrick(45,ItemLayer.FORGROUND,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,45,4285686091,["X","Crate","Metal","Box","Wood"]));
         _loc7_.addBrick(createBrick(46,ItemLayer.FORGROUND,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,46,4285426528,["Concrete","Grey","Gray","Stone","Slate","X"]));
         _loc7_.addBrick(createBrick(47,ItemLayer.FORGROUND,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,47,4287525711,["Wood","Tree","Wooden","House","Planks","Flooring","Parquet"]));
         _loc7_.addBrick(createBrick(48,ItemLayer.FORGROUND,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,48,4286533419,["X","Crate","Wooden","Box","Wood","Storage"]));
         _loc7_.addBrick(createBrick(49,ItemLayer.FORGROUND,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,49,4285887861,["Silver","Metal","Scales"]));
         brickPackages.push(_loc7_);
         var _loc8_:ItemBrickPackage = new ItemBrickPackage("secrets","Secret Bricks",["Hidden","Invisible"]);
         _loc8_.addBrick(createBrick(44,ItemLayer.FORGROUND,forgroundBricksBMD,"","completely black, makes minimap invisible",ItemTab.BLOCK,false,true,44,16777216,["Black","Pure","Old","Solid"]));
         _loc8_.addBrick(createBrick(50,ItemLayer.DECORATION,specialBricksBMD,"","",ItemTab.BLOCK,false,true,139,0,["Appear"]));
         _loc8_.addBrick(createBrick(243,ItemLayer.DECORATION,specialBricksBMD,"","",ItemTab.BLOCK,false,true,140,16777216,["Blank","Hidden"]));
         _loc8_.addBrick(createBrick(136,ItemLayer.DECORATION,specialBricksBMD,"","",ItemTab.BLOCK,false,false,141,0,["Disappear"]));
         brickPackages.push(_loc8_);
         var _loc9_:ItemBrickPackage = new ItemBrickPackage("glass","Glass bricks",["Bright","Light","Shine","Polish","Neon"]);
         _loc9_.addBrick(createBrick(51,ItemLayer.FORGROUND,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,51,4294480537,["Red","Light red","Pink","Ruby"]));
         _loc9_.addBrick(createBrick(58,ItemLayer.FORGROUND,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,58,4294359700,["Orange","Light orange","Topaz"]));
         _loc9_.addBrick(createBrick(57,ItemLayer.FORGROUND,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,57,4294498956,["Yellow","Light yellow","Jasmine"]));
         _loc9_.addBrick(createBrick(56,ItemLayer.FORGROUND,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,56,4287822762,["Green","Light green","Emerald"]));
         _loc9_.addBrick(createBrick(55,ItemLayer.FORGROUND,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,55,4288011510,["Cyan","Light blue","Diamond"]));
         _loc9_.addBrick(createBrick(54,ItemLayer.FORGROUND,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,54,4286487030,["Blue","Sapphire"]));
         _loc9_.addBrick(createBrick(53,ItemLayer.FORGROUND,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,53,4289169910,["Purple","Violet","Amethyst"]));
         _loc9_.addBrick(createBrick(52,ItemLayer.FORGROUND,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,52,4293495798,["Pink","Magenta","Purple","Quartz"]));
         brickPackages.push(_loc9_);
         var _loc10_:ItemBrickPackage = new ItemBrickPackage("minerals","Minerals",["Neon","Pure","Bright"]);
         _loc10_.addBrick(createBrick(70,ItemLayer.FORGROUND,forgroundBricksBMD,"brickminiral","",ItemTab.BLOCK,false,true,70,4293787648,["Red","Ruby"]));
         _loc10_.addBrick(createBrick(76,ItemLayer.FORGROUND,forgroundBricksBMD,"brickminiral","",ItemTab.BLOCK,false,true,76,4293818112,["Orange","Topaz"]));
         _loc10_.addBrick(createBrick(75,ItemLayer.FORGROUND,forgroundBricksBMD,"brickminiral","",ItemTab.BLOCK,false,true,75,4293848576,["Yellow","Jasmine"]));
         _loc10_.addBrick(createBrick(74,ItemLayer.FORGROUND,forgroundBricksBMD,"brickminiral","",ItemTab.BLOCK,false,true,74,4278251008,["Green","Lime","Emerald","Peridot"]));
         _loc10_.addBrick(createBrick(73,ItemLayer.FORGROUND,forgroundBricksBMD,"brickminiral","",ItemTab.BLOCK,false,true,73,4278251246,["Cyan","Light blue","Aquamarine","Turquoise"]));
         _loc10_.addBrick(createBrick(72,ItemLayer.FORGROUND,forgroundBricksBMD,"brickminiral","",ItemTab.BLOCK,false,true,72,4278190318,["Blue","Indigo","Sapphire","Lapis"]));
         _loc10_.addBrick(createBrick(71,ItemLayer.FORGROUND,forgroundBricksBMD,"brickminiral","",ItemTab.BLOCK,false,true,71,4293787886,["Pink","Magenta","Purple","Amethyst"]));
         brickPackages.push(_loc10_);
         var _loc11_:ItemBrickPackage = new ItemBrickPackage("christmas 2011","Christmas 2011 bricks",["Holiday","Wrapping Paper","Gift","Present"]);
         _loc11_.addBrick(createBrick(78,ItemLayer.FORGROUND,forgroundBricksBMD,"brickxmas2011","",ItemTab.BLOCK,false,true,78,-1,["Yellow"]));
         _loc11_.addBrick(createBrick(79,ItemLayer.FORGROUND,forgroundBricksBMD,"brickxmas2011","",ItemTab.BLOCK,false,true,79,-1,["White"]));
         _loc11_.addBrick(createBrick(80,ItemLayer.FORGROUND,forgroundBricksBMD,"brickxmas2011","",ItemTab.BLOCK,false,true,80,-1,["Red"]));
         _loc11_.addBrick(createBrick(81,ItemLayer.FORGROUND,forgroundBricksBMD,"brickxmas2011","",ItemTab.BLOCK,false,true,81,-1,["Blue"]));
         _loc11_.addBrick(createBrick(82,ItemLayer.FORGROUND,forgroundBricksBMD,"brickxmas2011","",ItemTab.BLOCK,false,true,82,-1,["Green"]));
         brickPackages.push(_loc11_);
         var _loc12_:ItemBrickPackage = new ItemBrickPackage("gravity","Gravity Modifying Arrows",["Physics","Motion","Action","Standard"]);
         _loc12_.addBrick(createBrick(0,ItemLayer.BACKGROUND,forgroundBricksBMD,"","",ItemTab.ACTION,false,false,0,4278190080,["Clear","Empty","Delete","Nothing","Erase"]));
         _loc12_.addBrick(createBrick(1,ItemLayer.DECORATION,forgroundBricksBMD,"","",ItemTab.ACTION,false,false,1,0,["Left","Arrow"]));
         _loc12_.addBrick(createBrick(2,ItemLayer.DECORATION,forgroundBricksBMD,"","",ItemTab.ACTION,false,false,2,0,["Up","Arrow"]));
         _loc12_.addBrick(createBrick(3,ItemLayer.DECORATION,forgroundBricksBMD,"","",ItemTab.ACTION,false,false,3,0,["Right","Arrow"]));
         _loc12_.addBrick(createBrick(1511,ItemLayer.DECORATION,forgroundBricksBMD,"","",ItemTab.ACTION,false,false,285,0,["Down","Arrow"]));
         _loc12_.addBrick(createBrick(4,ItemLayer.DECORATION,forgroundBricksBMD,"","",ItemTab.ACTION,false,false,4,0,["Dot"]));
         _loc12_.addBrick(createBrick(ItemId.SLOW_DOT,ItemLayer.DECORATION,forgroundBricksBMD,"","",ItemTab.ACTION,false,false,233,0,["Slow","Dot","Climbable","Physics"]));
         _loc12_.addBrick(createBrick(411,ItemLayer.DECORATION,specialBricksBMD,"","",ItemTab.ACTION,false,false,312,0,["Invisible","Left","Arrow"]));
         _loc12_.addBrick(createBrick(412,ItemLayer.DECORATION,specialBricksBMD,"","",ItemTab.ACTION,false,false,317,0,["Invisible","Up","Arrow"]));
         _loc12_.addBrick(createBrick(413,ItemLayer.DECORATION,specialBricksBMD,"","",ItemTab.ACTION,false,false,322,0,["Invisible","Right","Arrow"]));
         _loc12_.addBrick(createBrick(1512,ItemLayer.DECORATION,specialBricksBMD,"","",ItemTab.ACTION,false,false,651,0,["Invisible","Down","Arrow"]));
         _loc12_.addBrick(createBrick(414,ItemLayer.DECORATION,specialBricksBMD,"","",ItemTab.ACTION,false,false,327,0,["Invisible","Dot"]));
         _loc12_.addBrick(createBrick(ItemId.SLOW_DOT_INVISIBLE,ItemLayer.DECORATION,specialBricksBMD,"","",ItemTab.ACTION,false,false,466,0,["Slow","Dot","Climbable","Physics","Invisible"]));
         brickPackages.push(_loc12_);
         var _loc13_:ItemBrickPackage = new ItemBrickPackage("keys","Key Blocks",["Key","Lock","Button","Action","Standard"]);
         _loc13_.addBrick(createBrick(6,ItemLayer.DECORATION,forgroundBricksBMD,"","hit to activate key doors and gates for everyone for 6 seconds",ItemTab.ACTION,false,false,6,4281080346,["Red","Key","Magenta"]));
         _loc13_.addBrick(createBrick(7,ItemLayer.DECORATION,forgroundBricksBMD,"","hit to activate key doors and gates for everyone for 6 seconds",ItemTab.ACTION,false,false,7,4279905306,["Green","Key"]));
         _loc13_.addBrick(createBrick(8,ItemLayer.DECORATION,forgroundBricksBMD,"","hit to activate key doors and gates for everyone for 6 seconds",ItemTab.ACTION,false,false,8,4279900716,["Blue","Key"]));
         _loc13_.addBrick(createBrick(408,ItemLayer.DECORATION,forgroundBricksBMD,"","hit to activate key doors and gates for everyone for 6 seconds",ItemTab.ACTION,false,false,189,4278988093,["Cyan","Teal"]));
         _loc13_.addBrick(createBrick(409,ItemLayer.DECORATION,forgroundBricksBMD,"","hit to activate key doors and gates for everyone for 6 seconds",ItemTab.ACTION,false,false,190,4282387520,["Pink","Violet","Purple"]));
         _loc13_.addBrick(createBrick(410,ItemLayer.DECORATION,forgroundBricksBMD,"","hit to activate key doors and gates for everyone for 6 seconds",ItemTab.ACTION,false,false,191,4281086730,["Yellow","Key"]));
         brickPackages.push(_loc13_);
         var _loc14_:ItemBrickPackage = new ItemBrickPackage("gates","Gate Blocks",["Key","Lock","Action","Standard"]);
         _loc14_.addBrick(createBrick(26,ItemLayer.DECORATION,forgroundBricksBMD,"","",ItemTab.ACTION,false,false,26,4288425286,["Red","Magenta"]));
         _loc14_.addBrick(createBrick(27,ItemLayer.DECORATION,forgroundBricksBMD,"","",ItemTab.ACTION,false,false,27,4281834544,["Green"]));
         _loc14_.addBrick(createBrick(28,ItemLayer.DECORATION,forgroundBricksBMD,"","",ItemTab.ACTION,false,false,28,4281156764,["Blue"]));
         _loc14_.addBrick(createBrick(1008,ItemLayer.DECORATION,forgroundBricksBMD,"","",ItemTab.ACTION,false,false,195,4281175449,["Cyan","Teal"]));
         _loc14_.addBrick(createBrick(1009,ItemLayer.DECORATION,forgroundBricksBMD,"","",ItemTab.ACTION,false,false,196,4287704473,["Pink","Purple","Violet"]));
         _loc14_.addBrick(createBrick(1010,ItemLayer.DECORATION,forgroundBricksBMD,"","",ItemTab.ACTION,false,false,197,4288123437,["Yellow"]));
         brickPackages.push(_loc14_);
         var _loc15_:ItemBrickPackage = new ItemBrickPackage("doors","Door Blocks",["Key","Lock","Action","Standard"]);
         _loc15_.addBrick(createBrick(23,ItemLayer.DECORATION,forgroundBricksBMD,"","",ItemTab.ACTION,false,true,23,4288425286,["Red","Magenta"]));
         _loc15_.addBrick(createBrick(24,ItemLayer.DECORATION,forgroundBricksBMD,"","",ItemTab.ACTION,false,true,24,4281834544,["Green"]));
         _loc15_.addBrick(createBrick(25,ItemLayer.DECORATION,forgroundBricksBMD,"","",ItemTab.ACTION,false,true,25,4281156764,["Blue"]));
         _loc15_.addBrick(createBrick(1005,ItemLayer.DECORATION,forgroundBricksBMD,"","",ItemTab.ACTION,false,true,192,4281175449,["Cyan","Teal"]));
         _loc15_.addBrick(createBrick(1006,ItemLayer.DECORATION,forgroundBricksBMD,"","",ItemTab.ACTION,false,true,193,4287704473,["Pink","Purple","Violet"]));
         _loc15_.addBrick(createBrick(1007,ItemLayer.DECORATION,forgroundBricksBMD,"","",ItemTab.ACTION,false,true,194,4288123437,["Yellow"]));
         brickPackages.push(_loc15_);
         var _loc16_:ItemBrickPackage = new ItemBrickPackage("coins","Coin Blocks");
         _loc16_.addBrick(createBrick(100,ItemLayer.ABOVE,specialBricksBMD,"","",ItemTab.ACTION,false,false,0,0,["Gold","G-Coins","Yellow","Money","Primary","Collect","Magic","Value","Standard"]));
         _loc16_.addBrick(createBrick(101,ItemLayer.ABOVE,specialBricksBMD,"","",ItemTab.ACTION,false,false,13,0,["Blue","B-Coin","Secondary","Money","Optional","Collect","Magic","Value","Standard"]));
         _loc16_.addBrick(createBrick(110,ItemLayer.DECORATION,specialBricksBMD,"hidden","",ItemTab.ACTION,false,false,26,0,[],true,true));
         _loc16_.addBrick(createBrick(111,ItemLayer.DECORATION,specialBricksBMD,"hidden","",ItemTab.ACTION,false,false,39,0,[],true,true));
         _loc16_.addBrick(createBrick(ItemId.COINGATE,ItemLayer.DECORATION,forgroundBricksBMD,"","",ItemTab.ACTION,false,false,139,4290285077,["Gate","Yellow","Gold","Primary","Lock"]));
         _loc16_.addBrick(createBrick(ItemId.COINDOOR,ItemLayer.DECORATION,forgroundBricksBMD,"","",ItemTab.ACTION,false,true,43,4290285077,["Door","Yellow","Gold","Primary","Lock"]));
         _loc16_.addBrick(createBrick(ItemId.BLUECOINGATE,ItemLayer.DECORATION,forgroundBricksBMD,"","",ItemTab.ACTION,false,true,186,4280049908,["Gate","Blue","Optional","Lock"]));
         _loc16_.addBrick(createBrick(ItemId.BLUECOINDOOR,ItemLayer.DECORATION,forgroundBricksBMD,"","",ItemTab.ACTION,false,true,185,4280049908,["Door","Blue","Optional","Lock"]));
         brickPackages.push(_loc16_);
         var _loc17_:ItemBrickPackage = new ItemBrickPackage("tools","Tool Blocks");
         _loc17_.addBrick(createBrick(255,ItemLayer.DECORATION,decorationsBMD,"","players spawn here",ItemTab.ACTION,false,true,255 - 128,0,["Spawn","Start","Beginning","Enter"]));
         _loc17_.addBrick(createBrick(ItemId.CHECKPOINT,ItemLayer.DECORATION,specialBricksBMD,"","players respawn here when they die",ItemTab.ACTION,false,false,154,0,["Checkpoint","Respawn","Safe","Enter","Save"]));
         _loc17_.addBrick(createBrick(ItemId.BRICK_COMPLETE,ItemLayer.ABOVE,completeBMD,"","gives the player a silver crown, displays a win message",ItemTab.ACTION,false,false,0,0,["Trophy","Win","Complete","Finish","End","Reward"]));
         _loc17_.addBrick(createBrick(ItemId.RESET_POINT,ItemLayer.ABOVE,decorationsBMD,"","resets the player\'s progress",ItemTab.ACTION,false,false,288,0,["Reset","Restart","Retry"]));
         brickPackages.push(_loc17_);
         var _loc18_:ItemBrickPackage = new ItemBrickPackage("crown","Crown");
         _loc18_.addBrick(createBrick(5,ItemLayer.DECORATION,forgroundBricksBMD,"","awards the player a golden crown",ItemTab.ACTION,false,true,5,4282595615,["Crown","King","Gold","Action","Prize","Reward"]));
         _loc18_.addBrick(createBrick(ItemId.CROWNDOOR,ItemLayer.DECORATION,doorsBMD,"brickcrowndoor","",ItemTab.ACTION,false,true,41,0,["Crown","Door","Gold","Yellow","Lock"]));
         _loc18_.addBrick(createBrick(ItemId.CROWNGATE,ItemLayer.DECORATION,doorsBMD,"brickcrowndoor","",ItemTab.ACTION,false,true,40,0,["Crown","Gate","Gold","Yellow","Lock"]));
         brickPackages.push(_loc18_);
         var _loc19_:ItemBrickPackage = new ItemBrickPackage("boost","Boost Arrows",["Speed","Fast","Friction","Arrow","Motion","Action","Physics"]);
         _loc19_.addBrick(createBrick(ItemId.SPEED_LEFT,ItemLayer.DECORATION,forgroundBricksBMD,"brickboost","",ItemTab.ACTION,false,false,157,0,["Left"]));
         _loc19_.addBrick(createBrick(ItemId.SPEED_UP,ItemLayer.DECORATION,forgroundBricksBMD,"brickboost","",ItemTab.ACTION,false,false,159,0,["Up","Above"]));
         _loc19_.addBrick(createBrick(ItemId.SPEED_RIGHT,ItemLayer.DECORATION,forgroundBricksBMD,"brickboost","",ItemTab.ACTION,false,false,158,0,["Right"]));
         _loc19_.addBrick(createBrick(ItemId.SPEED_DOWN,ItemLayer.DECORATION,forgroundBricksBMD,"brickboost","",ItemTab.ACTION,false,false,160,0,["Down","Below"]));
         brickPackages.push(_loc19_);
         var _loc20_:ItemBrickPackage = new ItemBrickPackage("climbable","Climbable Blocks",["Transportation","No","Gravity","Slow"]);
         _loc20_.addBrick(createBrick(ItemId.CHAIN,ItemLayer.DECORATION,forgroundBricksBMD,"brickmedieval","",ItemTab.ACTION,false,true,135,0,["Chain","Vertical","Ninja"]));
         _loc20_.addBrick(createBrick(ItemId.NINJA_LADDER,ItemLayer.DECORATION,forgroundBricksBMD,"brickninja","",ItemTab.ACTION,false,false,98,0,["Ladder","Vertical","Ninja"]));
         _loc20_.addBrick(createBrick(ItemId.VINE_V,ItemLayer.DECORATION,forgroundBricksBMD,"","",ItemTab.ACTION,false,true,174,0,["Vine","Vertical","Jungle","Environment"]));
         _loc20_.addBrick(createBrick(ItemId.VINE_H,ItemLayer.DECORATION,forgroundBricksBMD,"","",ItemTab.ACTION,false,true,175,0,["Vine","Horizontal","Jungle","Environment"]));
         _loc20_.addBrick(createBrick(ItemId.ROPE,ItemLayer.DECORATION,decorationsBMD,"brickcowboy","",ItemTab.ACTION,false,true,266,0,["Rope","Vertical","Medieval","Ninja"]));
         _loc20_.addBrick(createBrick(ItemId.FAIRYTALE_LADDER,ItemLayer.DECORATION,forgroundBricksBMD,"brickfairytale","",ItemTab.ACTION,false,true,252,0,["Ladder","Vine","Fairytale"]));
         brickPackages.push(_loc20_);
         var _loc21_:ItemBrickPackage = new ItemBrickPackage("switches","Switches",["Lock","Action"]);
         _loc21_.addBrick(createBrick(ItemId.SWITCH_PURPLE,ItemLayer.DECORATION,specialBricksBMD,"brickswitchpurple","",ItemTab.ACTION,false,true,310,0,["Lever","Button","Purple","Violet"]));
         _loc21_.addBrick(createBrick(ItemId.GATE_PURPLE,ItemLayer.DECORATION,doorsBMD,"brickswitchpurple","",ItemTab.ACTION,false,false,8,4284760474,["Gate","Purple","Violet"]));
         _loc21_.addBrick(createBrick(ItemId.DOOR_PURPLE,ItemLayer.DECORATION,doorsBMD,"brickswitchpurple","",ItemTab.ACTION,false,false,9,4284760474,["Door","Purple","Violet"]));
         _loc21_.addBrick(createBrick(ItemId.SWITCH_ORANGE,ItemLayer.DECORATION,specialBricksBMD,"brickswitchorange","",ItemTab.ACTION,false,true,422,0,["Lever","Button","Orange"]));
         _loc21_.addBrick(createBrick(ItemId.GATE_ORANGE,ItemLayer.DECORATION,doorsBMD,"brickswitchorange","",ItemTab.ACTION,false,false,38,4292305967,["Gate","Orange"]));
         _loc21_.addBrick(createBrick(ItemId.DOOR_ORANGE,ItemLayer.DECORATION,doorsBMD,"brickswitchorange","",ItemTab.ACTION,false,false,39,4292305967,["Door","Orange"]));
         brickPackages.push(_loc21_);
         var _loc22_:ItemBrickPackage = new ItemBrickPackage("death","Death Doors/Gates (+10)",["Lock","Die","Skull","Curse"]);
         _loc22_.addBrick(createBrick(ItemId.DEATH_GATE,ItemLayer.DECORATION,forgroundBricksBMD,"brickdeathdoor","",ItemTab.ACTION,false,false,198,4289309097,["Gate","Off"]));
         _loc22_.addBrick(createBrick(ItemId.DEATH_DOOR,ItemLayer.DECORATION,forgroundBricksBMD,"brickdeathdoor","",ItemTab.ACTION,false,false,199,4289309097,["Door","On"]));
         brickPackages.push(_loc22_);
         var _loc23_:ItemBrickPackage = new ItemBrickPackage("zombie","Zombie Blocks",["Blue","Grey","Gray"]);
         _loc23_.addBrick(createBrick(ItemId.EFFECT_ZOMBIE,ItemLayer.DECORATION,effectBricksBMD,"brickeffectzombie","infects the player with a horrible disease",ItemTab.ACTION,false,false,5,0,["Effect","Death","Slow"]));
         _loc23_.addBrick(createBrick(ItemId.ZOMBIE_GATE,ItemLayer.DECORATION,doorsBMD,"brickeffectzombie","",ItemTab.ACTION,false,false,12,4284642431,["Gate"]));
         _loc23_.addBrick(createBrick(ItemId.ZOMBIE_DOOR,ItemLayer.DECORATION,doorsBMD,"brickeffectzombie","",ItemTab.ACTION,false,false,13,4284642431,["Door"]));
         brickPackages.push(_loc23_);
         var _loc24_:ItemBrickPackage = new ItemBrickPackage("teams","Team effect (+10)",["Team","Grey","Gray"]);
         _loc24_.addBrick(createBrick(ItemId.EFFECT_TEAM,ItemLayer.DECORATION,effectBricksBMD,"brickeffectteam","sets the player\'s team to the specified color",ItemTab.ACTION,false,false,6,0,["Effect","Separation"]));
         _loc24_.addBrick(createBrick(ItemId.TEAM_GATE,ItemLayer.DECORATION,doorsBMD,"brickeffectteam","",ItemTab.ACTION,false,false,29,0,["Gate","Lock","Off"]));
         _loc24_.addBrick(createBrick(ItemId.TEAM_DOOR,ItemLayer.DECORATION,doorsBMD,"brickeffectteam","",ItemTab.ACTION,false,false,22,0,["Door","Lock","On"]));
         brickPackages.push(_loc24_);
         var _loc25_:ItemBrickPackage = new ItemBrickPackage("timed","Timed Doors (+10)",["Lock","Wait","Door","Gate","Grey","Gray"]);
         _loc25_.addBrick(createBrick(ItemId.TIMEGATE,ItemLayer.DECORATION,specialBricksBMD,"bricktimeddoor","",ItemTab.ACTION,false,false,337,-1,["Off"]));
         _loc25_.addBrick(createBrick(ItemId.TIMEDOOR,ItemLayer.DECORATION,specialBricksBMD,"bricktimeddoor","",ItemTab.ACTION,false,true,332,-1,["On"]));
         brickPackages.push(_loc25_);
         var _loc26_:ItemBrickPackage = new ItemBrickPackage("music","Music Blocks",["Sound","Entertainment","Note","Melody","Instrument"]);
         _loc26_.addBrick(createBrick(77,ItemLayer.DECORATION,forgroundBricksBMD,"bricknode","plays a sound when touched",ItemTab.ACTION,false,false,77,0,["Piano","Note","Maestro"]));
         _loc26_.addBrick(createBrick(83,ItemLayer.DECORATION,forgroundBricksBMD,"brickdrums","plays a sound when touched",ItemTab.ACTION,false,false,83,0,["Drums"]));
         brickPackages.push(_loc26_);
         var _loc27_:ItemBrickPackage = new ItemBrickPackage("hazards","Hazard Blocks",["Kill","Die","Respawn","Death","Trap","Fatal","Deadly"]);
         _loc27_.addBrick(createBrick(ItemId.SPIKE,ItemLayer.DECORATION,specialBricksBMD,"brickspike","kills the player",ItemTab.ACTION,false,false,157,0,["Spikes","Morphable"]));
         _loc27_.addBrick(createBrick(ItemId.FIRE,ItemLayer.ABOVE,specialBricksBMD,"brickfire","kills the player",ItemTab.ACTION,false,false,188,0,["Fire","Burn","Flames","Animated","Hell"]));
         brickPackages.push(_loc27_);
         var _loc28_:ItemBrickPackage = new ItemBrickPackage("liquids","Liquid Blocks",["Transportation","Swim","Fluid","Action","Environment"]);
         _loc28_.addBrick(createBrick(ItemId.WATER,ItemLayer.ABOVE,specialBricksBMD,"","",ItemTab.ACTION,false,false,196,0,["Water","Blue","Up","Float"]));
         _loc28_.addBrick(createBrick(ItemId.LAVA,ItemLayer.ABOVE,specialBricksBMD,"bricklava","sets the player on fire and kills",ItemTab.ACTION,false,false,218,0,["Lava","Hazard","Die","Orange","Death","Burn","Sink","Hell"]));
         _loc28_.addBrick(createBrick(ItemId.MUD,ItemLayer.ABOVE,mudBMD,"brickswamp","slows the player down",ItemTab.ACTION,false,false,0,0,["Swamp","Bog","Slow","Brown","Sink"]));
         brickPackages.push(_loc28_);
         var _loc29_:ItemBrickPackage = new ItemBrickPackage("portals","Portal Blocks",["Teleport"]);
         _loc29_.addBrick(createBrick(ItemId.PORTAL_INVISIBLE,ItemLayer.DECORATION,specialBricksBMD,"brickinvisibleportal","teleports the player to another portal",ItemTab.ACTION,false,true,138,0,["Invisible","Secrets","Hidden"]));
         _loc29_.addBrick(createBrick(242,ItemLayer.DECORATION,specialBricksBMD,"brickportal","teleports the player to another portal",ItemTab.ACTION,false,true,52,-1,["Visible","Blue"]));
         _loc29_.addBrick(createBrick(ItemId.WORLD_PORTAL,ItemLayer.DECORATION,specialBricksBMD,"brickworldportal","teleports the player to another world",ItemTab.ACTION,true,true,113,-1,["World","Red"]));
         brickPackages.push(_loc29_);
         var _loc30_:ItemBrickPackage = new ItemBrickPackage("diamond","Diamond (+1)",["Exclusive"]);
         _loc30_.addBrick(createBrick(ItemId.DIAMOND,ItemLayer.DECORATION,decorationsBMD,"brickdiamond","changes the player\'s smiley to diamond",ItemTab.ACTION,true,true,241 - 128,-1,["Luxury","Smiley","Expensive","Gray","Animated","Shiny","Grey"],false,true));
         brickPackages.push(_loc30_);
         var _loc31_:ItemBrickPackage = new ItemBrickPackage("cake","Cake");
         _loc31_.addBrick(createBrick(ItemId.CAKE,ItemLayer.DECORATION,specialBricksBMD,"brickcake","changes the player\'s smiley to party hat",ItemTab.ACTION,true,true,298,0,["Party","Birthday","Smiley","Hat","Animated","Food"]));
         brickPackages.push(_loc31_);
         var _loc32_:ItemBrickPackage = new ItemBrickPackage("hologram","Hologram");
         _loc32_.addBrick(createBrick(ItemId.HOLOGRAM,ItemLayer.DECORATION,specialBricksBMD,"brickhologram","changes the player\'s smiley to hologram",ItemTab.ACTION,true,true,279,1718026239,["Sci-fi","Blue","Transparent","Smiley","Future","Animated"]));
         brickPackages.push(_loc32_);
         var _loc33_:ItemBrickPackage = new ItemBrickPackage("christmas 2010","Christmas 2010 Blocks",["Holiday","Xmas","Winter"]);
         _loc33_.addBrick(createBrick(249,ItemLayer.ABOVE,decorationsBMD,"brickchristmas2010","",ItemTab.DECORATIVE,false,false,249 - 128,0,["Snow","Left","Corner","Snowdrift","Environment"]));
         _loc33_.addBrick(createBrick(250,ItemLayer.ABOVE,decorationsBMD,"brickchristmas2010","",ItemTab.DECORATIVE,false,false,250 - 128,0,["Snow","Right","Corner","Snowdrift","Environment"]));
         _loc33_.addBrick(createBrick(251,ItemLayer.ABOVE,decorationsBMD,"brickchristmas2010","",ItemTab.DECORATIVE,false,false,251 - 128,0,["Tree","Plant","Nature","Spruce","Environment"]));
         _loc33_.addBrick(createBrick(252,ItemLayer.ABOVE,decorationsBMD,"brickchristmas2010","",ItemTab.DECORATIVE,false,false,252 - 128,0,["Tree","Snow","Plant","Lights","Spruce","Nature","Environment"]));
         _loc33_.addBrick(createBrick(253,ItemLayer.ABOVE,decorationsBMD,"brickchristmas2010","",ItemTab.DECORATIVE,false,false,253 - 128,0,["Fence","Snow","Wood"]));
         _loc33_.addBrick(createBrick(254,ItemLayer.ABOVE,decorationsBMD,"brickchristmas2010","",ItemTab.DECORATIVE,false,false,254 - 128,0,["Fence","Wood"]));
         brickPackages.push(_loc33_);
         var _loc34_:ItemBrickPackage = new ItemBrickPackage("new year 2010","New Year 2010",["Holiday","Baubles","Ornament","Light","Bulb"]);
         _loc34_.addBrick(createBrick(244,ItemLayer.DECORATION,decorationsBMD,"mixednewyear2010","",ItemTab.DECORATIVE,false,true,244 - 128,0,["Pink","Violet","Purple"]));
         _loc34_.addBrick(createBrick(245,ItemLayer.DECORATION,decorationsBMD,"mixednewyear2010","",ItemTab.DECORATIVE,false,true,245 - 128,0,["Yellow"]));
         _loc34_.addBrick(createBrick(246,ItemLayer.DECORATION,decorationsBMD,"mixednewyear2010","",ItemTab.DECORATIVE,false,true,246 - 128,0,["Blue"]));
         _loc34_.addBrick(createBrick(247,ItemLayer.DECORATION,decorationsBMD,"mixednewyear2010","",ItemTab.DECORATIVE,false,true,247 - 128,0,["Red"]));
         _loc34_.addBrick(createBrick(248,ItemLayer.DECORATION,decorationsBMD,"mixednewyear2010","",ItemTab.DECORATIVE,false,true,248 - 128,0,["Green"]));
         brickPackages.push(_loc34_);
         var _loc35_:ItemBrickPackage = new ItemBrickPackage("spring 2011","Spring package 2011",["Season","Nature","Plant","Environment"]);
         _loc35_.addBrick(createBrick(233,ItemLayer.ABOVE,decorationsBMD,"brickspring2011","",ItemTab.DECORATIVE,false,false,233 - 128,0,["Grass","Left","Grass","Short"]));
         _loc35_.addBrick(createBrick(234,ItemLayer.ABOVE,decorationsBMD,"brickspring2011","",ItemTab.DECORATIVE,false,false,234 - 128,0,["Grass","Middle","Short"]));
         _loc35_.addBrick(createBrick(235,ItemLayer.ABOVE,decorationsBMD,"brickspring2011","",ItemTab.DECORATIVE,false,false,235 - 128,0,["Grass","Right","Short"]));
         _loc35_.addBrick(createBrick(236,ItemLayer.ABOVE,decorationsBMD,"brickspring2011","",ItemTab.DECORATIVE,false,false,236 - 128,0,["Grass","Hedge","Left","Big","Tall Grass","Bush"]));
         _loc35_.addBrick(createBrick(237,ItemLayer.ABOVE,decorationsBMD,"brickspring2011","",ItemTab.DECORATIVE,false,false,237 - 128,0,["Grass","Hedge","Middle","Big","Tall Grass","Bush"]));
         _loc35_.addBrick(createBrick(238,ItemLayer.ABOVE,decorationsBMD,"brickspring2011","",ItemTab.DECORATIVE,false,false,238 - 128,0,["Grass","Hedge","Right","Big","Tall Grass","Bush"]));
         _loc35_.addBrick(createBrick(239,ItemLayer.ABOVE,decorationsBMD,"brickspring2011","",ItemTab.DECORATIVE,false,false,239 - 128,0,["Flower","Sun","Yellow","Flora"]));
         _loc35_.addBrick(createBrick(240,ItemLayer.ABOVE,decorationsBMD,"brickspring2011","",ItemTab.DECORATIVE,false,false,240 - 128,0,["Bush","Plant","Shrub","Flora"]));
         brickPackages.push(_loc35_);
         var _loc36_:ItemBrickPackage = new ItemBrickPackage("Prizes","Your Prizes",["Prize"]);
         _loc36_.addBrick(createBrick(223,ItemLayer.ABOVE,decorationsBMD,"brickhwtrophy","trophy for the Halloween 2017 contest winners",ItemTab.DECORATIVE,false,false,95,0,["Cup","Trophy","Halloween","Gold","Thanel"],false,true));
         _loc36_.addBrick(createBrick(478,ItemLayer.ABOVE,decorationsBMD,"brickspringtrophybronze","prize for winning third place in the Spring 2017 contest",ItemTab.DECORATIVE,false,false,298,0,["Trophy","Bronze","Spring","Flower"],false,true));
         _loc36_.addBrick(createBrick(479,ItemLayer.ABOVE,decorationsBMD,"brickspringtrophysilver","prize for winning second place in the Spring 2017 contest ",ItemTab.DECORATIVE,false,false,297,0,["Trophy","Silver","Spring","Flower"],false,true));
         _loc36_.addBrick(createBrick(480,ItemLayer.ABOVE,decorationsBMD,"brickspringtrophygold","prize for winning first place in the Spring 2017 contest",ItemTab.DECORATIVE,false,false,296,0,["Trophy","Gold","Spring","Flower"],false,true));
         _loc36_.addBrick(createBrick(484,ItemLayer.ABOVE,decorationsBMD,"bricksummertrophybronze","prize for winning third place in the Summer 2017 contest",ItemTab.DECORATIVE,false,false,301,0,["Trophy","Bronze","Summer","Sun"],false,true));
         _loc36_.addBrick(createBrick(485,ItemLayer.ABOVE,decorationsBMD,"bricksummertrophysilver","prize for winning second place in the Summer 2017 contest ",ItemTab.DECORATIVE,false,false,300,0,["Trophy","Silver","Summer","Sun"],false,true));
         _loc36_.addBrick(createBrick(486,ItemLayer.ABOVE,decorationsBMD,"bricksummertrophygold","prize for winning first place in the Summer 2017 contest",ItemTab.DECORATIVE,false,false,299,0,["Trophy","Gold","Summer","Sun"],false,true));
         brickPackages.push(_loc36_);
         var _loc37_:ItemBrickPackage = new ItemBrickPackage("easter 2012","Easter  decorations 2012",["Holiday","Decor","Egg"]);
         _loc37_.addBrick(createBrick(256,ItemLayer.ABOVE,decorationsBMD,"brickeaster2012","",ItemTab.DECORATIVE,false,false,256 - 128,0,["Cyan","Teal","Wavy"]));
         _loc37_.addBrick(createBrick(257,ItemLayer.ABOVE,decorationsBMD,"brickeaster2012","",ItemTab.DECORATIVE,false,false,257 - 128,0,["Pink","Wavy"]));
         _loc37_.addBrick(createBrick(258,ItemLayer.ABOVE,decorationsBMD,"brickeaster2012","",ItemTab.DECORATIVE,false,false,258 - 128,0,["Green","Line","Yellow"]));
         _loc37_.addBrick(createBrick(259,ItemLayer.ABOVE,decorationsBMD,"brickeaster2012","",ItemTab.DECORATIVE,false,false,259 - 128,0,["Pink","Stripes"]));
         _loc37_.addBrick(createBrick(260,ItemLayer.ABOVE,decorationsBMD,"brickeaster2012","",ItemTab.DECORATIVE,false,false,260 - 128,0,["Green","Dots"]));
         brickPackages.push(_loc37_);
         var _loc38_:ItemBrickPackage = new ItemBrickPackage("basic","Basic Background Blocks");
         _loc38_.addBrick(createBrick(715,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,false,209,-1,["White","Light"]));
         _loc38_.addBrick(createBrick(500,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,false,500 - 500,-1,["Gray","Grey"]));
         _loc38_.addBrick(createBrick(645,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,false,139,-1,["Black","Dark","Shadow"]));
         _loc38_.addBrick(createBrick(503,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,false,503 - 500,-1,["Red"]));
         _loc38_.addBrick(createBrick(644,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,false,138,-1,["Orange"]));
         _loc38_.addBrick(createBrick(504,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,false,504 - 500,-1,["Yellow","Lime","Green"]));
         _loc38_.addBrick(createBrick(505,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,false,505 - 500,-1,["Green","Backdrop"]));
         _loc38_.addBrick(createBrick(506,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,false,506 - 500,-1,["Cyan","Teal","Turquoise","Blue"]));
         _loc38_.addBrick(createBrick(501,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,false,501 - 500,-1,["Blue"]));
         _loc38_.addBrick(createBrick(502,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,false,502 - 500,-1,["Purple","Magenta","Pink","Violet"]));
         brickPackages.push(_loc38_);
         var _loc39_:ItemBrickPackage = new ItemBrickPackage("brick","Brick Background Blocks");
         _loc39_.addBrick(createBrick(716,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,false,210,4284177243,["White","Light"]));
         _loc39_.addBrick(createBrick(646,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,true,140,4280821800,["Gray","Grey"]));
         _loc39_.addBrick(createBrick(648,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,true,142,4279176975,["Black","Dark","Shadow"]));
         _loc39_.addBrick(createBrick(511,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,false,11,-1,["Red"]));
         _loc39_.addBrick(createBrick(507,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,false,7,-1,["Orange","Brown","Dirt","Soil"]));
         _loc39_.addBrick(createBrick(512,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,false,12,-1,["Yellow","Soil","Brown"]));
         _loc39_.addBrick(createBrick(510,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,false,10,-1,["Green","Lime"]));
         _loc39_.addBrick(createBrick(508,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,false,8,-1,["Cyan","Teal","Turquoise","Blue"]));
         _loc39_.addBrick(createBrick(647,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,true,141,-1,["Blue"]));
         _loc39_.addBrick(createBrick(509,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,false,9,-1,["Magenta","Purple","Violet"]));
         brickPackages.push(_loc39_);
         var _loc40_:ItemBrickPackage = new ItemBrickPackage("checker","Checker Backgrounds",["Checkered"]);
         _loc40_.addBrick(createBrick(718,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,false,212,-1,["White","Light"]));
         _loc40_.addBrick(createBrick(513,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,false,513 - 500,-1,["Gray","Grey","Shadow"]));
         _loc40_.addBrick(createBrick(650,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,true,144,-1,["Black","Dark","Shadow"]));
         _loc40_.addBrick(createBrick(516,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,false,516 - 500,-1,["Red","Pink"]));
         _loc40_.addBrick(createBrick(649,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,true,143,-1,["Orange"]));
         _loc40_.addBrick(createBrick(517,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,false,517 - 500,-1,["Yellow","Lime"]));
         _loc40_.addBrick(createBrick(518,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,false,518 - 500,-1,["Green"]));
         _loc40_.addBrick(createBrick(519,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,false,519 - 500,-1,["Cyan","Teal","Turquoise","Blue"]));
         _loc40_.addBrick(createBrick(514,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,false,514 - 500,-1,["Blue"]));
         _loc40_.addBrick(createBrick(515,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,false,515 - 500,-1,["Purple","Magenta","Pink","Violet"]));
         brickPackages.push(_loc40_);
         var _loc41_:ItemBrickPackage = new ItemBrickPackage("dark","Solid Dark Backgrounds",["Solid"]);
         _loc41_.addBrick(createBrick(719,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,false,213,-1,["White","Light"]));
         _loc41_.addBrick(createBrick(520,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,false,520 - 500,-1,["Gray","Grey","Shadow"]));
         _loc41_.addBrick(createBrick(652,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,true,146,-1,["Black","Dark","Shadow"]));
         _loc41_.addBrick(createBrick(523,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,false,523 - 500,-1,["Red"]));
         _loc41_.addBrick(createBrick(651,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,true,145,-1,["Orange"]));
         _loc41_.addBrick(createBrick(524,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,false,524 - 500,-1,["Yellow","Lime"]));
         _loc41_.addBrick(createBrick(525,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,false,525 - 500,-1,["Green"]));
         _loc41_.addBrick(createBrick(526,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,false,526 - 500,-1,["Cyan","Teal","Turquoise","Blue"]));
         _loc41_.addBrick(createBrick(521,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,false,521 - 500,-1,["Blue"]));
         _loc41_.addBrick(createBrick(522,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,false,522 - 500,-1,["Purple","Magenta","Pink","Violet"]));
         brickPackages.push(_loc41_);
         var _loc42_:ItemBrickPackage = new ItemBrickPackage("normal","Solid backrounds",["Solid"]);
         _loc42_.addBrick(createBrick(717,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,false,211,-1,["White","Light"]));
         _loc42_.addBrick(createBrick(610,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,true,110,-1,["Gray","Grey","Shadow"]));
         _loc42_.addBrick(createBrick(654,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,true,148,-1,["Black","Dark","Shadow"]));
         _loc42_.addBrick(createBrick(613,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,true,113,-1,["Red"]));
         _loc42_.addBrick(createBrick(653,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,true,147,-1,["Orange"]));
         _loc42_.addBrick(createBrick(614,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,true,114,-1,["Yellow","Lime"]));
         _loc42_.addBrick(createBrick(615,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,true,115,-1,["Green"]));
         _loc42_.addBrick(createBrick(616,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,true,116,-1,["Cyan","Teal","Turquoise","Blue"]));
         _loc42_.addBrick(createBrick(611,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,true,111,-1,["Blue"]));
         _loc42_.addBrick(createBrick(612,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,true,112,-1,["Purple","Magenta","Pink","Violet"]));
         brickPackages.push(_loc42_);
         var _loc43_:ItemBrickPackage = new ItemBrickPackage("pastel","Pretty Pastel Backgrounds",["Solid"]);
         _loc43_.addBrick(createBrick(743,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,false,237,-1,["White","Light","Bright"]));
         _loc43_.addBrick(createBrick(744,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,false,238,-1,["Dark","Black"]));
         _loc43_.addBrick(createBrick(532,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,false,32,-1,["Pink","Red","Magenta"]));
         _loc43_.addBrick(createBrick(676,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,false,170,-1,["Orange"]));
         _loc43_.addBrick(createBrick(527,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,false,27,-1,["Yellow"]));
         _loc43_.addBrick(createBrick(529,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,false,29,-1,["Yellow","Green","Lime"]));
         _loc43_.addBrick(createBrick(528,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,false,28,-1,["Green"]));
         _loc43_.addBrick(createBrick(530,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,false,30,-1,["Cyan","Light Blue","Sky"]));
         _loc43_.addBrick(createBrick(531,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,false,31,-1,["Blue","Sky"]));
         _loc43_.addBrick(createBrick(677,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,false,171,-1,["Purple"]));
         brickPackages.push(_loc43_);
         var _loc44_:ItemBrickPackage = new ItemBrickPackage("canvas","Canvas Backgrounds",["Rough","Textured"]);
         _loc44_.addBrick(createBrick(538,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickbgcanvas","",ItemTab.BACKGROUND,false,false,38,-1,["Gray","Grey"]));
         _loc44_.addBrick(createBrick(671,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickbgcanvas","",ItemTab.BACKGROUND,false,false,165,-1,["Red"]));
         _loc44_.addBrick(createBrick(533,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickbgcanvas","",ItemTab.BACKGROUND,false,false,33,-1,["Orange"]));
         _loc44_.addBrick(createBrick(534,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickbgcanvas","",ItemTab.BACKGROUND,false,false,34,-1,["Beige","Brown","Tan"]));
         _loc44_.addBrick(createBrick(535,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickbgcanvas","",ItemTab.BACKGROUND,false,false,35,-1,["Yellow"]));
         _loc44_.addBrick(createBrick(536,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickbgcanvas","",ItemTab.BACKGROUND,false,false,36,-1,["Green"]));
         _loc44_.addBrick(createBrick(537,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickbgcanvas","",ItemTab.BACKGROUND,false,false,37,-1,["Cyan","Light Blue","Water"]));
         _loc44_.addBrick(createBrick(606,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickbgcanvas","",ItemTab.BACKGROUND,false,false,106,-1,["Blue"]));
         _loc44_.addBrick(createBrick(672,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickbgcanvas","",ItemTab.BACKGROUND,false,false,166,-1,["Purple","Violet"]));
         brickPackages.push(_loc44_);
         var _loc45_:ItemBrickPackage = new ItemBrickPackage("carnival","Carnival backgrounds");
         _loc45_.addBrick(createBrick(545,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickbgcarnival","",ItemTab.BACKGROUND,false,false,45,-1,["Stripes","Red","Yellow","McDonald\'s"]));
         _loc45_.addBrick(createBrick(546,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickbgcarnival","",ItemTab.BACKGROUND,false,false,46,-1,["Stripes","Purple","Violet","Dark"]));
         _loc45_.addBrick(createBrick(547,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickbgcarnival","",ItemTab.BACKGROUND,false,false,47,-1,["Magenta","Pink"]));
         _loc45_.addBrick(createBrick(548,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickbgcarnival","",ItemTab.BACKGROUND,false,false,48,-1,["Checker","Black","White","Double"]));
         _loc45_.addBrick(createBrick(549,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickbgcarnival","",ItemTab.BACKGROUND,false,false,49,-1,["Green"]));
         _loc45_.addBrick(createBrick(558,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickbgcarnival","",ItemTab.BACKGROUND,false,false,58,-1,["Yellow"]));
         _loc45_.addBrick(createBrick(563,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickbgcarnival","",ItemTab.BACKGROUND,false,false,63,-1,["Poland","Stripes","Red","White"]));
         _loc45_.addBrick(createBrick(607,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickbgcarnival","",ItemTab.BACKGROUND,false,false,107,-1,["Blue","Solid"]));
         brickPackages.push(_loc45_);
         var _loc46_:ItemBrickPackage = new ItemBrickPackage("candy","CandyLand",["Sweet","Sugar","Food"]);
         _loc46_.addBrick(createBrick(60,ItemLayer.FORGROUND,forgroundBricksBMD,"brickcandy","",ItemTab.BLOCK,false,true,60,-1,["Pink","Cotton Candy","Fairy Floss","Stripes","Pastel"]));
         _loc46_.addBrick(createBrick(61,ItemLayer.DECORATION,forgroundBricksBMD,"brickcandy","",ItemTab.BLOCK,false,true,61,-1,["Platform","Magenta","Pink","One-Way"]));
         _loc46_.addBrick(createBrick(62,ItemLayer.DECORATION,forgroundBricksBMD,"brickcandy","",ItemTab.BLOCK,false,true,62,-1,["Platform","Red","One-Way","One way"]));
         _loc46_.addBrick(createBrick(63,ItemLayer.DECORATION,forgroundBricksBMD,"brickcandy","",ItemTab.BLOCK,false,true,63,-1,["Platform","Cyan","One-Way","One way"]));
         _loc46_.addBrick(createBrick(64,ItemLayer.DECORATION,forgroundBricksBMD,"brickcandy","",ItemTab.BLOCK,false,true,64,-1,["Platform","Green","One-Way","One way"]));
         _loc46_.addBrick(createBrick(65,ItemLayer.DECORATION,forgroundBricksBMD,"brickcandy","",ItemTab.BLOCK,false,true,65,-1,["Candy","Cane","Red","White","Stripes"]));
         _loc46_.addBrick(createBrick(66,ItemLayer.DECORATION,forgroundBricksBMD,"brickcandy","",ItemTab.BLOCK,false,true,66,-1,["Cake","Licorice","Hamburger","Sandwich","Stripes"]));
         _loc46_.addBrick(createBrick(67,ItemLayer.DECORATION,forgroundBricksBMD,"brickcandy","",ItemTab.BLOCK,false,true,67,-1,["Gingerbread","Chocolate","Brown","Cake","Dirt"]));
         _loc46_.addBrick(createBrick(227,ItemLayer.ABOVE,decorationsBMD,"brickcandy","",ItemTab.DECORATIVE,false,false,99,0,["Cream","Small","Creme","Whipped Topping","White"]));
         _loc46_.addBrick(createBrick(431,ItemLayer.ABOVE,decorationsBMD,"brickcandy","",ItemTab.DECORATIVE,false,false,273,0,["Cream","Big","Creme","Whipped Topping","White"]));
         _loc46_.addBrick(createBrick(432,ItemLayer.ABOVE,decorationsBMD,"brickcandy","",ItemTab.DECORATIVE,false,false,274,0,["Gumdrop","Red"]));
         _loc46_.addBrick(createBrick(433,ItemLayer.ABOVE,decorationsBMD,"brickcandy","",ItemTab.DECORATIVE,false,false,275,0,["Gumdrop","Green"]));
         _loc46_.addBrick(createBrick(434,ItemLayer.ABOVE,decorationsBMD,"brickcandy","",ItemTab.DECORATIVE,false,false,276,0,["Gumdrop","Pink"]));
         _loc46_.addBrick(createBrick(539,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickcandy","",ItemTab.BACKGROUND,false,false,39,-1,["Stripes","Pink","Pastel"]));
         _loc46_.addBrick(createBrick(540,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickcandy","",ItemTab.BACKGROUND,false,false,40,-1,["Stripes","Blue","Pastel"]));
         brickPackages.push(_loc46_);
         var _loc47_:ItemBrickPackage = new ItemBrickPackage("summer 2011","Summer package 2011",["Season","Hot","Beach"]);
         _loc47_.addBrick(createBrick(59,ItemLayer.FORGROUND,forgroundBricksBMD,"bricksummer2011","",ItemTab.BLOCK,false,true,59,-1,["Sand","Environment"]));
         _loc47_.addBrick(createBrick(228,ItemLayer.ABOVE,decorationsBMD,"bricksummer2011","",ItemTab.DECORATIVE,false,false,228 - 128,0,["Umbrella","Parasol","Beach","Sun"]));
         _loc47_.addBrick(createBrick(229,ItemLayer.ABOVE,decorationsBMD,"bricksummer2011","",ItemTab.DECORATIVE,false,false,229 - 128,0,["Left","Sand","Corner","Dune","Environment"]));
         _loc47_.addBrick(createBrick(230,ItemLayer.ABOVE,decorationsBMD,"bricksummer2011","",ItemTab.DECORATIVE,false,false,230 - 128,0,["Right","Sand","Corner","Dune","Environment"]));
         _loc47_.addBrick(createBrick(231,ItemLayer.ABOVE,decorationsBMD,"bricksummer2011","",ItemTab.DECORATIVE,false,false,231 - 128,0,["Rock","Stone","Environment"]));
         _loc47_.addBrick(createBrick(232,ItemLayer.ABOVE,decorationsBMD,"bricksummer2011","",ItemTab.DECORATIVE,false,false,232 - 128,0,["Bush","Nature","Plant","Yellow","Dead","Tumbleweed","Environment"]));
         brickPackages.push(_loc47_);
         var _loc48_:ItemBrickPackage = new ItemBrickPackage("halloween 2011","Halloween pack",["Scary","Holiday","Creepy"]);
         _loc48_.addBrick(createBrick(68,ItemLayer.FORGROUND,forgroundBricksBMD,"brickhw2011","",ItemTab.BLOCK,false,true,68,-1,["Brick","Gray","Grey","Bloody","Wall","House"]));
         _loc48_.addBrick(createBrick(69,ItemLayer.FORGROUND,forgroundBricksBMD,"brickhw2011","",ItemTab.BLOCK,false,true,69,-1,["Basic","Gray","Grey"]));
         _loc48_.addBrick(createBrick(224,ItemLayer.ABOVE,decorationsBMD,"brickhw2011","",ItemTab.DECORATIVE,false,false,224 - 128,0,["Grave","Tombstone","Headstone","Marker","Dead"]));
         _loc48_.addBrick(createBrick(225,ItemLayer.ABOVE,decorationsBMD,"brickhw2011","",ItemTab.DECORATIVE,false,true,225 - 128,0,["Cobweb","Spider Web","Right","Corner"]));
         _loc48_.addBrick(createBrick(226,ItemLayer.ABOVE,decorationsBMD,"brickhw2011","",ItemTab.DECORATIVE,false,true,226 - 128,0,["Cobweb","Spider Web","Left","Corner"]));
         _loc48_.addBrick(createBrick(541,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickhw2011","",ItemTab.BACKGROUND,false,false,541 - 500,-1,["Stone","Gray","Grey"]));
         _loc48_.addBrick(createBrick(542,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickhw2011","",ItemTab.BACKGROUND,false,false,542 - 500,-1,["Brick","Gray","Grey","House"]));
         _loc48_.addBrick(createBrick(543,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickhw2011","",ItemTab.BACKGROUND,false,false,543 - 500,-1,["Brick","Damaged","Right","Ruins","Corner","House"]));
         _loc48_.addBrick(createBrick(544,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickhw2011","",ItemTab.BACKGROUND,false,false,544 - 500,-1,["Brick","Damaged","Left","Ruins","Corner","House"]));
         brickPackages.push(_loc48_);
         var _loc49_:ItemBrickPackage = new ItemBrickPackage("christmas 2011","XMAS  decorations",["2011","Xmas","Bauble","Ornament","Holiday"]);
         _loc49_.addBrick(createBrick(218,ItemLayer.DECORATION,decorationsBMD,"brickxmas2011","",ItemTab.DECORATIVE,false,true,218 - 128,0,["Red","Bulb","Round","Holiday","Circle"]));
         _loc49_.addBrick(createBrick(219,ItemLayer.DECORATION,decorationsBMD,"brickxmas2011","",ItemTab.DECORATIVE,false,true,219 - 128,0,["Green","Bulb","Round","Holiday","Circle"]));
         _loc49_.addBrick(createBrick(220,ItemLayer.DECORATION,decorationsBMD,"brickxmas2011","",ItemTab.DECORATIVE,false,true,220 - 128,0,["Blue","Bulb","Round","Holiday","Circle"]));
         _loc49_.addBrick(createBrick(221,ItemLayer.DECORATION,decorationsBMD,"brickxmas2011","",ItemTab.DECORATIVE,false,true,221 - 128,0,["Circle","Wreath","Garland","Holiday","Green"]));
         _loc49_.addBrick(createBrick(222,ItemLayer.DECORATION,decorationsBMD,"brickxmas2011","",ItemTab.DECORATIVE,false,true,222 - 128,0,["Star","Yellow","Night","Sky"]));
         brickPackages.push(_loc49_);
         var _loc50_:ItemBrickPackage = new ItemBrickPackage("sci-fi","Sci-Fi Package",["Future","Science Fiction","Alien","UFO"]);
         _loc50_.addBrick(createBrick(84,ItemLayer.DECORATION,forgroundBricksBMD,"brickscifi","",ItemTab.BLOCK,false,true,84,-1,["Red","Screen"]));
         _loc50_.addBrick(createBrick(85,ItemLayer.DECORATION,forgroundBricksBMD,"brickscifi","",ItemTab.BLOCK,false,true,85,-1,["Blue","Screen"]));
         _loc50_.addBrick(createBrick(86,ItemLayer.DECORATION,forgroundBricksBMD,"brickscifi","",ItemTab.BLOCK,false,true,86,-1,["Metal","Gray","Bumpy","Grey"]));
         _loc50_.addBrick(createBrick(87,ItemLayer.DECORATION,forgroundBricksBMD,"brickscifi","",ItemTab.BLOCK,false,true,87,4294967295,["Metal","White","Grey","Gray"]));
         _loc50_.addBrick(createBrick(88,ItemLayer.DECORATION,forgroundBricksBMD,"brickscifi","",ItemTab.BLOCK,false,true,88,-1,["Brown","Camouflauge","Leopard","Carpet"]));
         _loc50_.addBrick(createBrick(89,ItemLayer.DECORATION,forgroundBricksBMD,"brickscifi","",ItemTab.BLOCK,false,true,89,-1,["Platform","Red","One-way","One way"]));
         _loc50_.addBrick(createBrick(90,ItemLayer.DECORATION,forgroundBricksBMD,"brickscifi","",ItemTab.BLOCK,false,true,90,-1,["Platform","Blue","One-way","One way"]));
         _loc50_.addBrick(createBrick(91,ItemLayer.DECORATION,forgroundBricksBMD,"brickscifi","",ItemTab.BLOCK,false,true,91,-1,["Platform","Green","One-way","One way"]));
         _loc50_.addBrick(createBrick(ItemId.ONEWAY_SCIFI_YELLOW,ItemLayer.DECORATION,forgroundBricksBMD,"brickscifi","",ItemTab.BLOCK,false,true,234,-1,["Platform","Yellow","One-way","One way"]));
         _loc50_.addBrick(createBrick(ItemId.GLOWYLINE_BLUE_SLOPE,ItemLayer.DECORATION,specialBricksBMD,"brickscifi","",ItemTab.DECORATIVE,false,true,177,0,["Morphable","Laser","Neon","Blue","Flourescent","Corner"]));
         _loc50_.addBrick(createBrick(ItemId.GLOWY_LINE_BLUE_STRAIGHT,ItemLayer.DECORATION,specialBricksBMD,"brickscifi","",ItemTab.DECORATIVE,false,true,181,0,["Morphable","Laser","Neon","Blue","Flourescent","Middle"]));
         _loc50_.addBrick(createBrick(ItemId.GLOWY_LINE_GREEN_SLOPE,ItemLayer.DECORATION,specialBricksBMD,"brickscifi","",ItemTab.DECORATIVE,false,true,169,0,["Morphable","Laser","Neon","Green","Flourescent","Corner"]));
         _loc50_.addBrick(createBrick(ItemId.GLOWY_LINE_GREEN_STRAIGHT,ItemLayer.DECORATION,specialBricksBMD,"brickscifi","",ItemTab.DECORATIVE,false,true,173,0,["Morphable","Laser","Neon","Green","Flourescent","Middle"]));
         _loc50_.addBrick(createBrick(ItemId.GLOWY_LINE_YELLOW_SLOPE,ItemLayer.DECORATION,specialBricksBMD,"brickscifi","",ItemTab.DECORATIVE,false,true,161,0,["Morphable","Laser","Neon","Yellow","Orange","Flourescent","Corner"]));
         _loc50_.addBrick(createBrick(ItemId.GLOWY_LINE_YELLOW_STRAIGHT,ItemLayer.DECORATION,specialBricksBMD,"brickscifi","",ItemTab.DECORATIVE,false,true,165,0,["Morphable","Laser","Neon","Yellow","Orange","Flourescent","Middle"]));
         _loc50_.addBrick(createBrick(ItemId.GLOWY_LINE_RED_SLOPE,ItemLayer.DECORATION,specialBricksBMD,"brickscifi","",ItemTab.DECORATIVE,false,true,409,0,["Morphable","Laser","Neon","Red","Pink","Flourescent","Corner"]));
         _loc50_.addBrick(createBrick(ItemId.GLOWY_LINE_RED_STRAIGHT,ItemLayer.DECORATION,specialBricksBMD,"brickscifi","",ItemTab.DECORATIVE,false,true,413,0,["Morphable","Laser","Neon","Red","Pink","Flourescent","Middle"]));
         _loc50_.addBrick(createBrick(637,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickscifi","",ItemTab.BACKGROUND,false,true,131,4285758849,["Gray","Outline","Grey"]));
         brickPackages.push(_loc50_);
         var _loc51_:ItemBrickPackage = new ItemBrickPackage("prison","Prison",["Cell","Jail"]);
         _loc51_.addBrick(createBrick(261,ItemLayer.ABOVE,decorationsBMD,"brickprison","",ItemTab.DECORATIVE,false,false,261 - 128,0,["Bars","Metal"]));
         _loc51_.addBrick(createBrick(92,ItemLayer.FORGROUND,forgroundBricksBMD,"brickprison","",ItemTab.BLOCK,false,true,92,-1,["Wall","Brick","Grey","Gray","House"]));
         _loc51_.addBrick(createBrick(550,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickprison","",ItemTab.BACKGROUND,false,true,50,-1,["Wall","Brick","Background","Grey","Gray","House"]));
         _loc51_.addBrick(createBrick(551,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickprison","",ItemTab.BACKGROUND,false,true,51,-1,["Window","Light","Orange","Brick"]));
         _loc51_.addBrick(createBrick(552,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickprison","",ItemTab.BACKGROUND,false,true,52,-1,["Window","Light","Blue","Brick"]));
         _loc51_.addBrick(createBrick(553,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickprison","",ItemTab.BACKGROUND,false,true,53,-1,["Window","Dark","Vent","Brick","Grey","Gray","Drain"]));
         brickPackages.push(_loc51_);
         var _loc52_:ItemBrickPackage = new ItemBrickPackage("windows","Colored Windows",["Glass"]);
         _loc52_.addBrick(createBrick(262,ItemLayer.ABOVE,decorationsBMD,"","",ItemTab.DECORATIVE,false,false,262 - 128,0,["Transparent","Clear","Black","Dark"]));
         _loc52_.addBrick(createBrick(268,ItemLayer.ABOVE,decorationsBMD,"","",ItemTab.DECORATIVE,false,false,268 - 128,0,["Transparent","Red","Pink"]));
         _loc52_.addBrick(createBrick(269,ItemLayer.ABOVE,decorationsBMD,"","",ItemTab.DECORATIVE,false,false,269 - 128,0,["Transparent","Orange"]));
         _loc52_.addBrick(createBrick(270,ItemLayer.ABOVE,decorationsBMD,"","",ItemTab.DECORATIVE,false,false,270 - 128,0,["Transparent","Yellow"]));
         _loc52_.addBrick(createBrick(263,ItemLayer.ABOVE,decorationsBMD,"","",ItemTab.DECORATIVE,false,false,263 - 128,0,["Transparent","Green"]));
         _loc52_.addBrick(createBrick(264,ItemLayer.ABOVE,decorationsBMD,"","",ItemTab.DECORATIVE,false,false,264 - 128,0,["Transparent","Turquoise","Cyan","Teal","Blue","Green"]));
         _loc52_.addBrick(createBrick(265,ItemLayer.ABOVE,decorationsBMD,"","",ItemTab.DECORATIVE,false,false,265 - 128,0,["Transparent","Blue"]));
         _loc52_.addBrick(createBrick(266,ItemLayer.ABOVE,decorationsBMD,"","",ItemTab.DECORATIVE,false,false,266 - 128,0,["Transparent","Purple","Violet","Indigo"]));
         _loc52_.addBrick(createBrick(267,ItemLayer.ABOVE,decorationsBMD,"","",ItemTab.DECORATIVE,false,false,267 - 128,0,["Transparent","Pink","Magenta"]));
         brickPackages.push(_loc52_);
         var _loc53_:ItemBrickPackage = new ItemBrickPackage("pirate","Pirate Pack");
         _loc53_.addBrick(createBrick(93,ItemLayer.FORGROUND,forgroundBricksBMD,"brickpirate","",ItemTab.BLOCK,false,true,93,-1,["Wood","Planks","Board","Siding","Navy","House"]));
         _loc53_.addBrick(createBrick(94,ItemLayer.FORGROUND,forgroundBricksBMD,"brickpirate","",ItemTab.BLOCK,false,true,94,-1,["Chest","Treasure","Loot","Booty","Navy"]));
         _loc53_.addBrick(createBrick(154,ItemLayer.DECORATION,forgroundBricksBMD,"brickpirate","",ItemTab.BLOCK,false,true,131,0,["Platform","Wood","Ship","Navy","One Way","One-Way"]));
         _loc53_.addBrick(createBrick(271,ItemLayer.DECORATION,decorationsBMD,"brickpirate","",ItemTab.DECORATIVE,false,true,143,0,["Wood","Decoration","Navy"]));
         _loc53_.addBrick(createBrick(272,ItemLayer.ABOVE,decorationsBMD,"brickpirate","",ItemTab.DECORATIVE,false,true,144,0,["Skull","Head","Skeleton","Creepy","Death"]));
         _loc53_.addBrick(createBrick(435,ItemLayer.DECORATION,decorationsBMD,"brickpirate","",ItemTab.DECORATIVE,false,false,277,0,["Cannon","Sea war","Gun","Ship","Navy"]));
         _loc53_.addBrick(createBrick(436,ItemLayer.DECORATION,decorationsBMD,"brickpirate","",ItemTab.DECORATIVE,false,false,278,0,["Port Window","Porthole","Ship","Navy"]));
         _loc53_.addBrick(createBrick(554,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickpirate","",ItemTab.BACKGROUND,false,false,54,-1,["Wood","Dark","Planks","Board","Ship","House","Siding","Navy"]));
         _loc53_.addBrick(createBrick(555,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickpirate","",ItemTab.BACKGROUND,false,false,55,-1,["Wood","Light","Planks","Board","Ship","House","Siding","Navy"]));
         _loc53_.addBrick(createBrick(559,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickpirate","",ItemTab.BACKGROUND,false,false,59,-1,["Wood","Dark","Planks","Board","Ship","House","Siding","Navy"]));
         _loc53_.addBrick(createBrick(560,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickpirate","",ItemTab.BACKGROUND,false,false,60,-1,["Flag","Jolly Roger","Skull","Ship","Navy"]));
         brickPackages.push(_loc53_);
         var _loc54_:ItemBrickPackage = new ItemBrickPackage("stone","Stone Pack",["Cave","Rocks","Environment","House"]);
         _loc54_.addBrick(createBrick(95,ItemLayer.FORGROUND,forgroundBricksBMD,"brickstone","",ItemTab.BLOCK,false,true,95,-1,["Gray","Grey"]));
         _loc54_.addBrick(createBrick(1044,ItemLayer.FORGROUND,forgroundBricksBMD,"brickstone","",ItemTab.BLOCK,false,true,226,-1,["Green","Limestone"]));
         _loc54_.addBrick(createBrick(1045,ItemLayer.FORGROUND,forgroundBricksBMD,"brickstone","",ItemTab.BLOCK,false,true,227,-1,["Brown","Dirt"]));
         _loc54_.addBrick(createBrick(1046,ItemLayer.FORGROUND,forgroundBricksBMD,"brickstone","",ItemTab.BLOCK,false,true,228,-1,["Blue"]));
         _loc54_.addBrick(createBrick(561,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickstone","",ItemTab.BACKGROUND,false,false,61,-1,["Dark","Gray","Grey"]));
         _loc54_.addBrick(createBrick(562,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickstone","",ItemTab.BACKGROUND,false,false,62,-1,["Half","Dark","Gray","Grey"]));
         _loc54_.addBrick(createBrick(688,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickstone","",ItemTab.BACKGROUND,false,false,182,-1,["Green","Limestone"]));
         _loc54_.addBrick(createBrick(689,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickstone","",ItemTab.BACKGROUND,false,false,183,-1,["Half","Limestone"]));
         _loc54_.addBrick(createBrick(690,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickstone","",ItemTab.BACKGROUND,false,false,184,-1,["Brown"]));
         _loc54_.addBrick(createBrick(691,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickstone","",ItemTab.BACKGROUND,false,false,185,-1,["Half","Brown"]));
         _loc54_.addBrick(createBrick(692,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickstone","",ItemTab.BACKGROUND,false,false,186,-1,["Blue"]));
         _loc54_.addBrick(createBrick(693,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickstone","",ItemTab.BACKGROUND,false,false,187,-1,["Half"]));
         brickPackages.push(_loc54_);
         var _loc55_:ItemBrickPackage = new ItemBrickPackage("dojo","Dojo Pack",["Ninja","Asian","Japanese","Kung Fu"]);
         _loc55_.addBrick(createBrick(96,ItemLayer.DECORATION,forgroundBricksBMD,"brickninja","",ItemTab.BLOCK,false,true,96,0,["Platform","White","One-way","One way"]));
         _loc55_.addBrick(createBrick(97,ItemLayer.DECORATION,forgroundBricksBMD,"brickninja","",ItemTab.BLOCK,false,true,97,0,["Platform","Gray","Grey","One-way","One way"]));
         _loc55_.addBrick(createBrick(564,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickninja","",ItemTab.BACKGROUND,false,true,64,-1,["White"]));
         _loc55_.addBrick(createBrick(565,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickninja","",ItemTab.BACKGROUND,false,true,65,-1,["Grey","Gray"]));
         _loc55_.addBrick(createBrick(566,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickninja","",ItemTab.BACKGROUND,false,true,66,-1,["Roof","Blue","Tile","Shingles","House"]));
         _loc55_.addBrick(createBrick(567,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickninja","",ItemTab.BACKGROUND,false,true,67,-1,["Roof","Blue","Dark","Tile","Shingles","House"]));
         _loc55_.addBrick(createBrick(667,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickninja","",ItemTab.BACKGROUND,false,false,161,-1,["Roof","Red","Tile","Shingles","House"]));
         _loc55_.addBrick(createBrick(668,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickninja","",ItemTab.BACKGROUND,false,false,162,-1,["Roof","Red","Dark","Tile","Shingles","House"]));
         _loc55_.addBrick(createBrick(669,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickninja","",ItemTab.BACKGROUND,false,false,163,-1,["Roof","Green","Tile","Shingles","House"]));
         _loc55_.addBrick(createBrick(670,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickninja","",ItemTab.BACKGROUND,false,false,164,-1,["Roof","Green","Dark","Tile","Shingles","House"]));
         _loc55_.addBrick(createBrick(ItemId.DOJO_LIGHT_LEFT,ItemLayer.DECORATION,specialBricksBMD,"brickninja","",ItemTab.DECORATIVE,false,false,389,0,["Morphable","Fin","Left","Blue","Green","Red","Corner"]));
         _loc55_.addBrick(createBrick(ItemId.DOJO_LIGHT_RIGHT,ItemLayer.DECORATION,specialBricksBMD,"brickninja","",ItemTab.DECORATIVE,false,false,392,0,["Morphable","Fin","Right","Blue","Green","Red","Corner"]));
         _loc55_.addBrick(createBrick(278,ItemLayer.DECORATION,decorationsBMD,"brickninja","",ItemTab.DECORATIVE,false,false,278 - 128,0,["Window","Open","House"]));
         _loc55_.addBrick(createBrick(ItemId.DOJO_DARK_LEFT,ItemLayer.DECORATION,specialBricksBMD,"brickninja","",ItemTab.DECORATIVE,false,false,395,0,["Morphable","Fin","Left","Dark","Blue","Green","Red","Corner"]));
         _loc55_.addBrick(createBrick(ItemId.DOJO_DARK_RIGHT,ItemLayer.DECORATION,specialBricksBMD,"brickninja","",ItemTab.DECORATIVE,false,false,398,0,["Morphable","Fin","Right","Dark","Blue","Green","Red","Corner"]));
         _loc55_.addBrick(createBrick(281,ItemLayer.DECORATION,decorationsBMD,"brickninja","",ItemTab.DECORATIVE,false,false,281 - 128,0,["Window","Dark","Open","House"]));
         _loc55_.addBrick(createBrick(282,ItemLayer.DECORATION,decorationsBMD,"brickninja","",ItemTab.DECORATIVE,false,false,282 - 128,0,["Character","Chinese"]));
         _loc55_.addBrick(createBrick(283,ItemLayer.DECORATION,decorationsBMD,"brickninja","",ItemTab.DECORATIVE,false,false,283 - 128,0,["Character","Chinese"]));
         _loc55_.addBrick(createBrick(284,ItemLayer.DECORATION,decorationsBMD,"brickninja","",ItemTab.DECORATIVE,false,false,284 - 128,0,["Yin Yang","Chinese","White","Black white"]));
         brickPackages.push(_loc55_);
         var _loc56_:ItemBrickPackage = new ItemBrickPackage("wild west","Wild West Pack",["Cowboy","Western","House"]);
         _loc56_.addBrick(createBrick(122,ItemLayer.DECORATION,forgroundBricksBMD,"brickcowboy","",ItemTab.BLOCK,false,true,99,0,["Brown","Wood","Platform","One way","One-Way"]));
         _loc56_.addBrick(createBrick(123,ItemLayer.DECORATION,forgroundBricksBMD,"brickcowboy","",ItemTab.BLOCK,false,true,100,0,["Red","Wood","Platform","One way","One-Way"]));
         _loc56_.addBrick(createBrick(124,ItemLayer.DECORATION,forgroundBricksBMD,"brickcowboy","",ItemTab.BLOCK,false,true,101,0,["Blue","Wood","Platform","One way","One-Way"]));
         _loc56_.addBrick(createBrick(125,ItemLayer.DECORATION,forgroundBricksBMD,"brickcowboy","",ItemTab.BLOCK,false,true,102,0,["Dark","Brown","Wood","Platform","One way","One-Way"]));
         _loc56_.addBrick(createBrick(126,ItemLayer.DECORATION,forgroundBricksBMD,"brickcowboy","",ItemTab.BLOCK,false,true,103,0,["Dark","Red","Wood","Platform","One way","One-Way"]));
         _loc56_.addBrick(createBrick(127,ItemLayer.DECORATION,forgroundBricksBMD,"brickcowboy","",ItemTab.BLOCK,false,true,104,0,["Dark","Blue","Wood","Platform","One way","One-Way"]));
         _loc56_.addBrick(createBrick(568,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickcowboy","",ItemTab.BACKGROUND,false,true,68,-1,["Siding","Wood","Brown","Planks","Ship","Board"]));
         _loc56_.addBrick(createBrick(569,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickcowboy","",ItemTab.BACKGROUND,false,true,69,-1,["Siding","Wood","Dark Brown","Planks","Ship","Board"]));
         _loc56_.addBrick(createBrick(570,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickcowboy","",ItemTab.BACKGROUND,false,true,70,-1,["Siding","Wood","Red","Planks","Board","Board"]));
         _loc56_.addBrick(createBrick(571,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickcowboy","",ItemTab.BACKGROUND,false,true,71,-1,["Siding","Wood","Dark Red","Planks","Board"]));
         _loc56_.addBrick(createBrick(572,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickcowboy","",ItemTab.BACKGROUND,false,true,72,-1,["Siding","Wood","Blue","Planks","Board"]));
         _loc56_.addBrick(createBrick(573,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickcowboy","",ItemTab.BACKGROUND,false,true,73,-1,["Siding","Wood","Dark Blue","Planks","Board"]));
         _loc56_.addBrick(createBrick(285,ItemLayer.ABOVE,decorationsBMD,"brickcowboy","",ItemTab.DECORATIVE,false,true,285 - 128,0,["Pole","White"]));
         _loc56_.addBrick(createBrick(286,ItemLayer.ABOVE,decorationsBMD,"brickcowboy","",ItemTab.DECORATIVE,false,true,286 - 128,0,["Pole","Gray","Dark","Grey"]));
         _loc56_.addBrick(createBrick(287,ItemLayer.DECORATION,decorationsBMD,"brickcowboy","",ItemTab.DECORATIVE,false,false,287 - 128,0,["Door","Wood","Brown","Left"]));
         _loc56_.addBrick(createBrick(288,ItemLayer.DECORATION,decorationsBMD,"brickcowboy","",ItemTab.DECORATIVE,false,false,288 - 128,0,["Door","Wood","Brown","Right"]));
         _loc56_.addBrick(createBrick(289,ItemLayer.DECORATION,decorationsBMD,"brickcowboy","",ItemTab.DECORATIVE,false,false,289 - 128,0,["Door","Wood","Red","Left"]));
         _loc56_.addBrick(createBrick(290,ItemLayer.DECORATION,decorationsBMD,"brickcowboy","",ItemTab.DECORATIVE,false,false,290 - 128,0,["Door","Wood","Red","Right"]));
         _loc56_.addBrick(createBrick(291,ItemLayer.DECORATION,decorationsBMD,"brickcowboy","",ItemTab.DECORATIVE,false,false,291 - 128,0,["Door","Wood","Blue","Left"]));
         _loc56_.addBrick(createBrick(292,ItemLayer.DECORATION,decorationsBMD,"brickcowboy","",ItemTab.DECORATIVE,false,false,292 - 128,0,["Door","Wood","Blue","Right"]));
         _loc56_.addBrick(createBrick(293,ItemLayer.DECORATION,decorationsBMD,"brickcowboy","",ItemTab.DECORATIVE,false,false,293 - 128,0,["Window","Curtains"]));
         _loc56_.addBrick(createBrick(294,ItemLayer.ABOVE,decorationsBMD,"brickcowboy","",ItemTab.DECORATIVE,false,false,294 - 128,0,["Fence","Wood","Brown"]));
         _loc56_.addBrick(createBrick(295,ItemLayer.ABOVE,decorationsBMD,"brickcowboy","",ItemTab.DECORATIVE,false,false,295 - 128,0,["Fence","Wood","Brown"]));
         _loc56_.addBrick(createBrick(296,ItemLayer.ABOVE,decorationsBMD,"brickcowboy","",ItemTab.DECORATIVE,false,false,296 - 128,0,["Fence","Wood","Red"]));
         _loc56_.addBrick(createBrick(297,ItemLayer.ABOVE,decorationsBMD,"brickcowboy","",ItemTab.DECORATIVE,false,false,297 - 128,0,["Fence","Wood","Red"]));
         _loc56_.addBrick(createBrick(298,ItemLayer.ABOVE,decorationsBMD,"brickcowboy","",ItemTab.DECORATIVE,false,false,298 - 128,0,["Fence","Wood","Blue"]));
         _loc56_.addBrick(createBrick(299,ItemLayer.ABOVE,decorationsBMD,"brickcowboy","",ItemTab.DECORATIVE,false,false,299 - 128,0,["Fence","Wood","Blue"]));
         brickPackages.push(_loc56_);
         var _loc57_:ItemBrickPackage = new ItemBrickPackage("plastic","Plastic Pack",["Neon","Bright"]);
         _loc57_.addBrick(createBrick(129,ItemLayer.DECORATION,forgroundBricksBMD,"brickplastic","",ItemTab.BLOCK,false,true,106,-1,["Red"]));
         _loc57_.addBrick(createBrick(135,ItemLayer.DECORATION,forgroundBricksBMD,"brickplastic","",ItemTab.BLOCK,false,true,112,-1,["Orange"]));
         _loc57_.addBrick(createBrick(130,ItemLayer.DECORATION,forgroundBricksBMD,"brickplastic","",ItemTab.BLOCK,false,true,107,-1,["Yellow"]));
         _loc57_.addBrick(createBrick(128,ItemLayer.DECORATION,forgroundBricksBMD,"brickplastic","",ItemTab.BLOCK,false,true,105,-1,["Green","Light Green","Lime"]));
         _loc57_.addBrick(createBrick(134,ItemLayer.DECORATION,forgroundBricksBMD,"brickplastic","",ItemTab.BLOCK,false,true,111,-1,["Green"]));
         _loc57_.addBrick(createBrick(131,ItemLayer.DECORATION,forgroundBricksBMD,"brickplastic","",ItemTab.BLOCK,false,true,108,-1,["Light Blue","Cyan"]));
         _loc57_.addBrick(createBrick(132,ItemLayer.DECORATION,forgroundBricksBMD,"brickplastic","",ItemTab.BLOCK,false,true,109,-1,["Blue","Indigo"]));
         _loc57_.addBrick(createBrick(133,ItemLayer.DECORATION,forgroundBricksBMD,"brickplastic","",ItemTab.BLOCK,false,true,110,-1,["Purple","Magenta","Pink"]));
         brickPackages.push(_loc57_);
         var _loc58_:ItemBrickPackage = new ItemBrickPackage("water","Water pack",["Sea","Ocean","Nature","Environment"]);
         _loc58_.addBrick(createBrick(ItemId.WAVE,ItemLayer.ABOVE,specialBricksBMD,"","",ItemTab.DECORATIVE,false,false,234,0,["Waves","Animated"]));
         _loc58_.addBrick(createBrick(574,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,true,74,4285913831));
         _loc58_.addBrick(createBrick(575,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,true,75,4285913831,["Octopus","Squid"]));
         _loc58_.addBrick(createBrick(576,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,true,76,4285913831,["Fish"]));
         _loc58_.addBrick(createBrick(577,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,true,77,4285913831,["Seahorse"]));
         _loc58_.addBrick(createBrick(578,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,true,78,4285913831,["Seaweed","Plant","Algae"]));
         brickPackages.push(_loc58_);
         var _loc59_:ItemBrickPackage = new ItemBrickPackage("sand","Sand Pack",["Desert","Beach","Environment","Soil"]);
         _loc59_.addBrick(createBrick(137,ItemLayer.FORGROUND,forgroundBricksBMD,"bricksand","",ItemTab.BLOCK,false,true,114,-1,["White","Beige"]));
         _loc59_.addBrick(createBrick(138,ItemLayer.FORGROUND,forgroundBricksBMD,"bricksand","",ItemTab.BLOCK,false,true,115,-1,["Grey","Gray"]));
         _loc59_.addBrick(createBrick(139,ItemLayer.FORGROUND,forgroundBricksBMD,"bricksand","",ItemTab.BLOCK,false,true,116,-1,["Yellow"]));
         _loc59_.addBrick(createBrick(140,ItemLayer.FORGROUND,forgroundBricksBMD,"bricksand","",ItemTab.BLOCK,false,true,117,-1,["Yellow","Orange"]));
         _loc59_.addBrick(createBrick(141,ItemLayer.FORGROUND,forgroundBricksBMD,"bricksand","",ItemTab.BLOCK,false,true,118,-1,["Brown","Light"]));
         _loc59_.addBrick(createBrick(142,ItemLayer.FORGROUND,forgroundBricksBMD,"bricksand","",ItemTab.BLOCK,false,true,119,-1,["Brown","Dark","Dirt"]));
         _loc59_.addBrick(createBrick(579,ItemLayer.BACKGROUND,backgroundBricksBMD,"bricksand","",ItemTab.BACKGROUND,false,false,79,-1,["Off-white"]));
         _loc59_.addBrick(createBrick(580,ItemLayer.BACKGROUND,backgroundBricksBMD,"bricksand","",ItemTab.BACKGROUND,false,false,80,-1,["Gray","Grey"]));
         _loc59_.addBrick(createBrick(581,ItemLayer.BACKGROUND,backgroundBricksBMD,"bricksand","",ItemTab.BACKGROUND,false,false,81,-1,["Yellow"]));
         _loc59_.addBrick(createBrick(582,ItemLayer.BACKGROUND,backgroundBricksBMD,"bricksand","",ItemTab.BACKGROUND,false,false,82,-1,["Orange","Yellow"]));
         _loc59_.addBrick(createBrick(583,ItemLayer.BACKGROUND,backgroundBricksBMD,"bricksand","",ItemTab.BACKGROUND,false,false,83,-1,["Brown","Light"]));
         _loc59_.addBrick(createBrick(584,ItemLayer.BACKGROUND,backgroundBricksBMD,"bricksand","",ItemTab.BACKGROUND,false,false,84,-1,["Brown","Dark"]));
         _loc59_.addBrick(createBrick(301,ItemLayer.ABOVE,decorationsBMD,"bricksand","",ItemTab.DECORATIVE,false,false,300 - 128,0,["White"]));
         _loc59_.addBrick(createBrick(302,ItemLayer.ABOVE,decorationsBMD,"bricksand","",ItemTab.DECORATIVE,false,false,301 - 128,0,["Gray","Grey"]));
         _loc59_.addBrick(createBrick(303,ItemLayer.ABOVE,decorationsBMD,"bricksand","",ItemTab.DECORATIVE,false,false,302 - 128,0,["Yellow"]));
         _loc59_.addBrick(createBrick(304,ItemLayer.ABOVE,decorationsBMD,"bricksand","",ItemTab.DECORATIVE,false,false,303 - 128,0,["Yellow","Orange"]));
         _loc59_.addBrick(createBrick(305,ItemLayer.ABOVE,decorationsBMD,"bricksand","",ItemTab.DECORATIVE,false,false,304 - 128,0,["Brown","Light"]));
         _loc59_.addBrick(createBrick(306,ItemLayer.ABOVE,decorationsBMD,"bricksand","",ItemTab.DECORATIVE,false,false,305 - 128,0,["Brown","Dark"]));
         brickPackages.push(_loc59_);
         var _loc60_:ItemBrickPackage = new ItemBrickPackage("summer 2012","Summer pack 2012",["Season","Beach"]);
         _loc60_.addBrick(createBrick(307,ItemLayer.ABOVE,decorationsBMD,"bricksummer2012","",ItemTab.DECORATIVE,false,false,306 - 128,0,["Beach","Ball","Toy","Ball"]));
         _loc60_.addBrick(createBrick(308,ItemLayer.ABOVE,decorationsBMD,"bricksummer2012","",ItemTab.DECORATIVE,false,false,307 - 128,0,["Pail","Bucket","Toy","Sand"]));
         _loc60_.addBrick(createBrick(309,ItemLayer.ABOVE,decorationsBMD,"bricksummer2012","",ItemTab.DECORATIVE,false,false,308 - 128,0,["Shovel","Dig","Toy","Sand"]));
         _loc60_.addBrick(createBrick(310,ItemLayer.ABOVE,decorationsBMD,"bricksummer2012","",ItemTab.DECORATIVE,false,false,309 - 128,0,["Drink","Margarita","Umbrella","Cocktail","Glass","Cup"]));
         brickPackages.push(_loc60_);
         var _loc61_:ItemBrickPackage = new ItemBrickPackage("cloud","Cloud Pack",["Sky","Environment","White"]);
         _loc61_.addBrick(createBrick(143,ItemLayer.FORGROUND,forgroundBricksBMD,"","",ItemTab.BLOCK,false,false,120,-1,["Center","Middle"]));
         _loc61_.addBrick(createBrick(311,ItemLayer.DECORATION,decorationsBMD,"","",ItemTab.DECORATIVE,false,false,310 - 128,0,["Top","Side"]));
         _loc61_.addBrick(createBrick(312,ItemLayer.DECORATION,decorationsBMD,"","",ItemTab.DECORATIVE,false,false,311 - 128,0,["Bottom","Side"]));
         _loc61_.addBrick(createBrick(313,ItemLayer.DECORATION,decorationsBMD,"","",ItemTab.DECORATIVE,false,false,312 - 128,0,["Left","Side"]));
         _loc61_.addBrick(createBrick(314,ItemLayer.DECORATION,decorationsBMD,"","",ItemTab.DECORATIVE,false,false,313 - 128,0,["Right","Side"]));
         _loc61_.addBrick(createBrick(315,ItemLayer.DECORATION,decorationsBMD,"","",ItemTab.DECORATIVE,false,false,314 - 128,0,["Top right","Corner"]));
         _loc61_.addBrick(createBrick(316,ItemLayer.DECORATION,decorationsBMD,"","",ItemTab.DECORATIVE,false,false,315 - 128,0,["Top left","Corner"]));
         _loc61_.addBrick(createBrick(317,ItemLayer.DECORATION,decorationsBMD,"","",ItemTab.DECORATIVE,false,false,316 - 128,0,["Bottom left","Corner"]));
         _loc61_.addBrick(createBrick(318,ItemLayer.DECORATION,decorationsBMD,"","",ItemTab.DECORATIVE,false,false,317 - 128,0,["Bottom right","Corner"]));
         brickPackages.push(_loc61_);
         var _loc62_:ItemBrickPackage = new ItemBrickPackage("industrial","Industrial Package",["Factory"]);
         _loc62_.addBrick(createBrick(144,ItemLayer.FORGROUND,forgroundBricksBMD,"brickindustrial","",ItemTab.BLOCK,false,true,121,-1,["Diamond plating","Plate","Metal"]));
         _loc62_.addBrick(createBrick(145,ItemLayer.FORGROUND,forgroundBricksBMD,"brickindustrial","",ItemTab.BLOCK,false,true,122,-1,["Wiring","Wires","Metal"]));
         _loc62_.addBrick(createBrick(585,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickindustrial","",ItemTab.BACKGROUND,false,false,85,-1,["Plate","Metal"]));
         _loc62_.addBrick(createBrick(586,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickindustrial","",ItemTab.BACKGROUND,false,false,86,-1,["Gray","Steel","Plate","Metal"]));
         _loc62_.addBrick(createBrick(587,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickindustrial","",ItemTab.BACKGROUND,false,false,87,-1,["Blue","Cyan","Plate","Metal"]));
         _loc62_.addBrick(createBrick(588,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickindustrial","",ItemTab.BACKGROUND,false,false,88,-1,["Green","Plate","Metal"]));
         _loc62_.addBrick(createBrick(589,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickindustrial","",ItemTab.BACKGROUND,false,false,89,-1,["Yellow","Orange","Plate","Metal"]));
         _loc62_.addBrick(createBrick(146,ItemLayer.DECORATION,forgroundBricksBMD,"brickindustrial","",ItemTab.BLOCK,false,true,123,0,["Platform","One-Way","One Way","Metal"]));
         _loc62_.addBrick(createBrick(147,ItemLayer.DECORATION,forgroundBricksBMD,"brickindustrial","",ItemTab.BLOCK,false,true,124,0,["Scissor","Scaffolding","X","Metal"]));
         _loc62_.addBrick(createBrick(148,ItemLayer.DECORATION,forgroundBricksBMD,"brickindustrial","",ItemTab.BLOCK,false,true,125,0,["Lift","Table","Piston","Metal"]));
         _loc62_.addBrick(createBrick(149,ItemLayer.FORGROUND,forgroundBricksBMD,"brickindustrial","",ItemTab.BLOCK,false,true,126,-1,["Tube","Plate","Piston","Metal"]));
         _loc62_.addBrick(createBrick(150,ItemLayer.DECORATION,forgroundBricksBMD,"brickindustrial","",ItemTab.BLOCK,false,true,127,-1,["Conveyor belt","Left","Metal"]));
         _loc62_.addBrick(createBrick(151,ItemLayer.DECORATION,forgroundBricksBMD,"brickindustrial","",ItemTab.BLOCK,false,true,128,-1,["Conveyor belt","Middle","Metal"]));
         _loc62_.addBrick(createBrick(152,ItemLayer.DECORATION,forgroundBricksBMD,"brickindustrial","",ItemTab.BLOCK,false,true,129,-1,["Conveyor belt","Middle","Metal"]));
         _loc62_.addBrick(createBrick(153,ItemLayer.DECORATION,forgroundBricksBMD,"brickindustrial","",ItemTab.BLOCK,false,true,130,-1,["Conveyor belt","Right","Metal"]));
         _loc62_.addBrick(createBrick(319,ItemLayer.ABOVE,decorationsBMD,"brickindustrial","",ItemTab.DECORATIVE,false,true,190,0,["Caution","Warning","Fire","Flame","Sign","Alert"]));
         _loc62_.addBrick(createBrick(320,ItemLayer.ABOVE,decorationsBMD,"brickindustrial","",ItemTab.DECORATIVE,false,true,191,0,["Caution","Warning","Death","Toxin","Poison","Sign","Alert"]));
         _loc62_.addBrick(createBrick(321,ItemLayer.ABOVE,decorationsBMD,"brickindustrial","",ItemTab.DECORATIVE,false,true,192,0,["Caution","Warning","Electricity","Lightning","Sign","Alert"]));
         _loc62_.addBrick(createBrick(322,ItemLayer.ABOVE,decorationsBMD,"brickindustrial","",ItemTab.DECORATIVE,false,true,193,0,["Caution","Warning","No","Do not enter","X","Sign","Alert"]));
         _loc62_.addBrick(createBrick(323,ItemLayer.DECORATION,decorationsBMD,"brickindustrial","",ItemTab.DECORATIVE,false,true,194,0,["Caution","Warning","Horizontal","Stripes","Hazard","Pole","Alert"]));
         _loc62_.addBrick(createBrick(324,ItemLayer.DECORATION,decorationsBMD,"brickindustrial","",ItemTab.DECORATIVE,false,true,195,0,["Caution","Warning","Vertical","Stripes","Hazard","Pole","Alert"]));
         brickPackages.push(_loc62_);
         var _loc63_:ItemBrickPackage = new ItemBrickPackage("clay","Clay Backgrounds",["House"]);
         _loc63_.addBrick(createBrick(594,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,false,94,-1,["White","Tile","Bathroom"]));
         _loc63_.addBrick(createBrick(595,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,false,95,-1,["Brick","Tile","Bathroom"]));
         _loc63_.addBrick(createBrick(596,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,false,96,-1,["Diamond","Chisel","Tile","Bathroom"]));
         _loc63_.addBrick(createBrick(597,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,false,97,-1,["X","Cross","Chisel","Bathroom","Tile"]));
         _loc63_.addBrick(createBrick(598,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,false,98,-1,["Rough","Natural"]));
         brickPackages.push(_loc63_);
         var _loc64_:ItemBrickPackage = new ItemBrickPackage("medieval","Medieval",["Castle"]);
         _loc64_.addBrick(createBrick(158,ItemLayer.DECORATION,forgroundBricksBMD,"brickmedieval","",ItemTab.BLOCK,false,true,132,0,["Platform","Stone"]));
         _loc64_.addBrick(createBrick(159,ItemLayer.FORGROUND,forgroundBricksBMD,"brickmedieval","",ItemTab.BLOCK,false,true,133,-1,["Brick","Stone"]));
         _loc64_.addBrick(createBrick(160,ItemLayer.FORGROUND,forgroundBricksBMD,"brickmedieval","",ItemTab.BLOCK,false,true,134,-1,["Brick","Arrow slit","Stone","Window"]));
         _loc64_.addBrick(createBrick(599,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickmedieval","",ItemTab.BACKGROUND,false,false,99,-1,["Anvil","Blacksmith"]));
         _loc64_.addBrick(createBrick(325,ItemLayer.ABOVE,decorationsBMD,"brickmedieval","",ItemTab.DECORATIVE,false,true,196,0,["Brick","Stone","House"]));
         _loc64_.addBrick(createBrick(326,ItemLayer.ABOVE,decorationsBMD,"brickmedieval","",ItemTab.DECORATIVE,false,false,197,-1,["Top","Display","Stone"]));
         _loc64_.addBrick(createBrick(162,ItemLayer.DECORATION,forgroundBricksBMD,"brickmedieval","",ItemTab.BLOCK,false,true,136,0,["Parapet","Stone"]));
         _loc64_.addBrick(createBrick(163,ItemLayer.DECORATION,forgroundBricksBMD,"brickmedieval","",ItemTab.BLOCK,false,true,137,0,["Barrel","Keg"]));
         _loc64_.addBrick(createBrick(437,ItemLayer.DECORATION,decorationsBMD,"brickmedieval","",ItemTab.DECORATIVE,false,false,279,0,["Window","Wood","House"]));
         _loc64_.addBrick(createBrick(600,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickmedieval","",ItemTab.BACKGROUND,false,false,100,-1,["Wood","Planks","Vertical","Brown","House"]));
         _loc64_.addBrick(createBrick(590,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickmedieval","",ItemTab.BACKGROUND,false,false,90,-1,["Straw","Hay","Roof","House"]));
         _loc64_.addBrick(createBrick(591,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickmedieval","",ItemTab.BACKGROUND,false,false,91,-1,["Roof","Shingles","Scales","Red","House"]));
         _loc64_.addBrick(createBrick(592,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickmedieval","",ItemTab.BACKGROUND,false,false,92,-1,["Roof","Shingles","Scales","Green","House"]));
         _loc64_.addBrick(createBrick(556,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickmedieval","",ItemTab.BACKGROUND,false,false,56,-1,["Roof","Shingles","Scales","Brown","House"]));
         _loc64_.addBrick(createBrick(593,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickmedieval","",ItemTab.BACKGROUND,false,false,93,-1,["Gray","Dry wall","Stucco","Grey","House","Beige"]));
         _loc64_.addBrick(createBrick(ItemId.MEDIEVAL_TIMBER,ItemLayer.DECORATION,specialBricksBMD,"brickmedieval","",ItemTab.DECORATIVE,false,false,417,0,["Scaffolding","Wood","Morphable","Fence","House","Design"]));
         _loc64_.addBrick(createBrick(330,ItemLayer.DECORATION,decorationsBMD,"brickmedieval","",ItemTab.DECORATIVE,false,true,201,0,["Shield","Warrior","Weapon"]));
         _loc64_.addBrick(createBrick(ItemId.MEDIEVAL_AXE,ItemLayer.DECORATION,specialBricksBMD,"brickmedieval","",ItemTab.DECORATIVE,false,true,365,0,["Axe","Morphable","Warrior","Weapon"]));
         _loc64_.addBrick(createBrick(ItemId.MEDIEVAL_SWORD,ItemLayer.DECORATION,specialBricksBMD,"brickmedieval","",ItemTab.DECORATIVE,false,true,377,0,["Sword","Morphable","Warrior","Weapon"]));
         _loc64_.addBrick(createBrick(ItemId.MEDIEVAL_SHIELD,ItemLayer.DECORATION,specialBricksBMD,"brickmedieval","",ItemTab.DECORATIVE,false,true,373,0,["Shield","Morphable","Blue","Green","Yellow","Red","Circle"]));
         _loc64_.addBrick(createBrick(ItemId.MEDIEVAL_COATOFARMS,ItemLayer.DECORATION,specialBricksBMD,"brickmedieval","",ItemTab.DECORATIVE,false,true,405,0,["Shield","Morphable","Blue","Green","Yellow","Red"]));
         _loc64_.addBrick(createBrick(ItemId.MEDIEVAL_BANNER,ItemLayer.DECORATION,specialBricksBMD,"brickmedieval","",ItemTab.DECORATIVE,false,true,369,0,["Banner","Morphable","Blue","Green","Yellow","Red","Flag"]));
         brickPackages.push(_loc64_);
         var _loc65_:ItemBrickPackage = new ItemBrickPackage("pipes","Pipes",["Orange"]);
         _loc65_.addBrick(createBrick(166,ItemLayer.FORGROUND,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,140,-1,["Left"]));
         _loc65_.addBrick(createBrick(167,ItemLayer.FORGROUND,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,141,-1,["Horizontal"]));
         _loc65_.addBrick(createBrick(168,ItemLayer.FORGROUND,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,142,-1,["Right"]));
         _loc65_.addBrick(createBrick(169,ItemLayer.FORGROUND,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,143,-1,["Up"]));
         _loc65_.addBrick(createBrick(170,ItemLayer.FORGROUND,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,144,-1,["Vertical"]));
         _loc65_.addBrick(createBrick(171,ItemLayer.FORGROUND,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,145,-1,["Down"]));
         brickPackages.push(_loc65_);
         var _loc66_:ItemBrickPackage = new ItemBrickPackage("outer space","Outer Space",["Ship","Aliens","UFO","Sci-Fi","Science Fiction","Void"]);
         _loc66_.addBrick(createBrick(172,ItemLayer.FORGROUND,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,146,-1,["White","Metal","Plate"]));
         _loc66_.addBrick(createBrick(173,ItemLayer.FORGROUND,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,147,-1,["Blue","Metal","Plate"]));
         _loc66_.addBrick(createBrick(174,ItemLayer.FORGROUND,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,148,-1,["Green","Metal","Plate"]));
         _loc66_.addBrick(createBrick(175,ItemLayer.FORGROUND,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,149,-1,["Red","Magenta","Metal","Plate","Pink"]));
         _loc66_.addBrick(createBrick(176,ItemLayer.FORGROUND,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,150,4294945604,["Sand","Mars","Orange"]));
         _loc66_.addBrick(createBrick(1029,ItemLayer.FORGROUND,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,214,-1,["Moon","Rock","Stone","Metal","Grey","Gray"]));
         _loc66_.addBrick(createBrick(601,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,true,101,-1,["White","Grey","Gray","Metal"]));
         _loc66_.addBrick(createBrick(602,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,true,102,-1,["Blue","Metal"]));
         _loc66_.addBrick(createBrick(603,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,true,103,-1,["Green","Metal"]));
         _loc66_.addBrick(createBrick(604,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,true,104,-1,["Red","Metal"]));
         _loc66_.addBrick(createBrick(332,ItemLayer.DECORATION,decorationsBMD,"","",ItemTab.DECORATIVE,false,false,203,0,["Sign","Panel","Computer","Green"]));
         _loc66_.addBrick(createBrick(333,ItemLayer.DECORATION,decorationsBMD,"","",ItemTab.DECORATIVE,false,false,204,0,["Red","Dot","Light","Lamp","Circle"]));
         _loc66_.addBrick(createBrick(334,ItemLayer.DECORATION,decorationsBMD,"","",ItemTab.DECORATIVE,false,false,205,0,["Blue","Dot","Light","Lamp","Circle"]));
         _loc66_.addBrick(createBrick(335,ItemLayer.DECORATION,decorationsBMD,"","",ItemTab.DECORATIVE,false,false,206,0,["Computer","Control panel","System"]));
         _loc66_.addBrick(createBrick(428,ItemLayer.DECORATION,decorationsBMD,"","",ItemTab.DECORATIVE,false,false,270,0,["Star","Shiny","Red","Light","Night","Sky","Big"]));
         _loc66_.addBrick(createBrick(429,ItemLayer.DECORATION,decorationsBMD,"","",ItemTab.DECORATIVE,false,false,271,0,["Star","Shiny","Blue","Light","Night","Sky","Medium"]));
         _loc66_.addBrick(createBrick(430,ItemLayer.DECORATION,decorationsBMD,"","",ItemTab.DECORATIVE,false,false,272,0,["Star","Shiny","Yellow","Light","Night","Sky","Small"]));
         _loc66_.addBrick(createBrick(331,ItemLayer.ABOVE,decorationsBMD,"","",ItemTab.DECORATIVE,false,false,202,0,["Rock","Hard","Gray","Grey","Boulder","Stone","Environment"]));
         brickPackages.push(_loc66_);
         var _loc67_:ItemBrickPackage = new ItemBrickPackage("desert","Desert Pack",["Environment"]);
         _loc67_.addBrick(createBrick(177,ItemLayer.FORGROUND,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,151,4292711483,["Mars","Orange","Sandstone","Ground","Soil","Dirt","Rocky","Space"]));
         _loc67_.addBrick(createBrick(178,ItemLayer.FORGROUND,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,152,4291200308,["Mars","Orange","Sandstone","Ground","Soil","Dirt","Rocky","Space"]));
         _loc67_.addBrick(createBrick(179,ItemLayer.FORGROUND,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,153,4287717671,["Mars","Orange","Sandstone","Ground","Soil","Dirt","Rocky","Space"]));
         _loc67_.addBrick(createBrick(180,ItemLayer.FORGROUND,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,154,-1,["Mars","Orange","Sandstone","Ground","Soil","Dirt","Rocky","Space"]));
         _loc67_.addBrick(createBrick(181,ItemLayer.FORGROUND,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,155,-1,["Mars","Orange","Sandstone","Ground","Soil","Dirt","Rocky","Space"]));
         _loc67_.addBrick(createBrick(336,ItemLayer.ABOVE,decorationsBMD,"","",ItemTab.DECORATIVE,false,false,207,0,["Rock","Orange","Sandstone","Boulder","Space"]));
         _loc67_.addBrick(createBrick(425,ItemLayer.ABOVE,decorationsBMD,"","",ItemTab.DECORATIVE,false,false,267,0,["Cactus","Nature","Plant","Western"]));
         _loc67_.addBrick(createBrick(426,ItemLayer.ABOVE,decorationsBMD,"","",ItemTab.DECORATIVE,false,false,268,0,["Bush","Cactus","Nature","Plant","Western"]));
         _loc67_.addBrick(createBrick(427,ItemLayer.ABOVE,decorationsBMD,"","",ItemTab.DECORATIVE,false,false,269,0,["Tree","Nature","Plant","Bush","Western","Bonsai"]));
         _loc67_.addBrick(createBrick(699,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,false,193,-1,["Brown","Dirt","Soil","Sandstone"]));
         _loc67_.addBrick(createBrick(700,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,false,194,-1,["Brown","Dirt","Soil","Sandstone"]));
         _loc67_.addBrick(createBrick(701,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,false,195,-1,["Brown","Dirt","Soil","Sandstone"]));
         brickPackages.push(_loc67_);
         var _loc68_:ItemBrickPackage = new ItemBrickPackage("neon","Neon Backgrounds",["Solid"]);
         _loc68_.addBrick(createBrick(675,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickneon","",ItemTab.BACKGROUND,false,true,169,-1,["Magenta","Pink","Red"]));
         _loc68_.addBrick(createBrick(673,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickneon","",ItemTab.BACKGROUND,false,true,167,-1,["Orange","Fire"]));
         _loc68_.addBrick(createBrick(697,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickneon","",ItemTab.BACKGROUND,false,true,191,-1,["Yellow"]));
         _loc68_.addBrick(createBrick(674,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickneon","",ItemTab.BACKGROUND,false,true,168,-1,["Green","Jungle"]));
         _loc68_.addBrick(createBrick(698,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickneon","",ItemTab.BACKGROUND,false,true,192,-1,["Cyan"]));
         _loc68_.addBrick(createBrick(605,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickneon","",ItemTab.BACKGROUND,false,true,105,-1,["Blue","Night","Sky","Dark"]));
         brickPackages.push(_loc68_);
         var _loc69_:ItemBrickPackage = new ItemBrickPackage("monster","Monster",["Creature"]);
         _loc69_.addBrick(createBrick(608,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickmonster","",ItemTab.BACKGROUND,false,true,108,4288716897,["Green","Grass"]));
         _loc69_.addBrick(createBrick(609,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickmonster","",ItemTab.BACKGROUND,false,true,109,4285558852,["Green","Dark","Grass"]));
         _loc69_.addBrick(createBrick(663,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickmonster","",ItemTab.BACKGROUND,false,true,157,-1,["Red","Pink","Scales"]));
         _loc69_.addBrick(createBrick(664,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickmonster","",ItemTab.BACKGROUND,false,false,158,-1,["Red","Pink","Dark","Scales"]));
         _loc69_.addBrick(createBrick(665,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickmonster","",ItemTab.BACKGROUND,false,false,159,-1,["Purple","Scales","Violet"]));
         _loc69_.addBrick(createBrick(666,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickmonster","",ItemTab.BACKGROUND,false,false,160,-1,["Purple","Scales","Dark","Violet"]));
         _loc69_.addBrick(createBrick(ItemId.TOOTH_BIG,ItemLayer.DECORATION,specialBricksBMD,"brickmonster","",ItemTab.DECORATIVE,false,false,385,0,["Teeth","Tooth","Creepy","Morphable","Scary"]));
         _loc69_.addBrick(createBrick(ItemId.TOOTH_SMALL,ItemLayer.DECORATION,specialBricksBMD,"brickmonster","",ItemTab.DECORATIVE,false,false,381,0,["Teeth","Tooth","Creepy","Morphable","Scary"]));
         _loc69_.addBrick(createBrick(ItemId.TOOTH_TRIPLE,ItemLayer.DECORATION,specialBricksBMD,"brickmonster","",ItemTab.DECORATIVE,false,false,401,0,["Teeth","Tooth","Creepy","Morphable","Scary"]));
         _loc69_.addBrick(createBrick(274,ItemLayer.DECORATION,decorationsBMD,"brickmonster","",ItemTab.DECORATIVE,false,false,146,0,["Eye","Purple","Circle","Creepy","Ball","Scary"]));
         _loc69_.addBrick(createBrick(341,ItemLayer.DECORATION,decorationsBMD,"brickmonster","",ItemTab.DECORATIVE,false,false,211,0,["Eye","Yellow","Circle","Creepy","Ball","Scary"]));
         _loc69_.addBrick(createBrick(342,ItemLayer.DECORATION,decorationsBMD,"brickmonster","",ItemTab.DECORATIVE,false,false,212,0,["Eye","Blue","Circle","Creepy","Ball","Scary"]));
         brickPackages.push(_loc69_);
         var _loc70_:ItemBrickPackage = new ItemBrickPackage("fog","Fog",["Mist","Transparent","Damp","Environment"]);
         _loc70_.addBrick(createBrick(343,ItemLayer.ABOVE,decorationsBMD,"brickfog","",ItemTab.DECORATIVE,false,false,213,0,["Center","Middle"]));
         _loc70_.addBrick(createBrick(344,ItemLayer.ABOVE,decorationsBMD,"brickfog","",ItemTab.DECORATIVE,false,false,214,0,["Bottom","Side"]));
         _loc70_.addBrick(createBrick(345,ItemLayer.ABOVE,decorationsBMD,"brickfog","",ItemTab.DECORATIVE,false,false,215,0,["Top","Side"]));
         _loc70_.addBrick(createBrick(346,ItemLayer.ABOVE,decorationsBMD,"brickfog","",ItemTab.DECORATIVE,false,false,216,0,["Left","Side"]));
         _loc70_.addBrick(createBrick(347,ItemLayer.ABOVE,decorationsBMD,"brickfog","",ItemTab.DECORATIVE,false,false,217,0,["Right","Side"]));
         _loc70_.addBrick(createBrick(348,ItemLayer.ABOVE,decorationsBMD,"brickfog","",ItemTab.DECORATIVE,false,false,218,0,["Top Right","Corner"]));
         _loc70_.addBrick(createBrick(349,ItemLayer.ABOVE,decorationsBMD,"brickfog","",ItemTab.DECORATIVE,false,false,219,0,["Top Left","Corner"]));
         _loc70_.addBrick(createBrick(350,ItemLayer.ABOVE,decorationsBMD,"brickfog","",ItemTab.DECORATIVE,false,false,220,0,["Bottom Left","Corner"]));
         _loc70_.addBrick(createBrick(351,ItemLayer.ABOVE,decorationsBMD,"brickfog","",ItemTab.DECORATIVE,false,false,221,0,["Bottom Right","Corner"]));
         brickPackages.push(_loc70_);
         var _loc71_:ItemBrickPackage = new ItemBrickPackage("halloween 2012","Halloween 2012",["Holiday","Spooky"]);
         _loc71_.addBrick(createBrick(352,ItemLayer.ABOVE,decorationsBMD,"brickhw2012","",ItemTab.DECORATIVE,false,true,222,0,["Head","Transfer","Lamp","Top"]));
         _loc71_.addBrick(createBrick(353,ItemLayer.DECORATION,decorationsBMD,"brickhw2012","",ItemTab.DECORATIVE,false,false,223,0,["Antenna","Tesla coil","Middle"]));
         _loc71_.addBrick(createBrick(354,ItemLayer.DECORATION,decorationsBMD,"brickhw2012","",ItemTab.DECORATIVE,false,true,224,0,["Wire","Blue","Red","Electricity","Wiring","Power","Vertical"]));
         _loc71_.addBrick(createBrick(355,ItemLayer.DECORATION,decorationsBMD,"brickhw2012","",ItemTab.DECORATIVE,false,true,225,0,["Wire","Blue","Red","Electricity","Wiring","Power","Horizontal"]));
         _loc71_.addBrick(createBrick(356,ItemLayer.ABOVE,decorationsBMD,"brickhw2012","",ItemTab.DECORATIVE,false,false,226,0,["Lightning","Storm","Electricity","Environment"]));
         brickPackages.push(_loc71_);
         var _loc72_:ItemBrickPackage = new ItemBrickPackage("checker","Checker Blocks",["Checkered"]);
         _loc72_.addBrick(createBrick(1091,ItemLayer.DECORATION,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,263,4290756543,["White","Light"]));
         _loc72_.addBrick(createBrick(186,ItemLayer.DECORATION,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,161,4285229931,["Gray","Grey"]));
         _loc72_.addBrick(createBrick(1026,ItemLayer.DECORATION,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,213,-1,["Black","Dark","Gray","Grey"]));
         _loc72_.addBrick(createBrick(189,ItemLayer.DECORATION,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,164,4289206591,["Red","Magenta"]));
         _loc72_.addBrick(createBrick(1025,ItemLayer.DECORATION,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,212,-1,["Orange"]));
         _loc72_.addBrick(createBrick(190,ItemLayer.DECORATION,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,165,4289442611,["Yellow","Lime"]));
         _loc72_.addBrick(createBrick(191,ItemLayer.DECORATION,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,166,4282753847,["Green"]));
         _loc72_.addBrick(createBrick(192,ItemLayer.DECORATION,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,167,4282167980,["Cyan","Blue"]));
         _loc72_.addBrick(createBrick(187,ItemLayer.DECORATION,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,162,4281291665,["Blue"]));
         _loc72_.addBrick(createBrick(188,ItemLayer.DECORATION,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,163,4286594449,["Purple","Magenta","Pink","Violet"]));
         brickPackages.push(_loc72_);
         var _loc73_:ItemBrickPackage = new ItemBrickPackage("jungle","Jungle");
         _loc73_.addBrick(createBrick(193,ItemLayer.DECORATION,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,168,0,["Idol","Face","Brick","No show","Statue","Totem","Ruins"]));
         _loc73_.addBrick(createBrick(194,ItemLayer.DECORATION,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,169,0,["Platform","Old","Mossy","Ruins","Stone"]));
         _loc73_.addBrick(createBrick(195,ItemLayer.FORGROUND,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,170,4288256378,["Brick","Grey","Gray","Ruins","Stone"]));
         _loc73_.addBrick(createBrick(196,ItemLayer.FORGROUND,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,171,4289491041,["Brick","Red","Pink","Ruins","Stone"]));
         _loc73_.addBrick(createBrick(197,ItemLayer.FORGROUND,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,172,4284647578,["Brick","Blue","Ruins","Stone"]));
         _loc73_.addBrick(createBrick(198,ItemLayer.FORGROUND,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,173,4287071297,["Brick","Yellow","Olive","Ruins","Stone","Green"]));
         _loc73_.addBrick(createBrick(617,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,true,117,4284900945,["Brick","Grey","Gray","Ruins","Stone"]));
         _loc73_.addBrick(createBrick(618,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,true,118,4286008900,["Brick","Red","Pink","Ruins","Stone"]));
         _loc73_.addBrick(createBrick(619,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,true,119,4282473062,["Brick","Blue","Ruins","Stone"]));
         _loc73_.addBrick(createBrick(620,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,true,120,4285229108,["Brick","Yellow","Olive","Ruins","Stone","Green"]));
         _loc73_.addBrick(createBrick(199,ItemLayer.DECORATION,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,176,0,["Pot","Jar","Clay","Ruins","Urn"]));
         _loc73_.addBrick(createBrick(621,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,true,121,4285039619,["Leaves","Green","Grass","Environment","Nature"]));
         _loc73_.addBrick(createBrick(622,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,true,122,4283985923,["Leaves","Green","Grass","Environment","Nature"]));
         _loc73_.addBrick(createBrick(623,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,true,123,4282536962,["Leaves","Green","Grass","Environment","Nature"]));
         _loc73_.addBrick(createBrick(357,ItemLayer.ABOVE,decorationsBMD,"","",ItemTab.DECORATIVE,false,false,227,0,["Bush","Plant","Nature","Environment"]));
         _loc73_.addBrick(createBrick(358,ItemLayer.ABOVE,decorationsBMD,"","",ItemTab.DECORATIVE,false,false,228,0,["Rock","Pot","Jar","Basket","Ruins","Clay"]));
         _loc73_.addBrick(createBrick(359,ItemLayer.ABOVE,decorationsBMD,"","",ItemTab.DECORATIVE,false,false,229,0,["Idol","Statue","Gold","Trophy","Artifact","Artefact","Yellow","Ruins"]));
         brickPackages.push(_loc73_);
         var _loc74_:ItemBrickPackage = new ItemBrickPackage("christmas 2012","Christmas 2012",["Xmas","Holiday"]);
         _loc74_.addBrick(createBrick(624,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickxmas2012","",ItemTab.BACKGROUND,false,true,124,4292381209,["Wrapping paper","Yellow","Stripes"]));
         _loc74_.addBrick(createBrick(625,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickxmas2012","",ItemTab.BACKGROUND,false,true,125,4283728909,["Wrapping paper","Green","Stripes"]));
         _loc74_.addBrick(createBrick(626,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickxmas2012","",ItemTab.BACKGROUND,false,true,126,4280236504,["Wrapping paper","Blue","Purple","Dots","Spots"]));
         _loc74_.addBrick(createBrick(362,ItemLayer.DECORATION,decorationsBMD,"brickxmas2012","",ItemTab.DECORATIVE,false,true,230,0,["Ribbon","Blue","Vertical"]));
         _loc74_.addBrick(createBrick(363,ItemLayer.DECORATION,decorationsBMD,"brickxmas2012","",ItemTab.DECORATIVE,false,true,231,0,["Ribbon","Blue","Horizontal"]));
         _loc74_.addBrick(createBrick(364,ItemLayer.DECORATION,decorationsBMD,"brickxmas2012","",ItemTab.DECORATIVE,false,true,232,0,["Ribbon","Blue","Cross","Middle"]));
         _loc74_.addBrick(createBrick(365,ItemLayer.DECORATION,decorationsBMD,"brickxmas2012","",ItemTab.DECORATIVE,false,true,233,0,["Ribbon","Purple","Vertical","Magenta","Red"]));
         _loc74_.addBrick(createBrick(366,ItemLayer.DECORATION,decorationsBMD,"brickxmas2012","",ItemTab.DECORATIVE,false,true,234,0,["Ribbon","Purple","Horizontal","Magenta","Red"]));
         _loc74_.addBrick(createBrick(367,ItemLayer.DECORATION,decorationsBMD,"brickxmas2012","",ItemTab.DECORATIVE,false,true,235,0,["Ribbon","Purple","Cross","Middle","Magenta","Red"]));
         brickPackages.push(_loc74_);
         var _loc75_:ItemBrickPackage = new ItemBrickPackage("lava","Lava",["Hell","Hot","Environment","Heat"]);
         _loc75_.addBrick(createBrick(202,ItemLayer.FORGROUND,forgroundBricksBMD,"bricklava","",ItemTab.BLOCK,false,true,177,4294954558,["Yellow"]));
         _loc75_.addBrick(createBrick(203,ItemLayer.FORGROUND,forgroundBricksBMD,"bricklava","",ItemTab.BLOCK,false,true,178,4294612750,["Orange"]));
         _loc75_.addBrick(createBrick(204,ItemLayer.FORGROUND,forgroundBricksBMD,"bricklava","",ItemTab.BLOCK,false,true,179,4294926080,["Orange","Red"]));
         _loc75_.addBrick(createBrick(627,ItemLayer.BACKGROUND,backgroundBricksBMD,"bricklava","",ItemTab.BACKGROUND,false,true,127,4291601203,["Yellow"]));
         _loc75_.addBrick(createBrick(628,ItemLayer.BACKGROUND,backgroundBricksBMD,"bricklava","",ItemTab.BACKGROUND,false,true,128,4291196171,["Orange"]));
         _loc75_.addBrick(createBrick(629,ItemLayer.BACKGROUND,backgroundBricksBMD,"bricklava","",ItemTab.BACKGROUND,false,true,129,4290198016,["Red","Orange"]));
         _loc75_.addBrick(createBrick(415,ItemLayer.ABOVE,decorationsBMD,"bricklava","",ItemTab.DECORATIVE,false,false,264,0,["Fire","Glow","Orange"]));
         brickPackages.push(_loc75_);
         var _loc76_:ItemBrickPackage = new ItemBrickPackage("swamp","Swamp");
         _loc76_.addBrick(createBrick(370,ItemLayer.ABOVE,specialBricksBMD,"brickswamp","",ItemTab.DECORATIVE,false,false,249,0,["Mud","Bubbles","Gas","Nature","Environment","Animated"]));
         _loc76_.addBrick(createBrick(371,ItemLayer.ABOVE,decorationsBMD,"brickswamp","",ItemTab.DECORATIVE,false,false,236,0,["Grass","Thick","Nature","Plant","Environment"]));
         _loc76_.addBrick(createBrick(372,ItemLayer.ABOVE,decorationsBMD,"brickswamp","",ItemTab.DECORATIVE,false,false,237,0,["Wood","Nature","Log","Environment"]));
         _loc76_.addBrick(createBrick(373,ItemLayer.ABOVE,decorationsBMD,"brickswamp","",ItemTab.DECORATIVE,false,false,238,0,["Danger","Sign","Caution","Radioactive","Nuclear"]));
         _loc76_.addBrick(createBrick(557,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickswamp","",ItemTab.BACKGROUND,false,false,57,-1,["Mud","Quicksand","Environment","Soil"]));
         _loc76_.addBrick(createBrick(630,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickswamp","",ItemTab.BACKGROUND,false,false,130,4284504612,["Green","Grass","Environment","Soil"]));
         brickPackages.push(_loc76_);
         var _loc77_:ItemBrickPackage = new ItemBrickPackage("marble","Sparta",["Rome","Sparta","House","Greece","Roman"]);
         _loc77_.addBrick(createBrick(382,ItemLayer.DECORATION,decorationsBMD,"bricksparta","",ItemTab.DECORATIVE,false,true,239,0,["Column","Top","Ancient"]));
         _loc77_.addBrick(createBrick(383,ItemLayer.DECORATION,decorationsBMD,"bricksparta","",ItemTab.DECORATIVE,false,true,240,0,["Column","Middle","Ancient"]));
         _loc77_.addBrick(createBrick(384,ItemLayer.DECORATION,decorationsBMD,"bricksparta","",ItemTab.DECORATIVE,false,true,241,0,["Column","Bottom","Ancient"]));
         _loc77_.addBrick(createBrick(208,ItemLayer.FORGROUND,forgroundBricksBMD,"bricksparta","",ItemTab.BLOCK,false,true,180,4291678675,["Brick","White","Ancient","Grey","Gray"]));
         _loc77_.addBrick(createBrick(209,ItemLayer.FORGROUND,forgroundBricksBMD,"bricksparta","",ItemTab.BLOCK,false,true,181,4290895033,["Brick","Green","Ancient"]));
         _loc77_.addBrick(createBrick(210,ItemLayer.FORGROUND,forgroundBricksBMD,"bricksparta","",ItemTab.BLOCK,false,true,182,4293248719,["Brick","Red","Pink","Ancient"]));
         _loc77_.addBrick(createBrick(211,ItemLayer.DECORATION,forgroundBricksBMD,"bricksparta","",ItemTab.BLOCK,false,true,183,0,["Column","Platform","Top","Ancient","One-Way","One Way"]));
         _loc77_.addBrick(createBrick(638,ItemLayer.BACKGROUND,backgroundBricksBMD,"bricksparta","",ItemTab.BACKGROUND,false,false,132,4286020477,["Brick","White","Ancient","Grey","Gray"]));
         _loc77_.addBrick(createBrick(639,ItemLayer.BACKGROUND,backgroundBricksBMD,"bricksparta","",ItemTab.BACKGROUND,false,false,133,4285563247,["Brick","Green","Ancient"]));
         _loc77_.addBrick(createBrick(640,ItemLayer.BACKGROUND,backgroundBricksBMD,"bricksparta","",ItemTab.BACKGROUND,false,false,134,4286805627,["Brick","Red","Pink","Ancient"]));
         brickPackages.push(_loc77_);
         var _loc78_:ItemBrickPackage = new ItemBrickPackage("Label","Admin Blocks");
         _loc78_.addBrick(createBrick(1000,ItemLayer.DECORATION,decorationsBMD,"","",ItemTab.ACTION,false,true,265,0,["Text","Words","ModText"],true));
         brickPackages.push(_loc78_);
         var _loc79_:ItemBrickPackage = new ItemBrickPackage("sign","Signs (+1)");
         _loc79_.addBrick(createBrick(ItemId.TEXT_SIGN,ItemLayer.ABOVE,specialBricksBMD,"bricksign","players will see a custom message when they touch this block",ItemTab.ACTION,false,true,513,0,["Morphable","Write","Text","Wood","Info"]));
         brickPackages.push(_loc79_);
         var _loc80_:ItemBrickPackage = new ItemBrickPackage("farm","Farm");
         _loc80_.addBrick(createBrick(386,ItemLayer.ABOVE,decorationsBMD,"brickfarm","",ItemTab.DECORATIVE,false,false,243,-1,["Wheat","Nature","Plant","Environment"]));
         _loc80_.addBrick(createBrick(387,ItemLayer.ABOVE,decorationsBMD,"brickfarm","",ItemTab.DECORATIVE,false,false,244,-1,["Corn","Nature","Plant","Environment"]));
         _loc80_.addBrick(createBrick(388,ItemLayer.ABOVE,decorationsBMD,"brickfarm","",ItemTab.DECORATIVE,false,false,245,-1,["Fence","Wood","Left"]));
         _loc80_.addBrick(createBrick(389,ItemLayer.ABOVE,decorationsBMD,"brickfarm","",ItemTab.DECORATIVE,false,false,246,-1,["Fence","Wood","Right"]));
         _loc80_.addBrick(createBrick(212,ItemLayer.DECORATION,forgroundBricksBMD,"brickfarm","",ItemTab.BLOCK,false,true,184,4291608181,["Hay","Yellow","Haybale","Straw"]));
         brickPackages.push(_loc80_);
         var _loc81_:ItemBrickPackage = new ItemBrickPackage("autumn 2014","Autumn 2014",["Nature","Environment","Season","Fall"]);
         _loc81_.addBrick(createBrick(390,ItemLayer.ABOVE,decorationsBMD,"brickautumn2014","",ItemTab.DECORATIVE,false,false,247,-1,["Leaves","Left","Orange"]));
         _loc81_.addBrick(createBrick(391,ItemLayer.ABOVE,decorationsBMD,"brickautumn2014","",ItemTab.DECORATIVE,false,false,248,-1,["Leaves","Right","Orange"]));
         _loc81_.addBrick(createBrick(392,ItemLayer.ABOVE,decorationsBMD,"brickautumn2014","",ItemTab.DECORATIVE,false,false,249,-1,["Grass","Left"]));
         _loc81_.addBrick(createBrick(393,ItemLayer.ABOVE,decorationsBMD,"brickautumn2014","",ItemTab.DECORATIVE,false,false,250,-1,["Grass","Middle"]));
         _loc81_.addBrick(createBrick(394,ItemLayer.ABOVE,decorationsBMD,"brickautumn2014","",ItemTab.DECORATIVE,false,false,251,-1,["Grass","Right"]));
         _loc81_.addBrick(createBrick(395,ItemLayer.ABOVE,decorationsBMD,"brickautumn2014","",ItemTab.DECORATIVE,false,false,252,-1,["Acorn","Nut","Brown"]));
         _loc81_.addBrick(createBrick(396,ItemLayer.ABOVE,decorationsBMD,"brickautumn2014","",ItemTab.DECORATIVE,false,false,253,-1,["Pumpkin","Halloween","Food","Orange"]));
         _loc81_.addBrick(createBrick(641,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickautumn2014","",ItemTab.BACKGROUND,false,true,135,-1,["Leaves","Yellow"]));
         _loc81_.addBrick(createBrick(642,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickautumn2014","",ItemTab.BACKGROUND,false,true,136,-1,["Leaves","Orange"]));
         _loc81_.addBrick(createBrick(643,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickautumn2014","",ItemTab.BACKGROUND,false,true,137,-1,["Leaves","Red"]));
         brickPackages.push(_loc81_);
         var _loc82_:ItemBrickPackage = new ItemBrickPackage("christmas 2014","Christmas 2014",["Xmas","Holiday"]);
         _loc82_.addBrick(createBrick(215,ItemLayer.FORGROUND,forgroundBricksBMD,"brickchristmas2014","",ItemTab.BLOCK,false,true,187,-1,["Snow","Environment"]));
         _loc82_.addBrick(createBrick(216,ItemLayer.DECORATION,forgroundBricksBMD,"brickchristmas2014","",ItemTab.BLOCK,false,true,188,-1,["Ice","Snow","Platform","Icicle","Top","Environment","One-Way","One Way"]));
         _loc82_.addBrick(createBrick(398,ItemLayer.ABOVE,decorationsBMD,"brickchristmas2014","",ItemTab.DECORATIVE,false,false,254,-1,["Snow","Fluff","Left","Snowdrift","Environment"]));
         _loc82_.addBrick(createBrick(399,ItemLayer.ABOVE,decorationsBMD,"brickchristmas2014","",ItemTab.DECORATIVE,false,false,255,-1,["Snow","Fluff","Middle","Snowdrift","Environment"]));
         _loc82_.addBrick(createBrick(400,ItemLayer.ABOVE,decorationsBMD,"brickchristmas2014","",ItemTab.DECORATIVE,false,false,256,-1,["Snow","Fluff","Right","Snowdrift","Environment"]));
         _loc82_.addBrick(createBrick(401,ItemLayer.ABOVE,decorationsBMD,"brickchristmas2014","",ItemTab.DECORATIVE,false,false,257,0,["Candy cane","Stripes"]));
         _loc82_.addBrick(createBrick(402,ItemLayer.DECORATION,decorationsBMD,"brickchristmas2014","",ItemTab.DECORATIVE,false,true,258,0,["Tinsel","Nature","Garland","Top"]));
         _loc82_.addBrick(createBrick(403,ItemLayer.DECORATION,decorationsBMD,"brickchristmas2014","",ItemTab.DECORATIVE,false,true,259,0,["Stocking","Sock","Red","Holiday"]));
         _loc82_.addBrick(createBrick(404,ItemLayer.DECORATION,decorationsBMD,"brickchristmas2014","",ItemTab.DECORATIVE,false,true,260,0,["Bow","Ribbon","Red"]));
         brickPackages.push(_loc82_);
         var _loc83_:ItemBrickPackage = new ItemBrickPackage("one-way","One-way Blocks",["Platform"]);
         _loc83_.addBrick(createBrick(ItemId.ONEWAY_WHITE,ItemLayer.DECORATION,specialBricksBMD,"brickoneway","",ItemTab.BLOCK,false,false,566,-1,["One way","White","Light","Morphable","One-way"]));
         _loc83_.addBrick(createBrick(ItemId.ONEWAY_GRAY,ItemLayer.DECORATION,specialBricksBMD,"brickoneway","",ItemTab.BLOCK,false,false,472,-1,["One way","Gray","Grey","Morphable","One-way"]));
         _loc83_.addBrick(createBrick(ItemId.ONEWAY_BLACK,ItemLayer.DECORATION,specialBricksBMD,"brickoneway","",ItemTab.BLOCK,false,false,488,-1,["One way","Black","Dark","Morphable","One-way"]));
         _loc83_.addBrick(createBrick(ItemId.ONEWAY_RED,ItemLayer.DECORATION,specialBricksBMD,"brickoneway","",ItemTab.BLOCK,false,false,480,-1,["One way","Red","Morphable","One-way"]));
         _loc83_.addBrick(createBrick(ItemId.ONEWAY_ORANGE,ItemLayer.DECORATION,specialBricksBMD,"brickoneway","",ItemTab.BLOCK,false,false,272,-1,["One way","Orange","Morphable","One-way"]));
         _loc83_.addBrick(createBrick(ItemId.ONEWAY_YELLOW,ItemLayer.DECORATION,specialBricksBMD,"brickoneway","",ItemTab.BLOCK,false,false,268,-1,["One way","Yellow","Morphable","One-way"]));
         _loc83_.addBrick(createBrick(ItemId.ONEWAY_GREEN,ItemLayer.DECORATION,specialBricksBMD,"brickoneway","",ItemTab.BLOCK,false,false,484,-1,["One way","Green","Morphable","One-way"]));
         _loc83_.addBrick(createBrick(ItemId.ONEWAY_CYAN,ItemLayer.DECORATION,specialBricksBMD,"brickoneway","",ItemTab.BLOCK,false,false,264,-1,["One way","Cyan","Blue","Morphable","One-way"]));
         _loc83_.addBrick(createBrick(ItemId.ONEWAY_BLUE,ItemLayer.DECORATION,specialBricksBMD,"brickoneway","",ItemTab.BLOCK,false,false,476,-1,["One way","Blue","Dark","Morphable","One-way"]));
         _loc83_.addBrick(createBrick(ItemId.ONEWAY_PINK,ItemLayer.DECORATION,specialBricksBMD,"brickoneway","",ItemTab.BLOCK,false,false,276,-1,["One way","Purple","Pink","Morphable","One-way"]));
         brickPackages.push(_loc83_);
         var _loc84_:ItemBrickPackage = new ItemBrickPackage("valentines 2015","Valentines 2015",["Kiss","Holiday","Love","Heart","<3"]);
         _loc84_.addBrick(createBrick(405,ItemLayer.DECORATION,decorationsBMD,"brickvalentines2015","",ItemTab.DECORATIVE,false,true,261,0,["Red"]));
         _loc84_.addBrick(createBrick(406,ItemLayer.DECORATION,decorationsBMD,"brickvalentines2015","",ItemTab.DECORATIVE,false,true,262,0,["Purple","Pink"]));
         _loc84_.addBrick(createBrick(407,ItemLayer.DECORATION,decorationsBMD,"brickvalentines2015","",ItemTab.DECORATIVE,false,true,263,0,["Pink"]));
         brickPackages.push(_loc84_);
         var _loc85_:ItemBrickPackage = new ItemBrickPackage("magic","Magic Blocks",["Rare"]);
         _loc85_.addBrick(createBrick(1013,ItemLayer.FORGROUND,forgroundBricksBMD,"brickmagic","the first magic block",ItemTab.BLOCK,false,true,200,-1,["Green","Emerald","Peridot"]));
         _loc85_.addBrick(createBrick(1014,ItemLayer.FORGROUND,forgroundBricksBMD,"brickmagic2","the second magic block",ItemTab.BLOCK,false,true,201,-1,["Purple","Violet","Amethyst"]));
         _loc85_.addBrick(createBrick(1015,ItemLayer.FORGROUND,forgroundBricksBMD,"brickmagic3","the third magic block",ItemTab.BLOCK,false,true,202,-1,["Yellow","Orange","Amber","Topaz"]));
         _loc85_.addBrick(createBrick(1016,ItemLayer.FORGROUND,forgroundBricksBMD,"brickmagic4","the fourth magic block",ItemTab.BLOCK,false,true,203,-1,["Blue","Sapphire"]));
         _loc85_.addBrick(createBrick(1017,ItemLayer.FORGROUND,forgroundBricksBMD,"brickmagic5","the fifth magic block",ItemTab.BLOCK,false,true,204,-1,["Red","Ruby"]));
         brickPackages.push(_loc85_);
         var _loc86_:ItemBrickPackage = new ItemBrickPackage("effect","Effect Blocks",["Powers","Action","Physics"]);
         _loc86_.addBrick(createBrick(ItemId.EFFECT_JUMP,ItemLayer.DECORATION,effectBricksBMD,"brickeffectjump","jump effect: players jump twice as high",ItemTab.ACTION,false,false,0,0,["Jump","Boost","High"]));
         _loc86_.addBrick(createBrick(ItemId.EFFECT_FLY,ItemLayer.DECORATION,effectBricksBMD,"brickeffectfly","fly effect: players can levitate by holding space",ItemTab.ACTION,false,false,1,0,["Fly","Hover","Levitate"]));
         _loc86_.addBrick(createBrick(ItemId.EFFECT_RUN,ItemLayer.DECORATION,effectBricksBMD,"brickeffectspeed","speed effect: players move 50% faster",ItemTab.ACTION,false,false,2,0,["Speed","Fast","Run"]));
         _loc86_.addBrick(createBrick(ItemId.EFFECT_LOW_GRAVITY,ItemLayer.DECORATION,effectBricksBMD,"brickeffectlowgravity","low gravity effect: player gravity is reduced",ItemTab.ACTION,false,false,13,0,["Gravity","Moon","Low gravity","Space","Slow fall","Float"]));
         _loc86_.addBrick(createBrick(ItemId.EFFECT_PROTECTION,ItemLayer.DECORATION,effectBricksBMD,"brickeffectprotection","protection effect: players are safe from hazards and cured from curses/zombies",ItemTab.ACTION,false,false,3,0,["Invincible","Health","Plus","Immortal","Protection"]));
         _loc86_.addBrick(createBrick(ItemId.EFFECT_CURSE,ItemLayer.DECORATION,effectBricksBMD,"brickeffectcurse","players die after X seconds, spreads on contact, maximum of 3 curses at a time",ItemTab.ACTION,false,false,4,0,["Curse","Skull","Skeleton","Timed","Death","Die","Kill"]));
         _loc86_.addBrick(createBrick(ItemId.EFFECT_MULTIJUMP,ItemLayer.DECORATION,effectBricksBMD,"brickeffectmultijump","multijump effect: players can jump X times",ItemTab.ACTION,false,false,16,0,["Double","Jump","Twice","Powers","Action","Physics"]));
         brickPackages.push(_loc86_);
         var _loc87_:ItemBrickPackage = new ItemBrickPackage("gold","Gold Membership Blocks",["Shiny","Yellow"]);
         _loc87_.addBrick(createBrick(1065,ItemLayer.FORGROUND,forgroundBricksBMD,"goldmember","",ItemTab.BLOCK,true,true,242,-1,[]));
         _loc87_.addBrick(createBrick(1066,ItemLayer.FORGROUND,forgroundBricksBMD,"goldmember","",ItemTab.BLOCK,true,true,243,-1,[]));
         _loc87_.addBrick(createBrick(1067,ItemLayer.FORGROUND,forgroundBricksBMD,"goldmember","",ItemTab.BLOCK,true,true,244,-1,[]));
         _loc87_.addBrick(createBrick(1068,ItemLayer.FORGROUND,forgroundBricksBMD,"goldmember","",ItemTab.BLOCK,true,true,245,-1,[]));
         _loc87_.addBrick(createBrick(1069,ItemLayer.DECORATION,forgroundBricksBMD,"goldmember","",ItemTab.BLOCK,true,true,246,0,[]));
         _loc87_.addBrick(createBrick(709,ItemLayer.BACKGROUND,backgroundBricksBMD,"goldmember","",ItemTab.BACKGROUND,true,false,198,-1,[]));
         _loc87_.addBrick(createBrick(710,ItemLayer.BACKGROUND,backgroundBricksBMD,"goldmember","",ItemTab.BACKGROUND,true,false,199,-1,[]));
         _loc87_.addBrick(createBrick(711,ItemLayer.BACKGROUND,backgroundBricksBMD,"goldmember","",ItemTab.BACKGROUND,true,false,200,-1,[]));
         _loc87_.addBrick(createBrick(ItemId.GATE_GOLD,ItemLayer.DECORATION,doorsBMD,"goldmember","",ItemTab.ACTION,true,false,10,-1,[]));
         _loc87_.addBrick(createBrick(ItemId.DOOR_GOLD,ItemLayer.DECORATION,doorsBMD,"goldmember","",ItemTab.ACTION,true,false,11,-1,[]));
         brickPackages.push(_loc87_);
         var _loc88_:ItemBrickPackage = new ItemBrickPackage("cave","Cave Backgrounds",["Environment"]);
         _loc88_.addBrick(createBrick(655,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickcave","",ItemTab.BACKGROUND,false,false,149,-1,["Dark","Purple"]));
         _loc88_.addBrick(createBrick(656,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickcave","",ItemTab.BACKGROUND,false,false,150,-1,["Dark","Cyan"]));
         _loc88_.addBrick(createBrick(657,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickcave","",ItemTab.BACKGROUND,false,false,151,-1,["Dark","Blue","Night","Sky"]));
         _loc88_.addBrick(createBrick(658,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickcave","",ItemTab.BACKGROUND,false,false,152,-1,["Dark","Pink","Magenta","Violet"]));
         _loc88_.addBrick(createBrick(659,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickcave","",ItemTab.BACKGROUND,false,false,153,-1,["Dark","Green"]));
         _loc88_.addBrick(createBrick(660,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickcave","",ItemTab.BACKGROUND,false,false,154,-1,["Dark","Orange","Brown"]));
         _loc88_.addBrick(createBrick(661,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickcave","",ItemTab.BACKGROUND,false,false,155,-1,["Dark","Yellow","Olive"]));
         _loc88_.addBrick(createBrick(662,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickcave","",ItemTab.BACKGROUND,false,false,156,-1,["Dark","Red"]));
         brickPackages.push(_loc88_);
         var _loc89_:ItemBrickPackage = new ItemBrickPackage("summer 2015","Summer 2015",["Season"]);
         _loc89_.addBrick(createBrick(441,ItemLayer.ABOVE,decorationsBMD,"bricksummer2015","",ItemTab.DECORATIVE,false,true,280,0,["Life preserver","Life saver","Circle","Life buoy","Ring"]));
         _loc89_.addBrick(createBrick(442,ItemLayer.DECORATION,decorationsBMD,"bricksummer2015","",ItemTab.DECORATIVE,false,true,281,0,["Anchor","Metal","Ship","Water"]));
         _loc89_.addBrick(createBrick(443,ItemLayer.ABOVE,decorationsBMD,"bricksummer2015","",ItemTab.DECORATIVE,false,false,282,0,["Rope","Left","Dock"]));
         _loc89_.addBrick(createBrick(444,ItemLayer.ABOVE,decorationsBMD,"bricksummer2015","",ItemTab.DECORATIVE,false,false,283,0,["Rope","Right","Dock"]));
         _loc89_.addBrick(createBrick(445,ItemLayer.ABOVE,decorationsBMD,"bricksummer2015","",ItemTab.DECORATIVE,false,false,284,0,["Tree","Nature","Palm","Plant","Environment"]));
         brickPackages.push(_loc89_);
         var _loc90_:ItemBrickPackage = new ItemBrickPackage("environment","Environment",["Nature"]);
         _loc90_.addBrick(createBrick(1030,ItemLayer.FORGROUND,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,215,-1,["Wood","Tree","Brown"]));
         _loc90_.addBrick(createBrick(1031,ItemLayer.FORGROUND,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,216,-1,["Leaves","Grass","Green","Plant"]));
         _loc90_.addBrick(createBrick(1032,ItemLayer.FORGROUND,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,217,-1,["Bamboo","Wood","Yellow"]));
         _loc90_.addBrick(createBrick(1033,ItemLayer.FORGROUND,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,218,-1,["Obsidian","Rock","Ice","Grey","Gray"]));
         _loc90_.addBrick(createBrick(1034,ItemLayer.FORGROUND,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,219,-1,["Fire","Lava","Hot"]));
         _loc90_.addBrick(createBrick(678,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,false,172,-1,["Wood","Tree","Brown"]));
         _loc90_.addBrick(createBrick(679,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,false,173,-1,["Leaves","Grass","Green"]));
         _loc90_.addBrick(createBrick(680,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,false,174,-1,["Bamboo","Wood"]));
         _loc90_.addBrick(createBrick(681,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,false,175,-1,["Obsidian","Rock","Ice","Grey","Gray"]));
         _loc90_.addBrick(createBrick(682,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,false,176,-1,["Fire","Lava","Hot","Molten"]));
         brickPackages.push(_loc90_);
         var _loc91_:ItemBrickPackage = new ItemBrickPackage("domestic","Domestic",["House"]);
         _loc91_.addBrick(createBrick(1035,ItemLayer.FORGROUND,forgroundBricksBMD,"brickdomestic","",ItemTab.BLOCK,false,true,220,-1,["Tile","Double","Floor","Parquet","Checkered"]));
         _loc91_.addBrick(createBrick(1036,ItemLayer.FORGROUND,forgroundBricksBMD,"brickdomestic","",ItemTab.BLOCK,false,true,221,-1,["Wood","Brown","Floor"]));
         _loc91_.addBrick(createBrick(1037,ItemLayer.FORGROUND,forgroundBricksBMD,"brickdomestic","",ItemTab.BLOCK,false,true,222,-1,["Red","Carpet"]));
         _loc91_.addBrick(createBrick(1038,ItemLayer.FORGROUND,forgroundBricksBMD,"brickdomestic","",ItemTab.BLOCK,false,true,223,-1,["Blue","Carpet"]));
         _loc91_.addBrick(createBrick(1039,ItemLayer.FORGROUND,forgroundBricksBMD,"brickdomestic","",ItemTab.BLOCK,false,true,224,-1,["Green","Carpet","Grass"]));
         _loc91_.addBrick(createBrick(1040,ItemLayer.FORGROUND,forgroundBricksBMD,"brickdomestic","",ItemTab.BLOCK,false,true,225,-1,["White","Marble","Box","Square"]));
         _loc91_.addBrick(createBrick(683,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickdomestic","",ItemTab.BACKGROUND,false,false,177,-1,["Wallpaper","Yellow","Dark yellow","Brown"]));
         _loc91_.addBrick(createBrick(684,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickdomestic","",ItemTab.BACKGROUND,false,false,178,-1,["Wallpaper","Brown","Dark brown"]));
         _loc91_.addBrick(createBrick(685,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickdomestic","",ItemTab.BACKGROUND,false,false,179,-1,["Wallpaper","Red","Dark red"]));
         _loc91_.addBrick(createBrick(686,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickdomestic","",ItemTab.BACKGROUND,false,false,180,-1,["Wallpaper","Blue","Dark blue"]));
         _loc91_.addBrick(createBrick(687,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickdomestic","",ItemTab.BACKGROUND,false,false,181,-1,["Wallpaper","Green","Dark green","Stripes"]));
         _loc91_.addBrick(createBrick(446,ItemLayer.DECORATION,decorationsBMD,"brickdomestic","",ItemTab.DECORATIVE,false,false,285,0,["Light","Lampshade"]));
         _loc91_.addBrick(createBrick(ItemId.DOMESTIC_LIGHT_BULB,ItemLayer.DECORATION,specialBricksBMD,"brickdomestic","",ItemTab.DECORATIVE,false,false,425,0,["Light","Bulb","Morphable"]));
         _loc91_.addBrick(createBrick(ItemId.DOMESTIC_TAP,ItemLayer.DECORATION,specialBricksBMD,"brickdomestic","",ItemTab.DECORATIVE,false,false,429,0,["Pipe","Tube","Mario","Corner","Morphable"]));
         _loc91_.addBrick(createBrick(ItemId.DOMESTIC_PAINTING,ItemLayer.DECORATION,specialBricksBMD,"brickdomestic","",ItemTab.DECORATIVE,false,false,433,0,["Picture","Painting","Frame","Morphable"]));
         _loc91_.addBrick(createBrick(ItemId.DOMESTIC_VASE,ItemLayer.DECORATION,specialBricksBMD,"brickdomestic","",ItemTab.DECORATIVE,false,false,437,0,["Flower","Nature","Plant","Vase"]));
         _loc91_.addBrick(createBrick(ItemId.DOMESTIC_TV,ItemLayer.DECORATION,specialBricksBMD,"brickdomestic","",ItemTab.DECORATIVE,false,false,441,0,["Television","TV","Morphable","Screen","CRT","Box","LCD","Electronic"]));
         _loc91_.addBrick(createBrick(ItemId.DOMESTIC_WINDOW,ItemLayer.DECORATION,specialBricksBMD,"brickdomestic","",ItemTab.DECORATIVE,false,false,445,0,["Window","Morphable"]));
         _loc91_.addBrick(createBrick(ItemId.HALFBLOCK_DOMESTIC_YELLOW,ItemLayer.DECORATION,specialBricksBMD,"brickdomestic","",ItemTab.BLOCK,false,false,449,-1,["Half block","Yellow","Morphable","Gold"]));
         _loc91_.addBrick(createBrick(ItemId.HALFBLOCK_DOMESTIC_BROWN,ItemLayer.DECORATION,specialBricksBMD,"brickdomestic","",ItemTab.BLOCK,false,false,453,-1,["Half block","Brown","Morphable","Wood"]));
         _loc91_.addBrick(createBrick(ItemId.HALFBLOCK_DOMESTIC_WHITE,ItemLayer.DECORATION,specialBricksBMD,"brickdomestic","",ItemTab.BLOCK,false,false,457,-1,["Half block","White","Morphable","Marble"]));
         brickPackages.push(_loc91_);
         var _loc92_:ItemBrickPackage = new ItemBrickPackage("halloween 2015","Halloween 2015",["Holiday","House","Scary","Creepy"]);
         _loc92_.addBrick(createBrick(1047,ItemLayer.FORGROUND,forgroundBricksBMD,"brickhalloween2015","",ItemTab.BLOCK,false,true,229,-1,["Mossy","Green","Brick","Old","Sewer","Ghost"]));
         _loc92_.addBrick(createBrick(1048,ItemLayer.FORGROUND,forgroundBricksBMD,"brickhalloween2015","",ItemTab.BLOCK,false,true,230,-1,["Siding","Light gray"]));
         _loc92_.addBrick(createBrick(1049,ItemLayer.FORGROUND,forgroundBricksBMD,"brickhalloween2015","",ItemTab.BLOCK,false,true,231,-1,["Mossy","Gray","Green","Grey","Roof","Catacomb","Brick","Tomb"]));
         _loc92_.addBrick(createBrick(ItemId.HALLOWEEN_2015_ONEWAY,ItemLayer.DECORATION,forgroundBricksBMD,"brickhalloween2015","",ItemTab.BLOCK,false,true,232,0,["Platform","Gray","Grey","Stone","Corner","One Way","One-Way"]));
         _loc92_.addBrick(createBrick(454,ItemLayer.ABOVE,decorationsBMD,"brickhalloween2015","",ItemTab.DECORATIVE,false,false,286,0,["Bush","Nature","Plant","Dead","Shrub","Environment"]));
         _loc92_.addBrick(createBrick(455,ItemLayer.ABOVE,decorationsBMD,"brickhalloween2015","",ItemTab.DECORATIVE,false,false,287,0,["Fence","Spikes"]));
         _loc92_.addBrick(createBrick(ItemId.HALLOWEEN_2015_WINDOW_RECT,ItemLayer.DECORATION,specialBricksBMD,"brickhalloween2015","",ItemTab.DECORATIVE,false,false,461,0,["Window","Morphable","Wood","Arched"]));
         _loc92_.addBrick(createBrick(ItemId.HALLOWEEN_2015_WINDOW_CIRCLE,ItemLayer.DECORATION,specialBricksBMD,"brickhalloween2015","",ItemTab.DECORATIVE,false,false,463,0,["Window","Morphable","Round","Circle","Wood"]));
         _loc92_.addBrick(createBrick(ItemId.HALLOWEEN_2015_LAMP,ItemLayer.DECORATION,specialBricksBMD,"brickhalloween2015","",ItemTab.DECORATIVE,false,false,465,0,["Light","Morphable","Lamp","Lantern"]));
         _loc92_.addBrick(createBrick(694,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickhalloween2015","",ItemTab.BACKGROUND,false,false,188,-1,["Mossy","Green","Brick","Stone","Sewer"]));
         _loc92_.addBrick(createBrick(695,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickhalloween2015","",ItemTab.BACKGROUND,false,false,189,-1,["Sliding","Gray","Grey","Slabs","Sewer"]));
         _loc92_.addBrick(createBrick(696,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickhalloween2015","",ItemTab.BACKGROUND,false,false,190,-1,["Mossy","Gray","Grey","Roof","Catacomb","Tomb"]));
         brickPackages.push(_loc92_);
         var _loc93_:ItemBrickPackage = new ItemBrickPackage("arctic","Arctic",["Snow","Cold","Blue","Frozen","Freeze"]);
         _loc93_.addBrick(createBrick(1059,ItemLayer.FORGROUND,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,237,-1,["Ice"]));
         _loc93_.addBrick(createBrick(1060,ItemLayer.FORGROUND,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,238,-1));
         _loc93_.addBrick(createBrick(1061,ItemLayer.DECORATION,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,239,-1,["Left"]));
         _loc93_.addBrick(createBrick(1062,ItemLayer.FORGROUND,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,240,-1,["Middle"]));
         _loc93_.addBrick(createBrick(1063,ItemLayer.DECORATION,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,241,-1,["Right"]));
         _loc93_.addBrick(createBrick(702,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,false,196,-1));
         _loc93_.addBrick(createBrick(703,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,false,197,-1));
         brickPackages.push(_loc93_);
         var _loc94_:ItemBrickPackage = new ItemBrickPackage("new year 2015","New Year 2015",["Holiday"]);
         _loc94_.addBrick(createBrick(462,ItemLayer.DECORATION,decorationsBMD,"bricknewyear2015","",ItemTab.DECORATIVE,false,true,289,0,["Glass","Wine","Drink"]));
         _loc94_.addBrick(createBrick(463,ItemLayer.DECORATION,decorationsBMD,"bricknewyear2015","",ItemTab.DECORATIVE,false,true,290,0,["Bottle","Champagne","Drink"]));
         _loc94_.addBrick(createBrick(ItemId.NEW_YEAR_2015_BALLOON,ItemLayer.DECORATION,specialBricksBMD,"bricknewyear2015","",ItemTab.DECORATIVE,false,true,492,0,["Balloon","Morphable"]));
         _loc94_.addBrick(createBrick(ItemId.NEW_YEAR_2015_STREAMER,ItemLayer.DECORATION,specialBricksBMD,"bricknewyear2015","",ItemTab.DECORATIVE,false,true,497,0,["String","Morphable","Streamer"]));
         brickPackages.push(_loc94_);
         var _loc95_:ItemBrickPackage = new ItemBrickPackage("ice","Ice");
         _loc95_.addBrick(createBrick(ItemId.ICE,ItemLayer.DECORATION,specialBricksBMD,"brickice2","",ItemTab.ACTION,false,true,501,-1,["Slippery","Physics","Slide"]));
         brickPackages.push(_loc95_);
         var _loc96_:ItemBrickPackage = new ItemBrickPackage("fairytale","Fairytale",["Mythical","Fiction"]);
         _loc96_.addBrick(createBrick(1070,ItemLayer.FORGROUND,forgroundBricksBMD,"brickfairytale","",ItemTab.BLOCK,false,true,247,-1,["Cobblestone","Pebbles"]));
         _loc96_.addBrick(createBrick(1071,ItemLayer.FORGROUND,forgroundBricksBMD,"brickfairytale","",ItemTab.BLOCK,false,true,248,-1,["Orange","Tree"]));
         _loc96_.addBrick(createBrick(1072,ItemLayer.FORGROUND,forgroundBricksBMD,"brickfairytale","",ItemTab.BLOCK,false,true,249,-1,["Green","Moss"]));
         _loc96_.addBrick(createBrick(1073,ItemLayer.DECORATION,forgroundBricksBMD,"brickfairytale","",ItemTab.BLOCK,false,true,250,-1,["Blue","Cloud"]));
         _loc96_.addBrick(createBrick(1074,ItemLayer.DECORATION,forgroundBricksBMD,"brickfairytale","",ItemTab.BLOCK,false,true,251,-1,["Red","Mushroom","Spotted"]));
         _loc96_.addBrick(createBrick(468,ItemLayer.DECORATION,decorationsBMD,"brickfairytale","",ItemTab.DECORATIVE,false,true,291,0,["Green","Plant","Vine"]));
         _loc96_.addBrick(createBrick(469,ItemLayer.DECORATION,decorationsBMD,"brickfairytale","",ItemTab.DECORATIVE,false,true,292,0,["Mushroom","Orange"]));
         _loc96_.addBrick(createBrick(470,ItemLayer.DECORATION,decorationsBMD,"brickfairytale","",ItemTab.DECORATIVE,false,true,293,0,["Dew Drop","Transparent","Water"]));
         _loc96_.addBrick(createBrick(704,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickfairytale","",ItemTab.BACKGROUND,false,false,201,-1,["Orange","Mist","Fog","Swirl"]));
         _loc96_.addBrick(createBrick(705,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickfairytale","",ItemTab.BACKGROUND,false,false,202,-1,["Green","Mist","Fog","Swirl"]));
         _loc96_.addBrick(createBrick(706,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickfairytale","",ItemTab.BACKGROUND,false,false,203,-1,["Blue","Mist","Fog","Swirl"]));
         _loc96_.addBrick(createBrick(707,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickfairytale","",ItemTab.BACKGROUND,false,false,204,-1,["Pink","Mist","Fog","Swirl"]));
         _loc96_.addBrick(createBrick(ItemId.HALFBLOCK_FAIRYTALE_ORANGE,ItemLayer.DECORATION,specialBricksBMD,"brickfairytale","",ItemTab.BLOCK,false,false,522,-1,["Half block","Gemstone","Crystal","Orange"]));
         _loc96_.addBrick(createBrick(ItemId.HALFBLOCK_FAIRYTALE_GREEN,ItemLayer.DECORATION,specialBricksBMD,"brickfairytale","",ItemTab.BLOCK,false,false,526,-1,["Half block","Gemstone","Crystal","Green"]));
         _loc96_.addBrick(createBrick(ItemId.HALFBLOCK_FAIRYTALE_BLUE,ItemLayer.DECORATION,specialBricksBMD,"brickfairytale","",ItemTab.BLOCK,false,false,530,-1,["Half block","Gemstone","Crystal","Blue"]));
         _loc96_.addBrick(createBrick(ItemId.HALFBLOCK_FAIRYTALE_PINK,ItemLayer.DECORATION,specialBricksBMD,"brickfairytale","",ItemTab.BLOCK,false,false,534,-1,["Half block","Gemstone","Crystal","Pink"]));
         _loc96_.addBrick(createBrick(ItemId.FAIRYTALE_FLOWERS,ItemLayer.DECORATION,specialBricksBMD,"brickfairytale","",ItemTab.DECORATIVE,false,true,538,0,["Morphable","Green","Blue","Orange","Pink","Plant","Flower"]));
         brickPackages.push(_loc96_);
         var _loc97_:ItemBrickPackage = new ItemBrickPackage("spring 2016","Spring 2016");
         _loc97_.addBrick(createBrick(1081,ItemLayer.FORGROUND,forgroundBricksBMD,"brickspring2016","",ItemTab.BLOCK,false,true,253,-1,["Dirt","Brown","Soil","Nature"]));
         _loc97_.addBrick(createBrick(1082,ItemLayer.FORGROUND,forgroundBricksBMD,"brickspring2016","",ItemTab.BLOCK,false,true,254,-1,["Hedge","Green","Leaf","Nature","Plant"]));
         _loc97_.addBrick(createBrick(473,ItemLayer.ABOVE,decorationsBMD,"brickspring2016","",ItemTab.DECORATIVE,false,false,294,0,["Dirt","Brown","Soil","Slope","Left"]));
         _loc97_.addBrick(createBrick(474,ItemLayer.ABOVE,decorationsBMD,"brickspring2016","",ItemTab.DECORATIVE,false,false,295,0,["Dirt","Brown","Soil","Slope","Right"]));
         _loc97_.addBrick(createBrick(ItemId.SPRING_DAISY,ItemLayer.DECORATION,specialBricksBMD,"brickspring2016","",ItemTab.DECORATIVE,false,false,541,0,["Daisy","Flower","Plant","Nature","White","Blue","Pink"]));
         _loc97_.addBrick(createBrick(ItemId.SPRING_TULIP,ItemLayer.DECORATION,specialBricksBMD,"brickspring2016","",ItemTab.DECORATIVE,false,false,544,0,["Tulip","Flower","Plant","Nature","Red","Yellow","Pink"]));
         _loc97_.addBrick(createBrick(ItemId.SPRING_DAFFODIL,ItemLayer.DECORATION,specialBricksBMD,"brickspring2016","",ItemTab.DECORATIVE,false,false,547,0,["Daffodil","Flower","Plant","Nature","Yellow","White","Orange"]));
         brickPackages.push(_loc97_);
         var _loc98_:ItemBrickPackage = new ItemBrickPackage("summer 2016","Summer 2016");
         _loc98_.addBrick(createBrick(1083,ItemLayer.FORGROUND,forgroundBricksBMD,"bricksummer2016","",ItemTab.BLOCK,false,true,255,-1,["Thatched","Straw","Seasonal","Beige","Tan"]));
         _loc98_.addBrick(createBrick(1084,ItemLayer.FORGROUND,forgroundBricksBMD,"bricksummer2016","",ItemTab.BLOCK,false,true,256,-1,["Planks","Wood","Seasonal","Purple"]));
         _loc98_.addBrick(createBrick(1085,ItemLayer.FORGROUND,forgroundBricksBMD,"bricksummer2016","",ItemTab.BLOCK,false,true,257,-1,["Planks","Wood","Seasonal","Yellow"]));
         _loc98_.addBrick(createBrick(1086,ItemLayer.FORGROUND,forgroundBricksBMD,"bricksummer2016","",ItemTab.BLOCK,false,true,258,-1,["Planks","Wood","Seasonal","Teal"]));
         _loc98_.addBrick(createBrick(1087,ItemLayer.DECORATION,forgroundBricksBMD,"bricksummer2016","",ItemTab.BLOCK,false,true,259,0,["Platform","Dock","Wood","Seasonal","One Way","One-Way","Brown"]));
         _loc98_.addBrick(createBrick(708,ItemLayer.BACKGROUND,backgroundBricksBMD,"bricksummer2016","",ItemTab.BACKGROUND,false,false,205,-1,["Thatched","Straw","Seasonal","Beige","Tan"]));
         _loc98_.addBrick(createBrick(712,ItemLayer.BACKGROUND,backgroundBricksBMD,"bricksummer2016","",ItemTab.BACKGROUND,false,false,206,-1,["Planks","Wood","Seasonal","Purple"]));
         _loc98_.addBrick(createBrick(713,ItemLayer.BACKGROUND,backgroundBricksBMD,"bricksummer2016","",ItemTab.BACKGROUND,false,false,207,-1,["Planks","Wood","Seasonal","Yellow"]));
         _loc98_.addBrick(createBrick(714,ItemLayer.BACKGROUND,backgroundBricksBMD,"bricksummer2016","",ItemTab.BACKGROUND,false,false,208,-1,["Planks","Wood","Seasonal","Teal"]));
         _loc98_.addBrick(createBrick(ItemId.SUMMER_FLAG,ItemLayer.DECORATION,specialBricksBMD,"bricksummer2016","",ItemTab.DECORATIVE,false,false,550,0,["Flag","Seasonal","Red","Yellow","Green","Cyan","Blue","Purple"]));
         _loc98_.addBrick(createBrick(ItemId.SUMMER_AWNING,ItemLayer.DECORATION,specialBricksBMD,"bricksummer2016","",ItemTab.DECORATIVE,false,false,556,0,["Awning","Striped","Seasonal","White","Red","Yellow","Green","Cyan","Blue","Purple"]));
         _loc98_.addBrick(createBrick(ItemId.SUMMER_ICECREAM,ItemLayer.DECORATION,specialBricksBMD,"bricksummer2016","",ItemTab.DECORATIVE,false,false,562,0,["Ice Cream","Food","Vanilla","Chocolate","Strawberry","Mint","Beige","Brown","Pink","Green"]));
         brickPackages.push(_loc98_);
         var _loc99_:ItemBrickPackage = new ItemBrickPackage("mine","Mine");
         _loc99_.addBrick(createBrick(1093,ItemLayer.FORGROUND,forgroundBricksBMD,"brickmine","",ItemTab.BLOCK,false,true,264,-1,["Stone","Brown","Tan","Rock"]));
         _loc99_.addBrick(createBrick(720,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickmine","",ItemTab.BACKGROUND,false,true,219,-1,["Stone","Brown","Tan","Rock","Dark"]));
         _loc99_.addBrick(createBrick(495,ItemLayer.DECORATION,decorationsBMD,"brickmine","",ItemTab.DECORATIVE,false,true,307,0,["Stalagmite","Stone","Brown","Tan","Rock"]));
         _loc99_.addBrick(createBrick(496,ItemLayer.DECORATION,decorationsBMD,"brickmine","",ItemTab.DECORATIVE,false,true,308,0,["Stalagtite","Stone","Brown","Tan","Rock"]));
         _loc99_.addBrick(createBrick(ItemId.CAVE_CRYSTAL,ItemLayer.DECORATION,specialBricksBMD,"brickmine","",ItemTab.DECORATIVE,false,true,570,0,["Crystal","Gemstone","Red","Yellow","Green","Cyan","Blue","Purple"]));
         _loc99_.addBrick(createBrick(ItemId.CAVE_TORCH,ItemLayer.DECORATION,specialBricksBMD,"brickmine","",ItemTab.DECORATIVE,false,false,576,0,["Torch","Fire","Animated"]));
         brickPackages.push(_loc99_);
         var _loc100_:ItemBrickPackage = new ItemBrickPackage("restaurant","Restaurant");
         _loc100_.addBrick(createBrick(487,ItemLayer.DECORATION,decorationsBMD,"brickrestaurant","",ItemTab.DECORATIVE,false,true,302,0,["Hamburger","Sandwich","Food"]));
         _loc100_.addBrick(createBrick(488,ItemLayer.DECORATION,decorationsBMD,"brickrestaurant","",ItemTab.DECORATIVE,false,true,303,0,["Hot Dog","Sausage","Food"]));
         _loc100_.addBrick(createBrick(489,ItemLayer.DECORATION,decorationsBMD,"brickrestaurant","",ItemTab.DECORATIVE,false,true,304,0,["Sub","Sandwich","Ham","Food"]));
         _loc100_.addBrick(createBrick(490,ItemLayer.DECORATION,decorationsBMD,"brickrestaurant","",ItemTab.DECORATIVE,false,true,305,0,["Soda","Drink","Beverage","Red"]));
         _loc100_.addBrick(createBrick(491,ItemLayer.DECORATION,decorationsBMD,"brickrestaurant","",ItemTab.DECORATIVE,false,true,306,0,["French Fries","Chips","Food","Red","Yellow"]));
         _loc100_.addBrick(createBrick(ItemId.RESTAURANT_CUP,ItemLayer.DECORATION,specialBricksBMD,"brickrestaurant","",ItemTab.DECORATIVE,false,true,588,0,["Glass","Cup","Drink","Water","Milk","Orange Juice","Beverage"]));
         _loc100_.addBrick(createBrick(ItemId.RESTAURANT_PLATE,ItemLayer.DECORATION,specialBricksBMD,"brickrestaurant","",ItemTab.DECORATIVE,false,true,592,0,["Plate","Chicken","Ham","Fish","Food"]));
         _loc100_.addBrick(createBrick(ItemId.RESTAURANT_BOWL,ItemLayer.DECORATION,specialBricksBMD,"brickrestaurant","",ItemTab.DECORATIVE,false,true,596,0,["Bowl","Salad","Spaghetti","Pasta","Ice Cream","Food"]));
         brickPackages.push(_loc100_);
         var _loc101_:ItemBrickPackage = new ItemBrickPackage("textile","Textile");
         _loc101_.addBrick(createBrick(721,ItemLayer.BACKGROUND,backgroundBricksBMD,"bricktextile","",ItemTab.BACKGROUND,false,true,214,-1,["Cloth","Fabric","Pattern","White","Green","Plaid","Checker"]));
         _loc101_.addBrick(createBrick(722,ItemLayer.BACKGROUND,backgroundBricksBMD,"bricktextile","",ItemTab.BACKGROUND,false,true,215,-1,["Cloth","Fabric","Pattern","White","Blue","Chevron","Zigzag"]));
         _loc101_.addBrick(createBrick(723,ItemLayer.BACKGROUND,backgroundBricksBMD,"bricktextile","",ItemTab.BACKGROUND,false,true,216,-1,["Cloth","Fabric","Pattern","White","Pink","Polka Dots","Spots"]));
         _loc101_.addBrick(createBrick(724,ItemLayer.BACKGROUND,backgroundBricksBMD,"bricktextile","",ItemTab.BACKGROUND,false,true,217,-1,["Cloth","Fabric","Pattern","White","Yellow","Stripes","Horizontal"]));
         _loc101_.addBrick(createBrick(725,ItemLayer.BACKGROUND,backgroundBricksBMD,"bricktextile","",ItemTab.BACKGROUND,false,true,218,-1,["Cloth","Fabric","Pattern","White","Red","Plaid","Diamond"]));
         brickPackages.push(_loc101_);
         var _loc102_:ItemBrickPackage = new ItemBrickPackage("halloween 2016","Halloween 2016");
         _loc102_.addBrick(createBrick(ItemId.HALLOWEEN_2016_ROTATABLE,ItemLayer.DECORATION,specialBricksBMD,"brickhalloween2016","",ItemTab.DECORATIVE,false,false,600,0,["Branch","Root","Wood","Slope","Black","Rotatable","Morphable","Seasonal","Holiday"]));
         _loc102_.addBrick(createBrick(ItemId.HALLOWEEN_2016_PUMPKIN,ItemLayer.DECORATION,specialBricksBMD,"brickhalloween2016","",ItemTab.DECORATIVE,false,false,604,0,["Pumpkin","Jack o Lantern","Orange","Morphable","Seasonal","Holiday"]));
         _loc102_.addBrick(createBrick(1501,ItemLayer.ABOVE,decorationsBMD,"brickhalloween2016","",ItemTab.DECORATIVE,false,false,309,0,["Grass","Plant","Purple","Seasonal","Holiday"]));
         _loc102_.addBrick(createBrick(ItemId.HALLOWEEN_2016_EYES,ItemLayer.DECORATION,specialBricksBMD,"brickhalloween2016","",ItemTab.DECORATIVE,false,false,611,0,["Eyes","Orange","Purple","Green","Yellow","Morphable","Seasonal","Holiday"]));
         _loc102_.addBrick(createBrick(726,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickhalloween2016","",ItemTab.BACKGROUND,false,false,220,-1,["Tree","Wood","Black","Seasonal","Holiday"]));
         _loc102_.addBrick(createBrick(727,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickhalloween2016","",ItemTab.BACKGROUND,false,false,221,-1,["Leaves","Plant","Purple","Seasonal","Holiday"]));
         brickPackages.push(_loc102_);
         var _loc103_:ItemBrickPackage = new ItemBrickPackage("construction","Construction");
         _loc103_.addBrick(createBrick(1096,ItemLayer.FORGROUND,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,265,-1,["Plywood","Wood","Brown","Tan"]));
         _loc103_.addBrick(createBrick(1097,ItemLayer.FORGROUND,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,266,-1,["Gravel","Stone","Gray","Grey"]));
         _loc103_.addBrick(createBrick(1098,ItemLayer.FORGROUND,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,267,-1,["Cement","Stone","Beige"]));
         _loc103_.addBrick(createBrick(1099,ItemLayer.FORGROUND,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,268,-1,["Beam","Metal","Red","Horizontal"]));
         _loc103_.addBrick(createBrick(1100,ItemLayer.FORGROUND,forgroundBricksBMD,"","",ItemTab.BLOCK,false,true,269,-1,["Beam","Metal","Red","Vertical"]));
         _loc103_.addBrick(createBrick(1503,ItemLayer.DECORATION,decorationsBMD,"","",ItemTab.DECORATIVE,false,true,310,0,["Sawhorse","Orange","White","Caution","Sign","Stripes","Horizontal"]));
         _loc103_.addBrick(createBrick(1504,ItemLayer.DECORATION,decorationsBMD,"","",ItemTab.DECORATIVE,false,true,311,0,["Cone","Orange","White"]));
         _loc103_.addBrick(createBrick(1505,ItemLayer.DECORATION,decorationsBMD,"","",ItemTab.DECORATIVE,false,true,312,0,["Sign","Orange","Caution","Warning"]));
         _loc103_.addBrick(createBrick(728,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,true,222,-1,["Plywood","Wood","Brown","Tan"]));
         _loc103_.addBrick(createBrick(729,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,true,223,-1,["Gravel","Stone","Gray","Grey"]));
         _loc103_.addBrick(createBrick(730,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,true,224,-1,["Cement","Stone","Beige"]));
         _loc103_.addBrick(createBrick(731,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,true,225,-1,["Beam","Metal","Red","Horizontal"]));
         _loc103_.addBrick(createBrick(732,ItemLayer.BACKGROUND,backgroundBricksBMD,"","",ItemTab.BACKGROUND,false,true,226,-1,["Beam","Metal","Red","Vertical"]));
         brickPackages.push(_loc103_);
         var _loc104_:ItemBrickPackage = new ItemBrickPackage("christmas 2016","Christmas 2016");
         _loc104_.addBrick(createBrick(ItemId.HALFBLOCK_CHRISTMAS_2016_PRESENT_RED,ItemLayer.DECORATION,forgroundBricksBMD,"brickchristmas2016","",ItemTab.BLOCK,false,true,270,-1,["Half block","Present","Gift","Holiday","Wrapping paper","Ribbon","Bow","Red"]));
         _loc104_.addBrick(createBrick(ItemId.HALFBLOCK_CHRISTMAS_2016_PRESENT_GREEN,ItemLayer.DECORATION,forgroundBricksBMD,"brickchristmas2016","",ItemTab.BLOCK,false,true,271,-1,["Half block","Present","Gift","Holiday","Wrapping paper","Ribbon","Bow","Green"]));
         _loc104_.addBrick(createBrick(ItemId.HALFBLOCK_CHRISTMAS_2016_PRESENT_WHITE,ItemLayer.DECORATION,forgroundBricksBMD,"brickchristmas2016","",ItemTab.BLOCK,false,true,272,-1,["Half block","Present","Gift","Holiday","Wrapping paper","Ribbon","Bow","White"]));
         _loc104_.addBrick(createBrick(ItemId.HALFBLOCK_CHRISTMAS_2016_PRESENT_BLUE,ItemLayer.DECORATION,forgroundBricksBMD,"brickchristmas2016","",ItemTab.BLOCK,false,true,273,-1,["Half block","Present","Gift","Holiday","Wrapping paper","Ribbon","Bow","Blue"]));
         _loc104_.addBrick(createBrick(ItemId.HALFBLOCK_CHRISTMAS_2016_PRESENT_YELLOW,ItemLayer.DECORATION,forgroundBricksBMD,"brickchristmas2016","",ItemTab.BLOCK,false,true,274,-1,["Half block","Present","Gift","Holiday","Wrapping paper","Ribbon","Bow","Yellow"]));
         _loc104_.addBrick(createBrick(ItemId.CHRISTMAS_2016_LIGHTS_DOWN,ItemLayer.DECORATION,specialBricksBMD,"brickchristmas2016","",ItemTab.DECORATIVE,false,true,630,0,["Light","String","Wire","Bulb","Holiday","Morphable","Red","Green","Yellow","Blue","Purple"]));
         _loc104_.addBrick(createBrick(ItemId.CHRISTMAS_2016_LIGHTS_UP,ItemLayer.DECORATION,specialBricksBMD,"brickchristmas2016","",ItemTab.DECORATIVE,false,true,635,0,["Light","String","Wire","Bulb","Holiday","Morphable","Red","Green","Yellow","Blue","Purple"]));
         _loc104_.addBrick(createBrick(1508,ItemLayer.DECORATION,decorationsBMD,"brickchristmas2016","",ItemTab.DECORATIVE,false,true,313,0,["Bell","Bow","Holiday","Yellow","Gold"]));
         _loc104_.addBrick(createBrick(1509,ItemLayer.DECORATION,decorationsBMD,"brickchristmas2016","",ItemTab.DECORATIVE,false,true,314,0,["Holly Berries","Holiday","Nature","Plant","Red","Green"]));
         _loc104_.addBrick(createBrick(ItemId.CHRISTMAS_2016_CANDLE,ItemLayer.DECORATION,specialBricksBMD,"brickchristmas2016","",ItemTab.DECORATIVE,false,true,639,0,["Candle","Fire","Flame","Holiday","Animated","Red"]));
         brickPackages.push(_loc104_);
         var _loc105_:ItemBrickPackage = new ItemBrickPackage("tiles","Tiles",["Tile"]);
         _loc105_.addBrick(createBrick(1106,ItemLayer.FORGROUND,forgroundBricksBMD,"bricktiles","",ItemTab.BLOCK,false,true,275,-1,["White"]));
         _loc105_.addBrick(createBrick(1107,ItemLayer.FORGROUND,forgroundBricksBMD,"bricktiles","",ItemTab.BLOCK,false,true,276,-1,["Gray","Grey"]));
         _loc105_.addBrick(createBrick(1108,ItemLayer.FORGROUND,forgroundBricksBMD,"bricktiles","",ItemTab.BLOCK,false,true,277,-1,["Black","Gray","Grey"]));
         _loc105_.addBrick(createBrick(1109,ItemLayer.FORGROUND,forgroundBricksBMD,"bricktiles","",ItemTab.BLOCK,false,true,278,-1,["Red"]));
         _loc105_.addBrick(createBrick(1110,ItemLayer.FORGROUND,forgroundBricksBMD,"bricktiles","",ItemTab.BLOCK,false,true,279,-1,["Orange"]));
         _loc105_.addBrick(createBrick(1111,ItemLayer.FORGROUND,forgroundBricksBMD,"bricktiles","",ItemTab.BLOCK,false,true,280,-1,["Yellow"]));
         _loc105_.addBrick(createBrick(1112,ItemLayer.FORGROUND,forgroundBricksBMD,"bricktiles","",ItemTab.BLOCK,false,true,281,-1,["Green"]));
         _loc105_.addBrick(createBrick(1113,ItemLayer.FORGROUND,forgroundBricksBMD,"bricktiles","",ItemTab.BLOCK,false,true,282,-1,["Cyan"]));
         _loc105_.addBrick(createBrick(1114,ItemLayer.FORGROUND,forgroundBricksBMD,"bricktiles","",ItemTab.BLOCK,false,true,283,-1,["Blue"]));
         _loc105_.addBrick(createBrick(1115,ItemLayer.FORGROUND,forgroundBricksBMD,"bricktiles","",ItemTab.BLOCK,false,true,284,-1,["Purple"]));
         _loc105_.addBrick(createBrick(733,ItemLayer.BACKGROUND,backgroundBricksBMD,"bricktiles","",ItemTab.BACKGROUND,false,true,227,-1,["White"]));
         _loc105_.addBrick(createBrick(734,ItemLayer.BACKGROUND,backgroundBricksBMD,"bricktiles","",ItemTab.BACKGROUND,false,true,228,-1,["Gray","Grey"]));
         _loc105_.addBrick(createBrick(735,ItemLayer.BACKGROUND,backgroundBricksBMD,"bricktiles","",ItemTab.BACKGROUND,false,true,229,-1,["Black","Gray","Grey"]));
         _loc105_.addBrick(createBrick(736,ItemLayer.BACKGROUND,backgroundBricksBMD,"bricktiles","",ItemTab.BACKGROUND,false,true,230,-1,["Red"]));
         _loc105_.addBrick(createBrick(737,ItemLayer.BACKGROUND,backgroundBricksBMD,"bricktiles","",ItemTab.BACKGROUND,false,true,231,-1,["Orange"]));
         _loc105_.addBrick(createBrick(738,ItemLayer.BACKGROUND,backgroundBricksBMD,"bricktiles","",ItemTab.BACKGROUND,false,true,232,-1,["Yellow"]));
         _loc105_.addBrick(createBrick(739,ItemLayer.BACKGROUND,backgroundBricksBMD,"bricktiles","",ItemTab.BACKGROUND,false,true,233,-1,["Green"]));
         _loc105_.addBrick(createBrick(740,ItemLayer.BACKGROUND,backgroundBricksBMD,"bricktiles","",ItemTab.BACKGROUND,false,true,234,-1,["Cyan"]));
         _loc105_.addBrick(createBrick(741,ItemLayer.BACKGROUND,backgroundBricksBMD,"bricktiles","",ItemTab.BACKGROUND,false,true,235,-1,["Blue"]));
         _loc105_.addBrick(createBrick(742,ItemLayer.BACKGROUND,backgroundBricksBMD,"bricktiles","",ItemTab.BACKGROUND,false,true,236,-1,["Purple"]));
         brickPackages.push(_loc105_);
         _loc105_ = new ItemBrickPackage("St. Patricks 2017","St. Patricks 2017");
         _loc105_.addBrick(createBrick(1513,ItemLayer.DECORATION,decorationsBMD,"brickstpatricks2017","",ItemTab.DECORATIVE,false,true,315,0,["Shamrock","Clover","Green","Plant","Nature"]));
         _loc105_.addBrick(createBrick(1514,ItemLayer.DECORATION,decorationsBMD,"brickstpatricks2017","",ItemTab.DECORATIVE,false,true,316,0,["Pot of Gold"]));
         _loc105_.addBrick(createBrick(1515,ItemLayer.DECORATION,decorationsBMD,"brickstpatricks2017","",ItemTab.DECORATIVE,false,true,317,0,["Horseshoe","Gold"]));
         _loc105_.addBrick(createBrick(1516,ItemLayer.DECORATION,decorationsBMD,"brickstpatricks2017","",ItemTab.DECORATIVE,false,true,318,0,["Rainbow","Left"]));
         _loc105_.addBrick(createBrick(1517,ItemLayer.DECORATION,decorationsBMD,"brickstpatricks2017","",ItemTab.DECORATIVE,false,true,319,0,["Rainbow","Right"]));
         brickPackages.push(_loc105_);
         _loc105_ = new ItemBrickPackage("Hospital","Hospital");
         _loc105_.addBrick(createBrick(1116,ItemLayer.FORGROUND,forgroundBricksBMD,"brickhospital","",ItemTab.BLOCK,false,true,286,-1,["Blue","Light","Wall","Floor","Tile"]));
         _loc105_.addBrick(createBrick(1117,ItemLayer.DECORATION,forgroundBricksBMD,"brickhospital","",ItemTab.BLOCK,false,true,287,-1,["Cyan","Blue","Bed"]));
         _loc105_.addBrick(createBrick(1118,ItemLayer.DECORATION,forgroundBricksBMD,"brickhospital","",ItemTab.BLOCK,false,true,288,-1,["Red","Pink","Bed"]));
         _loc105_.addBrick(createBrick(1119,ItemLayer.DECORATION,forgroundBricksBMD,"brickhospital","",ItemTab.BLOCK,false,true,289,-1,["Purple","Bed"]));
         _loc105_.addBrick(createBrick(1120,ItemLayer.DECORATION,forgroundBricksBMD,"brickhospital","",ItemTab.BLOCK,false,true,290,-1,["Black","Gray","Grey","Pillar","Floor","Neutral"]));
         _loc105_.addBrick(createBrick(1121,ItemLayer.DECORATION,forgroundBricksBMD,"brickhospital","",ItemTab.BLOCK,false,true,291,-1,["Black","Gray","Grey","Pillar","Floor","Neutral"]));
         _loc105_.addBrick(createBrick(1518,ItemLayer.DECORATION,decorationsBMD,"brickhospital","",ItemTab.DECORATIVE,false,true,320,0,["Computer","Screen"]));
         _loc105_.addBrick(createBrick(1519,ItemLayer.DECORATION,decorationsBMD,"brickhospital","",ItemTab.DECORATIVE,false,true,321,0,["Cacile","Red","Light","Animated"]));
         _loc105_.addBrick(createBrick(1520,ItemLayer.ABOVE,decorationsBMD,"brickhospital","",ItemTab.DECORATIVE,false,true,322,0,["Cross","Red","Medic"]));
         _loc105_.addBrick(createBrick(745,ItemLayer.BACKGROUND,backgroundBricksBMD,"brickhospital","",ItemTab.BACKGROUND,false,true,239,-1,["Blue","Floor","Wall","Tile"]));
         brickPackages.push(_loc105_);
         var _loc106_:int = 0;
         while(_loc106_ < 1000)
         {
            coinDoorsBMD.copyPixels(bmdBricks[ItemId.COINDOOR],bmdBricks[ItemId.COINDOOR].rect,new Point(16 * _loc106_,0));
            coinGatesBMD.copyPixels(bmdBricks[ItemId.COINGATE],bmdBricks[ItemId.COINGATE].rect,new Point(16 * _loc106_,0));
            blueCoinDoorsBMD.copyPixels(bmdBricks[ItemId.BLUECOINDOOR],bmdBricks[ItemId.BLUECOINDOOR].rect,new Point(16 * _loc106_,0));
            blueCoinGatesBMD.copyPixels(bmdBricks[ItemId.BLUECOINGATE],bmdBricks[ItemId.BLUECOINGATE].rect,new Point(16 * _loc106_,0));
            switchDoorsBMD.copyPixels(bmdBricks[ItemId.DOOR_PURPLE],bmdBricks[ItemId.DOOR_PURPLE].rect,new Point(16 * _loc106_,0));
            switchGatesBMD.copyPixels(bmdBricks[ItemId.GATE_PURPLE],bmdBricks[ItemId.GATE_PURPLE].rect,new Point(16 * _loc106_,0));
            switchOrangeDoorsBMD.copyPixels(bmdBricks[ItemId.DOOR_ORANGE],bmdBricks[ItemId.DOOR_ORANGE].rect,new Point(16 * _loc106_,0));
            switchOrangeGatesBMD.copyPixels(bmdBricks[ItemId.GATE_ORANGE],bmdBricks[ItemId.GATE_ORANGE].rect,new Point(16 * _loc106_,0));
            switchSwitchUpBMD.copyPixels(bmdBricks[ItemId.SWITCH_PURPLE],bmdBricks[ItemId.SWITCH_PURPLE].rect,new Point(16 * _loc106_,0));
            _loc108_ = new BitmapData(16,16);
            _loc108_.copyPixels(specialBricksBMD,new Rectangle(311 * 16,0,16,16),new Point(0,0));
            switchSwitchDownBMD.copyPixels(_loc108_,_loc108_.rect,new Point(16 * _loc106_,0));
            switchOrangeSwitchUpBMD.copyPixels(bmdBricks[ItemId.SWITCH_ORANGE],bmdBricks[ItemId.SWITCH_ORANGE].rect,new Point(16 * _loc106_,0));
            _loc109_ = new BitmapData(16,16);
            _loc109_.copyPixels(specialBricksBMD,new Rectangle(423 * 16,0,16,16),new Point(0,0));
            switchOrangeSwitchDownBMD.copyPixels(_loc109_,_loc109_.rect,new Point(16 * _loc106_,0));
            deathDoorBMD.copyPixels(bmdBricks[ItemId.DEATH_DOOR],bmdBricks[ItemId.DEATH_DOOR].rect,new Point(16 * _loc106_,0));
            deathGateBMD.copyPixels(bmdBricks[ItemId.DEATH_GATE],bmdBricks[ItemId.DEATH_GATE].rect,new Point(16 * _loc106_,0));
            if(_loc106_ >= 0)
            {
               _loc110_ = new Matrix();
               _loc110_.translate(_loc106_ * 16,0);
               _loc111_ = createBlockText(_loc106_);
               coinGatesBMD.draw(_loc111_,_loc110_);
               blueCoinDoorsBMD.draw(_loc111_,_loc110_);
               blueCoinGatesBMD.draw(_loc111_,_loc110_);
               switchDoorsBMD.draw(_loc111_,_loc110_);
               switchGatesBMD.draw(_loc111_,_loc110_);
               switchSwitchUpBMD.draw(_loc111_,_loc110_);
               switchSwitchDownBMD.draw(_loc111_,_loc110_);
               switchOrangeDoorsBMD.draw(_loc111_,_loc110_);
               switchOrangeGatesBMD.draw(_loc111_,_loc110_);
               switchOrangeSwitchUpBMD.draw(_loc111_,_loc110_);
               switchOrangeSwitchDownBMD.draw(_loc111_,_loc110_);
               deathGateBMD.draw(_loc111_,_loc110_);
               _loc111_.filters = [];
               _loc112_ = new ColorTransform(0,0,0);
               _loc111_.bitmapData.draw(_loc111_,null,_loc112_);
               _loc111_.filters = [new GlowFilter(16777215,1,1,1,2,3)];
               coinDoorsBMD.draw(_loc111_,_loc110_);
               deathDoorBMD.draw(_loc111_,_loc110_);
            }
            _loc106_++;
         }
         sprCoinDoors = new BlockSprite(coinDoorsBMD,0,0,16,16,coinDoorsBMD.width / 16,true);
         sprCoinGates = new BlockSprite(coinGatesBMD,0,0,16,16,coinGatesBMD.width / 16);
         sprBlueCoinDoors = new BlockSprite(blueCoinDoorsBMD,0,0,16,16,blueCoinDoorsBMD.width / 16,true);
         sprBlueCoinGates = new BlockSprite(blueCoinGatesBMD,0,0,16,16,blueCoinGatesBMD.width / 16);
         sprPurpleDoors = new BlockSprite(switchDoorsBMD,0,0,16,16,switchDoorsBMD.width / 16,true);
         sprPurpleGates = new BlockSprite(switchGatesBMD,0,0,16,16,switchGatesBMD.width / 16);
         sprSwitchUP = new BlockSprite(switchSwitchUpBMD,0,0,16,16,switchSwitchUpBMD.width / 16,true);
         sprSwitchDOWN = new BlockSprite(switchSwitchDownBMD,0,0,16,16,switchSwitchDownBMD.width / 16,true);
         sprDeathDoor = new BlockSprite(deathDoorBMD,0,0,16,16,deathDoorBMD.width / 16,true);
         sprDeathGate = new BlockSprite(deathGateBMD,0,0,16,16,deathGateBMD.width / 16);
         sprOrangeDoors = new BlockSprite(switchOrangeDoorsBMD,0,0,16,16,switchOrangeDoorsBMD.width / 16,true);
         sprOrangeGates = new BlockSprite(switchOrangeGatesBMD,0,0,16,16,switchOrangeGatesBMD.width / 16);
         sprOrangeSwitchUP = new BlockSprite(switchOrangeSwitchUpBMD,0,0,16,16,switchOrangeSwitchUpBMD.width / 16,true);
         sprOrangeSwitchDOWN = new BlockSprite(switchOrangeSwitchDownBMD,0,0,16,16,switchOrangeSwitchDownBMD.width / 16,true);
         var _loc107_:int = 0;
         while(_loc107_ < bmdBricks.length)
         {
            if(bmdBricks[_loc107_] == null)
            {
               bmdBricks[_loc107_] = bmdBricks[0];
            }
            _loc107_++;
         }
      }
      
      private static function createBlockText(param1:int) : Bitmap
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc2_:BitmapData = new BitmapData(16,16,true,0);
         var _loc3_:int = 1;
         do
         {
            _loc5_ = param1 % 10;
            _loc6_ = _loc5_ == 1?2:4;
            _loc3_ = _loc3_ + _loc6_;
            _loc2_.copyPixels(blockTextBMD,new Rectangle(_loc5_ * 4,0,_loc6_,5),new Point(16 - _loc3_,10));
            _loc3_ = _loc3_ + 1;
            param1 = param1 / 10;
         }
         while(param1 > 0);
         
         var _loc4_:Bitmap = new Bitmap(_loc2_);
         _loc4_.filters = [new GlowFilter(0,1,2,2,2,3)];
         return _loc4_;
      }
      
      public static function getSmileyByPayvaultId(param1:String) : ItemSmiley
      {
         var _loc2_:int = 0;
         while(_loc2_ < smilies.length)
         {
            if(smilies[_loc2_].payvaultid == param1)
            {
               return smilies[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      public static function getSmileyById(param1:int) : ItemSmiley
      {
         var _loc2_:int = 0;
         while(_loc2_ < smilies.length)
         {
            if(smilies[_loc2_].id == param1)
            {
               return smilies[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      public static function getAuraByIdAndColor(param1:int, param2:int) : ItemAura
      {
         var _loc3_:int = 0;
         while(_loc3_ < auraShapes.length)
         {
            if(auraShapes[_loc3_].id == param1)
            {
               return auraShapes[_loc3_].auras[param2];
            }
            _loc3_++;
         }
         return null;
      }
      
      public static function getAuraShapeByPayVaultId(param1:String) : ItemAuraShape
      {
         var _loc2_:int = 0;
         while(_loc2_ < auraShapes.length)
         {
            if(auraShapes[_loc2_].payvaultid == param1)
            {
               return auraShapes[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      public static function getBrickPackageByName(param1:String) : ItemBrickPackage
      {
         var _loc2_:int = 0;
         while(_loc2_ < brickPackages.length)
         {
            if(brickPackages[_loc2_].name == param1)
            {
               return brickPackages[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      public static function getBrickPackageByDescription(param1:String) : ItemBrickPackage
      {
         var _loc2_:int = 0;
         while(_loc2_ < brickPackages.length)
         {
            if(brickPackages[_loc2_].description.toLowerCase() == param1.toLowerCase())
            {
               return brickPackages[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      public static function getBricksByPayVaultId(param1:String) : Vector.<ItemBrick>
      {
         var _loc3_:ItemBrickPackage = null;
         var _loc4_:ItemBrick = null;
         var _loc2_:Vector.<ItemBrick> = new Vector.<ItemBrick>();
         for each(_loc3_ in brickPackages)
         {
            for each(_loc4_ in _loc3_.bricks)
            {
               if(_loc4_.payvaultid == param1)
               {
                  _loc2_.push(_loc4_);
               }
            }
         }
         return _loc2_;
      }
      
      public static function getOpenWorldAntiSubset() : Vector.<ItemBrick>
      {
         var _loc1_:Vector.<ItemBrick> = new Vector.<ItemBrick>();
         _loc1_.push(getBrickById(ItemId.EFFECT_CURSE));
         _loc1_.push(getBrickById(ItemId.EFFECT_FLY));
         _loc1_.push(getBrickById(ItemId.EFFECT_JUMP));
         _loc1_.push(getBrickById(ItemId.EFFECT_LOW_GRAVITY));
         _loc1_.push(getBrickById(ItemId.EFFECT_MULTIJUMP));
         _loc1_.push(getBrickById(ItemId.EFFECT_PROTECTION));
         _loc1_.push(getBrickById(ItemId.EFFECT_RUN));
         _loc1_.push(getBrickById(ItemId.EFFECT_ZOMBIE));
         _loc1_.push(getBrickById(ItemId.ZOMBIE_DOOR));
         _loc1_.push(getBrickById(ItemId.ZOMBIE_GATE));
         _loc1_.push(getBrickById(ItemId.TEXT_SIGN));
         _loc1_.push(getBrickById(ItemId.PORTAL));
         _loc1_.push(getBrickById(ItemId.PORTAL_INVISIBLE));
         _loc1_.push(getBrickById(ItemId.WORLD_PORTAL));
         _loc1_.push(getBrickById(255));
         _loc1_.push(getBrickById(ItemId.CHECKPOINT));
         _loc1_.push(getBrickById(121));
         _loc1_.push(getBrickById(ItemId.RESET_POINT));
         _loc1_.push(getBrickById(ItemId.HOLOGRAM));
         _loc1_.push(getBrickById(ItemId.DIAMOND));
         _loc1_.push(getBrickById(ItemId.EFFECT_TEAM));
         _loc1_.push(getBrickById(ItemId.TEAM_DOOR));
         _loc1_.push(getBrickById(ItemId.TEAM_GATE));
         _loc1_.push(getBrickById(ItemId.TIMEDOOR));
         _loc1_.push(getBrickById(ItemId.TIMEGATE));
         _loc1_.push(getBrickById(ItemId.DOOR_GOLD));
         _loc1_.push(getBrickById(ItemId.GATE_GOLD));
         _loc1_.push(getBrickById(ItemId.SLOW_DOT_INVISIBLE));
         _loc1_.push(getBrickById(411),getBrickById(412),getBrickById(413),getBrickById(414));
         _loc1_.push(getBrickById(ItemId.COINDOOR),getBrickById(ItemId.COINGATE));
         _loc1_.push(getBrickById(ItemId.BLUECOINDOOR),getBrickById(ItemId.BLUECOINGATE));
         _loc1_.push(getBrickById(ItemId.SWITCH_ORANGE),getBrickById(ItemId.SWITCH_PURPLE));
         _loc1_.push(getBrickById(ItemId.GATE_ORANGE),getBrickById(ItemId.GATE_PURPLE));
         _loc1_.push(getBrickById(ItemId.DOOR_ORANGE),getBrickById(ItemId.DOOR_PURPLE));
         _loc1_.push(getBrickById(1000));
         _loc1_.push(getBrickById(1512));
         _loc1_.push(getBrickById(ItemId.FIRE),getBrickById(ItemId.SPIKE),getBrickById(ItemId.LAVA));
         _loc1_.push(getBrickById(ItemId.DEATH_DOOR),getBrickById(ItemId.DEATH_GATE));
         _loc1_.push(getBrickById(136),getBrickById(50),getBrickById(243));
         _loc1_.push(getBrickById(ItemId.CAKE));
         return _loc1_;
      }
      
      public static function getBrickById(param1:int) : ItemBrick
      {
         var _loc3_:ItemBrickPackage = null;
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         while(_loc2_ < brickPackages.length)
         {
            _loc3_ = brickPackages[_loc2_];
            _loc4_ = 0;
            while(_loc4_ < _loc3_.bricks.length)
            {
               if(_loc3_.bricks[_loc4_].id == param1)
               {
                  return _loc3_.bricks[_loc4_];
               }
               _loc4_++;
            }
            _loc2_++;
         }
         return null;
      }
      
      public static function getBrickByPayvaultId(param1:String) : ItemBrick
      {
         var _loc3_:ItemBrickPackage = null;
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         while(_loc2_ < brickPackages.length)
         {
            _loc3_ = brickPackages[_loc2_];
            _loc4_ = 0;
            while(_loc4_ < _loc3_.bricks.length)
            {
               if(_loc3_.bricks[_loc4_].payvaultid == param1)
               {
                  return _loc3_.bricks[_loc4_];
               }
               _loc4_++;
            }
            _loc2_++;
         }
         return null;
      }
      
      public static function getEffectBrickById(param1:int) : ItemBrick
      {
         switch(param1)
         {
            case Config.effectJump:
               return getBrickById(ItemId.EFFECT_JUMP);
            case Config.effectFly:
               return getBrickById(ItemId.EFFECT_FLY);
            case Config.effectRun:
               return getBrickById(ItemId.EFFECT_RUN);
            case Config.effectProtection:
               return getBrickById(ItemId.EFFECT_PROTECTION);
            case Config.effectCurse:
               return getBrickById(ItemId.EFFECT_CURSE);
            case Config.effectZombie:
               return getBrickById(ItemId.EFFECT_ZOMBIE);
            case Config.effectLowGravity:
               return getBrickById(ItemId.EFFECT_LOW_GRAVITY);
            case Config.effectFire:
               return getBrickById(ItemId.LAVA);
            case Config.effectMultijump:
               return getBrickById(ItemId.EFFECT_MULTIJUMP);
            default:
               return null;
         }
      }
      
      public static function getMinimapColor(param1:int) : Number
      {
         var _loc2_:ItemBrick = bricks[param1];
         return _loc2_ == null?Number(bricks[0].minimapColor):Number(_loc2_.minimapColor);
      }
      
      public static function getBlockDescription(param1:int) : String
      {
         return bricks[param1].description;
      }
      
      public static function getBlockTags(param1:int) : Array
      {
         return bricks[param1].tags;
      }
      
      private static function createBrick(param1:int, param2:int, param3:BitmapData, param4:String, param5:String, param6:int, param7:Boolean, param8:Boolean, param9:int, param10:Number, param11:Array = null, param12:Boolean = false, param13:Boolean = false) : ItemBrick
      {
         totalBricks++;
         var _loc14_:BitmapData = new BitmapData(16,16,true,0);
         _loc14_.copyPixels(param3,new Rectangle(16 * param9,0,16,16),new Point(0,0));
         var _loc15_:ItemBrick = new ItemBrick(param1,param2,_loc14_,param4,param5,param6,param7,param12,param13,param8,param10,param11);
         if(bricks[param1] != null)
         {
            throw new Error("Error creating new brick \'" + param4 + "\'. Brick id \'" + param1 + "\' is already in use");
         }
         bmdBricks[param1] = _loc15_.bmd;
         bricks[param1] = _loc15_;
         return _loc15_;
      }
      
      private static function addSmiley(param1:int, param2:String, param3:String, param4:BitmapData, param5:String, param6:uint = 4.294967295E9) : void
      {
         totalSmilies++;
         var _loc7_:BitmapData = new BitmapData(26,26,true,0);
         _loc7_.copyPixels(param4,new Rectangle(26 * param1,0,26,26),new Point(0,0));
         var _loc8_:BitmapData = new BitmapData(26,26,true,0);
         _loc8_.copyPixels(param4,new Rectangle(26 * param1,26,26,26),new Point(0,0));
         var _loc13_:BitmapData = new BitmapData(26,26,true,0);
         _loc13_.copyPixels(param4,new Rectangle(26 * param1,52,26,26),new Point(0,0));
         var _loc14_:BitmapData = new BitmapData(26,26,true,0);
         _loc14_.copyPixels(param4,new Rectangle(26 * param1,78,26,26),new Point(0,0));
         smilies.push(new ItemSmiley(param1,param2,param3,_loc7_,param5,param6,_loc8_,_loc13_,_loc14_));
      }
      
      private static function addAuraColor(param1:int, param2:String, param3:String) : void
      {
         totalAuraColors++;
         auraColors.push(new ItemAuraColor(param1,param2,param3));
      }
      
      private static function addAuraShape(param1:int, param2:String, param3:BitmapData, param4:String, param5:int = 1, param6:Number = 0.2, param7:Boolean = false) : void
      {
         totalAuraShapes++;
         var _loc8_:BitmapData = new BitmapData(64 * totalAuraColors,64 * param5,true,0);
         _loc8_.copyPixels(param3,new Rectangle(0,64 * auraImagesId,64 * totalAuraColors,64 * param5),new Point(0,0));
         var _loc9_:ItemAuraShape = new ItemAuraShape(param1,param2,_loc8_,param4,param5,param6,param7);
         auraShapes.push(_loc9_);
         auraImagesId = auraImagesId + param5;
      }
      
      public static function toSeconds(param1:int, param2:int, param3:int, param4:int = 0) : int
      {
         param2 = param2 + param1 * 24;
         param3 = param3 + param2 * 60;
         param4 = param4 + param3 * 60;
         return param4;
      }
      
      public static function getBackgroundRotateableSprite(param1:int) : BlockSprite
      {
         if(0)
         {
         }
         return null;
      }
      
      public static function GetBlockBounds(param1:int, param2:int = -1) : Rectangle
      {
         if(param2 != -1)
         {
            if(param2 == 0)
            {
               return new Rectangle(8,0,8,16);
            }
            if(param2 == 1)
            {
               return new Rectangle(0,8,16,8);
            }
            if(param2 == 2)
            {
               return new Rectangle(0,0,8,16);
            }
            if(param2 == 3)
            {
               return new Rectangle(0,0,16,8);
            }
            return new Rectangle(0,0,16,16);
         }
         if(bounds[param1] != null)
         {
            return bounds[param1] as Rectangle;
         }
         return new Rectangle(0,0,16,16);
      }
      
      private static function AddBlockBounds(param1:int, param2:int, param3:int, param4:int, param5:int) : void
      {
         if(bounds[param1] != null)
         {
            return;
         }
         bounds[param1] = new Rectangle(param2,param3,param4,param5);
      }
      
      public static function getRotateableSprite(param1:int) : BlockSprite
      {
         switch(param1)
         {
            case ItemId.GLOWYLINE_BLUE_SLOPE:
               return sprGlowylineBlueSlope;
            case ItemId.GLOWY_LINE_BLUE_STRAIGHT:
               return sprGlowylineBlueStraight;
            case ItemId.GLOWY_LINE_GREEN_SLOPE:
               return sprGlowylineGreenSlope;
            case ItemId.GLOWY_LINE_GREEN_STRAIGHT:
               return sprGlowylineGreenStraight;
            case ItemId.GLOWY_LINE_YELLOW_SLOPE:
               return sprGlowylineYellowSlope;
            case ItemId.GLOWY_LINE_YELLOW_STRAIGHT:
               return sprGlowylineYellowStraight;
            case ItemId.GLOWY_LINE_RED_SLOPE:
               return sprGlowylineRedSlope;
            case ItemId.GLOWY_LINE_RED_STRAIGHT:
               return sprGlowylineRedStraight;
            case ItemId.ONEWAY_CYAN:
               return sprOnewayCyan;
            case ItemId.ONEWAY_YELLOW:
               return sprOnewayYellow;
            case ItemId.ONEWAY_ORANGE:
               return sprOnewayOrange;
            case ItemId.ONEWAY_PINK:
               return sprOnewayPink;
            case ItemId.ONEWAY_GRAY:
               return sprOnewayGray;
            case ItemId.ONEWAY_BLUE:
               return sprOnewayBlue;
            case ItemId.ONEWAY_RED:
               return sprOnewayRed;
            case ItemId.ONEWAY_GREEN:
               return sprOnewayGreen;
            case ItemId.ONEWAY_BLACK:
               return sprOnewayBlack;
            case ItemId.ONEWAY_WHITE:
               return sprOnewayWhite;
            case ItemId.MEDIEVAL_AXE:
               return sprMedievalAxe;
            case ItemId.MEDIEVAL_BANNER:
               return sprMedievalBanner;
            case ItemId.MEDIEVAL_COATOFARMS:
               return sprMedievalCoatOfArms;
            case ItemId.MEDIEVAL_SHIELD:
               return sprMedievalShield;
            case ItemId.MEDIEVAL_SWORD:
               return sprMedievalSword;
            case ItemId.MEDIEVAL_TIMBER:
               return sprMedievalTimber;
            case ItemId.TOOTH_BIG:
               return sprToothBig;
            case ItemId.TOOTH_SMALL:
               return sprToothSmall;
            case ItemId.TOOTH_TRIPLE:
               return sprToothTriple;
            case ItemId.DOJO_LIGHT_LEFT:
               return sprDojoLightLeft;
            case ItemId.DOJO_LIGHT_RIGHT:
               return sprDojoLightRight;
            case ItemId.DOJO_DARK_LEFT:
               return sprDojoDarkLeft;
            case ItemId.DOJO_DARK_RIGHT:
               return sprDojoDarkRight;
            case ItemId.DOMESTIC_LIGHT_BULB:
               return sprDomesticLightBulb;
            case ItemId.DOMESTIC_TAP:
               return sprDomesticTap;
            case ItemId.DOMESTIC_PAINTING:
               return sprDomesticPainting;
            case ItemId.DOMESTIC_VASE:
               return sprDomesticVase;
            case ItemId.DOMESTIC_TV:
               return sprDomesticTV;
            case ItemId.DOMESTIC_WINDOW:
               return sprDomesticWindow;
            case ItemId.HALFBLOCK_DOMESTIC_BROWN:
               return sprHalfBlockDomesticBrown;
            case ItemId.HALFBLOCK_DOMESTIC_WHITE:
               return sprHalfBlockDomesticWhite;
            case ItemId.HALFBLOCK_DOMESTIC_YELLOW:
               return sprHalfBlockDomesticYellow;
            case ItemId.HALLOWEEN_2015_WINDOW_RECT:
               return sprHalloween2015WindowRect;
            case ItemId.HALLOWEEN_2015_WINDOW_CIRCLE:
               return sprHalloween2015WindowCircle;
            case ItemId.HALLOWEEN_2015_LAMP:
               return sprHalloween2015Lamp;
            case ItemId.NEW_YEAR_2015_BALLOON:
               return sprNewYear2015Balloon;
            case ItemId.NEW_YEAR_2015_STREAMER:
               return sprNewYear2015Streamer;
            case ItemId.HALFBLOCK_FAIRYTALE_ORANGE:
               return sprHalfBlockFairytaleRed;
            case ItemId.HALFBLOCK_FAIRYTALE_GREEN:
               return sprHalfBlockFairytaleGreen;
            case ItemId.HALFBLOCK_FAIRYTALE_BLUE:
               return sprHalfBlockFairytaleBlue;
            case ItemId.HALFBLOCK_FAIRYTALE_PINK:
               return sprHalfBlockFairytalePink;
            case ItemId.FAIRYTALE_FLOWERS:
               return sprFairytaleFlowers;
            case ItemId.SPRING_TULIP:
               return sprSpringTulip;
            case ItemId.SPRING_DAISY:
               return sprSpringDaisy;
            case ItemId.SPRING_DAFFODIL:
               return sprSpringDaffodil;
            case ItemId.SUMMER_FLAG:
               return sprSummerFlag;
            case ItemId.SUMMER_AWNING:
               return sprSummerAwning;
            case ItemId.SUMMER_ICECREAM:
               return sprSummerIceCream;
            case ItemId.CAVE_TORCH:
               return sprCaveTorch;
            case ItemId.CAVE_CRYSTAL:
               return sprCaveCrystal;
            case ItemId.RESTAURANT_CUP:
               return sprRestaurantCup;
            case ItemId.RESTAURANT_PLATE:
               return sprRestaurantPlate;
            case ItemId.RESTAURANT_BOWL:
               return sprRestaurantBowl;
            case ItemId.HALLOWEEN_2016_ROTATABLE:
               return sprHalloweenRot;
            case ItemId.HALLOWEEN_2016_EYES:
               return sprHalloweenEyes;
            case ItemId.HALLOWEEN_2016_PUMPKIN:
               return sprHalloweenPumpkin;
            case ItemId.CHRISTMAS_2016_LIGHTS_DOWN:
               return sprChristmas2016LightsDown;
            case ItemId.CHRISTMAS_2016_LIGHTS_UP:
               return sprChristmas2016LightsUp;
            default:
               return null;
         }
      }
   }
}
