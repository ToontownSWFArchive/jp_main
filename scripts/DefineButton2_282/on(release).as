on(release){
   if(_root.m_character._currentframe == _root.m_character._totalframes - 1)
   {
      getUrl("javascript:urchinTracker(\'/home_guest/movie\');", "");
      _root.m_character.nextFrame();
      _root.newspaper.gotoAndStop(1);
      post.gotoAndStop(1);
   }
}
