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
Burada kullanılan % karakteri 0, 1 veya daha fazla karakteri temsil eder. _ karakteri ise sadece 1 karakteri temsil eder.

------------------------------------------------------------------------------------------------------------------------------------------------------
+ ILIKE operatörü ;

LIKE operatörünün case - insensitive versiyonudur.

------------------------------------------------------------------------------------------------------------------------------------------------------
+ SELECT DISTINCT operatörü ;

SELECT DISTINCT rental_rate FROM film;

Bu operatör istenilen sütunda/sütunlarda birbirini tekrar eden veriler görülmek istenmediğinde kullanılır.
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

Bu operatör istenilen koşulları sağlayan verilerin tamamı değil, belirli sayıda olanlar sıralanmak istenirse kullanılır.
Yukarıdaki sorguda da görüldüğü gibi önce koşullamayı, sonra gruplamayı, en son ise LIMIT kullanılarak istenilen veri sayısı belirtilir.

--------------------------------------------------------------------------------------------------------------------------------------------------------
+ OFFSET operatörü ;

SELECT *FROM film
WHERE title LIKE 'B%'
ORDER BY length DESC
OFFSET 6
LIMIT 4;

Yukarıdaki sorguda film tablosunda B ile başlayan filmler uzunluklarına göre sıralanırken, en uzun 6 film pass geçilip sonrasındaki 4 film sıralanır.

--------------------------------------------------------------------------------------------------------------------------------------------------------
+ Aggregate Funcs: AVG, SUM, MAX, MIN ;

Aggregate fonksiyonları ile "Toplam kaç adet müşterimiz var? Elimizde bulunan filmlerin ortalama uzunluğu nedir?" gibi sorulara veri kümelerimizden sonuçlar çıkararak cevap buluruz.
Yani bu fonksiyonlar belirli veri kümelerinden tek bir sonuç çıkartırlar.

SELECT AVG(length) FROM film;

AVG fonksiyonunu kullanılan sayısal değerlerden oluşan sütunun ortalama değerini alır.

SELECT SUM(length) FROM film;

SUM fonksiyonunu kullanılan sayısal değerlerden oluşan sütunun toplam değerini alır.

SELECT MAX(length) FROM film;

MAX fonksiyonunu kullanılan sayısal değerlerden oluşan sütunun en yüksek değerini alır.
 
SELECT MIN(length) FROM film; 
 
MIN fonksiyonunu kullanılan sayısal değerlerden oluşan sütunun en düşük değerini alır.

--------------------------------------------------------------------------------------------------------------------------------------------------------
+ GROUP BY operatörü ;

Sorgular yapılırken genel olarak tüm veri kümesinin tamamı üzerine düşündük ancak bazen aynı sonuçlar veri kümesinin içerisinde bulunan farklı gruplarda da bulmak istenebilir.
Örneğin dvdrental veritabanında rental_rate sütununda bizim 3 farklı değer var(0.99, 2.99, 4.99). Bu 3 farklı değer için en uzun filmi bulmaya çalışalım;

SELECT MAX(length) FROM film
WHERE rental_rate = 0.99;
SELECT MAX(length) FROM film
WHERE rental_rate = 2.99;
SELECT MAX(length) FROM film
WHERE rental_rate = 4.99;

İstenilen sonuçlar elde edilir ancak şöyle bir sorun var: 3 farklı değer yerine 30 farklı değer olsaydı? 
İşte bu şekilde senaryolar için, yani verileri gruplama için GROUP BY anahtar kelimesi kullanılır.

SELECT rental_rate, MAX(length) FROM film
GROUP BY rental_rate;

SELECT anahtar kelimesinde bulunan sütunların, GROUP BY anahtar kelimesi içerisinde bulunması gerekir.
Özetle GROUP BY operatörü söz dizimi aşağıdaki gibidir ;

SELECT <sütun_adı>, <sütun_adı>, ... (veya aggregate func) FROM <tablo_adı>
GROUP BY <sütun_adı>, <sütun_adı>, ...

-------------------------------------------------------------------------------------------------------------------------------------------------------
+ HAVING operatörü ;

SELECT rental_rate, COUNT(*) FROM film
GROUP BY rental_rate
HAVING COUNT(*) > 325;

Bu operatör sayesinde gruplandırılmış verilere koşullar eklenebilir. 
Koşul eklenmesi için akla ilk olarak WHERE operatörü gelir ancak WHERE operatörü ile satır bazlı koşullar verilebiliyor.
HAVING operatörü ile ise grup bazlı koşullar verilebiliyor.

-------------------------------------------------------------------------------------------------------------------------------------------------------
+ ALIAS (AS) operatörü ;

SELECT <sütun_adı> AS <geçici_ad> FROM <tablo_adı>;

SELECT <sütun_adı>, <sütun_adı>... FROM <tablo_adı> AS <geçici_ad>;

AS operatörü ile sorgular sonucu oluşturulan sanal tablo ve sütunlara geçici isimler verilebilir.

