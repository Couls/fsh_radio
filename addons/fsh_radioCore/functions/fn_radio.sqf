#include "..\macros.hpp"
#define DEF_SONG_LENTGH 300 //Default song lenth if not spesified in config
fshR_debug = false;
fsh_global_time = 0;
FSH_ACE = if (isClass(configFile >> "CfgPatches" >> "ace_main")) then {true} else {false};

fsh_vehicleRadioData = ["",0];

fsh_secToMin = compileFinal "
	private['_mins','_seconds','_str'];
	_mins = floor (_this / 60);
	_seconds = _this - (_mins * 60);
	_str = format['%1:%2',_mins, _seconds];
	if (_seconds<10) then {
		_str = format['%1:0%2',_mins, _seconds];
	};
	_str
";

fsh_getTime = compileFinal "
	fsh_global_time
";

//------------------------------------------------------
//For these functions, _var = "#songname" call fsh_...
fsh_getTrackCfg = compileFinal "
	private ['_name','_cfg'];
	_cfg = configFile >> 'CfgSounds' >> _this;
	_name = getText (_cfg >> 'name');
	if (_name == '') then {
		_cfg = missionConfigFile >> 'CfgSounds' >> _this;
		_name = getText (_cfg >> 'name');
		if (_name == '') then {_cfg = ''};
	};
	_cfg
";

fsh_arrayShuffle = compileFinal "
	private ['_shuffledArray', '_tempArray', '_indexToRemove'];
	_tempArray = _this;
	_shuffledArray = [];
	for '_size' from (count _tempArray) to 1 step -1 do {
		_indexToRemove = floor random _size;
		_shuffledArray pushBack (_tempArray deleteAt _indexToRemove);
	};
	_shuffledArray
";
fsh_arrayCycle = compileFinal "
	private ['_cycledArray', '_tempArray'];
	_tempArray = _this;
	_cycledArray = [];
	for [{_i=1}, {_i < (count _tempArray)}, {_i = _i + 1}] do { 
		_cycledArray pushBack (_tempArray select _i); 
	}; 
	_cycledArray pushBack (_tempArray select 0); 
	_cycledArray
";


fsh_getTrackName = compileFinal "
	private ['_name','_cfg'];
	_cfg = configFile >> 'CfgSounds' >> _this;
	_name = getText (_cfg >> 'name');
	if (_name == '') then {
		_cfg = missionConfigFile >> 'CfgSounds' >> _this;
		_name = getText (_cfg >> 'name');
	};
	_name
";

fsh_getStationName = compileFinal "
	private ['_name','_cfg'];
	_cfg = configFile >> 'CfgRadioStations' >> _this;
	_name = getText (_cfg >> 'name');
	if (_name == '') then {
		_cfg = missionConfigFile >> 'CfgRadioStations' >> _this;
		_name = getText (_cfg >> 'name');
	};
	_name
";

fsh_getTrackType = compileFinal "
	private ['_type','_cfg'];
	_cfg = configFile >> 'CfgSounds' >> _this;
	_type = getText (_cfg >> 'type');
	if (_type == '') then {
		_cfg = missionConfigFile >> 'CfgSounds' >> _this;
		_type = getText (_cfg >> 'type');
		if (_type == '') then {_type = 'song';};
	};
	_type
";

fsh_getTrackTheme = compileFinal "
	private ['_theme','_cfg'];
	_cfg = configFile >> 'CfgSounds' >> _this;
	_theme = getText (_cfg >> 'theme');
	if (_theme == '') then {
		_cfg = missionConfigFile >> 'CfgSounds' >> _this;
		_theme = getText (_cfg >> 'theme');
	};
	_theme
";

fsh_getTrackDuration = compileFinal "
	private ['_duration','_cfg'];
	_cfg = configFile >> 'CfgSounds' >> _this;
	_duration = getNumber (_cfg >> 'duration');
	if (_duration == 0) then {
		_cfg = missionConfigFile >> 'CfgSounds' >> _this;
		_duration = getNumber (_cfg >> 'duration');
	};
	_duration
";

fsh_getTrackArtist = compileFinal "
	private ['_artist','_cfg','_dft'];
	_cfg = configFile >> 'CfgSounds' >> _this;
	_dft = 'Unknown';
	if (configName (_cfg) == '') then {
		_cfg = missionConfigFile >> 'CfgSounds' >> _this;
		_dft = 'Valtteri Harju';
	};
	_artist = getText (_cfg >> 'artist');
	if (_artist == '') then {_artist = _dft;};
	_artist
";

fsh_getErrorMessage = compileFinal "
	private ['_cfg','_str'];
	_cfg = missionConfigFile >> 'cfgErrorMessages';
	_cfg = _cfg select (floor(random(count _cfg)));
	_str = getText (_cfg >> 'message');
	_str
";


