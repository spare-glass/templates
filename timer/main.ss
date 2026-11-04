// 倒计时模板：计时器、进度条、状态切换。应用只在打开时运行，关掉就停。
var total = 300;
var left = 300;
var running = 0;

fn fmt(s) { return pad(s / 60, 2) + ":" + pad(s % 60, 2); }

fn draw() {
  text(time, fmt(left));
  value(bar, (total - left) * 100 / total);
  if (running) { text(hint, "单击暂停"); }
  else if (left == 0) { text(hint, "到时间了 · 单击重来"); }
  else { text(hint, "转表冠调时长 · 单击开始"); }
}

on open() { draw(); }

on crown(d) {
  if (running) { return; }
  total = clamp(total + d * 60, 60, 5940);
  left = total;
  draw();
}

on click() {
  if (left == 0) { left = total; draw(); return; }
  if (running) { running = 0; timer(0, 0, 0); }
  else { running = 1; timer(0, 1000, 1); }
  draw();
}

on timer(id) {
  left -= 1;
  if (left <= 0) { left = 0; running = 0; timer(0, 0, 0); anim_opa(time, 60, 255, 600); }
  draw();
}
