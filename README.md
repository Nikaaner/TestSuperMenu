# TestSuperMenu

## Задание:
#### Требования:
1. Приложение в один экран
2. Использовать Yandex Map Kit (только для отображения карты)
3. Использовать методы API (описанные ниже) для получения данных об адресах

Сделать приложение с одним экраном, где будет использоваться Yandex Map Kit и наши методы геолокации. Пользователь должен иметь возможность указать адрес на карте через поиск или тапом. Желательно выводить пользователю подсказки по ближайшему адресу.

При выполнении работы используйте координаты или адреса на территории Казахстана или России.

#### Описание API:
Поиск адреса для клиента по названию адреса:
###### Пример запроса:
```
$ curl 'https://api-dev.supermenu.kz/address/clientSearch?query=street' -i
```
###### Пример ответа:
```
HTTP/1.1 200 OK
Strict-Transport-Security: max-age=31536000 ; includeSubDomains
X-XSS-Protection: 1; mode=block
X-Frame-Options: DENY
X-Content-Type-Options: nosniff
Content-Type: application/json;charset=UTF-8
Content-Length: 2283

{
  "data" : [ {
    "id" : 307,
    "name" : "Армения, город республиканского значения Ереван, 2-й тупик улицы Ачарян, 1",
    "latitude" : 40.226162,
    "longitude" : 44.55916
  }, {
    "id" : 308,
    "name" : "Армения, город республиканского значения Ереван, 2-я улица Вардашен, 1",
    "latitude" : 40.142898,
    "longitude" : 44.538229
  }, {
    "id" : 309,
    "name" : "Армения, город республиканского значения Ереван, 2-й переулок 1-й улицы Давташен, 1",
    "latitude" : 40.216521,
    "longitude" : 44.477431
  }, {
    "id" : 310,
    "name" : "Армения, город республиканского значения Ереван, 2-я улица Еркатугаинери, 1",
    "latitude" : 40.150047,
    "longitude" : 44.511936
  }, {
    "id" : 311,
    "name" : "Армения, город республиканского значения Ереван, 2-й переулок улицы Тичина, 1",
    "latitude" : 40.184898,
    "longitude" : 44.453949
  }, {
    "id" : 312,
    "name" : "Армения, город республиканского значения Ереван, 2-й переулок улицы Церенца, 1",
    "latitude" : 40.169463,
    "longitude" : 44.454488
  }, {
    "id" : 313,
    "name" : "Армения, город республиканского значения Ереван, 1-й переулок 2-й улицы Мушаван, 1",
    "latitude" : 40.147048,
    "longitude" : 44.570245
  }, {
    "id" : 314,
    "name" : "Армения, город республиканского значения Ереван, 2-я улица Ахтанак, 1",
    "latitude" : 40.184842,
    "longitude" : 44.430153
  }, {
    "id" : 315,
    "name" : "Россия, Нижегородская область, СТ Пластик-2",
    "latitude" : 56.301629,
    "longitude" : 43.630221
  }, {
    "id" : 316,
    "name" : "Россия, Омская область, Кормиловский район, садовое товарищество Дубрава-2",
    "latitude" : 54.999625,
    "longitude" : 73.904758
  } ]
}
```
Поиск адреса для клиента по координатам адреса:
###### Пример запроса:
```
$ curl 'https://api-dev.supermenu.kz/address/clientSearch?longitude=46.0&latitude=57.0' -i
```
###### Пример ответа:
```
HTTP/1.1 200 OK
Strict-Transport-Security: max-age=31536000 ; includeSubDomains
X-XSS-Protection: 1; mode=block
X-Frame-Options: DENY
X-Content-Type-Options: nosniff
Content-Type: application/json;charset=UTF-8
Content-Length: 736

{
  "data" : [ {
    "id" : 318,
    "name" : "Hi lo-lo street 80",
    "latitude" : 57.0,
    "longitude" : 46.0
  }, {
    "id" : 319,
    "name" : "Россия, Нижегородская область, Воскресенский район",
    "latitude" : 56.823503,
    "longitude" : 45.547693
  }, {
    "id" : 320,
    "name" : "Россия, Нижегородская область",
    "latitude" : 56.312764,
    "longitude" : 44.611891
  }, {
    "id" : 321,
    "name" : "Россия, Приволжский федеральный округ",
    "latitude" : 55.485362,
    "longitude" : 51.524283
  }, {
    "id" : 322,
    "name" : "Россия",
    "latitude" : 61.698653,
    "longitude" : 99.505405
  } ]
}
```
Поиск адреса для клиента по координатам адреса (одного ближайшего):
###### Пример запроса:
```
$ curl 'https://api-dev.supermenu.kz/address/clientGeocode?longitude=46.0&latitude=57.0' -i
```
###### Пример ответа:
```
HTTP/1.1 200 OK
Strict-Transport-Security: max-age=31536000 ; includeSubDomains
X-XSS-Protection: 1; mode=block
X-Frame-Options: DENY
X-Content-Type-Options: nosniff
Content-Type: application/json;charset=UTF-8
Content-Length: 117

{
  "data" : {
    "id" : 301,
    "name" : "Hi lo-lo street 80",
    "latitude" : 57.0,
    "longitude" : 46.0
  }
}
```

## Выполнено:
Чтобы запустить нужно выполнить в терминале следующие команды:
```
git clone https://github.com/Nikaaner/TestSuperMenu.git
cd TestSuperMenu
pod install
open TestSuperMenu.xcworkspace
```
