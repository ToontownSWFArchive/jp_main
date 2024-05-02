function loadPrData()
{
   var lv2 = new LoadVars();
   lv2.onData = function(src)
   {
      src = src.split("\r\n").join("\n").split("\r").join("\n");
      if(src.length > 0)
      {
         PrList = src.split("\n");
         theMaxNum = PrList.length;
         play();
      }
   };
   lv2.load("promotion/link.dat");
}
stop();
var theMaxNum = 0;
var PrList = [];
this.loadPrData();
