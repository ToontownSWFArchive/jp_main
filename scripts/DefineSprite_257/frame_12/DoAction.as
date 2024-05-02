theNum = 1;
var mc = this.createEmptyMovieClip("mc" + theNum,theNum);
eval("mc" + theNum)._x = -71;
eval("mc" + theNum)._y = -87;
eval("mc" + theNum).loadMovie("promotion/" + theNum + ".jpg");
oldMC = "mc" + theNum;
