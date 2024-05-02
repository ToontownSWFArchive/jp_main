this.onEnterFrame = function()
{
   theSize = eval("mc" + theNum).getBytesLoaded() / eval("mc" + theNum).getBytesTotal() * 100;
   if(eval("mc" + theNum).getBytesTotal() > 0 && theSize >= 100)
   {
      delete this.onEnterFrame;
      play();
   }
};
stop();
