#Q1: Who is the senior most employee based on job title?
SELECT * FROM EMPLOYEE
ORDER BY levels DESC
LIMIT 1;

#Q2:Which countries have the most invoices?
select * from invoice;
select billing_country , count(*)as c 
FROM invoice
GROUP BY billing_country
ORDER BY c desc;

#Q3: What are the top 3 values of total invoice
SELECT total FROM invoice
ORDER BY total desc
limit 3;

-- Q4:Which city has the best customer?
-- we would like to throw a promotional music festival in the city we made the most money.
-- write a query that returns one city that has the highest sum of invoice total.
SELECT * from invoice;
select billing_city , SUM(total)as c 
FROM invoice
GROUP BY billing_city
ORDER BY c desc;

-- Q5:Who is the best customer?The customer who spent the most money will be declared the best customer.
-- Write a query that returns the person who has spent the most money.  
select * from customer;
SELECT customer.customer_id,customer.first_name,customer.last_name ,SUM(invoice.total)as total
FROM customer
JOIN invoice
ON customer.customer_id=invoice.customer_id
GROUP BY customer.customer_id,customer.first_name,customer.last_name
ORDER BY total DESC
LIMIT 1;


-- Q1: Write a query to return the email,first name,last name & Genre of all Rock music listeners.
-- Returns your list ordered alphabetically by email starting with A
SELECT DISTINCT email,first_name,last_name
FROM customer
JOIN invoice ON customer.customer_id=invoice.customer_id
JOIN invoice_line ON invoice.invoice_id=invoice_line.invoice_id
WHERE track_id IN(
	SELECT track_id FROM track
    JOIN genre ON track.genre_id=genre.genre_id
    WHERE genre.name LIKE 'ROCK'
)
ORDER BY email ASC;

-- Q2:Lets invite the artist who have written the most rock music in our dataset
-- Write a query that returns the artist name and total track count of the top 10 rock band  
SELECT artist.artist_id,artist.name,COUNT(artist.artist_id) as number_songs
FROM track
JOIN album2 ON album2.album_id=track.album_id
JOIN artist ON artist.artist_id=album2.artist_id
JOIN genre ON genre.genre_id=track.genre_id
WHERE genre.name LIKE 'ROCK'
GROUP BY artist.artist_id,artist.name      
ORDER BY number_songs DESC
LIMIT 10;


-- Q3 Return all the track name that have a song length longer than the avergae song length.
-- Return the name  and milliseconds for each track.Order by the song length with the longest songs listed first.
SELECT NAME,milliseconds,AVG(milliseconds) as c
FROM track
WHERE milliseconds>(
	SELECT AVG(milliseconds) as c
    FROM track)
GROUP BY milliseconds,name
ORDER BY milliseconds DESC;