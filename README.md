<div align="center">

# Harvard CS50G · 2D 游戏开发

**中** · [English](./README.en.md)

[![CS50][cs50-src]][cs50-href]
[![LÖVE][love-src]][love-href]
[![Lua][lua-src]][lua-href]

</div>

CS50 2D（原名 CS50G）是哈佛 [CS50x](https://github.com/csfive/CS50x) 之后的课：用 Lua + LÖVE 一周做一个经典游戏，从 Pong、Flappy Bird、Breakout 一直到马里奥、塞尔达、宝可梦，最后交一个自选的 Final Project。讲的是 2D 图形、动画、音效和碰撞检测这些每个游戏都绕不开的东西。

这是 [@mancuoj](https://github.com/mancuoj) 自学的代码仓库：每个 Project（包含作业）一个目录，不一定照搬课程代码，更多是按自己的理解重写。

## 相关链接

| 资源       | 链接                                                                                                                                                                     |
| ---------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| 课程主页   | [CS50 2D 游戏开发](https://cs50.harvard.edu/games)                                                                                                                       |
| 讲座视频   | [YouTube 播放列表](https://www.youtube.com/playlist?list=PLhQjrBD2T380FZyaKIkZYuZWe2B1UHilA) · [CS50 Video Player](https://video.cs50.io/MY2y3dDwgMk?screen=0hk8ubOAsv8) |
| 官方讲义   | [Week 0 notes](https://cs50.harvard.edu/games/notes/0/) · [slides (PDF)](https://cdn.cs50.net/2d/2025/x/lectures/0/lecture0.pdf)                                         |
| 官方源码   | [github.com/games50](https://github.com/games50) · [Week 0 源码 zip](https://cdn.cs50.net/2d/2025/x/lectures/0/src0.zip)                                                 |
| 我的笔记   | [在线查看](https://csfive.netlify.app/cs50g/00) · [仓库](https://github.com/csfive/home)                                                                                 |
| LÖVE / Lua | [love2d.org](https://love2d.org/) · [LÖVE Wiki](https://love2d.org/wiki/Main_Page) · [Lua 5.1 手册](https://www.lua.org/manual/5.1/)                                     |

## 进度

| 周  | 项目                                                         | 作业                                                        | 代码                                  | 笔记                                        | 状态 |
| --- | ------------------------------------------------------------ | ----------------------------------------------------------- | ------------------------------------- | ------------------------------------------- | ---- |
| 0   | [Pong](https://cs50.harvard.edu/games/weeks/0/)              | [说明](https://cs50.harvard.edu/games/projects/0/pong/)     | [`00-pong/`](./00-pong)               | [笔记](https://csfive.netlify.app/cs50g/00) | 🚧   |
| 1   | [Flappy Bird](https://cs50.harvard.edu/games/weeks/1/)       | [说明](https://cs50.harvard.edu/games/projects/1/flappy/)   | [`01-flappy-bird/`](./01-flappy-bird) | [笔记](https://csfive.netlify.app/cs50g/01) | ⬜   |
| 2   | [Breakout](https://cs50.harvard.edu/games/weeks/2/)          | [说明](https://cs50.harvard.edu/games/projects/2/breakout/) | [`02-breakout/`](./02-breakout)       | [笔记](https://csfive.netlify.app/cs50g/02) | ⬜   |
| 3   | [Match 3](https://cs50.harvard.edu/games/weeks/3/)           | [说明](https://cs50.harvard.edu/games/projects/3/match/)    | [`03-match3/`](./03-match3)           | [笔记](https://csfive.netlify.app/cs50g/03) | ⬜   |
| 4   | [Super Mario Bros.](https://cs50.harvard.edu/games/weeks/4/) | [说明](https://cs50.harvard.edu/games/projects/4/mario/)    | [`04-mario/`](./04-mario)             | [笔记](https://csfive.netlify.app/cs50g/04) | ⬜   |
| 5   | [Legend of Zelda](https://cs50.harvard.edu/games/weeks/5/)   | [说明](https://cs50.harvard.edu/games/projects/5/zelda/)    | [`05-zelda/`](./05-zelda)             | [笔记](https://csfive.netlify.app/cs50g/05) | ⬜   |
| 6   | [Angry Birds](https://cs50.harvard.edu/games/weeks/6/)       | [说明](https://cs50.harvard.edu/games/projects/6/angry/)    | [`06-angry-birds/`](./06-angry-birds) | [笔记](https://csfive.netlify.app/cs50g/06) | ⬜   |
| 7   | [Pokémon](https://cs50.harvard.edu/games/weeks/7/)           | [说明](https://cs50.harvard.edu/games/projects/7/pokemon/)  | [`07-pokemon/`](./07-pokemon)         | [笔记](https://csfive.netlify.app/cs50g/07) | ⬜   |
| ✦   | [Final Project](https://cs50.harvard.edu/games/final/)       | —                                                           | [`final/`](./final)                   | —                                           | ⬜   |

状态：⬜ 未开始 · 🚧 进行中 · ✅ 已完成

## 环境与运行

需要 [LÖVE](https://love2d.org/) 11.5（当前稳定版）。macOS 可以用 Homebrew 安装，其他平台见[下载页](https://love2d.org/)。

```bash
# macOS
brew install --cask love

# 运行某一周
love 00-pong
```

## 致谢与许可

课程由 **Colton Ogden** 与 **David J. Malan** 讲授，课程材料（讲义、素材、示例代码）版权归 CS50 所有，遵循 [CC BY-NC-SA 4.0](https://cs50.harvard.edu/games/license/)。本仓库中的代码为个人跟做练习，仅供学习参考。

<!-- Badges -->

[cs50-src]: https://img.shields.io/badge/CS50-2D%20Game%20Development-4f7d14?style=flat&colorA=13160f&colorB=4f7d14
[cs50-href]: https://cs50.harvard.edu/games/
[lua-src]: https://img.shields.io/badge/Lua-5.1-4f7d14?style=flat&colorA=13160f&colorB=4f7d14
[lua-href]: https://www.lua.org/
[love-src]: https://img.shields.io/badge/L%C3%96VE-11.5-4f7d14?style=flat&colorA=13160f&colorB=4f7d14
[love-href]: https://love2d.org/
