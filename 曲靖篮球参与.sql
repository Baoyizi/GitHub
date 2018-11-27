OPEN SYMMETRIC KEY User3DESKey DECRYPTION BY PASSWORD ='$)OKM^(#@FV8DG*D';
select a.UserId,
姓名=CAST(DECRYPTBYKEY(a.UserName) AS NVARCHAR(100)),
手机=CAST(DECRYPTBYKEY(a.Mobile) AS NVARCHAR(100)),
(case a.GENDER when 0 then '未知' when 1 then '男' when 2 then '女' end) 性别,
b.PATHNAME 单位,
a.POSITION 职位,
(case a. PoliticalStatus when 01 then '中共党员' when 02 then '中共预备党员' when 03 then '共青团员' when 04 then '民革会员' when 05 then '民盟盟员' 
when 06 then '民建会员' when 07 then '民进会员' when 08 then '农工党党员' when 09 then '致公党党员' when 10 then '九三学社社员' 
when 11 then '台盟盟员' when 12 then '无党派民主人士' when 13 then '群众' when 14 then '普通公民' when 15 then '港澳同胞' when 16 then '叛徒'
 when 17 then '反革命分子' when 99 then '其他' end)  政治状态,
c.参与次数
from User_Users a left join USER_ORGAN_PATH b on b.id=(case when a.DepartmentId=0 then a.EnterpriseId else a.DepartmentId end)
inner join (select GuessUserId,count(GuessMatchId) 参与次数 from BasketBall_GuessMatches where ActivityId=3 group by GuessUserId) c 
on a.UserId=c.GuessUserId
where a.Status<>4



OPEN SYMMETRIC KEY User3DESKey DECRYPTION BY PASSWORD ='$)OKM^(#@FV8DG*D';
select a.UserId,
姓名=CAST(DECRYPTBYKEY(a.UserName) AS NVARCHAR(100)),
手机=CAST(DECRYPTBYKEY(a.Mobile) AS NVARCHAR(100)),
(case a.GENDER when 0 then '未知' when 1 then '男' when 2 then '女' end) 性别,
b.PATHNAME 单位,
a.POSITION 职位,
c.参与次数,
d.猜中次数
from User_Users a left join USER_ORGAN_PATH b on b.id=(case when a.DepartmentId=0 then a.EnterpriseId else a.DepartmentId end)
inner join (select GuessUserId,count(GuessMatchId) 参与次数 from BasketBall_GuessMatches where ActivityId=3 group by GuessUserId) c 
on a.UserId=c.GuessUserId left join (select GuessUserId,count(GuessMatchId) 猜中次数 from BasketBall_GuessMatches where ActivityId=3 
and GuessResult=0 group by GuessUserId) d 
on a.UserId=d.GuessUserId
where a.Status<>4