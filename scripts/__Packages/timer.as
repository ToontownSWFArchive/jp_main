class timer
{
   function timer(targetMC)
   {
      this.mc = targetMC;
   }
   function waitAndPlay(milisec)
   {
      this.mc.stop();
      clearInterval(this.waitTimer);
      this.waitTimer = setInterval(this,"timeout",milisec);
   }
   function timeout()
   {
      clearInterval(this.waitTimer);
      this.mc.play();
   }
}
