this.stop();
count = 40 * loop - 5;
this.onEnterFrame = function()
{
   if(--count < 0)
   {
      delete this.onEnterFrame;
      this.play();
   }
};
