disableSerialization;
_ui = uiNamespace getVariable 'fshR_Console';
_controlID = _this select 0;
_command = _this select 1;

switch (_command) do {
    case 'close': {
		closeDialog 0; 
	};
	case 'track_select': {
		_uid = _controlID select 0;
		_lid = _controlID select 1;
		_data =  _uid lbData _lid;
		(vehicle player) setVariable ['fshR_data', [_command, _data], true];
	};
	case 'station_select': {
		_uid = _controlID select 0;
		_lid = _controlID select 1;
		_data =  _uid lbData _lid;
		(vehicle player) setVariable ['fshR_data', [_command, _data], true];
	};
	case 'track_changed': {
		_uid = _controlID select 0;
		_lid = _controlID select 1;
		_data =  _uid lbData _lid;
		fsh_list_track = _data;
	};
	case 'station_changed': {
		_uid = _controlID select 0;
		_lid = _controlID select 1;
		_data =  _uid lbData _lid;
		fsh_list_station = _data;
	};
	case 'play': {
		if (fsh_vehicleRadioData select 0 == 2) then {
		if (fsh_list_station != '') then {
				(vehicle player) setVariable ['fshR_data', ['station_select', fsh_list_station], true];
			};
		} else {
			(vehicle player) setVariable ['fshR_data', [_command, _controlID], true];
		};
	};
	case 'track_time': {
		fsh_sliderVal = _controlID select 1;
		fsh_sliderTimer = 1;
	};
	case 'dj': {
		fsh_list_track = '';
		(vehicle player) setVariable ['fshR_data', ['mode', 1], true];
	};
	case 'fm': {
		fsh_list_station = '';
		(vehicle player) setVariable ['fshR_data', ['mode', 2], true];
	};

    default {
		(vehicle player) setVariable ['fshR_data', [_command, _controlID], true];
	};
};