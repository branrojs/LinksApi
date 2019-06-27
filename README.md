# README

* Ruby version -> 2.5.5

* Configuration -> All configurations done at the run.sh file.

* Database creation -> If not using Docker, run rails db:create

* Database initialization -> If not using Docker, run rails db:migrate and rails db:seed

## Services

1. **Get top 100**
 * http://localhost:8081/api/v1/links

2. **Post-create url** 
  * http://localhost:8081/api/v1/links 
  * *params: url*, 
  * *content type: application/json*

3. **Get *redirect* **
 * http://localhost:8081/api/v1/links/short_url
 * You can adquire this short url at the top 100 list or at the end of the post, if this is successful 

