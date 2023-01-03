/datum/config_entry/flag/auto_profile // Automatically start profiler on server start

/datum/config_entry/flag/autoadmin  // if autoadmin is enabled
	protection = CONFIG_ENTRY_LOCKED

/datum/config_entry/string/autoadmin_rank	// the rank for autoadmins
	config_entry_value = "Game Master"
	protection = CONFIG_ENTRY_LOCKED

/datum/config_entry/string/servername	// server name (the name of the game window)

/datum/config_entry/string/servertagline
	config_entry_value = "We forgot to set the server's tagline in config.txt"

/datum/config_entry/string/serversqlname	// short form server name used for the DB

/datum/config_entry/string/stationname	// station name (the name of the station in-game)

/datum/config_entry/number/lobby_countdown	// In between round countdown.
	config_entry_value = 120
	min_val = 0

/datum/config_entry/number/round_end_countdown	// Post round murder death kill countdown
	config_entry_value = 25
	min_val = 0

/datum/config_entry/flag/hub	// if the game appears on the hub or not

/datum/config_entry/flag/allow_admin_ooccolor	// Allows admins with relevant permissions to have their own ooc colour

/datum/config_entry/flag/allow_vote_restart	// allow votes to restart

/datum/config_entry/flag/allow_vote_mode	// allow votes to change mode

/datum/config_entry/number/vote_delay	// minimum time between voting sessions (deciseconds, 10 minute default)
	config_entry_value = 6000
	min_val = 0

/datum/config_entry/number/vote_period  // length of voting period (deciseconds, default 1 minute)
	config_entry_value = 600
	min_val = 0

/// Length of time before the first autotransfer vote is called (deciseconds, default 2 hours)
/// Set to 0 to disable the subsystem altogether.
/datum/config_entry/number/vote_autotransfer_initial
	config_entry_value = 72000
	min_val = 0

///length of time to wait before subsequent autotransfer votes (deciseconds, default 30 minutes)
/datum/config_entry/number/vote_autotransfer_interval
	config_entry_value = 18000
	min_val = 0

/// maximum extensions until the round autoends.
/// Set to 0 to force automatic crew transfer after the 'vote_autotransfer_initial' elapsed.
/// Set to -1 to disable the maximum extensions cap.
/datum/config_entry/number/vote_autotransfer_maximum
	config_entry_value = 4
	min_val = -1

/datum/config_entry/flag/default_no_vote	// vote does not default to nochange/norestart

/datum/config_entry/flag/no_dead_vote	// dead people can't vote

/datum/config_entry/flag/allow_metadata	// Metadata is supported.

/datum/config_entry/flag/popup_admin_pm	// adminPMs to non-admins show in a pop-up 'reply' window when set

/datum/config_entry/number/fps
	config_entry_value = 20
	min_val = 1
	max_val = 100   //byond will start crapping out at 50, so this is just ridic
	var/sync_validate = FALSE

/datum/config_entry/number/fps/ValidateAndSet(str_val)
	. = ..()
	if(.)
		sync_validate = TRUE
		var/datum/config_entry/number/ticklag/TL = config.entries_by_type[/datum/config_entry/number/ticklag]
		if(!TL.sync_validate)
			TL.ValidateAndSet(10 / config_entry_value)
		sync_validate = FALSE

/datum/config_entry/number/ticklag
	integer = FALSE
	var/sync_validate = FALSE

/datum/config_entry/number/ticklag/New()	//ticklag weirdly just mirrors fps
	var/datum/config_entry/CE = /datum/config_entry/number/fps
	config_entry_value = 10 / initial(CE.config_entry_value)
	..()

/datum/config_entry/number/ticklag/ValidateAndSet(str_val)
	. = text2num(str_val) > 0 && ..()
	if(.)
		sync_validate = TRUE
		var/datum/config_entry/number/fps/FPS = config.entries_by_type[/datum/config_entry/number/fps]
		if(!FPS.sync_validate)
			FPS.ValidateAndSet(10 / config_entry_value)
		sync_validate = FALSE

/datum/config_entry/flag/allow_holidays

/datum/config_entry/number/tick_limit_mc_init	//SSinitialization throttling
	config_entry_value = TICK_LIMIT_MC_INIT_DEFAULT
	min_val = 0 //oranges warned us
	integer = FALSE

