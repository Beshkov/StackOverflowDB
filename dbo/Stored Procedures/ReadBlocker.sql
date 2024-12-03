

/*
██████╗ ███████╗ █████╗ ██████╗                          
██╔══██╗██╔════╝██╔══██╗██╔══██╗                         
██████╔╝█████╗  ███████║██║  ██║                         
██╔══██╗██╔══╝  ██╔══██║██║  ██║                         
██║  ██║███████╗██║  ██║██████╔╝                         
╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═════╝                          
                                                         
██████╗ ██╗      ██████╗  ██████╗██╗  ██╗███████╗██████╗ 
██╔══██╗██║     ██╔═══██╗██╔════╝██║ ██╔╝██╔════╝██╔══██╗
██████╔╝██║     ██║   ██║██║     █████╔╝ █████╗  ██████╔╝
██╔══██╗██║     ██║   ██║██║     ██╔═██╗ ██╔══╝  ██╔══██╗
██████╔╝███████╗╚██████╔╝╚██████╗██║  ██╗███████╗██║  ██║
╚═════╝ ╚══════╝ ╚═════╝  ╚═════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝
*/



/*For a real reason...*/
CREATE   PROCEDURE dbo.ReadBlocker (@start_date datetime)
AS
BEGIN

    DECLARE  
        @i int;
    
    SELECT   
        @i = v.PostId
    FROM dbo.Votes AS v 
    WHERE v.CreationDate >= @start_date
    AND   v.VoteTypeId > 5
    GROUP BY v.PostId
    ORDER BY v.PostId;

END;

/*Get a "bad" plan*/
EXEC dbo.ReadBlocker 
    @start_date = '20131231';

/*Trivia!*/
EXEC dbo.ReadBlocker 
    @start_date = '17530101';



/*New window*/
EXEC dbo.sp_WhoIsActive 
    @get_locks = 1;



/*YET ANOTHER NEW WINDOW GOSH*/
BEGIN TRAN;
    UPDATE dbo.Votes
        SET UserId = 2147483647
    WHERE 1 = 1;
ROLLBACK;





















/*
What happened?

Our query did a key lookup
The nested loop join used the unordered prefetch optimization
That caused locks to be held on the clustered index until the query finished
Object level S locks will block IX and X locks

HA HA HA!
*/