--[[

Tukui_BigWigs skin by Affli@RU-Howling Fjord
All rights reserved.

]]--

local T, C, L = unpack(Tukui)

local freebg = {}
local freeibg = {}
local setpoint, setpoint2
local createbg = function()
	local bg=CreateFrame("Frame")
	bg:SetTemplate("Default")
	return bg
end
local function freestyle(bar)
	local bg = bar:Get("bigwigs:tukui_bigwigs:bg")
	local ibg = bar:Get("bigwigs:tukui_bigwigs:ibg")
	if bg then
		bg:ClearAllPoints()
		bg:SetParent(UIParent)
		bg:Hide()
		freebg[#freebg + 1] = bg
	end
	if ibg then
		ibg:ClearAllPoints()
		ibg:SetParent(UIParent)
		ibg:Hide()
		freeibg[#freeibg + 1] = ibg
	end
	bar.candyBarIconFrame.SetPoint=setpoint
end

local applystyle = function(bar)
	BAR=bar
 
	bar.candyBarBar:SetStatusBarTexture(C.media.normTex)
	bar.candyBarLabel:SetFont(C["media"].uffont, 12, "OUTLINE")
	bar.candyBarDuration:SetFont(C["media"].uffont, 12, "OUTLINE")
	bar.candyBarBackground:SetTexture(C.media.normTex)

--	print(bar.candyBarIconFrame:GetPoint())

	bar:SetScale(1)

	local bg=nil
	if #freebg > 0 then
		bg = table.remove(freebg)
	else
		bg = createbg()
	end
	bg:SetParent(bar)
	bg:ClearAllPoints()
	bg:Point("TOPLEFT", bar, "TOPLEFT", -2, 2)
	bg:Point("BOTTOMRIGHT", bar, "BOTTOMRIGHT", 2, -2)
	bg:SetFrameStrata("BACKGROUND")
	bg:Show()
	bar:Set("bigwigs:tukui_bigwigs:bg", bg)

	local ibg=nil
	if #freeibg > 0 then
		ibg = table.remove(freeibg)
	else
		ibg = createbg()
	end
	ibg:SetParent(bar)
	ibg:ClearAllPoints()
	ibg:Point("TOPLEFT", bar.candyBarIconFrame, "TOPLEFT", -2, 2)
	ibg:Point("BOTTOMRIGHT", bar.candyBarIconFrame, "BOTTOMRIGHT", 2, -2)
	ibg:SetFrameStrata("BACKGROUND")
	ibg:Show()
	bar:Set("bigwigs:tukui_bigwigs:ibg", ibg)

	-- rearrange
	bar.candyBarBackground:ClearAllPoints()
	bar.candyBarBackground:SetParent(bar)
	bar.candyBarBackground:SetAllPoints(bar)

	bar.candyBarBar:ClearAllPoints()
	bar.candyBarBar:SetParent(bar)
	bar.candyBarBar:SetAllPoints(bar)

	setpoint = bar.candyBarBar.SetPoint
	bar.candyBarBar.SetPoint=T.dummy

	setpoint2 = bar.candyBarBackground.SetPoint
	bar.candyBarBackground.SetPoint=T.dummy


--	local _, anch, _, _, _ = bar.candyBarIconFrame:GetPoint()
--	bar.candyBarIconFrame:ClearAllPoints()
--	bar.candyBarIconFrame:SetParent(bar)
	bar.candyBarIconFrame:Point("TOPLEFT", bar, "TOPLEFT", -30 , 0)
--	bar.candyBarIconFrame:Point("BOTTOMLEFT", bar, "BOTTOMLEFT", -30 , 0)
--	bg:HookScript("OnShow", function(self)
--		bar.candyBarIconFrame:ClearAllPoints()
--		bar.candyBarIconFrame:SetParent(bar)
--		bar.candyBarIconFrame:Point("TOPLEFT", bar, "TOPLEFT", -20 , 0)
--		bar.candyBarIconFrame:Point("BOTTOMLEFT", bar, "BOTTOMLEFT", -20 , 0)
--	end)
	--	bar.candyBarBar:Height(20)
end
	

local f = CreateFrame("Frame")

local function registerStyle()
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
		GetStyleName = function() return "Tukui_BigWigs" end,
	})
end
f:RegisterEvent("ADDON_LOADED")

local reason = nil
f:SetScript("OnEvent", function(self, event, msg)
	if event == "ADDON_LOADED" then
		if msg == "BigWigs" or msg == "BigWigs_Plugins" then
			registerStyle()
		end
	end
end)