/datum/config_entry/flag/admin_legacy_system	//Defines whether the server uses the legacy admin system with admins.txt or the SQL system
	protection = CONFIG_ENTRY_LOCKED

/datum/config_entry/flag/protect_legacy_admins	//Stops any admins loaded by the legacy system from having their rank edited by the permissions panel
	protection = CONFIG_ENTRY_LOCKED

/datum/config_entry/flag/protect_legacy_ranks	//Stops any ranks loaded by the legacy system from having their flags edited by the permissions panel
	protection = CONFIG_ENTRY_LOCKED

/datum/config_entry/flag/enable_localhost_rank	//Gives the !localhost! rank to any client connecting from 127.0.0.1 or ::1
	protection = CONFIG_ENTRY_LOCKED

/datum/config_entry/flag/load_legacy_ranks_only	//Loads admin ranks only from legacy admin_ranks.txt, while enabled ranks are mirrored to the database
	protection = CONFIG_ENTRY_LOCKED

/datum/config_entry/flag/mentors_mobname_only

/datum/config_entry/flag/mentor_legacy_system	//Defines whether the server uses the legacy mentor system with mentors.txt or the SQL system
	protection = CONFIG_ENTRY_LOCKED

/datum/config_entry/string/hostedby

/datum/config_entry/flag/guest_jobban

/datum/config_entry/flag/usewhitelist

/datum/config_entry/flag/ban_legacy_system	//Defines whether the server uses the legacy banning system with the files in /data or the SQL system.
	protection = CONFIG_ENTRY_LOCKED

/datum/config_entry/flag/use_age_restriction_for_jobs	//Do jobs use account age restrictions? --requires database

/datum/config_entry/flag/use_account_age_for_jobs	//Uses the time they made the account for the job restriction stuff. New player joining alerts should be unaffected.

/datum/config_entry/flag/use_exp_tracking

/datum/config_entry/flag/use_exp_restrictions_heads

/datum/config_entry/number/use_exp_restrictions_heads_hours
	config_entry_value = 0
	min_val = 0

/datum/config_entry/flag/use_exp_restrictions_heads_department

/datum/config_entry/flag/use_exp_restrictions_other

/datum/config_entry/flag/use_exp_restrictions_admin_bypass

/datum/config_entry/string/server

/datum/config_entry/string/banappeals

/datum/config_entry/string/wikiurl
	config_entry_value = "https://katlin.dog/citadel-wiki"

/datum/config_entry/string/wikiurltg
	config_entry_value = "http://www.tgstation13.org/wiki"

/datum/config_entry/string/forumurl
	config_entry_value = "http://tgstation13.org/phpBB/index.php"

/datum/config_entry/string/rulesurl
	config_entry_value = "http://www.tgstation13.org/wiki/Rules"

/datum/config_entry/string/githuburl
	config_entry_value = "https://www.github.com/tgstation/-tg-station"

/datum/config_entry/string/discordbotcommandprefix
	default = "?"

/datum/config_entry/string/roundstatsurl

/datum/config_entry/string/gamelogurl

/datum/config_entry/number/githubrepoid
	config_entry_value = null
	min_val = 0

/datum/config_entry/flag/guest_ban

/datum/config_entry/number/id_console_jobslot_delay
	config_entry_value = 30
	min_val = 0

/datum/config_entry/number/inactivity_period	//time in ds until a player is considered inactive
	config_entry_value = 3000
	min_val = 0

/datum/config_entry/number/inactivity_period/ValidateAndSet(str_val)
	. = ..()
	if(.)
		config_entry_value *= 10 //documented as seconds in config.txt

/datum/config_entry/number/afk_period	//time in ds until a player is considered inactive
	config_entry_value = 3000
	min_val = 0

/datum/config_entry/number/afk_period/ValidateAndSet(str_val)
	. = ..()
	if(.)
		config_entry_value *= 10 //documented as seconds in config.txt

/datum/config_entry/flag/kick_inactive	//force disconnect for inactive players

/datum/config_entry/flag/load_jobs_from_txt

/datum/config_entry/flag/forbid_singulo_possession

/datum/config_entry/flag/automute_on	//enables automuting/spam prevention

/datum/config_entry/string/panic_server_name

/datum/config_entry/string/panic_server_name/ValidateAndSet(str_val)
	return str_val != "\[Put the name here\]" && ..()

