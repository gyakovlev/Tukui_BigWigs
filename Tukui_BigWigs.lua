--[[

Tukui_BigWigs skin by Affli@RU-Howling Fjord
All rights reserved.

]]--

local T, C, L = unpack(Tukui)

--local classcolor = RAID_CLASS_COLORS[T.myclass]
local buttonsize

-- get buttonsize from Tukui
if C.actionbar.buttonsize and type(C.actionbar.buttonsize)=="number" then
	buttonsize=C.actionbar.buttonsize
else
	buttonsize=30	-- just to be safe
end
-- init some tables to store backgrounds
local freebg = {}
local freeibg = {}

-- init some vars to store methods
local setpoint, setpoint2, setwidth, setscale

local createbg = function()
	local bg=CreateFrame("Frame")
	bg:SetTemplate("Default")
	return bg
end
local function freestyle(bar)
	-- reparent and hide bar background
	local bg = bar:Get("bigwigs:tukui_bigwigs:bg")
	if bg then
		bg:ClearAllPoints()
		bg:SetParent(UIParent)
		bg:Hide()
		freebg[#freebg + 1] = bg
	end
	-- reparent and hide icon background
	local ibg = bar:Get("bigwigs:tukui_bigwigs:ibg")
	if ibg then
		ibg:ClearAllPoints()
		ibg:SetParent(UIParent)
		ibg:Hide()
		freeibg[#freeibg + 1] = ibg
	end
	-- replace dummies with original functions
	bar.candyBarIconFrame.SetPoint=setpoint
	bar.candyBarBackground.SetPoint=setpoint2
	bar.candyBarIconFrame.SetWidth=setwidth
	bar.SetScale=setscale
	
end

local applystyle = function(bar)
	-- debug
	BAR=bar

	-- general bar settings
	bar:SetHeight(buttonsize/4)
	bar:SetScale(1)
	bar.SetScale=T.dummy
	setscale=bar.SetScale

	-- create or reparent and use bar background
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

	-- create or reparent and use icon background
	local ibg=nil
	if bar.candyBarIconFrame:GetTexture() then
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
	end

	-- setup timer and bar name fonts and positions
	bar.candyBarBar:SetStatusBarTexture(C.media.normTex)
	bar.candyBarLabel:SetFont(C["media"].uffont, 12, "OUTLINE")
	bar.candyBarLabel:Point("BOTTOMLEFT", bar, "TOPLEFT", -1, 4)
	bar.candyBarDuration:SetFont(C["media"].uffont, 12, "OUTLINE")
	bar.candyBarDuration:Point("BOTTOMRIGHT", bar, "TOPRIGHT", -1, 4)
	bar.candyBarBackground:SetTexture(C.media.normTex)

	-- setup bar positions and look
	bar.candyBarBar:ClearAllPoints()
	bar.candyBarBar:SetAllPoints(bar)
	setpoint = bar.candyBarBar.SetPoint
	bar.candyBarBar.SetPoint=T.dummy

	-- setup icon positions and other things
	bar.candyBarIconFrame:ClearAllPoints()
	bar.candyBarIconFrame:Point("BOTTOMLEFT", bar, "BOTTOMLEFT", -buttonsize - buttonsize/3 , 0)
	bar.candyBarIconFrame:SetSize(buttonsize, buttonsize)
	setwidth = bar.candyBarIconFrame.SetWidth
	bar.candyBarIconFrame.SetWidth=T.dummy
	bar.candyBarIconFrame:SetTexCoord(0.08, 0.92, 0.08, 0.92)
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
	--	GetSpacing = function(bar) return buttonsize - buttonsize/4 end,
		GetSpacing = function(bar) return buttonsize end,
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
