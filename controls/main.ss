// 手机控制面板模板：ctl() 读控件值，on control(id) 收到变化，ctl_set() 回写只读控件。
persist var done = 0;
var left = 1500;
var running = 0;

fn fmt(s) { return pad(s / 60, 2) + ":" + pad(s % 60, 2); }
fn draw() {
  text(time, fmt(left));
  if (running) { text(hint, "专注中 · 单击暂停"); } else { text(hint, "单击开始 · 已完成 " + str(done) + " 个"); }
}
fn style() { if (ctl("style") == 1) { gray(time, 140); } else { gray(time, 255); } }

on open() { left = ctl("minutes") * 60; style(); draw(); }

on control(id) {                                   // "*" = 刚打开时手机补发了全部值
  if ((id == "minutes" || id == "*") && !running) { left = ctl("minutes") * 60; }
  if (id == "style" || id == "*") { style(); }
  if (id == "reset") { done = 0; save(); ctl_set("done", 0); }
  draw();
}

on click() {
  if (running) { running = 0; timer(0, 0, 0); } else { running = 1; timer(0, 1000, 1); }
  draw();
}

on timer(id) {
  left -= 1;
  if (left <= 0) {
    running = 0; timer(0, 0, 0);
    done += 1; save(); ctl_set("done", done);
    left = ctl("minutes") * 60;
    anim_opa(time, 60, 255, 600);
  }
  draw();
}
