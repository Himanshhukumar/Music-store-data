/*Q-1: what are top 3 values of total invoice WITH COURTNEY NAME? */

SELECT billing_country, total
FROM INVOICe
ORDER BY total DESC
LIMIT 3;




/* Q-2: which 5 countries have the most invoices? */

SELECT COUNT (billing_country) AS c, billing_country
FROM invoice
GROUP BY billing_country
ORDER BY c DESC
LIMIT 5;



/*Q-3: who is the senfor most employee according to levels also show job title? */

SELECT first_name, last_name, title
FROM employee
ORDER BY levels DESC 
LIMIT 1; 



/* Q-4; show the last 7 artist id, name with song title? */ 

SELECT a.artist_id, b.name, a.title
FROM album AS a 
LEFT JOIN artist AS b
ON a.artist_id = b.artist_id
GROUP BY a.artist_id, b.name, a.title
ORDER BY artist_id desc
LIMIT 7; 




/* Q-5: which city has the best customers? we would like to throw a promotion
music festival in the city we made the most money.
write a quary that returns one city that has the highest sum of invoice totals.
return both the city name and sum of all invoice totals. */


SELECT SUM(total) AS invoice_total, billing_city
FROM invoice
GROUP BY billing_city
ORDER BY invoice_total DESC
LIMIT 1;
	



/* Q-6: who is the best customer? the customer who has spent the most money 
will be declred the best customer. write a query that returns the person who has spent the most money. */


SELECT customer.customer_id, customer.first_name, customer.last_name, SUM(invoice.total) AS total_spent
FROM customer
JOIN invoice
ON customer.customer_id = invoice.customer_id
GROUP BY customer.customer_id
ORDER BY total_spent DESC
LIMIT 1;




/* Q-7: write query to return the e-mail, first name, last name and genre
of all rock music listeners.
return your list ordered alphabetically by e-mail starting with A. */


SELECT Email, first_name, last_name
FROM customer
JOIN invoice 
ON customer.customer_id = invoice.customer_id
JOIN invoice_line
ON invoice.invoice_id =invoice_line.invoice_id
WHERE track_id IN(
	SELECT track_id
	FROM track
	JOIN genre
	ON track.genre_id= genre.genre_id
	WHERE genre.name like 'rock'
	)
	ORDER BY EMAIL;

  
  
/* Q-8: find how much amount spent by each customer on artists?
write a query to return customer name, artist name and total spent. */

WITH higher_selling_artist AS(
	SELECT artist.artist_id AS artist_id, artist.name AS artist_name,
	SUM(INVOICE_LINE.UNIT_PRICE*INVOICE_LINE.quantity) AS total_sale
	FROM INVOICE_LINE
	JOIN track ON track.track_id = invoice_line.track_id
	JOIN album ON album.album_id = track.album_id
	JOIN artist ON artist.artist_id = album.artist_id
	GROUP BY 1
	ORDER BY 3 DESC
	LIMIT 1
)
SELECT C.customer_id, c.first_name, c.last_name, hsa.artist_name,
SUM(il.unit_price*il.quantity) AS amount_spent
FROM invoice i
JOIN customer c ON c.customer_id = i.customer_id
JOIN invoice_line il ON il.invoice_id = i.invoice_id
JOIN track t ON t.track_id = il.track_id
JOIN album alb ON alb.album_id = t.album_id
JOIN higher_selling_artist hsa ON hsa.artist_id = alb.artist_id
GROUP BY 1,2,3,4
ORDER BY 5 DESC;
 
  
  
  
  
  
  
  
  