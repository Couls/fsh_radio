#define MACRO_RADIO_ACTIONS \
	class ACE_SelfActions { \
		class ACE_vehicleRadio { \
			displayName = "Radio"; \
			condition = "if (_target getVariable ['fshR_vehInit',0] != 1) then {true} else {false}"; \
			statement = ""; \
			priority = 0.3; \
			icon = "fsh_radioCore\gui\fsh_ace_icon.paa"; \
			class ACE_vehicleRadio_on { \
				displayName = "Power on"; \
				condition = "if (_target getVariable ['fshR_vehInit',0] == 0) then {true} else {false}"; \
				statement = "call fshR_fnc_consoleOpen"; \
				priority = 0.3; \
			}; \
			class ACE_vehicleRadio_off { \
				displayName = "Power off"; \
				condition = "if (_target getVariable ['fshR_vehInit',0] == 2) then {true} else {false}"; \
				statement = "[-1,'off'] call fshR_fnc_button"; \
				priority = 0.3; \
			}; \
			class ACE_vehicleRadio_open { \
				displayName = "Open console"; \
				condition = "if (_target getVariable ['fshR_vehInit',0] == 2) then {true} else {false}"; \
				statement = "call fshR_fnc_consoleOpen"; \
				priority = 0.4; \
				icon = "fsh_radioCore\gui\fsh_ace_icon.paa"; \
			}; \
		}; \
	};

/*
class ACE_Actions { \
		class ACE_MainActions { \
			class ACE_vehicleRadio { \
				distance = 4;
				etc
*/
	
	
class CfgVehicles {
	class LandVehicle;
	class Car: LandVehicle {
		MACRO_RADIO_ACTIONS
	};
	class Tank: LandVehicle {
		MACRO_RADIO_ACTIONS
	};
	class Air;
	class Helicopter: Air {
		MACRO_RADIO_ACTIONS
	};
	
	//////////////////////////////////////
	class Item_Base_F;
	class Item_fsh_fPod: Item_Base_F {
		scope = 2;
		scopeCurator = 2;
		displayName = "fPod";
		author = "Fishy";
		vehicleClass = "Items";
		class TransportItems {
			class fsh_fPod {
				name="fsh_fPod";
				count=1;
			};
		};
	};
	
};
