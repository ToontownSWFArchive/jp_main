function playBGM(linkage)
{
   s_bgm = new Sound(m_bgm);
   s_bgm.attachSound("bgm_" + linkage);
   s_bgm.onSoundComplete = function()
   {
      this.start(0);
   };
   s_bgm.start(0);
}
this.stop();
_global.toontown = this;
_global.toontown.sound = m_sound;
_global.toontown.sound.BGM = m_sound.m_bgm;
_global.toontown.sound.SE = m_sound.m_se;
_global.toontown.sound.initialize = function()
{
   this.masterVolume = 100;
   this.BGM.initialize();
   this.SE.initialize();
};
_global.toontown.sound.BGM.initialize = function()
{
   var config_so = SharedObject.getLocal("cab_config","/");
   this.masterVolume = config_so.data.bgm_vol == undefined?80:config_so.data.bgm_vol;
   this.current_bgm = "";
   this.id = 0;
};
_global.toontown.sound.SE.initialize = function()
{
   var config_so = SharedObject.getLocal("cab_config","/");
   this.masterVolume = config_so.data.se_vol == undefined?80:config_so.data.se_vol;
   this.id = 0;
};
_global.toontown.sound.loadBGM = function(bgm)
{
   var m_bgm = this.BGM["bgm_" + bgm];
   if(m_bgm != undefined)
   {
      return undefined;
   }
   this.BGM.id = this.BGM.id + 1;
   var m = this.BGM.createEmptyMovieClip("bgm_" + bgm,this.BGM.id);
   m.loadMovie("bgm/bgm_" + bgm + ".swf");
};
_global.toontown.sound.playBGM = function(bgm, default_vol, dest_vol, fadein_speed, loop_point)
{
   var m_bgm = this.BGM["bgm_" + bgm];
   if(bgm != this.current_bgm)
   {
      this.BGM.setFade(this.BGM.current_bgm,0,2);
      this.BGM.current_bgm = bgm;
   }
   if(m_bgm.vol > 0)
   {
      m_bgm.dest_vol = dest_vol;
      m_bgm.speed = fadein_speed == undefined?2:fadein_speed;
      this.BGM.setFade(bgm,m_bgm.dest_vol,m_bgm.fadein_speed);
      return undefined;
   }
   m_bgm.vol = default_vol;
   m_bgm.dest_vol = dest_vol;
   m_bgm.speed = fadein_speed == undefined?2:fadein_speed;
   if(m_bgm.s == undefined)
   {
      m_bgm.s = new Sound(m_bgm);
      m_bgm.s._parent = m;
      m_bgm.s.attachSound("bgm_" + bgm);
      m_bgm.s.loop_point = loop_point == undefined?0.05:loop_point;
      m_bgm.s.onSoundComplete = function()
      {
         this.start(this.loop_point);
      };
   }
   m_bgm.s.setVolume(m_bgm.vol * this.BGM.masterVolume / 100 * this.masterVolume / 100);
   m_bgm.s.start(0);
   this.BGM.setFade(bgm,m_bgm.dest_vol,m_bgm.speed);
};
_global.toontown.sound.getBGMBytesLoaded = function(bgm)
{
   return this.BGM["bgm_" + bgm].getBytesLoaded();
};
_global.toontown.sound.getBGMBytesTotal = function(bgm)
{
   return this.BGM["bgm_" + bgm].getBytesTotal();
};
_global.toontown.sound.checkBGMLoaded = function(bgm)
{
   var m = this.BGM["bgm_" + bgm];
   return m.s.position > 0;
};
_global.toontown.sound.BGM.setFade = function(bgm, dest_vol, speed)
{
   var m_bgm = this["bgm_" + bgm];
   if(speed != undefined)
   {
      m_bgm.speed = speed;
   }
   m_bgm.dest_vol = dest_vol;
   if(dest_vol > m_bgm.vol)
   {
      m_bgm.onEnterFrame = function()
      {
         if(this.dest_vol > this.vol)
         {
            var next_vol = this.vol + this.speed;
            if(next_vol > this.dest_vol)
            {
               next_vol = this.dest_vol;
            }
            this.vol = next_vol;
            this.s.setVolume(this.vol * this._parent.masterVolume / 100 * _global.toontown.sound.masterVolume / 100);
         }
         else
         {
            delete this.onEnterFrame;
         }
      };
   }
   else
   {
      m_bgm.onEnterFrame = function()
      {
         if(this.dest_vol < this.vol)
         {
            var next_vol = this.vol - this.speed;
            if(next_vol < this.dest_vol)
            {
               next_vol = this.dest_vol;
            }
            this.vol = next_vol;
            this.s.setVolume(this.vol * this._parent.masterVolume / 100 * _global.toontown.sound.masterVolume / 100);
            if(this.vol == 0)
            {
               this.s.stop();
            }
         }
         else
         {
            delete this.onEnterFrame;
         }
      };
   }
};
_global.toontown.sound.BGM.setVolume = function(vol)
{
   this["bgm_" + this.current_bgm].vol = vol;
};
_global.toontown.sound.BGM.setMasterVolume = function(vol, speed)
{
   this.masterVolume = vol;
   this["bgm" + this.id].s.setVolume(this["bgm" + this.id].vol * this.masterVolume / 100 * _global.toontown.sound.masterVolume / 100);
};
_global.toontown.sound.BGM.getMasterVolume = function()
{
   return this.masterVolume;
};
_global.toontown.sound.playSE = function(linkage, vol)
{
   var volume = vol != undefined?vol:100;
   var m = this.SE["m_" + linkage];
   if(m == undefined)
   {
      this.SE.id = this.SE.id + 1;
      m = this.SE.createEmptyMovieClip("m_" + linkage,this.SE.id);
      m.s = new Sound(m);
      m.s.attachSound("se_" + linkage);
   }
   m.s.setVolume(volume * this.SE.masterVolume / 100 * this.masterVolume / 100);
   m.s.start(0);
};
_global.toontown.sound.SE.setMasterVolume = function(vol)
{
   this.masterVolume = vol;
};
_global.toontown.sound.SE.getMasterVolume = function()
{
   return this.masterVolume;
};
_global.toontown.sound.initialize();
_global.toontown.sound.loadBGM("main");
oWHEEL = {};
AsBroadcaster.initialize(oWHEEL);
oWHEEL.onMouseWheel = function(delta)
{
   this.broadcastMessage("onMouseWheelFunc",delta);
};
Mouse.addListener(oWHEEL);
