-- Aseprite Forums thread for this issue:
-- https://community.aseprite.org/t/need-a-little-help-caching-tag-names/10837

function cacheTags(_sprite)
	local _baseTags = {} -- LOCAL variable
	for i,tag in ipairs(_sprite.tags) do
		_baseTags[i] = tag
	end
	return _baseTags
end

function restoreTagNames(_baseTags, _sprite)
	for i,tag in ipairs(_sprite.tags) do
		tag.name = _baseTags[i].name
	end
end

------------------------------------------------------------

sprite = app.activeSprite
local baseTags = cacheTags(sprite)

--read the original tag's last frame
print("Original last frameNumber: " .. sprite.tags[2].toFrame.frameNumber)

--extend the last tag by 1 frame
sprite:newEmptyFrame()
print("Modified last frameNumber: " .. sprite.tags[2].toFrame.frameNumber)

--change frame number with cached copy
sprite.tags[2].toFrame = baseTags[2].toFrame.frameNumber
print("Restore last frameNumber attempt: " .. sprite.tags[2].toFrame.frameNumber)
--this prints a 5

--change frame number manually
sprite.tags[2].toFrame = 4
--this works... but impractical (oddly enough, toFrame is supposed to be a frame object btw)

--Second try, with tag names
--change the tag names
for i,tag in ipairs(sprite.tags) do
	tag.name = "New Title " .. i
end

--try to restore tag names...
restoreTagNames(baseTags, app.activeSprite)

--... and fail, this prints the modified version
print("---current tags---") 
for i,tag in ipairs(sprite.tags) do
	print(tag.name) 
end

-- the cached copy has also been modified:
print("---cached tags---") 
for i in ipairs(baseTags) do
	print(baseTags[i].name) 
end