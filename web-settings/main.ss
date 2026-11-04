// 托管网页设置模板：眼镜生成设置码 → 手机网页写 relay/<设置码> → 眼镜每 5 秒读一次。
// 设置一定存在眼镜的 persist var 里：服务器那份 12 小时不保存会过期，没连手机时也读不到。
persist var code = "";
persist var minutes = 25;
persist var sound = 1;
persist var label = "专注";
persist var rev = "";                           // 网页每次保存写新的 rev；没变就不重画、不写盘
var left = 1500;

fn gen() { var a = "ABCDEFGHJKMNPQRSTUVWXYZ23456789"; var s = ""; var i = 0;
           while (i < 8) { s = s + sub(a, rand(31), 1); i += 1; } return s; }
fn render() { text(title, label); text(time, pad(left / 60, 2) + ":" + pad(left % 60, 2));
              text(hint, "手机打开设置页，输入 " + code); }

on open()    { if (code == "") { code = gen(); save(); } left = minutes * 60; render();
               request(cfg, code); timer(1, 5000, 1); }
on timer(id) { if (id == 1) { request(cfg, code); } }
on data(seq) {
  if (data("_err") != "") { return; }           // 还没设置 / 已过期 / 没网：沿用眼镜上存的
  if (data("rev") == rev) { return; }
  rev = data("rev");
  minutes = clamp(num(data("min")), 1, 120);
  sound = num(data("snd")) != 0;
  if (data("ttl") != "") { label = data("ttl"); }
  left = minutes * 60; save(); render();
}
