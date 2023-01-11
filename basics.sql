+ BETWEEN operatörü ;

SELECT *FROM film
WHERE length BETWEEN 100 AND 140; 

SELECT *FROM film
WHERE length >= 100 AND length <= 140 

Yukarıdaki 2 sorgu da aynı sonucu verir.
Yani BETWEEN kullanımında belirtilen değerler aralığa dahildir.

--------------------------------------------------------------------------------------------------------------------------------------------------------
+ IN operatörü ;

SELECT *FROM film
WHERE length IN (30,60,90,120);

SELECT *FROM film
WHERE length = 30 OR length = 60 OR length = 90 OR length = 120;

Yukarıdaki 2 sorgu da aynı sonucu verir.
Yani istenilen her farklı değer için ayrı ayrı OR mantıksal operatörü kullanmak yerine istenilen değerler liste haline getirilip IN anahtar kelimesi kullanılır.

-------------------------------------------------------------------------------------------------------------------------------------------------------
+ LIKE operatörü ;

SELECT *FROM actor
WHERE first_name LIKE 'P%';

SELECT *FROM actor
WHERE first_name LIKE 'J_';

Yani 'Penelope' gibi tam eşleşme değil, belirli şablonlara uyan koşulların sağlanması istendiğinde LIKE operatörünü kullanılır.
Burada kullanılan % karakteri 0, 1 veya daha fazla karakteri temsil eder. 
_ karakteri ise sadece 1 karakteri temsil eder.

------------------------------------------------------------------------------------------------------------------------------------------------------
+ ILIKE operatörü ;

LIKE operatörünün case - insensitive versiyonudur.

------------------------------------------------------------------------------------------------------------------------------------------------------
+ SELECT DISTINCT operatörü ;

SELECT DISTINCT rental_rate FROM film;

Bu operatör istenilen sütunda/sütunlarda birbirini tekrar eden veriler görünmek istenmediğinde kullanılır.
Yani bir sütun içerisinde bulunan farklı değerleri gösterir.

------------------------------------------------------------------------------------------------------------------------------------------------------
+ COUNT fonksiyonu ;

SELECT COUNT(*) FROM actor
WHERE first_name = 'Penelope';

Yukaridaki sorgu sonucunda ismi 'Penelope' olan aktörlerin veri sayısı verilir.
Yani COUNT aggregate fonksiyonu ilgili sorgu sonucunda oluşan veri sayısını bildirir.
COUNT(*) veya COUNT(sütun_adı) aynı sonucu verir.

-------------------------------------------------------------------------------------------------------------------------------------------------------
+ ORDER BY operatörü ;

SELECT *FROM film
ORDER BY title ASC;

Yukaridaki sorguda film tablosundaki tüm sütunlar, title sütununda bulunan verilere göre artan (ASC) şekilde sıralanıyor.
ASC sıralaması zaten varsayılan olduğu için ayrı bir şekilde yazılması zorunluluğu yoktur ancak sorguyu belirginleştirmesi açısından genelde yazılır.

SELECT *FROM film
ORDER BY title ASC length DESC;

Sıralama birden fazla sütuna göre de yapılabilir. Yukarıdaki sorguda sıralama title sütununa göre artan, length sütununa göre azalan şekilde yapılıyor.

SELECT *FROM film
WHERE title LIKE 'A%'
ORDER BY title ASC length DESC;

Yukarıdaki sorguda da görüldüğü gibi sıralama işlemi koşuldan sonra yazılır. 
Özetle ORDER BY operatörü söz dizimi aşağıdaki gibidir ;

SELECT <sütun_adı>, <sütun_adı>, ... FROM <tablo_adı>
ORDER BY <sütun_adı>, <sütun_adı>, ... ASC|DESC;

--------------------------------------------------------------------------------------------------------------------------------------------------------
+ LIMIT operatörü ;

SELECT *FROM film
WHERE title LIKE 'B%'
ORDER BY length DESC
LIMIT 10;
