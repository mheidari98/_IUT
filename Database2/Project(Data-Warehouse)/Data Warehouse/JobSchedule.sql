
		/****** 
		
				Team Members:  SaraBaradaran, MahdiHeidari, AminEmamJomeh
				Script Date: January 1, 2021
		
		******/

	
	DECLARE @job_name NVARCHAR(128), 
			@description NVARCHAR(512), 
			@owner_login_name NVARCHAR(128), 
			@database_name NVARCHAR(128);

	SET @job_name = N'Some Title';
	SET @description = N'Periodically do something';
	SET @owner_login_name = N'login';
	SET @database_name = N'Database_Name';

	-- Delete job if it already exists:
	IF EXISTS(SELECT job_id FROM msdb.dbo.sysjobs WHERE (name = @job_name))
	BEGIN
		EXEC msdb.dbo.sp_delete_job
			@job_name = @job_name;
	END

	-- Create the job:
	EXEC  msdb.dbo.sp_add_job
		@job_name=@job_name,		--necessary
		@enabled=1,					--necessary
		@notify_level_eventlog=0, 
		@notify_level_email=2, 
		@notify_level_netsend=2, 
		@notify_level_page=2, 
		@delete_level=0, 
		@description=@description,	--necessary
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=@owner_login_name;

	-- Add server:
	EXEC msdb.dbo.sp_add_jobserver 
		@job_name=@job_name,		--necessary
		@server_name = @@servername ;	

	-- Add step to execute SQL:
	EXEC msdb.dbo.sp_add_jobstep
		@job_name=@job_name,		--necessary
		@step_name=N'Execute SQL',	--necessary
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_fail_action=2, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, 
		@subsystem=N'TSQL',			--necessary
		@command=N'EXEC Main_Dw_DailyProcedure; -- OR ANY SQL STATEMENT',	--necessary
		@database_name=@database_name, 
		@flags=0;

	-- Update job to set start step:
	EXEC msdb.dbo.sp_update_job
		@job_name=@job_name, 
		@enabled=1, 
		@start_step_id=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=2, 
		@notify_level_netsend=2, 
		@notify_level_page=2, 
		@delete_level=0, 
		@description=@description, 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=@owner_login_name, 
		@notify_email_operator_name=N'', 
		@notify_netsend_operator_name=N'', 
		@notify_page_operator_name=N'';

	-- Schedule job:
	EXEC msdb.dbo.sp_add_jobschedule
		@job_name=@job_name,		--necessary
		@name=N'Daily',				--necessary
		@enabled=1,
		@freq_type=4,--daily start	--necessary
		@freq_interval=1,			--necessary

		@freq_subday_type=1,	 -- 1 for runs at a specific time only- runs every  2 for seconds, 4 for minutes, or 8 for hours-0 indicates that this is unused, such as for a job that runs when SQL Server Agent starts 
		@freq_subday_interval=0, -- If freq_subday_type indicates a job that runs every N seconds/minutes/hours, then this column will have a number that tells us how many seconds/minutes/hours will pass between job runs 
		
		@freq_relative_interval=0, -- If a job occurs on the Nth day of a month, then this indicates what N is. 0 = unused (for other schedule types), 1 = 1st, 2 = 2nd, 4 = 3rd, 8 = 4th, and 16 = last 
		
		@freq_recurrence_factor=1, -- If a job occurs every N weeks or months, then this column indicates what N is. 0 means it is not used for a given schedule type. This is only used for daily, weekly, or monthly schedules 
	   
		@active_start_date=20170101,--YYYYMMDD
		@active_end_date=99991231, 	--YYYYMMDD (this represents no end date)
		@active_start_time=010000, 	--HHMMSS		--necessary
		@active_end_time=235959; 	--HHMMSS
