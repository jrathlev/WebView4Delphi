unit uWVCoreWebView2Profile;

{$IFDEF FPC}{$MODE Delphi}{$ENDIF}

{$I webview2.inc}

interface

uses
  uWVTypeLibrary, uWVTypes;

type
  /// <summary>
  /// Provides a set of properties to configure a Profile object.
  /// </summary>
  /// <remarks>
  /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2profile">See the ICoreWebView2Profile article.</see></para>
  /// </remarks>
  TCoreWebView2Profile = class
    protected
      FBaseIntf  : ICoreWebView2Profile;
      FBaseIntf2 : ICoreWebView2Profile2;
      FBaseIntf3 : ICoreWebView2Profile3;
      FBaseIntf4 : ICoreWebView2Profile4;
      FBaseIntf5 : ICoreWebView2Profile5;
      FBaseIntf6 : ICoreWebView2Profile6;

      function GetInitialized : boolean;
      function GetProfileName : wvstring;
      function GetIsInPrivateModeEnabled : boolean;
      function GetProfilePath : wvstring;
      function GetDefaultDownloadFolderPath : wvstring;
      function GetPreferredColorScheme : TWVPreferredColorScheme;
      function GetPreferredTrackingPreventionLevel : TWVTrackingPreventionLevel;
      function GetCookieManager : ICoreWebView2CookieManager;
      function GetIsPasswordAutosaveEnabled : boolean;
      function GetIsGeneralAutofillEnabled : boolean;

      procedure SetDefaultDownloadFolderPath(const aValue : wvstring);
      procedure SetPreferredColorScheme(aValue : TWVPreferredColorScheme);
      procedure SetPreferredTrackingPreventionLevel(aValue : TWVTrackingPreventionLevel);
      procedure SetIsPasswordAutosaveEnabled(aValue : boolean);
      procedure SetIsGeneralAutofillEnabled(aValue : boolean);

      procedure InitializeFields;

    public
      constructor Create(const aBaseIntf : ICoreWebView2Profile); reintroduce;
      destructor  Destroy; override;
      /// <summary>
      /// <para>Clear browsing data based on a data type. This method takes two parameters,
      /// the first being a mask of one or more `COREWEBVIEW2_BROWSING_DATA_KINDS`. OR
      /// operation(s) can be applied to multiple `COREWEBVIEW2_BROWSING_DATA_KINDS` to
      /// create a mask representing those data types. The browsing data kinds that are
      /// supported are listed below. These data kinds follow a hierarchical structure in
      /// which nested bullet points are included in their parent bullet point's data kind.</para>
      /// <para>Ex: All DOM storage is encompassed in all site data which is encompassed in
      /// all profile data.</para><code>
      /// * All Profile
      ///   * All Site Data
      ///     * All DOM Storage: File Systems, Indexed DB, Local Storage, Web SQL, Cache
      ///         Storage
      ///     * Cookies
      ///   * Disk Cache
      ///   * Download History
      ///   * General Autofill
      ///   * Password Autosave
      ///   * Browsing History
      ///   * Settings</code>
      /// <para>The completed handler will be invoked when the browsing data has been cleared and
      /// will indicate if the specified data was properly cleared. In the case in which
      /// the operation is interrupted and the corresponding data is not fully cleared
      /// the handler will return `E_ABORT` and otherwise will return `S_OK`.</para>
      /// <para>Because this is an asynchronous operation, code that is dependent on the cleared
      /// data must be placed in the callback of this operation.</para>
      /// <para>If the WebView object is closed before the clear browsing data operation
      /// has completed, the handler will be released, but not invoked. In this case
      /// the clear browsing data operation may or may not be completed.</para>
      /// <para>ClearBrowsingData clears the `dataKinds` regardless of timestamp.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2profile2#clearbrowsingdata">See the ICoreWebView2Profile2 article.</see></para>
      /// </remarks>
      function    ClearBrowsingData(dataKinds: TWVBrowsingDataKinds; const handler: ICoreWebView2ClearBrowsingDataCompletedHandler): boolean;
      /// <summary>
      /// <para>ClearBrowsingDataInTimeRange behaves like ClearBrowsingData except that it
      /// takes in two additional parameters for the start and end time for which it
      /// should clear the data between.  The `startTime` and `endTime`
      /// parameters correspond to the number of seconds since the UNIX epoch.</para>
      /// <para>`startTime` is inclusive while `endTime` is exclusive, therefore the data will
      /// be cleared between [startTime, endTime).</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2profile2#clearbrowsingdataintimerange">See the ICoreWebView2Profile2 article.</see></para>
      /// </remarks>
      function    ClearBrowsingDataInTimeRange(dataKinds: TWVBrowsingDataKinds; const startTime, endTime: TDateTime; const handler: ICoreWebView2ClearBrowsingDataCompletedHandler): boolean;
      /// <summary>
      /// ClearBrowsingDataAll behaves like ClearBrowsingData except that it
      /// clears the entirety of the data associated with the profile it is called on.
      /// It clears the data regardless of timestamp.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2profile2#clearbrowsingdataall">See the ICoreWebView2Profile2 article.</see></para>
      /// </remarks>
      function    ClearBrowsingDataAll(const handler: ICoreWebView2ClearBrowsingDataCompletedHandler): boolean;
      /// <summary>
      /// <para>Sets permission state for the given permission kind and origin
      /// asynchronously. The change persists across sessions until it is changed by
      /// another call to `SetPermissionState`, or by setting the `State` property
      /// in `PermissionRequestedEventArgs`. Setting the state to
      /// `COREWEBVIEW2_PERMISSION_STATE_DEFAULT` will erase any state saved in the
      /// profile and restore the default behavior.</para>
      /// <para>The origin should have a valid scheme and host (e.g. "https://www.example.com"),
      /// otherwise the method fails with `E_INVALIDARG`. Additional URI parts like
      /// path and fragment are ignored. For example, "https://wwww.example.com/app1/index.html/"
      /// is treated the same as "https://wwww.example.com". See the
      /// [MDN origin definition](https://developer.mozilla.org/en-US/docs/Glossary/Origin)
      /// for more details.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2profile4#setpermissionstate">See the ICoreWebView2Profile4 article.</see></para>
      /// </remarks>
      function    SetPermissionState(PermissionKind: TWVPermissionKind; const origin: wvstring; State: TWVPermissionState; const completedHandler: ICoreWebView2SetPermissionStateCompletedHandler): boolean;
      /// <summary>
      /// Invokes the handler with a collection of all nondefault permission settings.
      /// Use this method to get the permission state set in the current and previous
      /// sessions.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2profile4#getnondefaultpermissionsettings">See the ICoreWebView2Profile4 article.</see></para>
      /// </remarks>
      function    GetNonDefaultPermissionSettings(const completedHandler: ICoreWebView2GetNonDefaultPermissionSettingsCompletedHandler): boolean;

      /// <summary>
      /// Returns true when the interface implemented by this class is fully initialized.
      /// </summary>
      property Initialized                       : boolean                     read GetInitialized;
      /// <summary>
      /// Returns the interface implemented by this class.
      /// </summary>
      property BaseIntf                          : ICoreWebView2Profile        read FBaseIntf                            write FBaseIntf;
      /// <summary>
      /// Name of the profile.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2profile#get_profilename">See the ICoreWebView2Profile article.</see></para>
      /// </remarks>
      property ProfileName                       : wvstring                    read GetProfileName;
      /// <summary>
      /// InPrivate mode is enabled or not.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2profile#get_isinprivatemodeenabled">See the ICoreWebView2Profile article.</see></para>
      /// </remarks>
      property IsInPrivateModeEnabled            : boolean                     read GetIsInPrivateModeEnabled;
      /// <summary>
      /// Full path of the profile directory.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2profile#get_profilepath">See the ICoreWebView2Profile article.</see></para>
      /// </remarks>
      property ProfilePath                       : wvstring                    read GetProfilePath;
      /// <summary>
      /// Gets the `DefaultDownloadFolderPath` property. The default value is the
      /// system default download folder path for the user.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2profile#get_defaultdownloadfolderpath">See the ICoreWebView2Profile article.</see></para>
      /// </remarks>
      property DefaultDownloadFolderPath         : wvstring                    read GetDefaultDownloadFolderPath         write SetDefaultDownloadFolderPath;
      /// <summary>
      /// <para>The PreferredColorScheme property sets the overall color scheme of the
      /// WebView2s associated with this profile. This sets the color scheme for
      /// WebView2 UI like dialogs, prompts, and context menus by setting the
      /// media feature `prefers-color-scheme` for websites to respond to.</para>
      /// <para>The default value for this is COREWEBVIEW2_PREFERRED_COLOR_AUTO,
      /// which will follow whatever theme the OS is currently set to.</para>
      /// <para>Returns the value of the `PreferredColorScheme` property.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2profile#get_preferredcolorscheme">See the ICoreWebView2Profile article.</see></para>
      /// </remarks>
      property PreferredColorScheme              : TWVPreferredColorScheme     read GetPreferredColorScheme              write SetPreferredColorScheme;
      /// <summary>
      /// <para>The `PreferredTrackingPreventionLevel` property allows you to control levels of tracking prevention for WebView2
      /// which are associated with a profile. This level would apply to the context of the profile. That is, all WebView2s
      /// sharing the same profile will be affected and also the value is persisted in the user data folder.</para>
      /// <para>See `COREWEBVIEW2_TRACKING_PREVENTION_LEVEL` for descriptions of levels.</para>
      /// <para>If tracking prevention feature is enabled when creating the WebView2 environment, you can also disable tracking
      /// prevention later using this property and `COREWEBVIEW2_TRACKING_PREVENTION_LEVEL_NONE` value but that doesn't
      /// improves runtime performance.</para>
      /// <para>There is `ICoreWebView2EnvironmentOptions5::EnableTrackingPrevention` property to enable/disable tracking prevention feature
      /// for all the WebView2's created in the same environment. If enabled, `PreferredTrackingPreventionLevel` is set to
      /// `COREWEBVIEW2_TRACKING_PREVENTION_LEVEL_BALANCED` by default for all the WebView2's and profiles created in the same
      /// environment or is set to the level whatever value was last changed/persisted to the profile. If disabled
      /// `PreferredTrackingPreventionLevel` is not respected by WebView2. If `PreferredTrackingPreventionLevel` is set when the
      /// feature is disabled, the property value get changed and persisted but it will takes effect only if
      /// `ICoreWebView2EnvironmentOptions5::EnableTrackingPrevention` is true.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2profile3#get_preferredtrackingpreventionlevel">See the ICoreWebView2Profile3 article.</see></para>
      /// </remarks>
      property PreferredTrackingPreventionLevel  : TWVTrackingPreventionLevel  read GetPreferredTrackingPreventionLevel  write SetPreferredTrackingPreventionLevel;
      /// <summary>
      /// Get the cookie manager for the profile. All CoreWebView2s associated with this
      /// profile share the same cookie values. Changes to cookies in this cookie manager apply to all
      /// CoreWebView2s associated with this profile. See ICoreWebView2CookieManager.
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2profile5#get_cookiemanager">See the ICoreWebView2Profile5 article.</see></para>
      /// </remarks>
      property CookieManager                     : ICoreWebView2CookieManager  read GetCookieManager;
      /// <summary>
      /// <para>IsPasswordAutosaveEnabled controls whether autosave for password
      /// information is enabled. The IsPasswordAutosaveEnabled property behaves
      /// independently of the IsGeneralAutofillEnabled property. When IsPasswordAutosaveEnabled is
      /// false, no new password data is saved and no Save/Update Password prompts are displayed.
      /// However, if there was password data already saved before disabling this setting,
      /// then that password information is auto-populated, suggestions are shown and clicking on
      /// one will populate the fields.</para>
      /// <para>When IsPasswordAutosaveEnabled is true, password information is auto-populated,
      /// suggestions are shown and clicking on one will populate the fields, new data
      /// is saved, and a Save/Update Password prompt is displayed.</para>
      /// <para>It will take effect immediately after setting. The default value is `FALSE`.</para>
      /// <para>This property has the same value as
      /// `CoreWebView2Settings.IsPasswordAutosaveEnabled`, and changing one will
      /// change the other. All `CoreWebView2`s with the same `CoreWebView2Profile`
      /// will share the same value for this property, so for the `CoreWebView2`s
      /// with the same profile, their
      /// `CoreWebView2Settings.IsPasswordAutosaveEnabled` and
      /// `CoreWebView2Profile.IsPasswordAutosaveEnabled` will always have the same
      /// value.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2profile6#get_ispasswordautosaveenabled">See the ICoreWebView2Profile6 article.</see></para>
      /// </remarks>
      property IsPasswordAutosaveEnabled         : boolean                     read GetIsPasswordAutosaveEnabled         write SetIsPasswordAutosaveEnabled;
      /// <summary>
      /// <para>IsGeneralAutofillEnabled controls whether autofill for information
      /// like names, street and email addresses, phone numbers, and arbitrary input
      /// is enabled. This excludes password and credit card information. When
      /// IsGeneralAutofillEnabled is false, no suggestions appear, and no new information
      /// is saved. When IsGeneralAutofillEnabled is true, information is saved, suggestions
      /// appear and clicking on one will populate the form fields.</para>
      /// <para>It will take effect immediately after setting. The default value is `TRUE`.</para>
      /// <para>This property has the same value as
      /// `CoreWebView2Settings.IsGeneralAutofillEnabled`, and changing one will
      /// change the other. All `CoreWebView2`s with the same `CoreWebView2Profile`
      /// will share the same value for this property, so for the `CoreWebView2`s
      /// with the same profile, their
      /// `CoreWebView2Settings.IsGeneralAutofillEnabled` and
      /// `CoreWebView2Profile.IsGeneralAutofillEnabled` will always have the same
      /// value.</para>
      /// </summary>
      /// <remarks>
      /// <para><see href="https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2profile6#get_isgeneralautofillenabled">See the ICoreWebView2Profile6 article.</see></para>
      /// </remarks>
      property IsGeneralAutofillEnabled          : boolean                     read GetIsGeneralAutofillEnabled          write SetIsGeneralAutofillEnabled;
  end;

