    CREATE   PROCEDURE 
        dbo.Blueprint_Memory 
    AS 
    BEGIN;
    
        WITH 
            comments AS 
        (
            SELECT 
                c.Id, 
                c.CreationDate, 
                c.PostId, 
                c.Score, 
                c.Text, 
                c.UserId,
                n = 
                    ROW_NUMBER() OVER  
                    ( 
                        PARTITION BY 
                            c.UserId 
                        ORDER BY     
                            c.Score DESC 
                    )
            FROM dbo.Comments AS c
            WHERE c.UserId IS NOT NULL
        )
        SELECT 
            u.DisplayName, 
            c.*
        FROM comments AS c
        JOIN dbo.Users AS u
            ON u.Id = c.UserId
        WHERE c.n = 0;
    
    END;
