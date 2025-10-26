--select * from homeworks.facebook_ads_basic_daily

--select * from facebook_adset

--select * from facebook_campaign

--select * from google_ads_basic_daily

with Facebook_ads
as 
(
select ad_date
,  'Facebook' as media_source
, adset_name 
, campaign_name
, spend 
, impressions
, reach 
, clicks
, leads 
, value 
from homeworks.facebook_ads_basic_daily as fb
left join facebook_adset as ads
on ads.adset_id=fb.adset_id
left join facebook_campaign as cm
on fb.campaign_id=cm.campaign_id 
), 

Google_a
as
(
select ad_date
,  'Google' as media_source
, adset_name 
, campaign_name
, spend 
, impressions
, reach 
, clicks
, leads 
, value
from google_ads_basic_daily
), 

al_resul 
as
(select * from Facebook_ads
union
select * from Google_a)
 

select date_trunc ('week', ad_date ) as week
--, media_source
--, adset_name 
, campaign_name
---, AVG(spend) as avg_spend
---, MAX(spend) as MAX_spend
---, sum (spend) as spend
, sum(value) as value
---, case 
---	when sum(spend) = 0 then 1
 ---else sum(value)::numeric / sum(spend) 
 ---end as ROMI
--, sum (impressions) as impressions
--, sum (reach) as reach
--, sum(clicks) as clicks
--, sum (leads) as leads
from Al_resul
group by 1, 2
order by value desc
limit 1






