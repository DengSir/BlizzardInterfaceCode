
NUMGOSSIPBUTTONS = 32;

function GossipFrame_OnLoad(self)
	self:RegisterEvent("GOSSIP_SHOW");
	self:RegisterEvent("GOSSIP_CLOSED");
	self:RegisterEvent("QUEST_LOG_UPDATE");
	self:RegisterEvent("QUEST_COMPLETE");
end

function GossipFrame_OnEvent(self, event, ...)
	if ( event == "GOSSIP_SHOW" ) then
		-- if there is only a non-gossip option, then go to it directly
		CloseQuest();
		if ( (GetNumGossipAvailableQuests() == 0) and (GetNumGossipActiveQuests() == 0) and (GetNumGossipOptions() == 1) and not ForceGossip() ) then
			local text, gossipType = GetGossipOptions();
			if ( gossipType ~= "gossip" ) then
				SelectGossipOption(1);
				return;
			end
		end

		if ( not GossipFrame:IsShown() ) then
			ShowUIPanel(self);
			if ( not self:IsShown() ) then
				CloseGossip();
				return;
			end
		end
		NPCFriendshipStatusBar_Update(self);
		GossipFrameUpdate();
	elseif ( event == "GOSSIP_CLOSED" ) then
		HideUIPanel(self);
	elseif ( event == "QUEST_LOG_UPDATE" and GossipFrame.hasActiveQuests ) then
		GossipFrameUpdate();
	elseif ( event == "QUEST_COMPLETE") then
		HideUIPanel(self);
	end
end

function GossipFrameUpdate()
	GossipFrame.buttonIndex = 1;
	GossipGreetingText:SetText(GetGossipText());
	GossipFrameAvailableQuestsUpdate(GetGossipAvailableQuests());
	GossipFrameActiveQuestsUpdate(GetGossipActiveQuests());
	GossipFrameOptionsUpdate(GetGossipOptions());
	for i=GossipFrame.buttonIndex, NUMGOSSIPBUTTONS do
		_G["GossipTitleButton" .. i]:Hide();
	end
	GossipFrameNpcNameText:SetText(UnitName("npc"));
	if ( UnitExists("npc") ) then
		SetPortraitTexture(GossipFramePortrait, "npc");
	else
		GossipFramePortrait:SetTexture("Interface\\QuestFrame\\UI-QuestLog-BookIcon");
	end

	-- Set Spacer
	if ( GossipFrame.buttonIndex > 1 ) then
		GossipSpacerFrame:SetPoint("TOP", "GossipTitleButton"..GossipFrame.buttonIndex-1, "BOTTOM", 0, 0);
	else
		GossipSpacerFrame:SetPoint("TOP", GossipGreetingText, "BOTTOM", 0, 0);
	end

	-- Update scrollframe
	GossipGreetingScrollFrame:SetVerticalScroll(0);
end

function GossipTitleButton_OnClick(self, button)
	if ( self.type == "Available" ) then
		SelectGossipAvailableQuest(self:GetID());
	elseif ( self.type == "Active" ) then
		SelectGossipActiveQuest(self:GetID());
	else
		SelectGossipOption(self:GetID());
	end
end

function GossipFrameAvailableQuestsUpdate(...)
	local titleIndex = 1;
	
	for i=1, select("#", ...), 7 do
		if ( GossipFrame.buttonIndex > NUMGOSSIPBUTTONS ) then
			message("This NPC has too many quests and/or gossip options.");
		end
		local titleButton = _G["GossipTitleButton" .. GossipFrame.buttonIndex];
		local titleButtonIcon = _G[titleButton:GetName() .. "GossipIcon"];
		local titleText, level, isTrivial, frequency, isRepeatable, isLegendary, isIgnored = select(i, ...);
		titleButtonIcon:SetTexture("Interface\\GossipFrame\\AvailableQuestIcon");
		if (isTrivial) then
			titleButton:SetFormattedText(TRIVIAL_QUEST_DISPLAY, titleText);
			titleButtonIcon:SetVertexColor(0.5,0.5,0.5);
		else
			titleButton:SetFormattedText(NORMAL_QUEST_DISPLAY, titleText);
			titleButtonIcon:SetVertexColor(1,1,1);
		end
		GossipResize(titleButton);
		titleButton:SetID(titleIndex);
		titleButton.type="Available";
		GossipFrame.buttonIndex = GossipFrame.buttonIndex + 1;
		titleIndex = titleIndex + 1;
		titleButton:Show();
	end
	if ( GossipFrame.buttonIndex > 1 ) then
		local titleButton = _G["GossipTitleButton" .. GossipFrame.buttonIndex];
		titleButton:Hide();
		GossipFrame.buttonIndex = GossipFrame.buttonIndex + 1;
	end
