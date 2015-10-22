local button = CreateFrame("Button", "gMailButton", InboxFrame, "UIPanelButtonTemplate");
button:SetPoint("BOTTOM", InboxFrame, "BOTTOM", -25, 103);
button:SetWidth(128);
button:SetHeight(24);

local buttonText = button:CreateFontString(nil, "Overlay");
buttonText:SetFontObject(GameFontNormalSmall);
buttonText:SetPoint("CENTER");

local looting = false;

local function UpdateButtonText()
	local mailCount = GetInboxNumItems();
	local moneyCount = 0;
	local itemsCount = 0;
	
	for i = 1, mailCount do
		local packageIcon, stationeryIcon, sender, subject, money, CODAmount, daysLeft, hasItem, wasRead, wasReturned, textCreated, canReply, isGM = GetInboxHeaderInfo(i);
		moneyCount = moneyCount + money;
		if(hasItem and CODAmount < 1) then
			itemsCount = itemsCount + hasItem;
		end
	end
	
	buttonText:SetText(format("%d gold, %d items", floor(moneyCount * 0.0001), itemsCount))
end

local function OnEvent(self, event, ...)
	if(event == "MAIL_INBOX_UPDATE") then
		UpdateButtonText();
	end
	
	if(looting == true) then
		local mailCount = GetInboxNumItems();
		if(mailCount == 0) then
			looting = false;
			return;
		end
		
		for i = mailCount, 1, -1 do
			local packageIcon, stationeryIcon, sender, subject, money, CODAmount, daysLeft, hasItem, wasRead, wasReturned, textCreated, canReply, isGM = GetInboxHeaderInfo(i);
			if(hasItem and CODAmount < 1) then
				TakeInboxItem(i);
				return;
			end
			if(money > 0) then
				TakeInboxMoney(i);
				return;
			end
		end
	end
end

local function OnClick()
	looting = true;
	OnEvent();
end

local function OnHide()
	looting = false;
end

button:RegisterEvent("MAIL_INBOX_UPDATE");
button:SetScript("OnEvent", OnEvent);
button:SetScript("OnClick", OnClick);
button:SetScript("OnHide", OnHide);
