trace(theMaxNum);
if(theNum == theMaxNum)
{
   theNum = 1;
}
else
{
   theNum++;
}
var mc = this.createEmptyMovieClip("mc" + theNum,theNum);
eval("mc" + theNum)._x = -71;
eval("mc" + theNum)._y = -87;
eval("mc" + theNum)._alpha = 0;
eval("mc" + theNum).loadMovie("promotion/" + theNum + ".jpg");
