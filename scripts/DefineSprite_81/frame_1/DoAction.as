this.stop();
loop = 2;
count = 240;
this.onEnterFrame = function()
{
   if(--count == 0)
   {
      delete this.onEnterFrame;
      this.play();
   }
};