implementation

uses
  {$IFDEF DELPHI16_UP}
  System.DateUtils, Winapi.ActiveX,
  {$ELSE}
  DateUtils, ActiveX,
  {$ENDIF}
  uWVMiscFunctions;

constructor TCoreWebView2Profile.Create(const aBaseIntf: ICoreWebView2Profile);
begin
  inherited Create;

  InitializeFields;

  FBaseIntf  := aBaseIntf;

  if Initialized and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2Profile2, FBaseIntf2) and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2Profile3, FBaseIntf3) and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2Profile4, FBaseIntf4) and
     LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2Profile5, FBaseIntf5) then
    LoggedQueryInterface(FBaseIntf, IID_ICoreWebView2Profile6, FBaseIntf6);
end;

destructor TCoreWebView2Profile.Destroy;
begin
  InitializeFields;

  inherited Destroy;
end;

procedure TCoreWebView2Profile.InitializeFields;
begin
  FBaseIntf  := nil;
  FBaseIntf2 := nil;
  FBaseIntf3 := nil;
  FBaseIntf4 := nil;
  FBaseIntf5 := nil;
  FBaseIntf6 := nil;
end;

function TCoreWebView2Profile.GetInitialized : boolean;
begin
  Result := assigned(FBaseIntf);
end;

