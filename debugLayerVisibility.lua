--This one works fine
--Based largely on Export layers script by Gaspi (https://gist.github.com/PKGaspi) 


function hideLayers(_sprite)
	local _layerVisibility = {}
	for i,layer in ipairs(_sprite.layers) do
		_layerVisibility[i] = layer.isVisible
		layer.isVisible = false
	end
	return _layerVisibility
end

function restoreLayersVisibility(_layerVisibility, _sprite)
   for i,layer in ipairs(_sprite.layers) do
         layer.isVisible = _layerVisibility[i]
   end
end

sprite = app.activeSprite

local layerVisibility = hideLayers(sprite)

for i=1, #layerVisibility do
	print("Initial Layer Visibility" .. i .. " " .. tostring(layerVisibility[i]))
end

--set visibility to true in ALL layers
for h,layer in ipairs(sprite.layers) do
	layer.isVisible = true
end

print("----Modified visibility----------")
for j=1, #sprite.layers do
	print("Layer " .. j .. " " .. tostring(sprite.layers[j].isVisible))
end

restoreLayersVisibility(layerVisibility, sprite)

print("----Restored from cache----------")
for k=1, #layerVisibility do
	print("Layer " .. k .. " " .. tostring(layerVisibility[k]))
end