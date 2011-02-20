--[[

Tukui_BigWigs skin by Affli@RU-Howling Fjord
All rights reserved.

]]--

local T, C, L = unpack(Tukui)

local freeBackgrounds = {}
local createbg = function()
	local bg=CreateFrame("Frame")
	bg:SetTemplate("Default")
	return bg
end
local function freestyle(bar)
	local bg = bar:Get("bigwigs:tukui:bg")
	if not bg then return end
	bg:SetParent(UIParent)
	bg:Hide()
	freeBackgrounds[#freeBackgrounds + 1] = bg
end

local applystyle = function(bar)
	BAR=bar
	bar.candyBarBar:SetStatusBarTexture(C.media.normTex)
	bar.candyBarLabel:SetFont(C["media"].uffont, 12, "OUTLINE")
	bar.candyBarDuration:SetFont(C["media"].uffont, 12, "OUTLINE")
	bar.candyBarBackground:SetTexture(C.media.normTex)
--	bar.candyBarBarIconFrame
	bar:SetScale(1)
	local bg=nil
	if #freeBackgrounds > 0 then
		bg = table.remove(freeBackgrounds)
	else
		bg = createbg()
	end
	bg:SetParent(bar)
	bg:ClearAllPoints()
	bg:Point("TOPLEFT", bar, "TOPLEFT", -2, 2)
	bg:Point("BOTTOMRIGHT", bar, "BOTTOMRIGHT", 2, -2)
	bg:SetFrameStrata("BACKGROUND")
	bg:Show()
	bar:Set("bigwigs:tukui:bg", bg)
end
	

local f = CreateFrame("Frame")

local function registerMyStyle()
	if not BigWigs then return end
	local bars = BigWigs:GetPlugin("Bars", true)
	if not bars then return end
	f:UnregisterEvent("ADDON_LOADED")

	bars:RegisterBarStyle("identifier", {
		apiVersion = 1,
		version = 1,
		GetSpacing = function(bar) return T.Scale(6) end,
		ApplyStyle = applystyle,
		BarStopped = freestyle,
		GetStyleName = function() return "Tukui by Affli" end,
	})
end
f:RegisterEvent("ADDON_LOADED")

local reason = nil
f:SetScript("OnEvent", function(self, event, msg)
	if event == "ADDON_LOADED" then
		if msg == "BigWigs" or msg == "BigWigs_Plugins" then
			registerMyStyle()
		end
	end
end)