//Slightly more complex versio of KKs inString. Will search for a string OR an array in the haystack
fsh_fnc_inString = compileFinal "
	private ['_needle','_haystack','_needleLen','_hay','_found','_i'];
	_needle_array = [_this, 0, '', ['',[]]] call BIS_fnc_param;
	_haystack = toArray ([_this, 1, '', ['']] call BIS_fnc_param);
	
	if (typeName _needle_array == 'STRING') then {
		_needle_array = [_needle_array];
	};
	_found = false;
	for [{_i=0}, {_i < (count _needle_array)}, {_i = _i + 1}] do {
		_needle = _needle_array select _i;
		_needleLen = count toArray _needle;
		_hay = +_haystack;
		_hay resize _needleLen;
		for '_j' from _needleLen to count _haystack do {
			if (toString _hay == _needle) then {
				_found = true;
				_i = count _needle_array;
				_j = count _haystack;
			} else {
				_hay set [_needleLen, _haystack select _j];
				_hay set [0, 'x'];
				_hay = _hay - ['x']
			};
		};
	};
	_found
";


// _myResults = ['','','song','',0] call fsh_filterTracks;

fsh_filterTracks = compileFinal "
	private ['_name_fr', '_artist_fr', '_type_fr', '_theme_fr', '_allowDefault', '_allSongs', '_results', '_track', '_artist', '_type', '_theme','_name'];
	_name_fr = [_this,0,'',['',[]]] call BIS_fnc_param;
	_artist_fr = [_this,1,'',['',[]]] call BIS_fnc_param;
	_type_fr = [_this,2,'',['',[]]] call BIS_fnc_param;
	_theme_fr = [_this,3,'',['',[]]] call BIS_fnc_param;
	_allowDefault = [_this,4,true,[true]] call BIS_fnc_param;
	
	_allSongs = [_allowDefault] call fsh_getAllTracks;
	_results = [];
	{
		_track = _x;
		_name = _track call fsh_getTrackName;
		if ([_name_fr, _name] call fsh_fnc_inString) then {
			_artist = _track call fsh_getTrackArtist;
			if ([_artist_fr, _artist] call fsh_fnc_inString) then {
				_type = _track call fsh_getTrackType;
				if ([_type_fr, _type] call fsh_fnc_inString) then {
					_theme = _track call fsh_getTrackTheme;
					if ([_theme_fr, _theme] call fsh_fnc_inString) then {
						_results pushBack _track;
					};
				};
			};
		};
	} forEach _allSongs;
	_results
";


//------------------------------------------------------

//Function that will trawl through all configs and find songs. 
//param 0: if true, any song will be included. Otherwise must contain 'fshRadio = 1' in song config
fsh_getAllMusic = compileFinal "
	_anySong = true;
	_cfg = configFile >> 'CfgSounds';
	_mission_cfg = missionConfigFile >> 'CfgSounds';
	_songs_unsorted = [];
	for [{_i=0}, {_i < (count _cfg)}, {_i = _i + 1}] do {
		_song = _cfg select _i;
		_song_name = getText (_song >> 'name');
		if (_song_name != '') then {
			_song_cName = configName _song;
			_song_type = _song_cName call fsh_getTrackType;
			if (_song_type == 'song') then {
				_songs_unsorted pushBack _song_cName;
			};
		};
	
	};
	for [{_i=0}, {_i < (count _mission_cfg)}, {_i = _i + 1}] do {
		_song = _mission_cfg select _i;
		_song_name = getText (_song >> 'name');
		if (_song_name != '') then {
			_song_cName = configName _song;
			_song_type = _song_cName call fsh_getTrackType;
			if (_song_type == 'song') then {
				_songs_unsorted pushBack _song_cName;
			};
		};
	};
	_songs_unsorted
";

//get every single audio file that has a duration, you dirty dog
fsh_getAllTracks = compileFinal "
	_cfg = configFile >> 'CfgSounds';
	_mission_cfg = missionConfigFile >> 'CfgSounds';
	_songs_unsorted = [];
	for [{_i=0}, {_i < (count _cfg)}, {_i = _i + 1}] do {
		_song = _cfg select _i;
		_s_dur = getNumber (_song >> 'duration');
		if (_s_dur !=0) then {
			_song_cName = configName _song;
			_songs_unsorted pushBack _song_cName;
		};
	
	};
	for [{_i=0}, {_i < (count _mission_cfg)}, {_i = _i + 1}] do {
		_song = _mission_cfg select _i;
		_s_dur = getNumber (_song >> 'duration');
		if (_s_dur !=0) then {
			_song_cName = configName _song;
			_songs_unsorted pushBack _song_cName;
		};
	};
	_songs_unsorted
";


fsh_getAllStations = compileFinal "
	_cfg = configFile >> 'CfgRadioStations';
	_mission_cfg = missionConfigFile >> 'CfgRadioStations';
	_stations = [];
	for [{_i=0}, {_i < (count _cfg)}, {_i = _i + 1}] do {
		_station = _cfg select _i;
		_station_cName = configName _station;
		_stations pushBack _station_cName;
	};
	for [{_i=0}, {_i < (count _mission_cfg)}, {_i = _i + 1}] do {
		_station = _mission_cfg select _i;
		_station_cName = configName _station;
		_stations pushBack _station_cName;
	};
	_stations
";

//I like to call this function now, since its not exactly going to change at any point. 
//its there if you want it!
fsh_music = call fsh_getAllMusic;
fsh_tracks = call fsh_getAllTracks;
fsh_stations = call fsh_getAllStations;


if (isServer) then {call fshR_fnc_serverInit;};
if (!isDedicated) then {call fshR_fnc_playerInit;};
