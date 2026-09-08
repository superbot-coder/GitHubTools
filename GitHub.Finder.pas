(*
    My Projects: https://github.com/superbot-coder?tab=repositories
    Telegram channel: https://t.me/delphi_solutions
    Telegram chat: https://t.me/delphi_solutions_chat
    Date: 2026.09.03
 *)

unit GitHub.Finder;

interface

USES
  System.SysUtils, System.Generics.Collections, System.JSON, REST.Client,
  REST.Json, REST.Types, GitHub.FinderIntf;

Type

  TFoundResponse = class(TInterfacedObject, IFoundResponse)
  private
    FRESTResponse: TRESTResponse;
    FJSONArray: TJSONArray;
    function GetResponse: TRESTResponse;
  public
    constructor Create;
    destructor Destroy; override;
    function JSONValue: TJSONValue;
    function RepositoriesArray: TJSONArray;
    property RESTResponse: TRESTResponse read GetResponse;
  end;


  TRepositoriesFinder = class(TInterfacedObject, IRepositoriesFinder)
  private
    FBeginDate: string;
    FDateRangeEnabled: boolean;
    FEndDate: string;
    FLanguage: string;
    FSearch: string;
    FCreated: string;
    FRESTClient: TRESTClient;
    FRESTRequest  : TRESTRequest;
    function RemoveSpeace(const ValueStr: string): string;
    function UrlBuild: string;
  public
    constructor Create;
    destructor Destroy; override;
    function Get: IFoundResponse;
    function CustomUrl(const AUrl: string): IRepositoriesFinder;
    function DateRange(const ABeginDate, AEndDate: string): IRepositoriesFinder; overload;
    function DateRange(const ABegindate, AEndDate: TDate): IRepositoriesFinder; overload;
    function DateRangeEnabled(Value: Boolean): IRepositoriesFinder;
    function GetUrl: string;
    function Language(const ALanguage: string): IRepositoriesFinder;
    function Search(const ASearchStr: string): IRepositoriesFinder;
    function Timeout(const ATimeout: integer): IRepositoriesFinder;
    function Token(const AToken: string): IRepositoriesFinder;
    function UserAgent(const AUserAgent: string): IRepositoriesFinder;
    class function New: IRepositoriesFinder; static;
  end;

implementation

  Uses Unit1;

{ TRepositoriesFinder }

constructor TRepositoriesFinder.Create;
begin
  inherited Create;
  FBeginDate := FormatDateTime('yyyy-mm-dd', Now);
  FEndDate   := FormatDateTime('yyyy-mm-dd', Now);
  FCreated   := '+Created:' + FBeginDate + '..' + FEndDate;
  FDateRangeEnabled := false;
  FLanguage  := '';

  FRESTClient := TRESTClient.Create(Nil);
  FRESTRequest := TRESTRequest.Create(Nil);
  FRESTRequest.Client := FRESTClient;

  FRESTClient.ReadTimeout := 5000;
  FRESTClient.UserAgent := 'Repositories Finder';
  FRESTClient.Accept := 'application/vnd.github.v3+json'; //CONTENTTYPE_APPLICATION_JSON;
  FRESTClient.BaseURL := UrlBuild;

end;

destructor TRepositoriesFinder.Destroy;
begin
  FRESTClient.Free;
  FRESTRequest.Free;
  inherited Destroy;
end;

function TRepositoriesFinder.Get: IFoundResponse;
var
  FoundResponse: TFoundResponse;
begin
  Result := TFoundResponse.Create;
  FRESTRequest.Response := Result.RESTResponse;
  FRESTRequest.Execute;
end;

function TRepositoriesFinder.GetUrl: string;
begin
  Result := FRESTClient.BaseURL;
end;

function TRepositoriesFinder.CustomUrl(
  const AUrl: string): IRepositoriesFinder;
begin
  Result := Self;
  FRESTClient.BaseURL := AUrl;
end;

function TRepositoriesFinder.DateRange(const ABeginDate,
  AEndDate: TDate): IRepositoriesFinder;
