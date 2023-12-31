/*
   5 апреля 2023 г.14:42:15
   Пользователь: 
   Сервер: DESKTOP-B3FAFAI\SQLEXPRESS01
   База данных: Variant7
   Приложение: 
*/

/* Чтобы предотвратить возможность потери данных, необходимо внимательно просмотреть этот скрипт, прежде чем запускать его вне контекста конструктора баз данных.*/
BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.service
	DROP CONSTRAINT FK_service_by_company
GO
ALTER TABLE dbo.company SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.service SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
