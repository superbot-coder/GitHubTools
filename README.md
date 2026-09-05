# GitHubTools

### Мини библиотека на Delphi это инструменты для работы с GitHub: поиск репозиториев. 

![SreenShot](images/GitHubTools.png.png)

## **Модуль интерфейсов GitHub.FinderIntf.pas**

####  **IRepositoriesFineder**- Интерфейс для поиска новых репозиториев в заданном диапазоне дат.
 
| **Название метода**                                                                                                                                                               | **описание**                                                                                                                                |
| --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------- |
| `function CustomUrl(const AUrl: string): IRepositoriesFinder`                                                                                                                     | Функция, которая позволяет задать свой Url (не обязательная)                                                                                |
| `function DateRange(const ABeginDate, AEndDate: string): IRepositoriesFinder; overload`<br>`function DateRange(const ABegindate, AEndDate: TDate): IRepositoriesFinder; overload` | Задет диапазон дат в формате string<br>'YYYY-MM-DD' так и в формате TDate                                                                   |
| `function Get: IFoundResponse`                                                                                                                                                    | Выполняет собственно сам запрос и возвращает результат в **`IFoundResponse`**                                                               |
| `function GetUrl: string`                                                                                                                                                         | Возвращает текущий Url                                                                                                                      |
| `function Language(const ALanguage: string): IRepositoriesFinder`                                                                                                                 | Задает параметр языка поиска репозитория, т.е. на каком языке программирования разработан проект: Delphi, Python, JAVA, JS, C/C++/C# и т.д. |
| `function Timeout(const ATimeout: integer): IRepositoriesFinder`                                                                                                                  | Изменяет параметр во внутреннем классе `RESTClient.ReadTimeout`                                                                             |
| `function Token(const AToken: string): IRepositoriesFinder`                                                                                                                       | Устанавливает токен авторизации полученный в личном кабинете GitHub                                                                         |
| `function UserAgent(const AUserAgent: string): IRepositoriesFinder`                                                                                                               | Позволяет изменить UserAgent, который установлен по умолчанию                                                                               |

#### **IFoundResponse** - Интерфейс в который возвращается результат, основной ответ должен приходить в формате JSON

| **Название метода / свойства**           | **описание**                                                                            |
| ---------------------------------------- | --------------------------------------------------------------------------------------- |
| `function JSONValue: TJSONValue`         | Возвращает весь ответ целиком от GitHub                                                 |
| `function RepositoriesArray: TJSONArray` | Возвращает Только ту часть где сам массив найденными репозиториями                      |
| `property RESTResponse: TRESTResponse`   | Свойство, которое возвращает ссылку на внутренний экземпляр объект класса TRESTResponse |

---
# Модуль  **GitHub.ResponseTypes.pas** 

#### **TRepositoryInfo** - Класс  который содержит все поля с данными которые передаются в поисковом ответе GitHub  

### **Пример 1 / example 1:**

```pascal
//...................
var 
  ReposList: TObjectList<TJSONObject>;  
//...................  
  // Глобальный список для объектов TJSONObject  
  ReposList := TObjectList<TJSONObject>.Create;
//...................

procedure TForm1.BtnTestClick(Sender: TObject);
var
  ReposFinder: IRepositoriesFinder;
  Resp: IFoundResponse;
  LReposArray: TJSONArray;
begin
  Url := 'https://api.github.com/search/repositories?' +                                    'q=language:Delphi+created:2026-01-01..2026-09-11&per_page=100';
  ReposFinder := TRepositoriesFinder.Create;
  // в качестве примера настраиваем все параметры
  Resp := ReposFinder.UserAgent('Repositories-Finder') // Не обязательный                               // Если параметр не задать то по умочанию будет текущая дата
                     .DateRange('2026-01-01', '2026-01-10')
                     // Если не задать то по умолчанию парметр Delphi
                     .Language('Delphi') 
                     // Если парметр не задать то по умолчанию 5000
                     .Timeout(2000)
                     // не обязательный параметр, если не задать? то соединение                         // будет без авторизации с ограничениями
                     .Token('ghp_XXXXXXXXXXSJQSaaU8SYURMzPsXXXXXXXXXX')
                     // не обязательный пармет, нужен если нужно изменить значения                      // по умолчанию на свой особенный Url 
                     // с расширенными параметрами
                     .CustomUrl(Url)
                     // Выпоняет запрос и возвращает результат в IFoundResponse
                     .Get; 
                     
  LReposArray := Resp.RepositoriesArray;
  if Assigned(LReposArray) then
  begin
    show('ReposArray.Count: ' + LReposArray.Count.ToString);

    for var i := 0 to LReposArray.Count -1  do
    begin 
      // Если данные будут выходить за пределы видимости этой процедуры,
      // то их нужно клонировать потому что JSON будет уничтожен вместе 
      // с объектом интерфейса
      ReposList.Add(TJSONObject(LReposArray[i].Clone));
    end;
  end else
    show('ReposArray = Nil');
end;
```

### **Пример 2 / example 2**

Использование IRepositoriesFinder с неявным (скрытым)  использованием  конструктора

```pascal

var DtBgn := StrToDate('01.01.2026'); // TDate
var DtEnd := StrToDate('03.01.2026'); // TDate

var Response := TRepositoriesFinder.New.DateRange(DtBgn, DtEnd).Get;
                                   
``` 

### **Пример 3 / Example 3 (Десериализация/ Deserialization)** 

Десериализация данных в объект класса **TRepositoryInfo**

```pascal
// модули, которые потребуются
USES 
   REST.Json, GitHub.ResponseTypes;

// .............
var ReposInfo := TResponseInfo;
var Response := TRepositoriesFinder.New.DateRange(DtBgn, DtEnd).Get;
var LReposArray := Resp.RepositoriesArray;

if Assigned(LReposArray) then
begin
  if LReposArray.Count > 0 then
  begin
      // Метод, который сериализует TJSONObject в TFoundRepository
	  RespInfo := TJson.JsonToObject<TFoundRepository>(LReposArray[0],
	                                [joDateIsUTC, joIndentCaseLower]);	  
      Show('HtmlUrl' + ReposInfo.HtmlUrl);                          
	  Show('FullName' + ReposInfo.FullName);
	  Show('Created' + ReposInfo.CreatedAt.ToString);
	  Show('Pushed' + ReposInfo.PushedAt.ToString);
	  Show('Updated' + ReposInfo.UpdatedAt.ToString);  
 end;                               

end;

```