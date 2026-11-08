-- Unchanged excerpts from Blizzard's Forever TextureUtil.lua (2026-11-07).
-- https://github.com/Gethe/wow-ui-source/blob/forever/Interface/AddOns/Blizzard_SharedXMLBase/TextureUtil.lua
TextureKitConstants = {
	SetVisibility = true;
	DoNotSetVisibility = false;

	UseAtlasSize = true;
	IgnoreAtlasSize = false;

	AddressModeClamp = 1,
	AddressModeWrap = 2,
	AddressModeAllowAssetToDetermine = 3,
};

function CheckSetAtlas(texture, atlasName, ...)
	if C_Texture.GetAtlasInfo(atlasName) then
		texture:SetAtlas(atlasName, ...);
		return true;
	end

	return false;
end

local addressModeLookup = {
	[TextureKitConstants.AddressModeClamp] = { descriptor = "CLAMP", tile = false },
	[TextureKitConstants.AddressModeWrap] = { descriptor = "REPEAT", tile = true },
	[TextureKitConstants.AddressModeAllowAssetToDetermine] = { descriptor = nil, tile = nil },
};

-- This API is intended to call either SetAtlas or SetTexture for a given asset and ensure that the correct texture addressing mode APIs are selected
-- so that as the region changes size, it continues to look correct.
-- SetAtlas is preferred and checked first before falling back to set texture.
-- Whether or not the asset refers to an atlas or a texture, UV wrapping will only work as expected if the asset contains a single image.
function SetTextureWithAddressModeOptions(region, asset, autoSize, addressModeU, addressModeV, resetTextureCoords)
	local hData = addressModeLookup[addressModeU or TextureKitConstants.AddressModeClamp];
	local vData = addressModeLookup[addressModeV or TextureKitConstants.AddressModeClamp];

	-- NOTE: filterMode and resetTexCoords not supported in this API yet, just use defaults.
	local filterMode = nil;
	if not CheckSetAtlas(region, asset, autoSize, filterMode, resetTextureCoords, hData.descriptor, vData.descriptor) then
		region:SetTexture(asset, hData.descriptor, vData.descriptor, filterMode);
	end

	if hData.tile ~= nil then
		region:SetHorizTile(hData.tile);
	end

	if vData.tile ~= nil then
		region:SetVertTile(vData.tile);
	end
end
