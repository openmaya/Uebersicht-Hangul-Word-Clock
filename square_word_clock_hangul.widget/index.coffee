#
# Square Word Clock in Korean widget for Übersicht
# Kwanghyun Ko (openmaya@gmail.com)

style: """
  top: auto
  bottom: 10%
  right: 30px
  left: auto
  font-family: 'Andale Mono', sans-serif
  color: rgba(145, 145, 145, .8)
  font-weight: 50
  text-align: left
  text-transform: uppercase
  font-size: 2vw
  letter_spacing: 0.035em
  font-smoothing: antialiased
  line-height: 1.1em
  text-shadow: 1px 1px 0px rgba(10, 10, 0, .1)
  
  .active
    color: rgba(245, 245, 245, 1)
    text-shadow: 1px 1px 0px rgba(105, 105, 105, .4)

"""

# Get the current hour as word.
command: ""

# Lower the frequency for more accuracy.
refreshFrequency: (1000 * 1) # (1000 * n) seconds


render: (o) -> """
  <div id="content">
    <span id="밤">밤</span><span id="한">한</span><span id="다">다</span><span id="세">세</span><span id="네">네</span><br/>
    <span id="열">열</span><span id="여">여</span><span id="섯">섯</span><span id="일">일</span><span id="곱">곱</span><br/>
    <span id="두">두</span><span id="덟">덟</span><span id="아">아</span><span id="홉">홉</span><span id="시">시</span><br/>
    <span id="자">자</span><span id="정">정</span><span id="이">이</span><span id="삼">삼</span><span id="십1">십</span><br/>
    <span id="사">사</span><span id="오1">오</span><span id="십2">십</span><span id="오2">오</span><span id="분">분</span><br/>
  </div>
  <div id="log" class="active">

  </div>
"""


update: (output, dom) ->
  
  hours = [["밤","열","두"], ["한"], ["두"], ["세"], ["네"], ["다","섯"], ["여","섯"], ["일","곱"],
    ["여","덟"], ["아","홉"], ["열"], ["열","한"], ["열","두"]]
  minutes = [null, ["오2"], ["십1"], ["십2","오2"], ["이","십1"], ["이","십1","오2"], ["삼","십1"],["삼","십1","오2"], ["사","십2"],
    ["사","십2","오2"], ["오1","십2"], ["오1","십2","오2"]]
  noons = [["자","정"],["정","오1"]]
  
  ligthOffAll = () -> $(dom).find(".active").removeClass("active")
  lightOn = (str) -> $(dom).find("##{str}").addClass("active")
  log = (str) -> $(dom).find("#log").html(str)
  timeOn = (ar) -> lightOn typo for typo in ar

  ligthOffAll()

  date   = new Date()
  minute = date.getMinutes()
  hour   = date.getHours()
  
  if (hour is 0 or hour is 12) and minute is 0 
    lightOn h_typo for h_typo in noons[Math.floor(hour / 12)]
  else
    h_idx = if hour > 12 then hour % 12 else hour
    timeOn(hours[h_idx])
    lightOn("시")

    m_idx = Math.floor(minute / 5)
    if m_idx isnt 0
      timeOn(minutes[m_idx])
      lightOn("분")


