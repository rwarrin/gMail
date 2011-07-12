local button = CreateFrame("Button", "gMailButton", InboxFrame, "UIPanelButtonTemplate");
button:SetPoint("BOTTOM", InboxFrame, "BOTTOM", -10, 85);
button:SetWidth(128);
button:SetHeight(24);

local buttonText = button:CreateFontString(nil, "Overlay");
buttonText:SetFontObject(GameFontNormalSmall);
buttonText:SetPoint("CENTER");

local function OnEvent(self, event, ...)

end

local function OnClick()

end

local function OnHide()

end

button:RegisterEvent("MAIL_INBOX_UPDATE");
button:SetScript("OnEvent", OnEvent);
button:SetScript("OnClick", OnClick);
button:SetScript("OnHide", OnHide);