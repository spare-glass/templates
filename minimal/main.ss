// 最小模板：表冠加减，单击清零，数字关掉应用也记得。
persist var n = 0;

on open()   { text(big, n); }
on crown(d) { n = clamp(n + d, -999, 999); text(big, n); save(); }
on click()  { n = 0; text(big, n); anim_opa(big, 80, 255, 300); save(); }