/datum/config_entry/string/panic_server_address	//Reconnect a player this linked server if this server isn't accepting new players

/datum/config_entry/string/panic_server_address/ValidateAndSet(str_val)
	return str_val != "byond://address:port" && ..()

/datum/config_entry/string/invoke_youtubedl
	protection = CONFIG_ENTRY_LOCKED | CONFIG_ENTRY_HIDDEN

/datum/config_entry/flag/show_irc_name

/datum/config_entry/flag/see_own_notes	//Can players see their own admin notes

/datum/config_entry/number/note_fresh_days
	config_entry_value = null
	min_val = 0
	integer = FALSE

/datum/config_entry/number/note_stale_days
	config_entry_value = null
	min_val = 0
	integer = FALSE

/datum/config_entry/flag/maprotation

/datum/config_entry/flag/tgstyle_maprotation

/datum/config_entry/string/map_vote_type
	config_entry_value = APPROVAL_VOTING

/datum/config_entry/number/maprotatechancedelta
	config_entry_value = 0.75
	min_val = 0
	max_val = 1
	integer = FALSE

/datum/config_entry/number/soft_popcap
	config_entry_value = null
	min_val = 0

/datum/config_entry/number/hard_popcap
	config_entry_value = null
	min_val = 0

/datum/config_entry/number/extreme_popcap
	config_entry_value = null
	min_val = 0

/datum/config_entry/string/soft_popcap_message
	config_entry_value = "Be warned that the server is currently serving a high number of users, consider using alternative game servers."

/datum/config_entry/string/hard_popcap_message
	config_entry_value = "The server is currently serving a high number of users, You cannot currently join. You may wait for the number of living crew to decline, observe, or find alternative servers."

/datum/config_entry/string/extreme_popcap_message
	config_entry_value = "The server is currently serving a high number of users, find alternative servers."

/datum/config_entry/flag/panic_bunker	// prevents people the server hasn't seen before from connecting

/datum/config_entry/number/panic_bunker_living // living time in minutes that a player needs to pass the panic bunker

/datum/config_entry/string/panic_bunker_message
	config_entry_value = "Sorry but the server is currently not accepting connections from never before seen players."

/datum/config_entry/number/notify_new_player_age	// how long do we notify admins of a new player
	min_val = -1

/datum/config_entry/number/notify_new_player_account_age	// how long do we notify admins of a new byond account
	min_val = 0

/datum/config_entry/flag/age_verification //are we using the automated age verification which asks users if they're 18+?
	config_entry_value = TRUE

/datum/config_entry/flag/irc_first_connection_alert	// do we notify the irc channel when somebody is connecting for the first time?

/datum/config_entry/flag/check_randomizer

/datum/config_entry/string/ipintel_email

/datum/config_entry/string/ipintel_email/ValidateAndSet(str_val)
	return str_val != "ch@nge.me" && ..()

/datum/config_entry/number/ipintel_rating_bad
	config_entry_value = 1
	integer = FALSE
	min_val = 0
	max_val = 1

/datum/config_entry/number/ipintel_save_good
	config_entry_value = 12
	min_val = 0

/datum/config_entry/number/ipintel_save_bad
	config_entry_value = 1
	min_val = 0

/datum/config_entry/string/ipintel_domain
	config_entry_value = "check.getipintel.net"

/datum/config_entry/flag/aggressive_changelog

/datum/config_entry/flag/autoconvert_notes	//if all connecting player's notes should attempt to be converted to the database
	protection = CONFIG_ENTRY_LOCKED

/datum/config_entry/flag/allow_webclient

/datum/config_entry/flag/webclient_only_byond_members

/datum/config_entry/flag/announce_admin_logout

/datum/config_entry/flag/announce_admin_login

/datum/config_entry/flag/allow_map_voting

/datum/config_entry/number/client_warn_version
	config_entry_value = null
	min_val = 500

/datum/config_entry/number/client_warn_version
	config_entry_value = null
	min_val = 500

/datum/config_entry/string/client_warn_message
	config_entry_value = "Your version of byond may have issues or be blocked from accessing this server in the future."

/datum/config_entry/flag/client_warn_popup

/datum/config_entry/number/client_error_version
	config_entry_value = null
	min_val = 500

/datum/config_entry/string/client_error_message
	config_entry_value = "Your version of byond is too old, may have issues, and is blocked from accessing this server."

