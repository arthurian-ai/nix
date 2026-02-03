{
  pkgs,
  inputs,
  lib,
  osConfig,
  ...
}: let
  transparency = osConfig.custom.theme.transparency or false;
  opacity = lib.mkForce (if transparency then 0.8 else 1.0);
  radius = lib.mkForce 0.3;
in {
  imports = [
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia-shell = {
    enable = true;
    settings = {
      # settingsVersion = 0;
      bar = {
        position = "right";
        # 	monitors = [ ];
        # 	density = "default";
        # 	showOutline = false;
        # 	showCapsule = true;
        # 	capsuleOpacity = 1;
        backgroundOpacity = opacity;
        # 	useSeparateOpacity = false;
        floating = true;
        # 	marginVertical = 4;
        # 	marginHorizontal = 4;
        # 	outerCorners = true;
        # 	exclusive = true;
        # 	hideOnOverview = false;
        widgets = {
          left = [
            # {
            # 	id = "Launcher";
            # }
            {
              id = "ControlCenter";
            }
            {
              id = "Clock";
            }
            {
              id = "NotificationHistory";
            }
            # {
            # 	id = "ActiveWindow";
            # }
            {
              id = "MediaMini";
            }
          ];
          center = [
            {
              id = "Workspace";
            }
          ];
          right = [
            {
              id = "Tray";
            }
            {
              id = "Battery";
            }
            {
              id = "Volume";
            }
            {
              id = "Brightness";
            }
            {
              id = "SystemMonitor";
            }
          ];
        };
      };
      general = {
        # 	avatarImage = "";
        # 	dimmerOpacity = 0.2;
        # 	showScreenCorners = false;
        # 	forceBlackScreenCorners = false;
        scaleRatio = 0.85;
        radiusRatio = radius;
        iRadiusRatio = radius;
        boxRadiusRatio = radius;
        screenRadiusRatio = radius;
        animationSpeed = 2;
        # 	animationDisabled = false;
        # 	compactLockScreen = false;
        # 	lockOnSuspend = true;
        # 	showSessionButtonsOnLockScreen = true;
        # 	showHibernateOnLockScreen = false;
        # 	enableShadows = true;
        # 	shadowDirection = "bottom_right";
        # 	shadowOffsetX = 2;
        # 	shadowOffsetY = 3;
        # 	language = "";
        # 	allowPanelsOnScreenWithoutBar = true;
        # 	showChangelogOnStartup = true;
        # 	telemetryEnabled = false;
      };
      ui = {
        # 	fontDefault = "";
        # 	fontFixed = "";
        # 	fontDefaultScale = 1;
        # 	fontFixedScale = 1;
        # 	tooltipsEnabled = true;
        panelBackgroundOpacity = opacity;
        # 	panelsAttachedToBar = true;
        # 	settingsPanelMode = "attached";
        # 	wifiDetailsViewMode = "grid";
        # 	bluetoothDetailsViewMode = "grid";
        # 	networkPanelView = "wifi";
        # 	bluetoothHideUnnamedDevices = false;
        # 	boxBorderEnabled = false;
      };
      location = {
        name = "San Francisco";
        weatherEnabled = true;
        # 	weatherShowEffects = true;
        useFahrenheit = true;
        # 	use12hourFormat = false;
        # 	showWeekNumberInCalendar = false;
        # 	showCalendarEvents = true;
        # 	showCalendarWeather = true;
        # 	analogClockInCalendar = false;
        # 	firstDayOfWeek = -1;
        # 	hideWeatherTimezone = false;
        # 	hideWeatherCityName = false;
      };
      calendar = {
        # cards = [
        # 	{
        # 		enabled = true;
        # 		id = "calendar-header-card";
        # 	}
        # 	{
        # 		enabled = true;
        # 		id = "calendar-month-card";
        # 	}
        # 	{
        # 		enabled = true;
        # 		id = "weather-card";
        # 	}
        # 	];
      };
      wallpaper = {
        # 	enabled = true;
        # 	overviewEnabled = false;
        # 	directory = "";
        # 	monitorDirectories = [ ];
        # 	enableMultiMonitorDirectories = false;
        # 	recursiveSearch = false;
        # 	setWallpaperOnAllMonitors = true;
        # 	fillMode = "crop";
        # 	fillColor = "#000000";
        # 	useSolidColor = false;
        # 	solidColor = "#1a1a2e";
        # 	randomEnabled = false;
        # 	wallpaperChangeMode = "random";
        # 	randomIntervalSec = 300;
        # 	transitionDuration = 1500;
        # 	transitionType = "random";
        # 	transitionEdgeSmoothness = 0.05;
        # 	panelPosition = "follow_bar";
        # 	hideWallpaperFilenames = false;
        # 	useWallhaven = false;
        # 	wallhavenQuery = "";
        # 	wallhavenSorting = "relevance";
        # 	wallhavenOrder = "desc";
        # 	wallhavenCategories = "111";
        # 	wallhavenPurity = "100";
        # 	wallhavenRatios = "";
        # 	wallhavenApiKey = "";
        # 	wallhavenResolutionMode = "atleast";
        # 	wallhavenResolutionWidth = "";
        # 	wallhavenResolutionHeight = "";
      };
      appLauncher = {
        enableClipboardHistory = true;
        # 	autoPasteClipboard = false;
        # 	enableClipPreview = true;
        # 	clipboardWrapText = true;
        # 	position = "center";
        # 	pinnedApps = [ ];
        # 	useApp2Unit = false;
        # 	sortByMostUsed = true;
        # 	terminalCommand = "xterm -e";
        # 	customLaunchPrefixEnabled = false;
        # 	customLaunchPrefix = "";
        # 	viewMode = "list";
        # 	showCategories = true;
        # 	iconMode = "tabler";
        # 	showIconBackground = false;
        # 	ignoreMouseInput = false;
        # 	screenshotAnnotationTool = "";
      };
      controlCenter = {
        # 	position = "close_to_bar_button";
        # 	diskPath = "/";
        # 	shortcuts = {
        # 		left = [
        # 		{
        # 			id = "Network";
        # 		}
        # 		{
        # 			id = "Bluetooth";
        # 		}
        # 		{
        # 			id = "WallpaperSelector";
        # 		}
        # 		];
        # 		right = [
        # 		{
        # 			id = "Notifications";
        # 		}
        # 		{
        # 			id = "PowerProfile";
        # 		}
        # 		{
        # 			id = "KeepAwake";
        # 		}
        # 		{
        # 			id = "NightLight";
        # 		}
        # 		];
        # 	};
        # 	cards = [
        # 	{
        # 		enabled = true;
        # 		id = "profile-card";
        # 	}
        # 	{
        # 		enabled = true;
        # 		id = "shortcuts-card";
        # 	}
        # 	{
        # 		enabled = true;
        # 		id = "audio-card";
        # 	}
        # 	{
        # 		enabled = false;
        # 		id = "brightness-card";
        # 	}
        # 	{
        # 		enabled = true;
        # 		id = "weather-card";
        # 	}
        # 	{
        # 		enabled = true;
        # 		id = "media-sysmon-card";
        # 	}
        # 	];
      };
      systemMonitor = {
        # 	cpuWarningThreshold = 80;
        # 	cpuCriticalThreshold = 90;
        # 	tempWarningThreshold = 80;
        # 	tempCriticalThreshold = 90;
        # 	gpuWarningThreshold = 80;
        # 	gpuCriticalThreshold = 90;
        # 	memWarningThreshold = 80;
        # 	memCriticalThreshold = 90;
        # 	diskWarningThreshold = 80;
        # 	diskCriticalThreshold = 90;
        # 	cpuPollingInterval = 3000;
        # 	tempPollingInterval = 3000;
        # 	gpuPollingInterval = 3000;
        # 	enableDgpuMonitoring = false;
        # 	memPollingInterval = 3000;
        # 	diskPollingInterval = 3000;
        # 	networkPollingInterval = 3000;
        # 	loadAvgPollingInterval = 3000;
        # 	useCustomColors = false;
        # 	warningColor = "";
        # 	criticalColor = "";
        # 	externalMonitor = "resources || missioncenter || jdsystemmonitor || corestats || system-monitoring-center || gnome-system-monitor || plasma-systemmonitor || mate-system-monitor || ukui-system-monitor || deepin-system-monitor || pantheon-system-monitor";
      };
      dock = {
        # 	enabled = true;
        # position = "left";
        # 	displayMode = "auto_hide";
        backgroundOpacity = opacity;
        # 	floatingRatio = 1;
        # 	size = 1;
        # 	onlySameOutput = true;
        # 	monitors = [ ];
        # 	pinnedApps = [ ];
        # 	colorizeIcons = false;
        # 	pinnedStatic = false;
        # 	inactiveIndicators = false;
        # 	deadOpacity = 0.6;
        # 	animationSpeed = 1;
      };
      network = {
        # 	wifiEnabled = true;
        # 	bluetoothRssiPollingEnabled = false;
        # 	bluetoothRssiPollIntervalMs = 10000;
        # 	wifiDetailsViewMode = "grid";
        # 	bluetoothDetailsViewMode = "grid";
        # 	bluetoothHideUnnamedDevices = false;
      };
      sessionMenu = {
        enableCountdown = false;
        # 	countdownDuration = 10000;
        # 	position = "center";
        # 	showHeader = true;
        # 	largeButtonsStyle = false;
        # 	largeButtonsLayout = "grid";
        # 	showNumberLabels = true;
        # 	powerOptions = [
        # 	{
        # 		action = "lock";
        # 		enabled = true;
        # 	}
        # 	{
        # 		action = "suspend";
        # 		enabled = true;
        # 	}
        # 	{
        # 		action = "hibernate";
        # 		enabled = true;
        # 	}
        # 	{
        # 		action = "reboot";
        # 		enabled = true;
        # 	}
        # 	{
        # 		action = "logout";
        # 		enabled = true;
        # 	}
        # 	{
        # 		action = "shutdown";
        # 		enabled = true;
        # 	}
        # 	];
      };
      notifications = {
        # 	enabled = true;
        # 	monitors = [ ];
        # 	location = "top_right";
        # 	overlayLayer = true;
        backgroundOpacity = opacity;
        # 	respectExpireTimeout = false;
        # 	lowUrgencyDuration = 3;
        # 	normalUrgencyDuration = 8;
        # 	criticalUrgencyDuration = 15;
        # 	enableKeyboardLayoutToast = true;
        # 	saveToHistory = {
        # 		low = true;
        # 		normal = true;
        # 		critical = true;
        # 	};
        # 	sounds = {
        # 		enabled = false;
        # 		volume = 0.5;
        # 		separateSounds = false;
        # 		criticalSoundFile = "";
        # 		normalSoundFile = "";
        # 		lowSoundFile = "";
        # 		excludedApps = "discord,firefox,chrome,chromium,edge";
        # 	};
        # 	enableMediaToast = false;
      };
      osd = {
        # 	enabled = true;
        # 	location = "top_right";
        # 	autoHideMs = 2000;
        # 	overlayLayer = true;
        backgroundOpacity = opacity;
        # 	enabledTypes = [
        # 		0
        # 			1
        # 			2
        # 	];
        # 	monitors = [ ];
      };
      audio = {
        # 	volumeStep = 5;
        # 	volumeOverdrive = false;
        # 	cavaFrameRate = 30;
        # 	visualizerType = "linear";
        # 	mprisBlacklist = [ ];
        # 	preferredPlayer = "";
      };
      brightness = {
        # 	brightnessStep = 5;
        # 	enforceMinimum = true;
        # 	enableDdcSupport = false;
      };
      colorSchemes = {
        # 	useWallpaperColors = false;
        # 	predefinedScheme = "Noctalia (default)";
        # 	darkMode = true;
        # 	schedulingMode = "off";
        # 	manualSunrise = "06:30";
        # 	manualSunset = "18:30";
        # 	matugenSchemeType = "scheme-fruit-salad";
      };
      templates = {
        # 	activeTemplates = [ ];
        # 	enableUserTemplates = false;
      };
      nightLight = {
        # 	enabled = false;
        # 	forced = false;
        # 	autoSchedule = true;
        # 	nightTemp = "4000";
        # 	dayTemp = "6500";
        # 	manualSunrise = "06:30";
        # 	manualSunset = "18:30";
      };
      hooks = {
        # 	enabled = false;
        # 	wallpaperChange = "";
        # 	darkModeChange = "";
        # 	screenLock = "";
        # 	screenUnlock = "";
        # 	performanceModeEnabled = "";
        # 	performanceModeDisabled = "";
        # 	session = "";
      };
      desktopWidgets = {
        # 	enabled = false;
        # 	gridSnap = false;
        # 	monitorWidgets = [ ];
      };
    };
  };
}
