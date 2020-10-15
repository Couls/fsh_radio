#include "BIS_AddonInfo.hpp"
class CfgPatches {
	class fsh_stealthSounds {
		units[] = {};
		weapons[] = {};
		requiredVersion = 1;
		requiredAddons[] = {};
		author = "Fishy";
		version = 0.1;
		versionStr = "0.10";
		versionAr[] = {0,10};
	};
};

class CfgRadioStations {
	class stealthSounds {
		name = 'Stealth sounds';
		program[] = {sfx,chat,sfx,advert};
		debug = 0;
		Speed = 4;
		class advert {
			tracks[] = {};
			types[] = {advert};
			themes[] = {};
		};
		class song {
			tracks[] = {};
			types[] = {song,bis};
			themes[] = {stealth};
		};
		class chat {
			tracks[] = {};
			types[] = {chat};
			themes[] = {stealthSounds};
		};
		class sfx {
			tracks[] = {};
			types[] = {sfx};
			themes[] = {stealthSounds};
		};
	};
};

class CfgMusic {
	class ss_1 {
		name = "Stealth Sounds";
		duration = 9;
		artist = "";
		type = "sfx";
		theme = "stealthSounds";
		tags[] = {};
		sound[] = {"fsh_stealthSounds\ss_1.ogg", db+0, 1.0};
	};
	class ss_2 {
		name = "Stealth Sounds";
		duration = 9;
		artist = "";
		type = "sfx";
		theme = "stealthSounds";
		tags[] = {};
		sound[] = {"fsh_stealthSounds\ss_2.ogg", db+0, 1.0};
	};
	class ss_3 {
		name = "Stealth Sounds";
		duration = 9;
		artist = "";
		type = "sfx";
		theme = "stealthSounds";
		tags[] = {};
		sound[] = {"fsh_stealthSounds\ss_3.ogg", db+0, 1.0};
	};
	class ss_chat_1 {
		name = "Stealth Sounds";
		duration = 32;
		artist = "";
		type = "chat";
		theme = "stealthSounds";
		tags[] = {};
		sound[] = {"fsh_stealthSounds\ss_chat_1.ogg", db+0, 1.0};
	};
	class ss_chat_2 {
		name = "Stealth Sounds";
		duration = 32;
		artist = "";
		type = "chat";
		theme = "stealthSounds";
		tags[] = {};
		sound[] = {"fsh_stealthSounds\ss_chat_2.ogg", db+0, 1.0};
	};
	class ss_chat_3 {
		name = "Stealth Sounds";
		duration = 22;
		artist = "";
		type = "chat";
		theme = "stealthSounds";
		tags[] = {};
		sound[] = {"fsh_stealthSounds\ss_chat_3.ogg", db+0, 1.0};
	};
	class ss_chat_4 {
		name = "Stealth Sounds";
		duration = 26;
		artist = "";
		type = "chat";
		theme = "stealthSounds";
		tags[] = {};
		sound[] = {"fsh_stealthSounds\ss_chat_4.ogg", db+0, 1.0};
	};
	class ss_chat_5 {
		name = "Stealth Sounds";
		duration = 50;
		artist = "";
		type = "chat";
		theme = "stealthSounds";
		tags[] = {};
		sound[] = {"fsh_stealthSounds\ss_chat_5.ogg", db+0, 1.0};
	};
	class ss_chat_6 {
		name = "Stealth Sounds";
		duration = 39;
		artist = "";
		type = "chat";
		theme = "stealthSounds";
		tags[] = {};
		sound[] = {"fsh_stealthSounds\ss_chat_6.ogg", db+0, 1.0};
	};
};

