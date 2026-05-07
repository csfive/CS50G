---@meta love2d

---This module is responsible for decoding sound files. It can't play the sounds, see love.audio for that.
---
---[Open in Browser](https://love2d.org/wiki/love.sound)
---
---@class love.sound
love.sound = {}

--region love.Decoder

---An object which can gradually decode a sound file.
---
---[Open in Browser](https://love2d.org/wiki/Decoder)
---
---@class love.Decoder : love.Object
Decoder = {}

---Creates a new copy of current decoder.
---
---The new decoder will start decoding from the beginning of the audio stream.
---
---[Open in Browser](https://love2d.org/wiki/Decoder:clone)
---
---@param self love.Decoder
---@return love.Decoder decoder New copy of the decoder.
function Decoder:clone() end

---Decodes the audio and returns a SoundData object containing the decoded audio data.
---
---[Open in Browser](https://love2d.org/wiki/Decoder:decode)
---
---@param self love.Decoder
---@return love.SoundData soundData Decoded audio data.
function Decoder:decode() end

---Returns the number of bits per sample.
---
---[Open in Browser](https://love2d.org/wiki/Decoder:getBitDepth)
---
---@param self love.Decoder
---@return number bitDepth Either 8, or 16.
function Decoder:getBitDepth() end

---Returns the number of channels in the stream.
---
---[Open in Browser](https://love2d.org/wiki/Decoder:getChannelCount)
---
---@param self love.Decoder
---@return number channels 1 for mono, 2 for stereo.
function Decoder:getChannelCount() end

---Gets the duration of the sound file. It may not always be sample-accurate, and it may return -1 if the duration cannot be determined at all.
---
---[Open in Browser](https://love2d.org/wiki/Decoder:getDuration)
---
---@param self love.Decoder
---@return number duration The duration of the sound file in seconds, or -1 if it cannot be determined.
function Decoder:getDuration() end

---Returns the sample rate of the Decoder.
---
---[Open in Browser](https://love2d.org/wiki/Decoder:getSampleRate)
---
---@param self love.Decoder
---@return number rate Number of samples per second.
function Decoder:getSampleRate() end

---Sets the currently playing position of the Decoder.
---
---[Open in Browser](https://love2d.org/wiki/Decoder:seek)
---
---@param self love.Decoder
---@param offset number The position to seek to, in seconds.
function Decoder:seek(offset) end

--endregion love.Decoder

--region love.SoundData

---Contains raw audio samples.
---
---You can not play SoundData back directly. You must wrap a Source object around it.
---
---[Open in Browser](https://love2d.org/wiki/SoundData)
---
---@class love.SoundData : love.Data, love.Object
SoundData = {}

---Returns the number of bits per sample.
---
---[Open in Browser](https://love2d.org/wiki/SoundData:getBitDepth)
---
---@param self love.SoundData
---@return number bitdepth Either 8, or 16.
function SoundData:getBitDepth() end

---Returns the number of channels in the SoundData.
---
---[Open in Browser](https://love2d.org/wiki/SoundData:getChannelCount)
---
---@param self love.SoundData
---@return number channels 1 for mono, 2 for stereo.
function SoundData:getChannelCount() end

---Gets the duration of the sound data.
---
---[Open in Browser](https://love2d.org/wiki/SoundData:getDuration)
---
---@param self love.SoundData
---@return number duration The duration of the sound data in seconds.
function SoundData:getDuration() end

---Gets the value of the sample-point at the specified position. For stereo SoundData objects, the data from the left and right channels are interleaved in that order.
---
---[Open in Browser](https://love2d.org/wiki/SoundData:getSample)
---
---Gets the value of a sample using an explicit sample index instead of interleaving them in the sample position parameter.
---@param self love.SoundData
---@param i number An integer value specifying the position of the sample (starting at 0).
---@param channel number The index of the channel to get within the given sample.
---@return number sample The normalized samplepoint (range -1.0 to 1.0).
---@overload fun(self: love.SoundData, i: number): number
function SoundData:getSample(i, channel) end

---Returns the number of samples per channel of the SoundData.
---
---[Open in Browser](https://love2d.org/wiki/SoundData:getSampleCount)
---
---@param self love.SoundData
---@return number count Total number of samples.
function SoundData:getSampleCount() end

---Returns the sample rate of the SoundData.
---
---[Open in Browser](https://love2d.org/wiki/SoundData:getSampleRate)
---
---@param self love.SoundData
---@return number rate Number of samples per second.
function SoundData:getSampleRate() end

---Sets the value of the sample-point at the specified position. For stereo SoundData objects, the data from the left and right channels are interleaved in that order.
---
---[Open in Browser](https://love2d.org/wiki/SoundData:setSample)
---
---Sets the value of a sample using an explicit sample index instead of interleaving them in the sample position parameter.
---@param self love.SoundData
---@param i number An integer value specifying the position of the sample (starting at 0).
---@param channel number The index of the channel to set within the given sample.
---@param sample number The normalized samplepoint (range -1.0 to 1.0).
---@overload fun(self: love.SoundData, i: number, sample: number): nil
function SoundData:setSample(i, channel, sample) end

--endregion love.SoundData

---Attempts to find a decoder for the encoded sound data in the specified file.
---
---[Open in Browser](https://love2d.org/wiki/love.sound.newDecoder)
---
---@param file love.File The file with encoded sound data.
---@param buffer number? The size of each decoded chunk, in bytes. (defaults to `2048`).
---@return love.Decoder decoder A new Decoder object.
---@overload fun(filename: string, buffer: number?): love.Decoder
function love.sound.newDecoder(file, buffer) end

---Creates new SoundData from a filepath, File, or Decoder. It's also possible to create SoundData with a custom sample rate, channel and bit depth.
---
---The sound data will be decoded to the memory in a raw format. It is recommended to create only short sounds like effects, as a 3 minute song uses 30 MB of memory this way.
---
---[Open in Browser](https://love2d.org/wiki/love.sound.newSoundData)
---
---@param samples number Total number of samples.
---@param rate number? Number of samples per second (defaults to `44100`).
---@param bits number? Bits per sample (8 or 16). (defaults to `16`).
---@param channels number? Either 1 for mono or 2 for stereo. (defaults to `2`).
---@return love.SoundData soundData A new SoundData object.
---@overload fun(decoder: love.Decoder): love.SoundData
---@overload fun(file: love.File): love.SoundData
---@overload fun(filename: string): love.SoundData
function love.sound.newSoundData(samples, rate, bits, channels) end

