-- This file is executed at the end of addon load

-- Talent tabs
for i=1, (PlayerTalentFrame.numTabs or 0) do
	local tabName = "PlayerTalentFrameTab"..i;
	_G[tabName.."Text"]:SetPoint("CENTER", tabName, "CENTER", 0, 5);
end

-- Move talent stuff
PlayerTalentFrameTalentPoints:SetPoint("RIGHT", "PlayerTalentFrameTalentPointsText", "LEFT", -3, 0);
PlayerTalentFrameTalentPointsText:SetPoint("BOTTOMRIGHT", "PlayerTalentFrame", "BOTTOMLEFT", 252, 84);
PlayerTalentFrameSpentPoints:SetPoint("TOP", "PlayerTalentFramePointsMiddle", "TOP", 0, -2);