---@meta love2d

---Allows you to work with fonts.
---
---[Open in Browser](https://love2d.org/wiki/love.font)
---
---@class love.font
love.font = {}

--region love.GlyphData

---A GlyphData represents a drawable symbol of a font Rasterizer.
---
---[Open in Browser](https://love2d.org/wiki/GlyphData)
---
---@class love.GlyphData : love.Data, love.Object
GlyphData = {}

---Gets glyph advance.
---
---[Open in Browser](https://love2d.org/wiki/GlyphData:getAdvance)
---
---@param self love.GlyphData
---@return number advance Glyph advance.
function GlyphData:getAdvance() end

---Gets glyph bearing.
---
---[Open in Browser](https://love2d.org/wiki/GlyphData:getBearing)
---
---@param self love.GlyphData
---@return number bx Glyph bearing X.
---@return number by Glyph bearing Y.
function GlyphData:getBearing() end

---Gets glyph bounding box.
---
---[Open in Browser](https://love2d.org/wiki/GlyphData:getBoundingBox)
---
---@param self love.GlyphData
---@return number x Glyph position x.
---@return number y Glyph position y.
---@return number width Glyph width.
---@return number height Glyph height.
function GlyphData:getBoundingBox() end

---Gets glyph dimensions.
---
---[Open in Browser](https://love2d.org/wiki/GlyphData:getDimensions)
---
---@param self love.GlyphData
---@return number width Glyph width.
---@return number height Glyph height.
function GlyphData:getDimensions() end

---Gets glyph pixel format.
---
---[Open in Browser](https://love2d.org/wiki/GlyphData:getFormat)
---
---@param self love.GlyphData
---@return love.PixelFormat format Glyph pixel format.
function GlyphData:getFormat() end

---Gets glyph number.
---
---[Open in Browser](https://love2d.org/wiki/GlyphData:getGlyph)
---
---@param self love.GlyphData
---@return number glyph Glyph number.
function GlyphData:getGlyph() end

---Gets glyph string.
---
---[Open in Browser](https://love2d.org/wiki/GlyphData:getGlyphString)
---
---@param self love.GlyphData
---@return string glyph Glyph string.
function GlyphData:getGlyphString() end

---Gets glyph height.
---
---[Open in Browser](https://love2d.org/wiki/GlyphData:getHeight)
---
---@param self love.GlyphData
---@return number height Glyph height.
function GlyphData:getHeight() end

---Gets glyph width.
---
---[Open in Browser](https://love2d.org/wiki/GlyphData:getWidth)
---
---@param self love.GlyphData
---@return number width Glyph width.
function GlyphData:getWidth() end

--endregion love.GlyphData

--region love.Rasterizer

---A Rasterizer handles font rendering, containing the font data (image or TrueType font) and drawable glyphs.
---
---[Open in Browser](https://love2d.org/wiki/Rasterizer)
---
---@class love.Rasterizer : love.Object
Rasterizer = {}

---Gets font advance.
---
---[Open in Browser](https://love2d.org/wiki/Rasterizer:getAdvance)
---
---@param self love.Rasterizer
---@return number advance Font advance.
function Rasterizer:getAdvance() end

---Gets ascent height.
---
---[Open in Browser](https://love2d.org/wiki/Rasterizer:getAscent)
---
---@param self love.Rasterizer
---@return number height Ascent height.
function Rasterizer:getAscent() end

---Gets descent height.
---
---[Open in Browser](https://love2d.org/wiki/Rasterizer:getDescent)
---
---@param self love.Rasterizer
---@return number height Descent height.
function Rasterizer:getDescent() end

---Gets number of glyphs in font.
---
---[Open in Browser](https://love2d.org/wiki/Rasterizer:getGlyphCount)
---
---@param self love.Rasterizer
---@return number count Glyphs count.
function Rasterizer:getGlyphCount() end

---Gets glyph data of a specified glyph.
---
---[Open in Browser](https://love2d.org/wiki/Rasterizer:getGlyphData)
---
---@param self love.Rasterizer
---@param glyph string Glyph
---@return love.GlyphData glyphData Glyph data
---@overload fun(self: love.Rasterizer, glyphNumber: number): love.GlyphData
function Rasterizer:getGlyphData(glyph) end

---Gets font height.
---
---[Open in Browser](https://love2d.org/wiki/Rasterizer:getHeight)
---
---@param self love.Rasterizer
---@return number height Font height
function Rasterizer:getHeight() end

---Gets line height of a font.
---
---[Open in Browser](https://love2d.org/wiki/Rasterizer:getLineHeight)
---
---@param self love.Rasterizer
---@return number height Line height of a font.
function Rasterizer:getLineHeight() end

---Checks if font contains specified glyphs.
---
---[Open in Browser](https://love2d.org/wiki/Rasterizer:hasGlyphs)
---
---@param self love.Rasterizer
---@param glyph1 string|number Glyph
---@return boolean hasGlyphs Whatever font contains specified glyphs.
function Rasterizer:hasGlyphs(glyph1, ...) end

--endregion love.Rasterizer

---True Type hinting mode.
---
---[Open in Browser](https://love2d.org/wiki/HintingMode)
---
---@alias love.HintingMode
---| "normal" # Default hinting. Should be preferred for typical antialiased fonts.
---| "light" # Results in fuzzier text but can sometimes preserve the original glyph shapes of the text better than normal hinting.
---| "mono" # Results in aliased / unsmoothed text with either full opacity or completely transparent pixels. Should be used when antialiasing is not desired for the font.
---| "none" # Disables hinting for the font. Results in fuzzier text.

---Creates a new BMFont Rasterizer.
---
---[Open in Browser](https://love2d.org/wiki/love.font.newBMFontRasterizer)
---
---@param imageData love.ImageData The image data containing the drawable pictures of font glyphs.
---@param glyphs string The sequence of glyphs in the ImageData.
---@param dpiscale number? DPI scale. (defaults to `1`).
---@return love.Rasterizer rasterizer The rasterizer.
---@overload fun(fileName: string, glyphs: string, dpiscale: number?): love.Rasterizer
function love.font.newBMFontRasterizer(imageData, glyphs, dpiscale) end

---Creates a new GlyphData.
---
---[Open in Browser](https://love2d.org/wiki/love.font.newGlyphData)
---
---@param rasterizer love.Rasterizer The Rasterizer containing the font.
---@param glyph number The character code of the glyph.
function love.font.newGlyphData(rasterizer, glyph) end

---Creates a new Image Rasterizer.
---
---[Open in Browser](https://love2d.org/wiki/love.font.newImageRasterizer)
---
---Create an ImageRasterizer from the image data.
---@param imageData love.ImageData Font image data.
---@param glyphs string String containing font glyphs.
---@param extraSpacing number? Font extra spacing. (defaults to `0`).
---@param dpiscale number? Font DPI scale. (defaults to `1`).
---@return love.Rasterizer rasterizer The rasterizer.
function love.font.newImageRasterizer(imageData, glyphs, extraSpacing, dpiscale) end

---Creates a new Rasterizer.
---
---[Open in Browser](https://love2d.org/wiki/love.font.newRasterizer)
---
---Create a TrueTypeRasterizer with custom font.
---@param fileName string Path to font file.
---@param size number? The font size. (defaults to `12`).
---@param hinting love.HintingMode? True Type hinting mode. (defaults to `'normal'`).
---@param dpiscale number? The font DPI scale. (defaults to `love.window.getDPIScale()`).
---@return love.Rasterizer rasterizer The rasterizer.
---Create a TrueTypeRasterizer with custom font.
---@overload fun(fileData: love.FileData, size: number?, hinting: love.HintingMode?, dpiscale: number?): love.Rasterizer
---Creates a new BMFont Rasterizer.
---@overload fun(imageData: love.ImageData, glyphs: string, dpiscale: number?): love.Rasterizer
---Creates a new BMFont Rasterizer.
---@overload fun(fileName: string, glyphs: string, dpiscale: number?): love.Rasterizer
---Create a TrueTypeRasterizer with the default font.
---@overload fun(size: number, hinting: love.HintingMode?, dpiscale: number?): love.Rasterizer
---@overload fun(data: love.FileData): love.Rasterizer
---@overload fun(filename: string): love.Rasterizer
function love.font.newRasterizer(fileName, size, hinting, dpiscale) end

---Creates a new TrueType Rasterizer.
---
---[Open in Browser](https://love2d.org/wiki/love.font.newTrueTypeRasterizer)
---
---Create a TrueTypeRasterizer with custom font.
---@param fileData love.FileData File data containing font.
---@param size number? The font size. (defaults to `12`).
---@param hinting love.HintingMode? True Type hinting mode. (defaults to `'normal'`).
---@param dpiscale number? The font DPI scale. (defaults to `love.window.getDPIScale()`).
---@return love.Rasterizer rasterizer The rasterizer.
---Create a TrueTypeRasterizer with custom font.
---@overload fun(fileName: string, size: number?, hinting: love.HintingMode?, dpiscale: number?): love.Rasterizer
---Create a TrueTypeRasterizer with the default font.
---@overload fun(size: number, hinting: love.HintingMode?, dpiscale: number?): love.Rasterizer
function love.font.newTrueTypeRasterizer(fileData, size, hinting, dpiscale) end

