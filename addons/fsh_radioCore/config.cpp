#include "BIS_AddonInfo.hpp"
class CfgPatches
{
	class fsh_radioCore
	{
		units[] = {};
		weapons[] = {};
		requiredVersion = 1;
		requiredAddons[] = {"A3_Weapons_F_Items"};
		author = "Fishy";
		version = 0.1;
		versionStr = "0.10";
		versionAr[] = {0,10};
	};
};

#include "gui\dialog.hpp"
#include "CfgVehicles.hpp"
#include "CfgWeapons.hpp"


class CfgFunctions {	
	#include "functions\cfgFunctions.hpp"
};

class RscTitles { 
	#include "gui\radio_hud.hpp"
};

class CfgSounds {
	sounds[] = {};
};

class CfgRadioStations {
	class actionair {
		name = 'Action Air';
		program[] = {song,advert,song};
		debug = 0;
		Speed = 1;
		class advert {
			tracks[] = {};
			types[] = {advert};
			themes[] = {};
		};
		class song {
			tracks[] = {};
			types[] = {song};
			themes[] = {action};
		};
	};
};




class cfgErrorMessages {
	class E1 {
		message = 'Hold the fuck up mate, there seems to be some code missing. God damn mexicans...';
	};
	class E2 {
		message = 'This is a steaming pile of shit and you should just stop.';
	};
	class E3 {
		message = 'Jesus mate, this is missing more code than your mum is chromozones...';
	};
	class E4 {
		message = 'Cunt. Go die somewhere';
	};
	class E5 {
		message = 'In the same way you know that your life is destined for nothing and no one will ever love you, I know that this is broken. Dont sweat it, i can fix it (the code, not your sorry excuse for a life)';
	};
	class E6 {
		message = 'Please await momentary assistance, we are working hard to resolve this issue.';
	};
	class E7 {
		message = 'Your oppion matters to us. Please take the time to shout at your screen about how this error has affected you and your loved ones. God bless';
	};
	class E8 {
		message = 'Youre a wizard harry.';
	};
	class E9 {
		message = 'Oh dear, you seem to be experienceing technical difficulties. This time however, viagra simply isnt going to cut the mustard.';
	};
	class E10 {
		message = 'Das ist nichs';
	};
	class E11 {
		message = 'I should probably write some code instead of all these error messages, but then if I write more code ill definately have to write more error messages. Life...';
	};
	class E12 {
		message = 'Im afraid I cant do that Dave';
	};
};