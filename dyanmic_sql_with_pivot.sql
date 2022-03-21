----================================================
---- DYNAMIC SQL
---- GOAL: give us a table with weekly aggregated data
--------- we need to aggregate the fields, then pivot them so that we have a wide table as opposed to a long table
----================================================
	DECLARE @cols AS NVARCHAR(MAX),
    @query  AS NVARCHAR(MAX);

	------- because the pivot function requires column names in order to properly pivot the data, we need to dynamically create each week's column name since it is a rolling 12 weeks of data we're pulling
	------- each column header is a date that corresponds with the week during which we're aggregating creator user data (e.g. 2022-01-09)
SET @cols = STUFF((SELECT distinct ',' + QUOTENAME(cast(c.________ as date)) as __________
            FROM #____________ c
			order by ____________ asc
            FOR XML PATH(''), TYPE
            ).value('.', 'NVARCHAR(MAX)') 
        ,1,1,'') 

		--select @cols

		--------- this dynamic SQL builds a PIVOT query that will automatically grab the column names for the 12 weeks of rolling data (using the @cols variable above)
		--------- after we build the query, we execute it into a universal temp table & then place the output in the final table with the suffix _excel
set @query = 'drop table if exists ##stage SELECT ____________ as ____________, ' + @cols + ', cast(null as int) as [Grand Total] into ##stage from 
            (
                	 select ____________
	      , ____________
		  , ____________
	   from #____________
           ) x
            pivot 
            (
                 count(____________)
                for ____________ in (' + @cols + ')
            ) p '


			--select @query

execute(@query)