end

function GossipFrameActiveQuestsUpdate(...)
	local titleButton;
	local titleIndex = 1;
	local titleButtonIcon;
	local numActiveQuestData = select("#", ...);
	GossipFrame.hasActiveQuests = (numActiveQuestData > 0);
	for i=1, numActiveQuestData, 6 do
		if ( GossipFrame.buttonIndex > NUMGOSSIPBUTTONS ) then
			message("This NPC has too many quests and/or gossip options.");
		end
		titleButton = _G["GossipTitleButton" .. GossipFrame.buttonIndex];
		titleButtonIcon = _G[titleButton:GetName() .. "GossipIcon"];
		titleButton:SetFormattedText(NORMAL_QUEST_DISPLAY, select(i, ...));
		GossipResize(titleButton);
		titleButton:SetID(titleIndex);
		titleButton.type="Active";
		titleButtonIcon:SetTexture("Interface\\GossipFrame\\ActiveQuestIcon");	
		GossipFrame.buttonIndex = GossipFrame.buttonIndex + 1;
		titleIndex = titleIndex + 1;
		titleButton:Show();
	end
	if ( titleIndex > 1 ) then
		titleButton = _G["GossipTitleButton" .. GossipFrame.buttonIndex];
		titleButton:Hide();
		GossipFrame.buttonIndex = GossipFrame.buttonIndex + 1;
	end
end

function GossipFrameOptionsUpdate(...)
	local titleButton;
	local titleIndex = 1;
	local titleButtonIcon;
	for i=1, select("#", ...), 2 do
		if ( GossipFrame.buttonIndex > NUMGOSSIPBUTTONS ) then
			message("This NPC has too many quests and/or gossip options.");
		end
		titleButton = _G["GossipTitleButton" .. GossipFrame.buttonIndex];
		titleButton:SetText(select(i, ...));
		GossipResize(titleButton);
		titleButton:SetID(titleIndex);
		titleButton.type="Gossip";
		titleButtonIcon = _G[titleButton:GetName() .. "GossipIcon"];
		titleButtonIcon:SetTexture("Interface\\GossipFrame\\" .. select(i+1, ...) .. "GossipIcon");
		titleButtonIcon:SetVertexColor(1, 1, 1, 1);
		GossipFrame.buttonIndex = GossipFrame.buttonIndex + 1;
		titleIndex = titleIndex + 1;
		titleButton:Show();
	end
end

function GossipResize(titleButton)
	titleButton:SetHeight( titleButton:GetTextHeight() + 2);
end

function NPCFriendshipStatusBar_Update(frame, factionID --[[ = nil ]])
	--[[local statusBar = NPCFriendshipStatusBar;
	local id, rep, maxRep, name, text, texture, reaction, threshold, nextThreshold = GetFriendshipReputation(factionID);
	statusBar.friendshipFactionID = id;
	if ( id and id > 0 ) then
		statusBar:SetParent(frame);
		-- if max rank, make it look like a full bar
		if ( not nextThreshold ) then
			threshold, nextThreshold, rep = 0, 1, 1;
		end
		if ( texture ) then
			statusBar.icon:SetTexture(texture);
		else
			statusBar.icon:SetTexture("Interface\\Common\\friendship-heart");
		end
		statusBar:SetMinMaxValues(threshold, nextThreshold);
		statusBar:SetValue(rep);
		statusBar:ClearAllPoints();
		statusBar:SetPoint("TOPLEFT", 73, -41);
		statusBar:Show();
	else
		statusBar:Hide();
	end]]
end

function NPCFriendshipStatusBar_OnEnter(self)
	ShowFriendshipReputationTooltip(self.friendshipFactionID, self, "ANCHOR_BOTTOMRIGHT");
end
