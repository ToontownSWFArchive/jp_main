function playVideo()
{
   var owner = this;
   nc = new NetConnection();
   nc.connect(null);
   ns = new NetStream(nc);
   ns.onStatus = function(info)
   {
      trace(info.level + ":" + info.code);
      if(info.code == "NetStream.Play.Start")
      {
         m_bufferingMeter._visible = true;
      }
      else if(info.code == "NetStream.Play.Stop")
      {
         m_bufferingMeter._visible = false;
      }
      else if(info.code == "NetStream.Buffer.Empty")
      {
         m_bufferingMeter._visible = true;
      }
      else if(info.code == "NetStream.Buffer.Full")
      {
         m_bufferingMeter._visible = false;
      }
      else if(info.code == "NetStream.Play.StreamNotFound")
      {
         m_bufferingMeter._visible = false;
      }
   };
   ns.onMetaData = function(info)
   {
      owner.onEnterFrame = function()
      {
         if(ns.time >= info.duration)
         {
            delete this.onEnterFrame;
            isPlay = false;
            stopVideo();
         }
      };
   };
   my_video.attachVideo(ns);
   m_bufferingMeter._visible = true;
   ns.setBufferTime(10);
   if(this.filename.indexOf("http://") == 0)
   {
      ns.play(this.filename);
   }
   else
   {
      ns.play(this.filename);
   }
   b_play.enabled = false;
   b_stop.enabled = true;
   b_pause.enabled = true;
   b_stop._alpha = !b_stop.enabled?50:100;
   b_play._alpha = !b_play.enabled?50:100;
   b_pause._alpha = !b_pause.enabled?50:100;
}
function pauseVideo()
{
   isPause = true;
   ns.pause(true);
   b_play.enabled = true;
   b_stop.enabled = true;
   b_pause.enabled = false;
   b_stop._alpha = !b_stop.enabled?50:100;
   b_play._alpha = !b_play.enabled?50:100;
   b_pause._alpha = !b_pause.enabled?50:100;
   Selection.setFocus(null);
}
function replayVideo()
{
   isPause = false;
   ns.pause(false);
   b_play.enabled = false;
   b_stop.enabled = true;
   b_pause.enabled = true;
   b_stop._alpha = !b_stop.enabled?50:100;
   b_play._alpha = !b_play.enabled?50:100;
   b_pause._alpha = !b_pause.enabled?50:100;
   Selection.setFocus(null);
}
function stopVideo()
{
   delete this.onEnterFrame;
   isPause = false;
   my_video.clear();
   ns.close();
   m_bufferingMeter._visible = false;
   b_stop.enabled = false;
   b_play.enabled = true;
   b_pause.enabled = false;
   b_stop._alpha = !b_stop.enabled?50:100;
   b_play._alpha = !b_play.enabled?50:100;
   b_pause._alpha = !b_pause.enabled?50:100;
   _parent.onEnterFrame = function()
   {
      if(this.isFinishFall)
      {
         delete this.onEnterFrame;
         _global.toontown.sound.playBGM("main",100,100);
         this._parent.gotoAndPlay(1);
      }
      else
      {
         this.prevFrame();
      }
   };
}
function openVideo(filename)
{
   this.filename = filename;
   b_play.enabled = true;
   b_stop.enabled = false;
   b_pause.enabled = false;
   b_stop._alpha = !b_stop.enabled?50:100;
   b_play._alpha = !b_play.enabled?50:100;
   b_pause._alpha = !b_pause.enabled?50:100;
   _parent.m_frame._visible = false;
   this._visible = true;
   this.playVideo();
}
function closeVideo()
{
   my_video.clear();
   ns.close();
   this._visible = false;
   _parent.m_frame._visible = true;
   _parent.onEnterFrame = _parent.onEnterFrameFunc;
}
this._visible = false;
b_cover.useHandCursor = false;
isPlay = false;
isPause = false;
m_bufferingMeter._visible = false;
_global.toontown.sound.BGM.setFade("main",0,10);
this.openVideo("movies/promo.flv");