function TCoreWebView2Profile.GetProfileName : wvstring;
var
  TempResult : PWideChar;
begin
  Result     := '';
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_ProfileName(TempResult)) and
     (TempResult <> nil) then
    begin
      Result := TempResult;
      CoTaskMemFree(TempResult);
    end;
end;

function TCoreWebView2Profile.GetIsInPrivateModeEnabled : boolean;
var
  TempResult : integer;
begin
  Result := Initialized and
            succeeded(FBaseIntf.Get_IsInPrivateModeEnabled(TempResult)) and
            (TempResult <> 0);
end;

function TCoreWebView2Profile.GetProfilePath : wvstring;
var
  TempResult : PWideChar;
begin
  Result     := '';
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_ProfilePath(TempResult)) and
     (TempResult <> nil) then
    begin
      Result := TempResult;
      CoTaskMemFree(TempResult);
    end;
end;

function TCoreWebView2Profile.GetDefaultDownloadFolderPath : wvstring;
var
  TempResult : PWideChar;
begin
  Result     := '';
  TempResult := nil;

  if Initialized and
     succeeded(FBaseIntf.Get_DefaultDownloadFolderPath(TempResult)) and
     (TempResult <> nil) then
    begin
      Result := TempResult;
      CoTaskMemFree(TempResult);
    end;
