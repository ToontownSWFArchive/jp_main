stop();
var mcbtn = this.createEmptyMovieClip("mcbtn",10000);
mcbtn.attachMovie("mcbtn","btn_mc",10000);
mcbtn.btn_mc._x = -40;
mcbtn.btn_mc._y = 10;
mcbtn.btn_mc.btn.onPress = function()
{
   getUrl("javascript:urchinTracker(\'/home_guest/promotion\');", "");
};
mcbtn.btn_mc.btn.onRelease = function()
{
   getURL("javascript:popupWin(\'" + PrList[theNum - 1] + "\')","");
};
