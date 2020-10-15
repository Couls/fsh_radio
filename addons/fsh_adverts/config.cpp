#include "BIS_AddonInfo.hpp"
class CfgPatches {
	class fsh_adverts {
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



class CfgSounds {
	sounds[] = {};
	class advert_1 {
		name = "Advert";
		duration = 38;
		artist = "";
		type = "advert";
		theme = "comedy";
		tags[] = {casparfm,angus};
		sound[] = {"fsh_adverts\advert_1.ogg", db+0, 1.0};
	};
	class advert_2 {
		name = "Advert";
		duration = 38;
		artist = "";
		type = "advert";
		theme = "comedy";
		tags[] = {casparfm,angus};
		sound[] = {"fsh_adverts\advert_2.ogg", db+0, 1.0};
	};
	class advert_3 {
		name = "Advert";
		duration = 28;
		artist = "";
		type = "advert";
		theme = "comedy";
		tags[] = {casparfm,angus};
		sound[] = {"fsh_adverts\advert_3.ogg", db+0, 1.0};
	};
	class advert_4 {
		name = "Advert";
		duration = 45;
		artist = "";
		type = "advert";
		theme = "comedy";
		tags[] = {furniture};
		sound[] = {"fsh_adverts\advert_4.ogg", db+2, 1.0};
	};
};