end;

function TCoreWebView2Profile.GetPreferredColorScheme : TWVPreferredColorScheme;
var
  TempResult : COREWEBVIEW2_PREFERRED_COLOR_SCHEME;
begin
  Result     := 0;
  TempResult := 0;

  if Initialized and
     succeeded(FBaseIntf.Get_PreferredColorScheme(TempResult)) then
    Result := TempResult;
end;

function TCoreWebView2Profile.GetPreferredTrackingPreventionLevel : TWVTrackingPreventionLevel;
var
  TempResult : COREWEBVIEW2_TRACKING_PREVENTION_LEVEL;
begin
  Result := COREWEBVIEW2_TRACKING_PREVENTION_LEVEL_BALANCED;

  if assigned(FBaseIntf3) and
     succeeded(FBaseIntf3.Get_PreferredTrackingPreventionLevel(TempResult)) then
    Result := TempResult;
end;

function TCoreWebView2Profile.GetCookieManager : ICoreWebView2CookieManager;
var
  TempResult : ICoreWebView2CookieManager;
begin
  Result     := nil;
  TempResult := nil;

  if assigned(FBaseIntf5) and
     succeeded(FBaseIntf5.Get_CookieManager(TempResult)) and
     assigned(TempResult) then
    Result := TempResult;