/datum/config_entry/number/client_error_build
	config_entry_value = null
	min_val = 0

/datum/config_entry/number/minute_topic_limit
	config_entry_value = null
	min_val = 0

/datum/config_entry/number/second_topic_limit
	config_entry_value = null
	min_val = 0

/datum/config_entry/number/minute_click_limit
	config_entry_value = 400
	min_val = 0

/datum/config_entry/number/second_click_limit
	config_entry_value = 15
	min_val = 0

/datum/config_entry/number/error_cooldown	// The "cooldown" time for each occurrence of a unique error
	config_entry_value = 600
	min_val = 0

/datum/config_entry/number/error_limit	// How many occurrences before the next will silence them
	config_entry_value = 50

/datum/config_entry/number/error_silence_time	// How long a unique error will be silenced for
	config_entry_value = 6000

/datum/config_entry/number/error_msg_delay	// How long to wait between messaging admins about occurrences of a unique error
	config_entry_value = 50

/datum/config_entry/flag/irc_announce_new_game
	deprecated_by = /datum/config_entry/string/chat_announce_new_game

/datum/config_entry/flag/irc_announce_new_game/DeprecationUpdate(value)
	return ""	//default broadcast

/datum/config_entry/string/chat_announce_new_game
	config_entry_value = null

/datum/config_entry/string/chat_new_game_notifications
	default = null

/datum/config_entry/flag/debug_admin_hrefs

/datum/config_entry/number/mc_tick_rate/base_mc_tick_rate
	integer = FALSE
	config_entry_value = 1

/datum/config_entry/number/mc_tick_rate/high_pop_mc_tick_rate
	integer = FALSE
	config_entry_value = 1.1

/datum/config_entry/number/mc_tick_rate/high_pop_mc_mode_amount
	config_entry_value = 65

/datum/config_entry/number/mc_tick_rate/disable_high_pop_mc_mode_amount
	config_entry_value = 60

/datum/config_entry/number/mc_tick_rate
	abstract_type = /datum/config_entry/number/mc_tick_rate

/datum/config_entry/number/mc_tick_rate/ValidateAndSet(str_val)
	. = ..()
	if (.)
		Master.UpdateTickRate()

/datum/config_entry/flag/resume_after_initializations

/datum/config_entry/flag/resume_after_initializations/ValidateAndSet(str_val)
	. = ..()
	if(. && Master.current_runlevel)
		world.sleep_offline = !config_entry_value

/datum/config_entry/number/rounds_until_hard_restart
	config_entry_value = -1
	min_val = 0

/datum/config_entry/string/default_view
	config_entry_value = "15x15"

/datum/config_entry/string/default_view_square
	config_entry_value = "15x15"

/datum/config_entry/number/max_bunker_days
	config_entry_value = 7
	min_val = 1

/datum/config_entry/flag/minimaps_enabled
	config_entry_value = TRUE

/datum/config_entry/string/centcom_ban_db	// URL for the CentCom Galactic Ban DB API

/datum/config_entry/number/damage_multiplier
	config_entry_value = 1
	integer = FALSE

/datum/config_entry/number/minimal_access_threshold	//If the number of players is larger than this threshold, minimal access will be turned on.
	min_val = 0

/datum/config_entry/flag/jobs_have_minimal_access	//determines whether jobs use minimal access or expanded access.

/datum/config_entry/flag/assistants_have_maint_access

/datum/config_entry/flag/security_has_maint_access

/datum/config_entry/flag/everyone_has_maint_access

/datum/config_entry/flag/sec_start_brig	//makes sec start in brig instead of dept sec posts

/datum/config_entry/flag/force_random_names

/datum/config_entry/flag/humans_need_surnames

/datum/config_entry/flag/allow_ai	// allow ai job

/datum/config_entry/flag/allow_ai_multicam //whether the AI can use their multicam

/datum/config_entry/flag/disable_human_mood

/datum/config_entry/flag/disable_borg_flash_knockdown //Should borg flashes be capable of knocking humanoid entities down?

/datum/config_entry/flag/weaken_secborg //Brings secborgs and k9s back in-line with the other borg modules

/datum/config_entry/flag/disable_secborg	// disallow secborg module to be chosen.

/datum/config_entry/flag/disable_peaceborg

/datum/config_entry/flag/economy	//money money money money money money money money money money money money

