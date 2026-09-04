(*
    My Projects: https://github.com/superbot-coder?tab=repositories
    Telegram channel: https://t.me/delphi_solutions
    Telegram chat: https://t.me/delphi_solutions_chat
    Date: 2026.09.03
 *)

unit GitHub.FinderIntf;

interface

  Uses
    System.JSON,
    REST.Client;

type

  IFoundResponse = interface(IInvokable)
  ['{828E5F67-CA81-4CFA-9B98-59412F474FDD}']
    function GetResponse: TRESTResponse;
    function JSONValue: TJSONValue;
    function RepositoriesArray: TJSONArray;
    property RESTResponse: TRESTResponse read GetResponse;
  end;

  IRepositoriesFinder = interface(IInvokable)
  ['{E419CFF7-E313-44F8-AFE7-CCF3951D1C1D}']
    function CustomUrl(const AUrl: string): IRepositoriesFinder;
    function DateRange(const ABeginDate, AEndDate: string): IRepositoriesFinder; overload;
    function DateRange(const ABegindate, AEndDate: TDate): IRepositoriesFinder; overload;
    function Get: IFoundResponse;
    function GetUrl: string;
    function Language(const ALanguage: string): IRepositoriesFinder;
    function Timeout(const ATimeout: integer): IRepositoriesFinder;
    function Token(const AToken: string): IRepositoriesFinder;
    function UserAgent(const AUserAgent: string): IRepositoriesFinder;
  end;

implementation

end.
