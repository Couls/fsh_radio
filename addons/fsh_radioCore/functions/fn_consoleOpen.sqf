#include "..\macros.hpp"
_vehicle = vehicle player;

_veh_rStatus = _vehicle getVariable ['fshR_vehInit', 0];
if (_veh_rStatus == 0) then {
	//This vehicle is not running fshR, prompt server
	if (!isServer) then {
		fshR_serverData = ['vehicleInit', _vehicle];
		publicVariableServer 'fshR_serverData';
	} else {
		[_vehicle] spawn fshR_fnc_vehicleLoop;
	};
};

if (_veh_rStatus == 2) then {
	disableSerialization;
	createDialog "fshR_console";
	_ui = uiNamespace getVariable 'fshR_Console';
	_ui_title = _ui DisplayCtrl 7150;
	_ui_list_title = _ui DisplayCtrl 7151;
	_ui_info_song = _ui DisplayCtrl 7152;
	_ui_info_artist = _ui DisplayCtrl 7153;
	_ui_info_songTime = _ui DisplayCtrl 7154;
	_ui_info_songEnd = _ui DisplayCtrl 7155;
	_ui_list = _ui DisplayCtrl 7156;
	_ui_song_slider = _ui DisplayCtrl 7157;
	_ui_list_radio = _ui DisplayCtrl 7158;

	_ui_song_slider sliderSetRange [0, 100];
	_ui_list ctrlShow false;
	_ui_list_radio ctrlShow false;

	_song_list = _vehicle getVariable ['fshR_tracks', []];

	_i = 0;
	{
		_song_cName = _x;
		_song_name = _song_cName call fsh_getTrackName;
		_song_artist = _song_cName call fsh_getTrackArtist;
		
		_ui_list lbAdd format ['%1', _song_name];
		_ui_list lbSetData [(lbSize _ui_list)-1, _song_cName];
		_ui_list lbSetTooltip [(lbSize _ui_list)-1, _song_artist];
		INC(_i);
	} forEach _song_list;

	{
		_radio_cName = _x;
		_radio_name = _radio_cName call fsh_getStationName;
		
		_ui_list_radio lbAdd format ['%1', _radio_name];
		_ui_list_radio lbSetData [(lbSize _ui_list_radio)-1, _radio_cName];
		INC(_i);
	} forEach fsh_stations;


	_nul = [_ui,_vehicle] spawn {
		disableSerialization;
		_ui = _this select 0;
		_vehicle = _this select 1;
		_ui_title = _ui DisplayCtrl 7150;
		_ui_list_title = _ui DisplayCtrl 7151;
		_ui_info_audioName = _ui DisplayCtrl 7152;
		_ui_info_artist = _ui DisplayCtrl 7153;
		_ui_info_audioTime = _ui DisplayCtrl 7154;
		_ui_info_audioEnd = _ui DisplayCtrl 7155;
		_ui_list = _ui DisplayCtrl 7156;
		_ui_audio_slider = _ui DisplayCtrl 7157;
		_ui_list_radio = _ui DisplayCtrl 7158;
		
		while {!isnull (findDisplay 715)} do {
			_audioClass = fsh_audioName;
			_audioMode = fsh_audioType;
			_audioTitle =  _audioClass call fsh_getTrackName;
			_audioArtist = if ((_audioClass call fsh_getTrackType) == 'song') then {_audioClass call fsh_getTrackArtist} else {''};
			_audioStation = fsh_station;
			_audioPos = fsh_audioPos;
			
			//Check the slider
			if (fsh_sliderTimer > 0) then {
				fsh_sliderTimer = fsh_sliderTimer -1;
			} else {
				if (fsh_sliderTimer == 0) then {
					fsh_sliderTimer = -1;
					//Send server value
					_vehicle setVariable ['fshR_data', ['track_time', fsh_sliderVal], true];
				};
			};
			
			if (_audioMode == 1) then {
				_ui_info_audioName ctrlSetText _audioTitle;
				_ui_info_artist ctrlSetText _audioArtist;
				_audioEnd = _audioClass call fsh_getTrackDuration;
				_ui_list ctrlShow true;
				_ui_list_radio ctrlShow false;
				_ui_list_title ctrlSetText 'Songs';
				if (_audioEnd != 0) then {
					_audioTime = ((abs _audioPos) call fsh_secToMin);
					_ui_info_audioTime ctrlSetText _audioTime;
					_ui_info_audioEnd ctrlSetText (_audioEnd call fsh_secToMin);
					if (fsh_sliderTimer == -1) then {
						_ui_audio_slider sliderSetPosition 100*((abs(_audioPos))/_audioEnd);
					};
				} else {
					_ui_info_audioTime ctrlSetText '';
					_ui_info_audioEnd ctrlSetText '';
					_ui_audio_slider sliderSetPosition 0;
					_ui_info_artist ctrlSetText '';
				};
			} else {
				_ui_list ctrlShow false;
				_ui_list_radio ctrlShow true;
				_ui_list_title ctrlSetText 'Radio';
				_ui_audio_slider sliderSetPosition 0;
				_ui_info_audioName ctrlSetText (_audioStation call fsh_getStationName);
				_ui_info_artist ctrlSetText '';
				_ui_info_audioTime ctrlSetText '';
				_ui_info_audioEnd ctrlSetText '';
			};
			uiSleep 1;
		};
	};
};