/datum/config_entry/flag/reactionary_explosions	//If we use reactionary explosions, explosions that react to walls and doors

/datum/config_entry/flag/enforce_human_authority	//If non-human species are barred from joining as a head of staff

/datum/config_entry/number/midround_antag_time_check	// How late (in minutes you want the midround antag system to stay on, setting this to 0 will disable the system)
	config_entry_value = 60
	min_val = 0

/datum/config_entry/number/midround_antag_life_check	// A ratio of how many people need to be alive in order for the round not to immediately end in midround antagonist
	config_entry_value = 0.7
	integer = FALSE
	min_val = 0
	max_val = 1

/datum/config_entry/number/suicide_reenter_round_timer
	config_entry_value = 30
	min_val = 0

/datum/config_entry/number/roundstart_suicide_time_limit
	config_entry_value = 30
	min_val = 0

/datum/config_entry/number/shuttle_refuel_delay
	config_entry_value = 12000
	min_val = 0

/datum/config_entry/flag/show_game_type_odds	//if set this allows players to see the odds of each roundtype on the get revision screen

/datum/config_entry/keyed_list/roundstart_races	//races you can play as from the get go.
	key_mode = KEY_MODE_TEXT
	value_mode = VALUE_MODE_FLAG

/datum/config_entry/flag/join_with_mutant_humans	//players can pick mutant bodyparts for humans before joining the game

/datum/config_entry/flag/no_summon_guns		//No

/datum/config_entry/flag/no_summon_magic	//Fun

/datum/config_entry/flag/no_summon_events	//Allowed

/datum/config_entry/flag/no_summon_traumas	//!

/datum/config_entry/flag/no_intercept_report	//Whether or not to send a communications intercept report roundstart. This may be overridden by gamemodes.

/datum/config_entry/number/arrivals_shuttle_dock_window	//Time from when a player late joins on the arrivals shuttle to when the shuttle docks on the station
	config_entry_value = 55
	min_val = 30

/datum/config_entry/flag/arrivals_shuttle_require_undocked	//Require the arrivals shuttle to be undocked before latejoiners can join

/datum/config_entry/flag/arrivals_shuttle_require_safe_latejoin	//Require the arrivals shuttle to be operational in order for latejoiners to join


/datum/config_entry/flag/revival_pod_plants

/datum/config_entry/flag/revival_cloning

/datum/config_entry/number/revival_brain_life
	config_entry_value = -1
	min_val = -1

/datum/config_entry/flag/ooc_during_round

/datum/config_entry/flag/emojis

/datum/config_entry/flag/roundstart_away	//Will random away mission be loaded.

/datum/config_entry/flag/roundstart_vr 		//Will virtual reality missions be loaded?

/datum/config_entry/number/gateway_delay	//How long the gateway takes before it activates. Default is half an hour. Only matters if roundstart_away is enabled.
	config_entry_value = 18000
	min_val = 0

/datum/config_entry/flag/ghost_interaction

/datum/config_entry/flag/silent_ai
/datum/config_entry/flag/silent_borg

/datum/config_entry/flag/sandbox_autoclose	// close the sandbox panel after spawning an item, potentially reducing griff

/datum/config_entry/number/default_laws //Controls what laws the AI spawns with.
	config_entry_value = 0
	min_val = 0
	max_val = 3

/datum/config_entry/number/silicon_max_law_amount
	config_entry_value = 12
	min_val = 0

/datum/config_entry/keyed_list/random_laws
	key_mode = KEY_MODE_TEXT
	value_mode = VALUE_MODE_FLAG

/datum/config_entry/keyed_list/law_weight
	key_mode = KEY_MODE_TEXT
	value_mode = VALUE_MODE_NUM
	splitter = ","

/datum/config_entry/number/overflow_cap
	config_entry_value = -1
	min_val = -1

/datum/config_entry/string/overflow_job
	config_entry_value = "Assistant"

/datum/config_entry/flag/starlight
/datum/config_entry/flag/grey_assistants

/datum/config_entry/number/lavaland_budget
	config_entry_value = 60
	min_val = 0

/datum/config_entry/number/space_budget
	config_entry_value = 16
	min_val = 0

/datum/config_entry/number/icemoon_budget
	config_entry_value = 90
	integer = FALSE
	min_val = 0

