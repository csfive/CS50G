<div align="center">

# Harvard CS50G · 2D 游戏开发

**中** · [English](./README.en.md)

[![CS50][cs50-src]][cs50-href]
[![Lua][lua-src]][lua-href]
[![LÖVE][love-src]][love-href]
[![Notes][notes-src]][notes-href]

</div>

## 简介

这是从零学习 [CS50 2D 游戏开发](https://cs50.harvard.edu/games/)（CS50G）的代码仓库：用 **Lua + LÖVE**，跟着 lecture 一周实现一个经典小游戏，最后做自选的 Final Project。

- **代码** —— 每个项目一个自包含目录，按 lecture 的推进顺序写。
- **笔记** —— 写在 [csfive/home](https://github.com/csfive/home)，内容包括 lecture 要点、代码片段、我踩过的坑和更多内容延伸。

## 相关链接

| 资源       | 链接（以 Week 0 示例）                                                                                                                                                   |
| ---------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| 课程主页   | [CS50 2D](https://cs50.harvard.edu/games)                                                                                                                                |
| 讲座视频   | [YouTube 播放列表](https://www.youtube.com/playlist?list=PLhQjrBD2T380FZyaKIkZYuZWe2B1UHilA) · [CS50 Video Player](https://video.cs50.io/MY2y3dDwgMk?screen=0hk8ubOAsv8) |
| 官方讲义   | [notes](https://cs50.harvard.edu/games/notes/0/) · [slides (PDF)](https://cdn.cs50.net/2d/2025/x/lectures/0/lecture0.pdf)                                                |
| 官方源码   | [github.com/games50](https://github.com/games50) · [源码 zip](https://cdn.cs50.net/2d/2025/x/lectures/0/src0.zip)                                                        |
| 我的笔记   | [在线查看](https://csfive.netlify.app/cs50g/00) · [仓库](https://github.com/csfive/home)                                                                                 |
| LÖVE / Lua | [love2d.org](https://love2d.org/) · [LÖVE Wiki](https://love2d.org/wiki/Main_Page) · [Lua 5.1 手册](https://www.lua.org/manual/5.1/)                                     |

## 进度

| 周  | 项目                                                         | 规格                                                        | 代码              | 笔记                                                | 状态 |
| --- | ------------------------------------------------------------ | ----------------------------------------------------------- | ----------------- | --------------------------------------------------- | ---- |
| 0   | [Pong](https://cs50.harvard.edu/games/weeks/0/)              | [Spec](https://cs50.harvard.edu/games/projects/0/pong/)     | `00-pong/`        | [笔记](https://csfive.netlify.app/cs50g/00)         | ⬜   |
| 1   | [Flappy Bird](https://cs50.harvard.edu/games/weeks/1/)       | [Spec](https://cs50.harvard.edu/games/projects/1/flappy/)   | `01-flappy-bird/` | [笔记](https://csfive.netlify.app/cs50g/01)         | ⬜   |
| 2   | [Breakout](https://cs50.harvard.edu/games/weeks/2/)          | [Spec](https://cs50.harvard.edu/games/projects/2/breakout/) | `02-breakout/`    | [笔记](https://csfive.netlify.app/cs50g/02)         | ⬜   |
| 3   | [Match 3](https://cs50.harvard.edu/games/weeks/3/)           | [Spec](https://cs50.harvard.edu/games/projects/3/match/)    | `03-match3/`      | [笔记](https://csfive.netlify.app/cs50g/03)         | ⬜   |
| 4   | [Super Mario Bros.](https://cs50.harvard.edu/games/weeks/4/) | [Spec](https://cs50.harvard.edu/games/projects/4/mario/)    | `04-mario/`       | [笔记](https://csfive.netlify.app/cs50g/04)         | ⬜   |
| 5   | [Legend of Zelda](https://cs50.harvard.edu/games/weeks/5/)   | [Spec](https://cs50.harvard.edu/games/projects/5/zelda/)    | `05-zelda/`       | [笔记](https://csfive.netlify.app/cs50g/05)         | ⬜   |
| 6   | [Angry Birds](https://cs50.harvard.edu/games/weeks/6/)       | [Spec](https://cs50.harvard.edu/games/projects/6/angry/)    | `06-angry-birds/` | [笔记](https://csfive.netlify.app/cs50g/06)         | ⬜   |
| 7   | [Pokémon](https://cs50.harvard.edu/games/weeks/7/)           | [Spec](https://cs50.harvard.edu/games/projects/7/pokemon/)  | `07-pokemon/`     | [笔记](https://csfive.netlify.app/cs50g/07)         | ⬜   |
| ✦   | [Final Project](https://cs50.harvard.edu/games/final/)       | [Spec](https://cs50.harvard.edu/games/final/)               | `final/`          | —                                                   | ⬜   |

状态：⬜ 未开始 · 🚧 进行中 · ✅ 已完成

## 环境与运行

需要 [LÖVE](https://love2d.org/) **11.5**（当前稳定版），内置 LuaJIT / Lua 5.1。

```bash
# macOS
brew install --cask love

# 运行某一周
love 0-pong
```

## 致谢与许可

课程由 **Colton Ogden** 与 **David J. Malan** 讲授，课程材料（讲义、素材、示例代码）版权归 CS50 所有，遵循 [CC BY-NC-SA 4.0](https://cs50.harvard.edu/games/license/)。本仓库中的代码为个人跟做练习，仅供学习参考。

<!-- Badges -->

[cs50-src]: https://img.shields.io/badge/CS50-2D%20Game%20Development-1f6feb?style=flat&colorA=18181b&colorB=1f6feb
[cs50-href]: https://cs50.harvard.edu/games/
[lua-src]: https://img.shields.io/badge/Lua-5.1-1f6feb?style=flat&colorA=18181b&colorB=1f6feb
[lua-href]: https://www.lua.org/
[love-src]: https://img.shields.io/badge/L%C3%96VE-11.5-1f6feb?style=flat&colorA=18181b&colorB=1f6feb
[love-href]: https://love2d.org/
[notes-src]: https://img.shields.io/badge/Notes-CS%20Five-1f6feb?style=flat&colorA=18181b&colorB=1f6feb
[notes-href]: https://csfive.netlify.app/cs50g/00
