(*
    My Projects: https://github.com/superbot-coder?tab=repositories
    Telegram channel: https://t.me/delphi_solutions
    Telegram chat: https://t.me/delphi_solutions_chat
    Date: 2026.09.03
 *)

unit GitHub.Finder;

interface

USES
  System.SysUtils, System.JSON, REST.Client, REST.Json, REST.Types,
  GitHub.FinderIntf;

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
    FEndDate: string;
    FToken: string;
    FLanguage: string;
    FRESTClient: TRESTClient;
    FRESTRequest  : TRESTRequest;
    FUrl: string;
    function GetUrl: string;
    function CustomUrl(const AUrl: string): IRepositoriesFinder;
    function DateRange(const ABeginDate, AEndDate: string): IRepositoriesFinder; overload;
    function DateRange(const ABegindate, AEndDate: TDate): IRepositoriesFinder; overload;
    function Timeout(const ATimeout: integer): IRepositoriesFinder;
    function Token(const AToken: string): IRepositoriesFinder;
    function Language(const ALanguage: string): IRepositoriesFinder;
    function UserAgent(const AUserAgent: string): IRepositoriesFinder;
  public
    constructor Create;
    destructor Destroy; override;
    function Get: IFoundResponse;
    class function New: IRepositoriesFinder;
  end;

implementation

  Uses Unit1;

{ TRepositoriesFinder }

constructor TRepositoriesFinder.Create;
begin
  inherited Create;
  FBeginDate := FormatDateTime('yyyy-mm-dd', Now);
  FEndDate   := FormatDateTime('yyyy-mm-dd', Now);
  FLanguage  := 'Delphi';

  FRESTClient := TRESTClient.Create(Nil);
  FRESTRequest := TRESTRequest.Create(Nil);
  FRESTRequest.Client := FRESTClient;

  FRESTClient.ReadTimeout := 5000;
  FRESTClient.UserAgent := 'Repositories Finder';
  FRESTClient.Accept := 'application/vnd.github.v3+json'; //CONTENTTYPE_APPLICATION_JSON;
  FRESTClient.BaseURL := Format('https://api.github.com/search/repositories?' +
                                 'q=language:%s+created:%s..%s&sort=created&order=desc&per_page=100',
                                  [FLanguage, FBeginDate, FEndDate]);
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
  FBeginDate := FormatDateTime('yyyy-mm-dd', ABeginDate);
  FEndDate := FormatDateTime('yyyy-mm-dd', AEndDate);
  FRESTClient.BaseURL := Format('https://api.github.com/search/repositories?' +
                                 'q=language:%s+created:%s..%s&sort=created&order=desc&per_page=100',
                                  [FLanguage, FBeginDate, FEndDate]);
end;

function TRepositoriesFinder.DateRange(const ABeginDate,
  AEndDate: string): IRepositoriesFinder;
begin
  Result := Self;
  FBeginDate := ABeginDate;
  FEndDate   := AEndDate;
  FRESTClient.BaseURL := Format('https://api.github.com/search/repositories?' +
                                 'q=language:%s+created:%s..%s&sort=created&order=desc&per_page=100',
                                  [FLanguage, FBeginDate, FEndDate]);

end;

function TRepositoriesFinder.Language(
  const ALanguage: string): IRepositoriesFinder;
begin
  Result := Self;
  FLanguage := ALanguage;
  FRESTClient.BaseURL := Format('https://api.github.com/search/repositories?' +
                         'q=language:%s+created:%s..%s&sort=created&order=desc&per_page=100',
                          [FLanguage, FBeginDate, FEndDate]);
end;

class function TRepositoriesFinder.New: TRepositoriesFinder;
begin
  Result := TRepositoriesFinder.Create;
end;

function TRepositoriesFinder.Timeout(const ATimeout: integer): IRepositoriesFinder;
begin
  Result := Self;
  FRESTClient.ReadTimeout :=  ATimeout;
end;

function TRepositoriesFinder.Token(const AToken: string): IRepositoriesFinder;
begin
  Result := Self;
  FRESTClient.SetHTTPHeader('Authorization', 'token ' + FToken);
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
