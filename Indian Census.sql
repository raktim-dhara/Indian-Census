-- All records in dataset1 
select *
from dataset1;

-- All records in dataset2
select*
from dataset2;

-- Total Population of India
select sum(population) as Total_Population
from dataset2;

-- Avg Population Growth Rate of India
select round((avg(growth)*100),2) as Growth_Rate
from dataset1;

-- Top 5 Population Growing State of India
select state,round((avg(growth)*100),1) as Growth_Rate
from dataset1
group by state
order by Growth_Rate DESC
Limit 5;

-- Bottom 5 Population Growing State of India
select state,round((avg(growth)*100),1) as Growth_Rate
from dataset1
group by state
order by Growth_Rate desc
Limit 5;

-- Avg Sex Ratio of India
select round((AVG(Sex_Ratio)),0) as Sex_Ratio
from dataset1;

-- Lowest 5 Sex Ratio State of India
select state,round(avg(Sex_Ratio),0) as sex_ratio
from dataset1
group by state
order by sex_ratio ASC
Limit 5;

-- Highest 5 Sex Ratio State of India
select state,round(avg(Sex_Ratio),0) as sex_ratio
from dataset1
group by state
order by sex_ratio DESC
Limit 5;

-- States where Sex Ratio more than 1000
select state,round(avg(Sex_Ratio),0) as sex_ratio
from dataset1
group by state
having sex_ratio >1000
order by sex_ratio DESC;

-- Avg Literacy Rate of India
select round((AVG(Literacy)),2) as Literacy_Rate
from dataset1;

-- States having Literacy Rate More than 80
select state,round(avg(Literacy),2) as Literacy_Rate
from dataset1
group by state
having Literacy_Rate >80
order by 2 desc;

-- Top 3 Literacy State of India
select state,round(avg(Literacy),2) as Literacy_Rate
from dataset1
group by state
order by Literacy_Rate DESC
Limit 3;

-- Bottom 3 Literacy State of India
select state,round(avg(Literacy),2) as Literacy_Rate
from dataset1
group by state
order by Literacy_Rate ASC
Limit 3;

-- Join both Tables
select d1.district, d1.state, growth, Sex_Ratio,Literacy,Area_km2,Population
from dataset1 d1 inner join dataset2 d2 on d1.District=d2.District;

-- Total no of Male & Female in each state
select d1.state,sum(Population) as Total_Population,sum(round((Sex_Ratio/(sex_ratio+1000)*Population),0)) as Total_Female,sum(round((1000/(sex_ratio+1000)*Population),0)) as Total_Male
from dataset1 d1 inner join dataset2 d2 on d1.District=d2.District
group by d1.state
order by 1;

-- Total no of Literates & Illiterates in each state
select d1.state,sum(Population) as Total_Population,sum(round(((Literacy/100)*Population),0)) as Total_Literates,sum(population-(round(((Literacy/100)*Population),0))) as Total_Illiterates
from dataset1 d1 inner join dataset2 d2 on d1.District=d2.District
group by d1.State
order by 1;

-- Population in Previous Census & Population Change
select d1.state,sum(Population) as Total_Population,sum(round((Population/(1+growth)),0)) as Population_Previous_Census,sum((Population-round((Population/(1+growth)),0))) as Population_Change
from dataset1 d1 inner join dataset2 d2 on d1.District=d2.District
group by d1.State
order by 1;

-- Top 3 districts from each state with highest Literacy Rate
select * from(
select District,state,Literacy,Rank() Over(Partition By State Order By Literacy DESC) as Rnk
from dataset1)R
where R.Rnk in (1,2,3);
