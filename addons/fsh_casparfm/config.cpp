#include "BIS_AddonInfo.hpp"
class CfgPatches {
	class fsh_casparfm {
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
	class casparfm {
		name = 'Caspar FM';
		program[] = {cfm,chat,song,advert,cfm,song,cfm,chat,song,advert,cfm,song};
		debug = 0;
		Speed = 1;
		class chat {
			tracks[] = {};
			types[] = {chat};
			themes[] = {casparfm};
		};
		class cfm {
			tracks[] = {};
			types[] = {sfx};
			themes[] = {casparfm};
		};
		class advert {
			tracks[] = {};
			types[] = {advert};
			themes[] = {};
		};
		class song {
			tracks[] = {};
			types[] = {song};
			themes[] = {pop,latin,rock,jazz};
		};
	};
};


class CfgMusic {
	class cfm_1 {
		name = "Caspar FM";
		duration = 7;
		artist = "";
		type = "sfx";
		theme = "casparfm";
		tags[] = {};
		sound[] = {"fsh_casparfm\cfm_1.ogg", db+0, 1.0};
	};
	class cfm_2 {
		name = "Caspar FM";
		duration = 6;
		artist = "";
		type = "sfx";
		theme = "casparfm";
		tags[] = {};
		sound[] = {"fsh_casparfm\cfm_2.ogg", db+0, 1.0};
	};
	class cfm_3 {
		name = "Caspar FM";
		duration = 8;
		artist = "";
		type = "sfx";
		theme = "casparfm";
		tags[] = {};
		sound[] = {"fsh_casparfm\cfm_3.ogg", db+0, 1.0};
	};
	class cfm_4 {
		name = "Caspar FM";
		duration = 7;
		artist = "";
		type = "sfx";
		theme = "casparfm";
		tags[] = {};
		sound[] = {"fsh_casparfm\cfm_4.ogg", db+0, 1.0};
	};
	class cfm_5 {
		name = "Caspar FM";
		duration = 5;
		artist = "";
		type = "sfx";
		theme = "casparfm";
		tags[] = {};
		sound[] = {"fsh_casparfm\cfm_5.ogg", db+0, 1.0};
	};
	//Chats
	class cfm_chat_1 {
		name = "The Angus Gibson Show";
		duration = 38;
		artist = "";
		type = "chat";
		theme = "comedy";
		tags[] = {casparfm};
		sound[] = {"fsh_casparfm\cfm_chat_1.ogg", db+0, 1.0};
	};
	class cfm_chat_2 {
		name = "The Angus Gibson Show";
		duration = 44;
		artist = "";
		type = "chat";
		theme = "comedy";
		tags[] = {casparfm};
		sound[] = {"fsh_casparfm\cfm_chat_2.ogg", db+0, 1.0};
	};
	class cfm_chat_3 {
		name = "The Angus Gibson Show";
		duration = 27;
		artist = "";
		type = "chat";
		theme = "comedy";
		tags[] = {casparfm};
		sound[] = {"fsh_casparfm\cfm_chat_3.ogg", db+0, 1.0};
	};
	class cfm_chat_4 {
		name = "The Angus Gibson Show";
		duration = 80;
		artist = "";
		type = "chat";
		theme = "comedy";
		tags[] = {casparfm};
		sound[] = {"fsh_casparfm\cfm_chat_4.ogg", db+0, 1.0};
	};
	class cfm_chat_5 {
		name = "The Angus Gibson Show";
		duration = 25;
		artist = "";
		type = "chat";
		theme = "comedy";
		tags[] = {casparfm};
		sound[] = {"fsh_casparfm\cfm_chat_5.ogg", db+0, 1.0};
	};

};

