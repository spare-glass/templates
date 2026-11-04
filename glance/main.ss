// 「瞄一眼」模板（以后的 card / face 组件就是这个形状）：只显示，不需要操作。
fn hhmm() { var m = clock(); return pad(m / 60, 2) + ":" + pad(m % 60, 2); }
fn draw_wx() {
  if (data("temp") == "") { text(cond, "天气获取中…"); return; }
  text(cond, data("temp") + "°  " + data("text"));
}

on open() {
  text(time, hhmm()); draw_wx();
  request(wx, "");
  timer(0, 10000, 1);                          // 每 10 秒刷新时间
  timer(1, 1800000, 1);                        // 每 30 分钟刷新天气
}

on timer(id) {
  if (id == 0) { text(time, hhmm()); } else { request(wx, ""); }
}

on data(seq) {
  if (data("_err") != "") { if (data("temp") == "") { text(cond, "天气暂不可用"); } return; }
  draw_wx();
}
