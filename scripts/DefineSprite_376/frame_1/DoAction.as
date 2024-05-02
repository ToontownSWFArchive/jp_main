m_bufferingBar._xscale = 0;
m_bufferingBar._alpha = 80;
m_bufferingBar.onEnterFrame = function()
{
   this._xscale = 100 * _parent.ns.bufferLength / _parent.ns.bufferTime;
};