/datum/config_entry/number/station_space_budget
	config_entry_value = 10
	min_val = 0

/datum/config_entry/flag/allow_random_events	// Enables random events mid-round when set

/datum/config_entry/number/events_min_time_mul	// Multipliers for random events minimal starting time and minimal players amounts
	config_entry_value = 1
	min_val = 0
	integer = FALSE

/datum/config_entry/number/events_min_players_mul
	config_entry_value = 1
	min_val = 0
	integer = FALSE

/datum/config_entry/number/mice_roundstart
	config_entry_value = 10
	min_val = 0

/datum/config_entry/number/bombcap
	config_entry_value = 14
	min_val = 4

/datum/config_entry/number/bombcap/ValidateAndSet(str_val)
	. = ..()
	if(.)
		GLOB.MAX_EX_DEVESTATION_RANGE = round(config_entry_value / 4)
		GLOB.MAX_EX_HEAVY_RANGE = round(config_entry_value / 2)
		GLOB.MAX_EX_LIGHT_RANGE = config_entry_value
		GLOB.MAX_EX_FLASH_RANGE = config_entry_value
		GLOB.MAX_EX_FLAME_RANGE = config_entry_value

/datum/config_entry/number/emergency_shuttle_autocall_threshold
	min_val = 0
	max_val = 1
	integer = FALSE

/datum/config_entry/flag/ic_printing

/datum/config_entry/flag/roundstart_traits

/datum/config_entry/flag/enable_night_shifts

/datum/config_entry/number/night_shift_public_areas_only
	config_entry_value = NIGHTSHIFT_AREA_PUBLIC

/datum/config_entry/flag/nightshift_toggle_requires_auth
	config_entry_value = FALSE

/datum/config_entry/flag/nightshift_toggle_public_requires_auth
	config_entry_value = TRUE

/datum/config_entry/flag/randomize_shift_time

/datum/config_entry/flag/shift_time_realtime

/datum/config_entry/number/monkeycap
	config_entry_value = 64
	min_val = 0

/datum/config_entry/number/ratcap
	config_entry_value = 64
	min_val = 0

/datum/config_entry/keyed_list/box_random_engine
	key_mode = KEY_MODE_TEXT
	value_mode = VALUE_MODE_NUM
	lowercase = FALSE
	splitter = ","

/datum/config_entry/flag/pai_custom_holoforms

/datum/config_entry/number/marauder_delay_non_reebe
	config_entry_value = 1800
	min_val = 0

/datum/config_entry/flag/allow_clockwork_marauder_on_station
	config_entry_value = TRUE

/datum/config_entry/flag/suicide_allowed


//Allows players to set a hexadecimal color of their choice as skin tone, on top of the standard ones.
/datum/config_entry/flag/allow_custom_skintones

///Initial loadout points
/datum/config_entry/number/initial_gear_points
	config_entry_value = 10

/**
  * Enables the FoV component, which hides objects and mobs behind the parent from their sight, unless they turn around, duh.
  * Camera mobs, AIs, ghosts and some other are of course exempt from this. This also doesn't influence simplemob AI, for the best.
  */
/datum/config_entry/flag/use_field_of_vision

//Shuttle size limiter
/datum/config_entry/number/max_shuttle_count
	config_entry_value = 6

/datum/config_entry/number/max_shuttle_size
	config_entry_value = 500

//wound config stuff (increases the max injury roll, making injuries more likely)
/datum/config_entry/number/wound_exponent
	config_entry_value = WOUND_DAMAGE_EXPONENT
	min_val = 0
	integer = FALSE

//adds a set amount to any injury rolls on a limb using get_damage() multiplied by this number
/datum/config_entry/number/wound_damage_multiplier
	config_entry_value = 0.333
	min_val = 0
	integer = FALSE

/datum/config_entry/number/hard_deletes_overrun_threshold
	integer = FALSE
	min_val = 0
	default = 0.5

/datum/config_entry/number/hard_deletes_overrun_limit
	default = 0
	min_val = 0

/datum/config_entry/flag/atmos_equalize_enabled
	default = FALSE

/datum/config_entry/flag/dynamic_config_enabled

/datum/config_entry/flag/station_name_needs_approval

//ambition start
/datum/config_entry/number/max_ambitions	// Maximum number of ambitions a mind can store.
	config_entry_value = 5
//ambition end
