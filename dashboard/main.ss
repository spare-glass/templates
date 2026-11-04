// 数据看板模板：手机代取 JSON（http_json）、离线缓存、定时刷新。
// 数据用 MCP set_app_data 写到 kv/today：{"line1": "...", "line2": "...", "by": "..."}，每个值 ≤ 63 字节。
fn draw() { text(l1, data("q1")); text(l2, data("q2")); text(by, data("by")); }

on open() {
  if (data("q1") != "") { draw(); } else { text(l1, "正在获取…"); }
  if (!connected()) { text(st, "未连接手机 · 显示上次内容"); }
  request(quote, "");
  timer(0, 600000, 1);                         // 10 分钟刷新一次
}

on timer(id) { request(quote, ""); }

on click() { text(st, "刷新中…"); request(quote, ""); }

on data(seq) {
  if (data("_err") != "") {
    if (data("q1") == "") { text(l1, "暂时取不到内容"); }
    text(st, "");
    return;
  }
  text(st, "");
  draw();
}
