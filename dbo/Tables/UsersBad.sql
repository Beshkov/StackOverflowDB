CREATE TABLE [dbo].[UsersBad] (
    [Id]             INT            IDENTITY (1, 1) NOT NULL,
    [AboutMe]        NVARCHAR (MAX) NULL,
    [Age]            INT            NULL,
    [CreationDate]   DATETIME       NOT NULL,
    [DisplayName]    VARCHAR (80)   NULL,
    [DownVotes]      INT            NOT NULL,
    [EmailHash]      NVARCHAR (40)  NULL,
    [LastAccessDate] DATETIME       NOT NULL,
    [Location]       NVARCHAR (100) NULL,
    [Reputation]     INT            NOT NULL,
    [UpVotes]        INT            NOT NULL,
    [Views]          INT            NOT NULL,
    [WebsiteUrl]     NVARCHAR (200) NULL,
    [AccountId]      INT            NULL,
    CONSTRAINT [PK_user_id] PRIMARY KEY CLUSTERED ([Id] ASC)
);

