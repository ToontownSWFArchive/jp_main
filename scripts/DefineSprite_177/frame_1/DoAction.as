function loadNewsData()
{
   var lv = new LoadVars();
   lv.onData = function(src)
   {
      src = src.split("\r\n").join("\n").split("\r").join("\n");
      if(src.length > 0)
      {
         var arr = src.split("\n");
         var len = arr.length;
         var i = 0;
         while(i < len)
         {
            var news_arr = arr[i].split("<>");
            newsList.push({time:news_arr[0],subject:news_arr[1],news:news_arr[2]});
            i++;
         }
         setupTable();
      }
      txt_nowloading._visible = false;
   };
   lv.load("news/news.dat");
}
function setupTable()
{
   var arr = newsList;
   var len = arr.length;
   var i = 1;
   while(i <= len)
   {
      var oDATA = arr[i - 1];
      var row_mc = m_table.m_row.duplicateMovieClip("m_row" + i,i);
      row_mc._y = i != 1?m_table["m_row" + (i - 1)]._y + m_table["m_row" + (i - 1)]._height + 10:m_table.m_row._y;
      row_mc.txt_time.text = this.getTimeFormat(oDATA.time);
      row_mc.txt_subject.text = oDATA.subject;
      row_mc.txt_subject._height = row_mc.txt_subject.textHeight + 5;
      row_mc.m_line1._y = row_mc.txt_subject._y + row_mc.txt_subject._height + 5;
      row_mc.txt_news.htmlText = this.getNewsFormat(oDATA.news);
      row_mc.txt_news._y = row_mc.m_line1._y + 5;
      row_mc.txt_news._height = txt_news.txt_subject.textHeight + 5;
      row_mc.m_line2._y = row_mc.txt_news._y + row_mc.txt_news._height + 5;
      i++;
   }
   m_table.m_row._visible = false;
   if(m_table._height > m_mask._height)
   {
      this.setScrollbar();
   }
   else
   {
      m_scrollbar._visible = false;
   }
}
function setScrollbar()
{
   m_scrollbar.step_scroll = 10;
   m_scrollbar.m_bar.top = 0;
   m_scrollbar.m_bar.bottom = 160;
   m_scrollbar.m_bar.onPress = function()
   {
      this.startDrag(true,this._x,this.top,this._x,this.bottom);
      this.onMouseMove = this.onMouseMoveFunc;
   };
   m_scrollbar.m_bar.onRelease = function()
   {
      stopDrag();
      delete this.onMouseMove;
   };
   m_scrollbar.m_bar.onReleaseOutside = m_scrollbar.m_bar.onRelease;
   m_scrollbar.m_bar.onMouseMoveFunc = function()
   {
      m_table._y = m_mask._y - (m_table._height - m_mask._height) * this._y / this.bottom;
   };
   m_scrollbar.onMouseWheelFunc = function(delta)
   {
      if(delta > 0)
      {
         this.m_bar._y = Math.max(this.m_bar._y - this.step_scroll,this.m_bar.top);
      }
      else
      {
         this.m_bar._y = Math.min(this.m_bar._y + this.step_scroll,this.m_bar.bottom);
      }
      this.m_bar.onMouseMoveFunc();
   };
   _parent.oWHEEL.addListener(m_scrollbar);
}
function getNewsFormat(news)
{
   if(news.length > 40)
   {
      news = news.substr(0,40) + "..";
   }
   return news + "\n" + "<a href=\"asfunction:_parent._parent.jumpToNewsPage, aaa\"><font color=\"#FF0000\">→続きを読む</font></a>";
}
function jumpToNewsPage()
{
   getUrl("news/index.html", "");
}
function getTimeFormat(time)
{
   var year = parseFloat(time.substr(0,4));
   var month = parseFloat(time.substr(4,2));
   var day = parseFloat(time.substr(6,2));
   var d = new Date(year,month - 1,day);
   return year + "年" + month + "月" + day + "日 (" + dayList[d.getDay()] + ")";
}
dayList = ["日","月","火","水","木","金","土"];
newsList = [];
m_table.m_row._visible = false;
m_table.setMask(m_mask);
this.loadNewsData();
