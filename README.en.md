<div align="center">

# Harvard CS50G · 2D Game Development

**EN** · [中](./README.md)

[![CS50][cs50-src]][cs50-href]
[![LÖVE][love-src]][love-href]
[![Lua][lua-src]][lua-href]
[![Notes][notes-src]][notes-href]

</div>

## About

A repo for learning [CS50's Introduction to 2D Game Development](https://cs50.harvard.edu/games/) (CS50G) from scratch: one classic game per week with **Lua + LÖVE**, following the lectures, plus a self-chosen Final Project.

- **Code** — one self-contained directory per project, written in lecture order.
- **Notes** — written in [csfive/home](https://github.com/csfive/home): lecture highlights, code snippets, the pitfalls I hit, and pointers to go further.

## Links

| Resource   | Link                                                                                                                                                                     |
| ---------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Course     | [CS50 2D](https://cs50.harvard.edu/games)                                                                                                                                |
| Lectures   | [YouTube playlist](https://www.youtube.com/playlist?list=PLhQjrBD2T380FZyaKIkZYuZWe2B1UHilA) · [CS50 Video Player](https://video.cs50.io/MY2y3dDwgMk?screen=0hk8ubOAsv8) |
| Notes      | [Week 0 notes](https://cs50.harvard.edu/games/notes/0/) · [slides (PDF)](https://cdn.cs50.net/2d/2025/x/lectures/0/lecture0.pdf)                                         |
| Source     | [github.com/games50](https://github.com/games50) · [Week 0 source zip](https://cdn.cs50.net/2d/2025/x/lectures/0/src0.zip)                                               |
| My notes   | [view online](https://csfive.netlify.app/cs50g/00) · [repo](https://github.com/csfive/home)                                                                              |
| LÖVE / Lua | [love2d.org](https://love2d.org/) · [LÖVE Wiki](https://love2d.org/wiki/Main_Page) · [Lua 5.1 reference](https://www.lua.org/manual/5.1/)                                |

## Progress

| Week | Project                                                      | Assignment                                                  | Code              | Notes                                        | Status |
| ---- | ------------------------------------------------------------ | ----------------------------------------------------------- | ----------------- | -------------------------------------------- | ------ |
| 0    | [Pong](https://cs50.harvard.edu/games/weeks/0/)              | [Spec](https://cs50.harvard.edu/games/projects/0/pong/)     | `00-pong/`        | [Notes](https://csfive.netlify.app/cs50g/00) | ⬜     |
| 1    | [Flappy Bird](https://cs50.harvard.edu/games/weeks/1/)       | [Spec](https://cs50.harvard.edu/games/projects/1/flappy/)   | `01-flappy-bird/` | [Notes](https://csfive.netlify.app/cs50g/01) | ⬜     |
| 2    | [Breakout](https://cs50.harvard.edu/games/weeks/2/)          | [Spec](https://cs50.harvard.edu/games/projects/2/breakout/) | `02-breakout/`    | [Notes](https://csfive.netlify.app/cs50g/02) | ⬜     |
| 3    | [Match 3](https://cs50.harvard.edu/games/weeks/3/)           | [Spec](https://cs50.harvard.edu/games/projects/3/match/)    | `03-match3/`      | [Notes](https://csfive.netlify.app/cs50g/03) | ⬜     |
| 4    | [Super Mario Bros.](https://cs50.harvard.edu/games/weeks/4/) | [Spec](https://cs50.harvard.edu/games/projects/4/mario/)    | `04-mario/`       | [Notes](https://csfive.netlify.app/cs50g/04) | ⬜     |
| 5    | [Legend of Zelda](https://cs50.harvard.edu/games/weeks/5/)   | [Spec](https://cs50.harvard.edu/games/projects/5/zelda/)    | `05-zelda/`       | [Notes](https://csfive.netlify.app/cs50g/05) | ⬜     |
| 6    | [Angry Birds](https://cs50.harvard.edu/games/weeks/6/)       | [Spec](https://cs50.harvard.edu/games/projects/6/angry/)    | `06-angry-birds/` | [Notes](https://csfive.netlify.app/cs50g/06) | ⬜     |
| 7    | [Pokémon](https://cs50.harvard.edu/games/weeks/7/)           | [Spec](https://cs50.harvard.edu/games/projects/7/pokemon/)  | `07-pokemon/`     | [Notes](https://csfive.netlify.app/cs50g/07) | ⬜     |
| ✦    | [Final Project](https://cs50.harvard.edu/games/final/)       | [Spec](https://cs50.harvard.edu/games/final/)               | `final/`          | —                                            | ⬜     |

Status: ⬜ Not started · 🚧 In progress · ✅ Done

## Setup & run

Requires [LÖVE](https://love2d.org/) **11.5** (current stable), which bundles LuaJIT 2.1 (Lua 5.1 semantics). On macOS install it with Homebrew; for other platforms see the [download page](https://love2d.org/).

```bash
# macOS
brew install --cask love

# run a week
love 00-pong
```

## Credits & license

Taught by **Colton Ogden** and **David J. Malan**. Course materials (slides, assets, distribution code) belong to CS50 and are licensed [CC BY-NC-SA 4.0](https://cs50.harvard.edu/games/license/). The code in this repo is personal practice, for study only.

<!-- Badges -->

[cs50-src]: https://img.shields.io/badge/CS50-2D%20Game%20Development-1f6feb?style=flat&colorA=18181b&colorB=1f6feb
[cs50-href]: https://cs50.harvard.edu/games/
[lua-src]: https://img.shields.io/badge/Lua-5.1-1f6feb?style=flat&colorA=18181b&colorB=1f6feb
[lua-href]: https://www.lua.org/
[love-src]: https://img.shields.io/badge/L%C3%96VE-11.5-1f6feb?style=flat&colorA=18181b&colorB=1f6feb
[love-href]: https://love2d.org/
[notes-src]: https://img.shields.io/badge/Notes-CS%20Five-1f6feb?style=flat&colorA=18181b&colorB=1f6feb
[notes-href]: https://csfive.netlify.app/cs50g/00
