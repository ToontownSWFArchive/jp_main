on(press){
   m_bar._y = Math.min(m_bar.bottom,m_bar._y + step_scroll);
   m_bar.onMouseMoveFunc();
   this.onEnterFrame = function()
   {
      m_bar._y = Math.min(m_bar.bottom,m_bar._y + step_scroll);
      m_bar.onMouseMoveFunc();
   };
}
