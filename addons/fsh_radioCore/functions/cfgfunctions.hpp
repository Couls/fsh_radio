#define fnc_pre(NAME) \
	class NAME { \
		preInit = 1; \
		ext = ".sqf"; \
		headerType = -1; \
		description = ""; \
	}
	
#define fnc_post(NAME) \
	class NAME { \
		postInit = 1; \
		ext = ".sqf"; \
		headerType = -1; \
		description = ""; \
	}

#define fnc(NAME) \
	class NAME { \
		ext = ".sqf"; \
		headerType = -1; \
		description = ""; \
	}			



class fsh_fncs {
	//	Main functions
	tag = "fshR";
	class misc {
		requiredAddons[] = {"A3_Data_F"};
		file = "fsh_radioCore\functions";
		fnc_pre(radio);
		fnc(serverInit);
		fnc(playerInit);
		fnc(stationInit);
		
		fnc(vehicleLoop);
		fnc(playerLoop);
		fnc(consoleOpen);
		fnc(button);
		
		fnc(getTracks);
	};
};

