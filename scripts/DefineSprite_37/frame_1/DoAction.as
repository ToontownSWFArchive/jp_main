this.stop();
count = 30;
this.onEnterFrame = function()
{
   if(_global.toontown.sound.getBGMBytesLoaded("main") < 10)
   {
      return undefined;
   }
   var loaded = _parent.getBytesLoaded() + _global.toontown.sound.getBGMBytesLoaded("main");
   var total = _parent.getBytesTotal() + _global.toontown.sound.getBGMBytesTotal("main");
   var percent = 100 * loaded / total;
   if(percent < 100)
   {
      m_water._y = 50 - percent / 2;
      txt_percent.text = Math.round(percent);
   }
   else
   {
      txt_percent._x = txt_percent._x - 1.2;
      txt_percent.text = 100;
      this.nextFrame();
      this.onEnterFrame = function()
      {
         if(--count < 0)
         {
            delete this.onEnterFrame;
            _global.toontown.sound.playBGM("main",100,100,100);
            _parent.play();
         }
      };
   }
};