end;

function TCoreWebView2Profile.GetIsPasswordAutosaveEnabled : boolean;
var
  TempResult : integer;
begin
  Result := assigned(FBaseIntf6) and
            succeeded(FBaseIntf6.Get_IsPasswordAutosaveEnabled(TempResult)) and
            (TempResult <> 0);
end;

function TCoreWebView2Profile.GetIsGeneralAutofillEnabled : boolean;
var
  TempResult : integer;
begin
  Result := assigned(FBaseIntf6) and
            succeeded(FBaseIntf6.Get_IsGeneralAutofillEnabled(TempResult)) and
            (TempResult <> 0);
end;

procedure TCoreWebView2Profile.SetDefaultDownloadFolderPath(const aValue : wvstring);
begin
  if Initialized then
    FBaseIntf.Set_DefaultDownloadFolderPath(PWideChar(aValue));
end;

procedure TCoreWebView2Profile.SetPreferredColorScheme(aValue : TWVPreferredColorScheme);
begin
  if Initialized then
    FBaseIntf.Set_PreferredColorScheme(aValue);
end;

procedure TCoreWebView2Profile.SetPreferredTrackingPreventionLevel(aValue : TWVTrackingPreventionLevel);
begin
  if assigned(FBaseIntf3) then
    FBaseIntf3.Set_PreferredTrackingPreventionLevel(aValue);
end;

procedure TCoreWebView2Profile.SetIsPasswordAutosaveEnabled(aValue: boolean);
begin
  if assigned(FBaseIntf6) then
    FBaseIntf6.Set_IsPasswordAutosaveEnabled(ord(aValue));
end;

procedure TCoreWebView2Profile.SetIsGeneralAutofillEnabled(aValue: boolean);
begin
  if assigned(FBaseIntf6) then
    FBaseIntf6.Set_IsGeneralAutofillEnabled(ord(aValue));
end;

function TCoreWebView2Profile.ClearBrowsingData(      dataKinds : TWVBrowsingDataKinds;
                                                const handler   : ICoreWebView2ClearBrowsingDataCompletedHandler): boolean;
begin
  Result := assigned(FBaseIntf2) and
            assigned(handler)    and
            succeeded(FBaseIntf2.ClearBrowsingData(dataKinds, handler));
end;

function TCoreWebView2Profile.ClearBrowsingDataInTimeRange(      dataKinds : TWVBrowsingDataKinds;
                                                           const startTime : TDateTime;
                                                           const endTime   : TDateTime;
                                                           const handler   : ICoreWebView2ClearBrowsingDataCompletedHandler): boolean;
var
  TempStart, TempEnd : int64;
begin
  Result := False;

  if assigned(FBaseIntf2) and
     assigned(handler)    then
    begin
      TempStart := DateTimeToUnix(startTime{$IFDEF DELPHI20_UP}, False{$ENDIF});
      TempEnd   := DateTimeToUnix(endTime{$IFDEF DELPHI20_UP}, False{$ENDIF});
      Result    := succeeded(FBaseIntf2.ClearBrowsingDataInTimeRange(dataKinds, TempStart, TempEnd, handler));
    end;
end;

function TCoreWebView2Profile.ClearBrowsingDataAll(const handler: ICoreWebView2ClearBrowsingDataCompletedHandler): boolean;
begin
  Result := assigned(FBaseIntf2) and
            assigned(handler)    and
            succeeded(FBaseIntf2.ClearBrowsingDataAll(handler));
end;

function TCoreWebView2Profile.SetPermissionState(      PermissionKind   : TWVPermissionKind;
                                                 const origin           : wvstring;
                                                       State            : TWVPermissionState;
                                                 const completedHandler : ICoreWebView2SetPermissionStateCompletedHandler): boolean;
begin
  Result := assigned(FBaseIntf4)       and
            assigned(completedHandler) and
            succeeded(FBaseIntf4.SetPermissionState(PermissionKind, PWideChar(origin), State, completedHandler));
end;

function TCoreWebView2Profile.GetNonDefaultPermissionSettings(const completedHandler: ICoreWebView2GetNonDefaultPermissionSettingsCompletedHandler): boolean;
begin
  Result := assigned(FBaseIntf4)       and
            assigned(completedHandler) and
            succeeded(FBaseIntf4.GetNonDefaultPermissionSettings(completedHandler));
end;

end.

