---@meta love2d

---This module is responsible for decoding, controlling, and streaming video files.
---
---It can't draw the videos, see love.graphics.newVideo and Video objects for that.
---
---[Open in Browser](https://love2d.org/wiki/love.video)
---
---@class love.video
love.video = {}

--region love.VideoStream

---An object which decodes, streams, and controls Videos.
---
---[Open in Browser](https://love2d.org/wiki/VideoStream)
---
---@class love.VideoStream : love.Object
VideoStream = {}

---Gets the filename of the VideoStream.
---
---[Open in Browser](https://love2d.org/wiki/VideoStream:getFilename)
---
---@param self love.VideoStream
---@return string filename The filename of the VideoStream
function VideoStream:getFilename() end

---Gets whether the VideoStream is playing.
---
---[Open in Browser](https://love2d.org/wiki/VideoStream:isPlaying)
---
---@param self love.VideoStream
---@return boolean playing Whether the VideoStream is playing.
function VideoStream:isPlaying() end

---Pauses the VideoStream.
---
---[Open in Browser](https://love2d.org/wiki/VideoStream:pause)
---
---@param self love.VideoStream
function VideoStream:pause() end

---Plays the VideoStream.
---
---[Open in Browser](https://love2d.org/wiki/VideoStream:play)
---
---@param self love.VideoStream
function VideoStream:play() end

---Rewinds the VideoStream. Synonym to VideoStream:seek(0).
---
---[Open in Browser](https://love2d.org/wiki/VideoStream:rewind)
---
---@param self love.VideoStream
function VideoStream:rewind() end

---Sets the current playback position of the VideoStream.
---
---[Open in Browser](https://love2d.org/wiki/VideoStream:seek)
---
---@param self love.VideoStream
---@param offset number The time in seconds since the beginning of the VideoStream.
function VideoStream:seek(offset) end

---Gets the current playback position of the VideoStream.
---
---[Open in Browser](https://love2d.org/wiki/VideoStream:tell)
---
---@param self love.VideoStream
---@return number seconds The number of seconds sionce the beginning of the VideoStream.
function VideoStream:tell() end

--endregion love.VideoStream

---Creates a new VideoStream. Currently only Ogg Theora video files are supported. VideoStreams can't draw videos, see love.graphics.newVideo for that.
---
---[Open in Browser](https://love2d.org/wiki/love.video.newVideoStream)
---
---@param filename string The file path to the Ogg Theora video file.
---@return love.VideoStream videostream A new VideoStream.
---@overload fun(file: love.File): love.VideoStream
function love.video.newVideoStream(filename) end

