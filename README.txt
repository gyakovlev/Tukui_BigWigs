This addon skins BigWigs (http://www.wowace.com/addons/big-wigs/) Tukui-like.

Screenshot worth a thousand words: https://img.skitch.com/20110224-nxyfpqt7p5migscmcefp53j1nw.png

	Limited Support provided here:
		http://www.tukui.org/forums/topic.php?id=9585

	Usage:

		* Install BigWigs
		* Install Tukui_BigWigs to <WOWDir>/Interface/AddOns/
		* type /tukuibigwigs apply
		* reconfigure BigWigs as you like
		* go kill some bosses
	
	Config & commands:

		/tukuibigwigs test - launch BigWigs demo mode
		/tukuibigwigs apply - apply skin settings
		
		Tiny config can be found at the top of Tukui_BigWigs.lua file.
		The lines a pretty well commented and self-descriptive
		Default config:
		----------------------------------------
		local classcolor = true			-- classcolored bars
		local drawshadow = false		-- draw Tukui shadows around frames.
		local skinrange = true			-- skin distance window
		local transparent = true		-- use semi-transparent template on bars.
		local disablescaling = true		-- disables bar scaling (including emphasized bars).
		----------------------------------------		

	FAQ:	

		Q) Do i need to change something within Tukui to use your style instead of default one?
			A) No, Tukui will auto-disable it's skinn and this skin will be used.
			But do not forget to run /tukuibigwigs apply to reapply skin settings.

		Q) Should i run /tukuibigwigs apply every time the skin updates?
			A) No. Only on first install and if you scerw up font settings or bar styles.

		Q) Can i include this addon into my Tukui-edit?
			A) Sure.
			You can include like any addon, or even embed it into your edit, but there is one limitation. 
			The following comment section should never be deleted from Tukui_BigWigs.lua
				--[[

				Tukui_BigWigs skin by Affli@RU-Howling Fjord
				All rights reserved.

				]]--
