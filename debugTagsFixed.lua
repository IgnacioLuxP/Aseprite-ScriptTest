--little cached tags metaclass
local CachedTag = {
	name = "",
	from = 0,
	to = 0,
}

--constructor for creating instances of cached tag object
function CachedTag:new (name, from, to)
	local o = {}
	setmetatable(o, CachedTag)
	o.name = name
	o.from = from
	o.to = to
	return o
end

--function to cache all tags in the original sprite
function saveBaseTags(tags)
	local cachedTags = {}
	for i in ipairs(tags) do
		cachedTags[i] = CachedTag:new(tags[i].name, tags[i].fromFrame.frameNumber, tags[i].toFrame.frameNumber)
	end
	return cachedTags
end	

--function to restore the sprite's original tags from the cached copy
function restoreBaseTags(sprite, baseTags)
	for i,tag in ipairs(sprite.tags) do
		tag.name = baseTags[i].name
		tag.fromFrame = baseTags[i].from
		tag.toFrame = baseTags[i].to
	end
end

----------------------------------------------
--Simple test
----------------------------------------------

sprite = app.activeSprite
local baseTags = saveBaseTags(sprite.tags)

--original tags: 
--"First" -> 1-2
--"Last" -> 3-4

--modify the sprite's tags (name and end frame)

--save original frame length so it doesn't explode
local origLength = #sprite.frames

for i=1, origLength do
	for j,tag in ipairs(sprite.tags) do
		tag.name = "ModifiedTag " .. j
	end
	sprite:newEmptyFrame()
end

--restore base tags
restoreBaseTags(sprite, baseTags)

--test if first tag properties was restored correctly
assert(sprite.tags[1].name == "First")
assert(sprite.tags[1].fromFrame.frameNumber == 1)
assert(sprite.tags[1].toFrame.frameNumber == 2)
