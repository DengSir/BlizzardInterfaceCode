function Localize()
	-- Put all locale specific string adjustments here
	CHINA_AGE_APPROPRIATENESS_TEXT = [[
1、本游戏是一款多人在线角色扮演类游戏，适用于年满16周岁及以上的用户，建议未成年人在家长监护下使用游戏产品。我们鼓励家长根据未成年人的实际情况管理其游戏行为，家长可以拨打官方客服电话0571-28090163或者通过暴雪游戏未成年人家长监护服务页面（|H57|h|cffffffffhttps://www.battlenet.com.cn/support/zh/article/202684|r|h）查看具体指引。
2、本游戏的故事为架空的幻想世界，含有宏大的故事背景和丰富的人物关系，存在合理的想象和虚构，但不会与现实生活相混淆。游戏玩法基于一定难度的思维判断和肢体操作，有需要多人配合进行的团队玩法，鼓励玩家提升和挑战自我，并通过沟通、思考和合作达成目标。游戏中有基于文字和语音的陌生人社交系统，但社交系统的管理遵循相关法律法规。
3、游戏中有用户实名认证系统，认证为未成年人的用户将接受以下管理：
游戏中部分服务和道具需要付费。未满8周岁的用户不能付费；8周岁以上未满16周岁的未成年人用户，单次充值金额不得超过50元人民币，同一战网账号下所有游戏每月充值金额累计不得超过200元人民币；16周岁以上的未成年人用户，单次充值金额不得超过100元人民币，同一战网账号下所有游戏每月充值金额累计不得超过400元人民币。
未成年人用户可以在周五、周六、周日和法定节假日每日晚20时至21时期间登录游戏，其他时间内无法登录游戏。
4、本游戏背景、情节、角色等设计丰富多彩且富有个性。游戏玩法具有策略性，有助于锻炼玩家的思维能力。游戏设有组队功能，并设有大型团队任务和比赛，需要玩家互相配合，有助于培养玩家的团队协作能力。
]];
	CHINA_AGE_APPROPRIATENESS_TEXT_TITLE = "《魔兽世界》适龄提示";
end

function LocalizeFrames()
	CharacterCreateNameEdit:SetMaxLetters(12);

	-- Defined variable to show gameroom billing messages
	SHOW_GAMEROOM_BILLING_FRAME = 1;

	ONLY_SHOW_GAMEROOM_BILLING_FRAME_ON_PERSONAL_TIME = true;
	
	-- Hide save username button
	HIDE_SAVE_ACCOUNT_NAME_CHECKBUTTON = true;

	-- fix the credits screen
	-- CREDITS_ART_INFO[3] = {};
	-- CREDITS_ART_INFO[3][1] = { file="ColdarraNexTGA", w=1024, h=512, offsetx=0, offsety=0, maxAlpha=0.7 };

	-- zhCN Logo
	CLASSIC_MODERN_LOGO_OVERRIDE = {filename = 'Interface\\Glues\\Common\\GLUES-WOW-CLASSICLOGO', uv = { 0, 1, 0, 1 }};
	BURNING_CRUSADE_ORIGINAL_LOGO_OVERRIDE = {filename = 'Interface\\Glues\\Common\\GLUES-WOW-CHINESEBCLOGO', uv = { 0, 1, 0, 1 }};

	_G["CharacterCreateWoWLogo"]:SetPoint("TOPLEFT", _G["CharacterCreateFrame"], 3, 14) -- -3, +11
	_G["CharacterSelectLogo"]:SetPoint("TOPLEFT", 5, -5);
	_G["AccountLogin"].UI.GameLogo:SetPoint("TOPLEFT", 5, -5);

	tbcInfoIconAtlas = "classic-burningcrusade-infoicon-zhcn";
	tbcInfoPaneInfographicAtlas = "classic-announcementpopup-bcinfographic-zhcn";
	choicePaneCurrentLogoAtlas = "classic-burningcrusadetransition-choice-logo-current-zhcn";
	choicePaneOtherLogoAtlas = "classic-burningcrusadetransition-choice-logo-other-zhcn";

	SHOW_CHINA_AGE_APPROPRIATENESS_WARNING = true;
end
