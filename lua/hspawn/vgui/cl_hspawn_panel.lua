local PANEL = {}

function PANEL:Init()
	
	self:SetTitle(hspawn.Title)
	self:MakePopup()
	self:ShowCloseButton(false)
	self:OptionPnl()

end


function PANEL:OptionPnl()

	optionpnl = self:Add("DPanel")

	optionpnl:Dock(FILL)
	-- optionpnl:DockMargin(170, 150, 170, 150)


end



vgui.Register("HSpawnPanel", PANEL, "XeninUI.Frame")