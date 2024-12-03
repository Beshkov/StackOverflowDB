CREATE TABLE [alx].[test_table_one] (
    [id]          BIGINT        IDENTITY (1, 1) NOT NULL,
    [DateCreated] DATETIME2 (7) CONSTRAINT [DF_datecreated] DEFAULT (getdate()) NOT NULL,
    [Insertable]  INT           NOT NULL,
    [Months]      AS            (datepart(month,[DateCreated])) PERSISTED NOT NULL,
    CONSTRAINT [PK_tst_tbl_one] PRIMARY KEY CLUSTERED ([id] ASC) WITH (FILLFACTOR = 86, PAD_INDEX = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = ON)
);

