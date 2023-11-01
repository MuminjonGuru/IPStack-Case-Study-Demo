unit IPStackCaseStudyDemo.UnitMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, REST.Types,
  REST.Client, Data.Bind.Components, Data.Bind.ObjectScope, FMX.TabControl,
  System.Actions, FMX.ActnList, FMX.Gestures, FMX.Effects, FMX.Objects,
  FMX.StdCtrls, FMX.Controls.Presentation, FMX.ListBox, FMX.Layouts;

type
  TForm1 = class(TForm)
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabControl2: TTabControl;
    TabItem5: TTabItem;
    ToolBar1: TToolBar;
    btnNext: TSpeedButton;
    lblTitle1: TLabel;
    Label1: TLabel;
    SpeedButton1: TSpeedButton;
    CalloutRectangle1: TCalloutRectangle;
    ShadowEffect1: TShadowEffect;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    TabItem6: TTabItem;
    ToolBar2: TToolBar;
    lblTitle2: TLabel;
    btnBack: TSpeedButton;
    TabItem2: TTabItem;
    ToolBar3: TToolBar;
    lblTitle3: TLabel;
    TabItem3: TTabItem;
    ToolBar4: TToolBar;
    lblTitle4: TLabel;
    TabItem4: TTabItem;
    ToolBar5: TToolBar;
    lblTitle5: TLabel;
    Lang1: TLang;
    GestureManager1: TGestureManager;
    ActionList1: TActionList;
    NextTabAction1: TNextTabAction;
    PreviousTabAction1: TPreviousTabAction;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    StyleBook1: TStyleBook;
    ListBox1: TListBox;
    ListBoxItem1: TListBoxItem;
    ListBoxItem2: TListBoxItem;
    ListBoxItem3: TListBoxItem;
    ListBoxItem4: TListBoxItem;
    ListBox2: TListBox;
    ListBoxItem5: TListBoxItem;
    ListBoxItem6: TListBoxItem;
    ListBoxItem7: TListBoxItem;
    ListBoxItem8: TListBoxItem;
    ListBox3: TListBox;
    ListBoxItem9: TListBoxItem;
    ListBoxItem10: TListBoxItem;
    ListBoxItem11: TListBoxItem;
    ListBoxItem12: TListBoxItem;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure SpeedButton1Click(Sender: TObject);
    procedure GestureDone(Sender: TObject; const EventInfo: TGestureEventInfo;
      var Handled: Boolean);
  private
    { Private declarations }
    FGlobalCountryCode: String;
  public
    { Public declarations }
    procedure CheckUserAddress;
    procedure DisplayAirbnbFeatures(const CountryCode: string);
    procedure UpdatePricingAndAvailability(const CountryCode: string);
    function ConfirmListingLocation(const Listing: TListing; HostIPAddress: string; GPSLat: Double; GPSLon: Double; WiFiSignals: array of string): Boolean;
  end;

type
  TCountryPricing = record
    CountryCode: string;
    ProductPrice: Currency;
    ProductAvailability: Boolean;
  end;

const
  PricingData: array[1..3] of TCountryPricing = (
    (CountryCode: 'US'; ProductPrice: 99.99; ProductAvailability: True),
    (CountryCode: 'FR'; ProductPrice: 89.99; ProductAvailability: True),
    (CountryCode: 'IN'; ProductPrice: 79.99; ProductAvailability: False)
  );

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses
  System.JSON;



procedure TForm1.CheckUserAddress;
begin
  // init parameters
  RESTClient1.ResetToDefaults;
  RESTClient1.Accept := 'application/json';
  RESTClient1.AcceptCharset := 'UTF-8, *;q=0.8';
  RESTClient1.BaseURL := Format('http://api.ipstack.com/check?access_key=%s',
    ['afd8c877c16bbb9da45e20b2edc90ea3']);

  // send API endpoint request
  RESTRequest1.Execute;

  // parse the country code from the response
  var JSONValue := TJSONObject.ParseJSONValue(RESTResponse1.Content);
  try
    if JSONValue is TJSONObject then
    begin
      Label1.Text := 'You are from: ' + JSONValue.GetValue<String>
        ('country_code');
      FGlobalCountryCode := JSONValue.GetValue<String>('country_code');

      // use the functions after you have the flag !

    end;
  finally
    JSONValue.Free;
  end;
end;

procedure TForm1.DisplayAirbnbFeatures(const CountryCode: string);
begin
  if CountryCode = 'US' then
  begin
    // Show experiences and wish lists specific to the US
//    ShowUSExperiences();
//    ShowUSWishLists();
  end
  else if CountryCode = 'FR' then
  begin
    // Show experiences and wish lists specific to France
//    ShowFranceExperiences();
//    ShowFranceWishLists();
  end
  // ... Add more countries as needed
  else
  begin
    // Default or global experiences and wish lists
//    ShowDefaultExperiences();
//    ShowDefaultWishLists();
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  TabControl1.ActiveTab := TabItem1;
end;

procedure TForm1.FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkHardwareBack then
  begin
    if (TabControl1.ActiveTab = TabItem1) and (TabControl2.ActiveTab = TabItem6)
    then
    begin
      TabControl2.Previous;
      Key := 0;
    end;
  end;
end;

procedure TForm1.GestureDone(Sender: TObject;
  const EventInfo: TGestureEventInfo; var Handled: Boolean);
begin
  case EventInfo.GestureID of
    sgiLeft:
      begin
        if TabControl1.ActiveTab <> TabControl1.Tabs[TabControl1.TabCount - 1]
        then
          TabControl1.ActiveTab := TabControl1.Tabs[TabControl1.TabIndex + 1];
        Handled := True;
      end;

    sgiRight:
      begin
        if TabControl1.ActiveTab <> TabControl1.Tabs[0] then
          TabControl1.ActiveTab := TabControl1.Tabs[TabControl1.TabIndex - 1];
        Handled := True;
      end;
  end;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  // lookup via IP address
  CheckUserAddress;

  // check the global property for country code
  if FGlobalCountryCode.Equals('FR') then
  begin
    LoadLangFromStrings(Lang1.LangStr['FR']);
  end
  else if FGlobalCountryCode.Equals('UZ') then
  begin
    LoadLangFromStrings(Lang1.LangStr['UZ'])
  end;
end;

procedure TForm1.UpdatePricingAndAvailability(const CountryCode: string);
var
  I: Integer;
  Found: Boolean;
begin
  Found := False;

  for I := Low(PricingData) to High(PricingData) do
  begin
    if PricingData[I].CountryCode = CountryCode then
    begin
      LabelPrice.Caption := 'Price: ' + CurrToStr(PricingData[I].ProductPrice);
      if PricingData[I].ProductAvailability then
        LabelAvailability.Caption := 'Product is available'
      else
        LabelAvailability.Caption := 'Product is not available';

      Found := True;
      Break;
    end;
  end;

  if not Found then
  begin
    // Default pricing and availability for countries not in our data
    LabelPrice.Caption := 'Price: ' + CurrToStr(109.99);
    LabelAvailability.Caption := 'Product is available';
  end;
end;

end.
