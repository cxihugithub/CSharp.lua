--[[
Copyright 2017 YANG Huan (sy.yanghuan@gmail.com).

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
--]]

local System = System
local throw = System.throw
local Collection = System.Collection
local addCount = Collection.addCount
local getCount = Collection.getCount
local removeArrayAll = Collection.removeArrayAll
local clearCount = Collection.clearCount
local ArgumentNullException = System.ArgumentNullException
local ArgumentOutOfRangeException = System.ArgumentOutOfRangeException

local table = table
local tconcat = table.concat
local schar = string.char
local ssub = string.sub

local StringBuilder = {}

local function build(this, value, startIndex, length)
  value = value:Substring(startIndex, length)
  local len = #value
  if len > 0 then
    this[#this + 1] = value
    addCount(this, len) 
  end
end

function StringBuilder.__ctor__(this, ...)
  local len = select("#", ...)
  if len == 0 then
  elseif len == 1 or len == 2 then
    local value = ...
    if type(value) == "string" then
      build(this, value, 0, #value)
    else
      build(this, "", 0, 0)
    end
  else 
    local value, startIndex, length = ...
    build(this, value, startIndex, length)
  end
end

StringBuilder.getLength = getCount

function StringBuilder.setLength(this, value) 
  if value < 0 then throw(ArgumentOutOfRangeException("value")) end
  if value == 0 then
    this:Clear()
    return
  end
  local delta = value - getCount(this)
  if delta > 0 then
    this:AppendCharRepeat(0, delta)
  else
    local length, remain = #this, value
    for i = 1, length do
      local s = this[i]
      local len = #s
      if len >= remain then
        if len ~= remain then
          s = ssub(s, 0, remain)
          this[i] = s
        end
        for j = i + 1, length do
          this[j] = nil
        end
        break
      end
      remain = remain - len
    end
    addCount(this, delta)
  end  
end

function StringBuilder.Append(this, ...)
  local len = select("#", "...")
  if len == 1 then
    local value = ...
    if value ~= nil then
      value = value:ToString()
      this[#this + 1] = value
      addCount(this, #value) 
    end
  else
    local value, startIndex, length = ...
    if value == nil then
      throw(ArgumentNullException("value"))
    end
    value = value:Substring(startIndex, length)
    this[#this + 1] = value
    addCount(this, #value) 
  end
  return this
end

function StringBuilder.AppendChar(this, v) 
  v = schar(v)
  this[#this + 1] = v
  addCount(this, 1) 
  return this
end

function StringBuilder.AppendCharRepeat(this, v, repeatCount)
  if repeatCount < 0 then throw(ArgumentOutOfRangeException("repeatCount")) end
  if repeatCount == 0 then return this end
  v = schar(v)
  local count = #this + 1
  for i = 1, repeatCount do
    this[count] = v
    count = count + 1
  end
  addCount(this, repeatCount) 
  return this
end

function StringBuilder.AppendFormat(this, format, ...)
  local value = format:Format(...)
  this[#this + 1] = value
  addCount(this, #value) 
  return this
end

function StringBuilder.AppendLine(this, value)
  local count = 1
  local len = #this + 1
  if value ~= nil then
    this[len] = value
    len = len + 1
    count = count + #value
  end
  this[len] = "\n"
  addCount(this, count) 
  return this
end

function StringBuilder.Clear(this)
  removeArrayAll(this)
  clearCount(this)
  return this
end

StringBuilder.ToString = tconcat
StringBuilder.__tostring = StringBuilder.ToString

System.define("System.StringBuilder", StringBuilder)
