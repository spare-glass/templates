# Spare 眼镜应用模板

复制一个文件夹就能开始写自己的 Spare 眼镜应用。每个模板都能直接编译，每次云端构建都跑完了平台压力场景（0 FAULT）。

| 模板 | 演示什么 | 权限 |
|---|---|---|
| [minimal](minimal/) | 最小应用：表冠、单击、持久变量 | 无 |
| [timer](timer/) | 计时器、进度条、状态切换 | 无 |
| [dashboard](dashboard/) | 手机代取 JSON（`http_json`）、离线缓存、定时刷新 | `network:apps.spare.cool` |
| [controls](controls/) | 手机原生控制面板（`controls`）：滑块、选项、只读值、按钮 | 无 |
| [web-settings](web-settings/) | 托管网页做设置页（`publish_page` + 配对码中转） | `network:apps.spare.cool` |
| [glance](glance/) | 「瞄一眼」型：时间 + 天气，不需要操作（以后的卡片 / 表盘组件就是这个形状） | `location` |

## 用法

1. 复制一个模板文件夹，把 `app.json` 里的 `id` 换成平台分配给你的 `dev.<handle>.<名字>`。URL 里如果有 `dev.yourname.…`，一起替换。
2. 改 `app.json`（界面）和 `main.ss`（逻辑），改 `scenarios/smoke.txt`（模拟器场景）。
3. 编译、模拟、装到眼镜，参见[开发者文档](https://github.com/spare-glass/docs)。

许可：0BSD。随意复制，不用署名。