begin
  Result := Self;
  FCreated := '+Created:' + FormatDateTime('yyyy-mm-dd', ABeginDate) + '..' +
                            FormatDateTime('yyyy-mm-dd', AEndDate);
  FRESTClient.BaseURL := UrlBuild;
end;

function TRepositoriesFinder.DateRangeEnabled(
  Value: Boolean): IRepositoriesFinder;
begin
  FDateRangeEnabled := Value;
end;

function TRepositoriesFinder.DateRange(const ABeginDate,
  AEndDate: string): IRepositoriesFinder;
begin
  Result := Self;
  FCreated   := '+created:' + ABeginDate + '..' + AEndDate;
  FRESTClient.BaseURL := UrlBuild;
end;

function TRepositoriesFinder.Language(
  const ALanguage: string): IRepositoriesFinder;
begin
  Result := Self;
  if ALanguage.IsEmpty then
    FLanguage := ''
  else
    FLanguage := '+language:' + ALanguage;
  FRESTClient.BaseURL := UrlBuild;
end;

class function TRepositoriesFinder.New: IRepositoriesFinder;
begin
  Result := TRepositoriesFinder.Create;
end;

function TRepositoriesFinder.RemoveSpeace(const ValueStr: string): string;
begin
  Result := '';
  var AList := ValueStr.Trim.Split([' ']);
  for var i:=0 to High(AList) do
  begin
    if AList[i].IsEmpty then
      Continue;
    if i = 0 then
      Result := Result + Alist[i]
    else
      Result := Result + '+' + Alist[i];
  end;
end;

function TRepositoriesFinder.Search(
  const ASearchStr: string): IRepositoriesFinder;
begin
  FSearch := RemoveSpeace(ASearchStr);
  FRESTClient.BaseURL := UrlBuild;
end;

function TRepositoriesFinder.Timeout(const ATimeout: integer): IRepositoriesFinder;
begin
  Result := Self;
  if ATimeout > 300000 then
    FRESTClient.ReadTimeout := 300000
  else
    FRESTClient.ReadTimeout :=  ATimeout;
end;

function TRepositoriesFinder.Token(const AToken: string): IRepositoriesFinder;
begin
  Result := Self;
  if Atoken.IsEmpty then
    FRESTRequest.Params.Delete('Authorization')
  else
    FRESTRequest.Params.AddHeader('Authorization', 'Bearer ' + AToken);
end;

function TRepositoriesFinder.UrlBuild: string;
var
  LCreated: String;
begin
  LCreated := '';
  if FDateRangeEnabled then
    LCreated := FCreated;

  Result := Format('https://api.github.com/search/repositories?q=%s%s%s&sort=created&order=desc',
                                  [FSearch, FLanguage, LCreated]);
end;

function TRepositoriesFinder.UserAgent(
  const AUserAgent: string): IRepositoriesFinder;
begin
  Result := Self;
  FRESTClient.UserAgent := AUserAgent;
end;

{ TResponseFinder }

constructor TFoundResponse.Create;
begin
  inherited Create;
  FRESTResponse := TRESTResponse.Create(Nil);
  FJSONArray := Nil;
end;

destructor TFoundResponse.Destroy;
begin
  FRESTResponse.Free;
  inherited Destroy;
end;

function TFoundResponse.GetResponse: TRESTResponse;
begin
  Result := FRESTResponse;
end;

function TFoundResponse.JSONValue: TJSONValue;
begin
  Result := RESTResponse.JSONValue;
end;

function TFoundResponse.RepositoriesArray: TJSONArray;
begin
  Result := Nil;
  if Assigned(FJSONArray) then
  begin
    Result := FJSONArray;
  end else
  begin
    if Assigned(RESTResponse.JSONValue) then
    begin
      var LJSA: TJSONArray;
      if RESTResponse.JSONValue.TryGetValue<TJSONArray>('items', LJSA)
         and (LJSA is TJSONArray) then
      begin
        FJSONArray := LJSA;
        Result := LJSA;
      end;
    end;
  end;
end;

end.
