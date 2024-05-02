on(press){
   m_bar._y = Math.max(m_bar.top,m_bar._y - step_scroll);
   m_bar.onMouseMoveFunc();
   this.onEnterFrame = function()
   {
      m_bar._y = Math.max(m_bar.top,m_bar._y - step_scroll);
      m_bar.onMouseMoveFunc();
   };
}
