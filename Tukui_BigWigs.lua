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
	f:UnregisterEvent("PLAYER_LOGIN")
	bars:RegisterBarStyle("identifier", {
		apiVersion = 1,
		version = 1,
		GetSpacing = function(bar) return 4 end,
		ApplyStyle = applystyle,
		BarStopped = freestyle,
		GetStyleName = function() return "Tukui Editless" end,
	})
end
f:RegisterEvent("ADDON_LOADED")
--f:RegisterEvent("PLAYER_LOGIN")

local reason = nil
f:SetScript("OnEvent", function(self, event, msg)
	if event == "ADDON_LOADED" then
--		if not reason then reason = (select(6, GetAddOnInfo("BigWigs_Plugins"))) end
--		if (reason == "MISSING" and msg == "BigWigs") or msg == "BigWigs_Plugins" then
		if msg == "BigWigs" or msg == "BigWigs_Plugins" then
			registerMyStyle()
		end
--	elseif event == "PLAYER_LOGIN" then
--		registerMyStyle()
	end
end)

