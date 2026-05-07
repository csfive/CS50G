---@meta love2d

---Allows you to work with threads.
---
---Threads are separate Lua environments, running in parallel to the main code. As their code runs separately, they can be used to compute complex operations without adversely affecting the frame rate of the main thread. However, as they are separate environments, they cannot access the variables and functions of the main thread, and communication between threads is limited.
---
---All LOVE objects (userdata) are shared among threads so you'll only have to send their references across threads. You may run into concurrency issues if you manipulate an object on multiple threads at the same time.
---
---When a Thread is started, it only loads the love.thread module. Every other module has to be loaded with require.
---
---[Open in Browser](https://love2d.org/wiki/love.thread)
---
---@class love.thread
love.thread = {}

--region love.Channel

---An object which can be used to send and receive data between different threads.
---
---[Open in Browser](https://love2d.org/wiki/Channel)
---
---@class love.Channel : love.Object
Channel = {}

---Clears all the messages in the Channel queue.
---
---[Open in Browser](https://love2d.org/wiki/Channel:clear)
---
---@param self love.Channel
function Channel:clear() end

---Retrieves the value of a Channel message and removes it from the message queue.
---
---It waits until a message is in the queue then returns the message value.
---
---[Open in Browser](https://love2d.org/wiki/Channel:demand)
---
---@param self love.Channel
---@param timeout number The maximum amount of time to wait.
---@return Variant value The contents of the message or nil if the timeout expired.
---@overload fun(self: love.Channel): Variant
function Channel:demand(timeout) end

---Retrieves the number of messages in the thread Channel queue.
---
---[Open in Browser](https://love2d.org/wiki/Channel:getCount)
---
---@param self love.Channel
---@return number count The number of messages in the queue.
function Channel:getCount() end

---Gets whether a pushed value has been popped or otherwise removed from the Channel.
---
---[Open in Browser](https://love2d.org/wiki/Channel:hasRead)
---
---@param self love.Channel
---@param id number An id value previously returned by Channel:push.
---@return boolean hasread Whether the value represented by the id has been removed from the Channel via Channel:pop, Channel:demand, or Channel:clear.
function Channel:hasRead(id) end

---Retrieves the value of a Channel message, but leaves it in the queue.
---
---It returns nil if there's no message in the queue.
---
---[Open in Browser](https://love2d.org/wiki/Channel:peek)
---
---@param self love.Channel
---@return Variant value The contents of the message.
function Channel:peek() end

---Executes the specified function atomically with respect to this Channel.
---
---Calling multiple methods in a row on the same Channel is often useful. However if multiple Threads are calling this Channel's methods at the same time, the different calls on each Thread might end up interleaved (e.g. one or more of the second thread's calls may happen in between the first thread's calls.)
---
---This method avoids that issue by making sure the Thread calling the method has exclusive access to the Channel until the specified function has returned.
---
---[Open in Browser](https://love2d.org/wiki/Channel:performAtomic)
---
---@param self love.Channel
---@param func fun(...) The function to call, the form of function(channel, arg1, arg2, ...) end. The Channel is passed as the first argument to the function when it is called.
---@return any ret1 The first return value of the given function (if any.)
---@return any # Any other return values.
function Channel:performAtomic(func, ...) end

---Retrieves the value of a Channel message and removes it from the message queue.
---
---It returns nil if there are no messages in the queue.
---
---[Open in Browser](https://love2d.org/wiki/Channel:pop)
---
---@param self love.Channel
---@return Variant value The contents of the message.
function Channel:pop() end

---Send a message to the thread Channel.
---
---See Variant for the list of supported types.
---
---[Open in Browser](https://love2d.org/wiki/Channel:push)
---
---@param self love.Channel
---@param value Variant The contents of the message.
---@return number id Identifier which can be supplied to Channel:hasRead
function Channel:push(value) end

---Send a message to the thread Channel and wait for a thread to accept it.
---
---See Variant for the list of supported types.
---
---[Open in Browser](https://love2d.org/wiki/Channel:supply)
---
---@param self love.Channel
---@param value Variant The contents of the message.
---@param timeout number The maximum amount of time to wait.
---@return boolean success Whether the message was successfully supplied before the timeout expired.
---@overload fun(self: love.Channel, value: Variant): boolean
function Channel:supply(value, timeout) end

--endregion love.Channel

--region love.Thread

---A Thread is a chunk of code that can run in parallel with other threads. Data can be sent between different threads with Channel objects.
---
---[Open in Browser](https://love2d.org/wiki/Thread)
---
---@class love.Thread : love.Object
Thread = {}

---Retrieves the error string from the thread if it produced an error.
---
---[Open in Browser](https://love2d.org/wiki/Thread:getError)
---
---@param self love.Thread
---@return string err The error message, or nil if the Thread has not caused an error.
function Thread:getError() end

---Returns whether the thread is currently running.
---
---Threads which are not running can be (re)started with Thread:start.
---
---[Open in Browser](https://love2d.org/wiki/Thread:isRunning)
---
---@param self love.Thread
---@return boolean value True if the thread is running, false otherwise.
function Thread:isRunning() end

---Starts the thread.
---
---Beginning with version 0.9.0, threads can be restarted after they have completed their execution.
---
---[Open in Browser](https://love2d.org/wiki/Thread:start)
---
---Arguments passed to Thread:start are accessible in the thread's main file via '''...''' (the vararg expression.)
---@param self love.Thread
---@overload fun(self: love.Thread): nil
function Thread:start(...) end

---Wait for a thread to finish.
---
---This call will block until the thread finishes.
---
---[Open in Browser](https://love2d.org/wiki/Thread:wait)
---
---@param self love.Thread
function Thread:wait() end

--endregion love.Thread

---Creates or retrieves a named thread channel.
---
---[Open in Browser](https://love2d.org/wiki/love.thread.getChannel)
---
---@param name string The name of the channel you want to create or retrieve.
---@return love.Channel channel The Channel object associated with the name.
function love.thread.getChannel(name) end

---Create a new unnamed thread channel.
---
---One use for them is to pass new unnamed channels to other threads via Channel:push on a named channel.
---
---[Open in Browser](https://love2d.org/wiki/love.thread.newChannel)
---
---@return love.Channel channel The new Channel object.
function love.thread.newChannel() end

---Creates a new Thread from a filename, string or FileData object containing Lua code.
---
---[Open in Browser](https://love2d.org/wiki/love.thread.newThread)
---
---@param filename string The name of the Lua file to use as the source.
---@return love.Thread thread A new Thread that has yet to be started.
---@overload fun(fileData: love.FileData): love.Thread
---@overload fun(codestring: string): love.Thread
function love.thread.newThread(filename) end

