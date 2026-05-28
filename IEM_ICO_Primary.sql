SET FOREIGN_KEY_CHECKS = OFF;

CREATE TABLE IF NOT EXISTS IEM_ICO_REF_OBJECT_TYPE
(
	OBJECT_TYPE_ID INT                                                     NOT NULL
		PRIMARY KEY,
	CODE           VARCHAR(255) CHARSET latin1                             NOT NULL,
	LC_CODE        VARCHAR(255) CHARSET latin1                             NOT NULL,
	NAME           VARCHAR(255) CHARSET latin1                             NOT NULL,
	DESCRIPTION    VARCHAR(1000) CHARSET latin1                            NULL,
	TABLE_NAME     VARCHAR(255) CHARSET latin1                             NULL,
	ORDER_BY       INT                                                     NULL,
	CREATED_BY     VARCHAR(255) CHARSET latin1 DEFAULT 'SYSTEM'            NOT NULL,
	DATE_CREATED   DATETIME                    DEFAULT CURRENT_TIMESTAMP() NOT NULL,
	IS_ACTIVE      BIT                         DEFAULT b'1'                NOT NULL,
	CONSTRAINT IEM_ICO_REF_OBJECT_TYPE_CODE_NAME_uindex
		UNIQUE (CODE, NAME)
)
	COLLATE = utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS IEM_ICO_AUDIT_LOG
(
	AUDIT_LOG_ID   INT AUTO_INCREMENT
		PRIMARY KEY,
	USER_ID        INT                                                     NULL,
	OBJECT_ID      INT                                                     NULL,
	OBJECT_TYPE_ID INT                                                     NULL,
	ACTION         VARCHAR(255) CHARSET latin1                             NOT NULL,
	USER_ACTION    VARCHAR(255) CHARSET latin1                             NOT NULL,
	REASON         VARCHAR(4000) CHARSET latin1                            NULL,
	CREATED_BY     VARCHAR(255) CHARSET latin1 DEFAULT 'SYSTEM'            NOT NULL,
	DATE_CREATED   DATETIME                    DEFAULT CURRENT_TIMESTAMP() NOT NULL,
	IS_ACTIVE      BIT                         DEFAULT b'1'                NOT NULL,
	CONSTRAINT IEM_ICO_AUDIT_LOG_pk
		UNIQUE (OBJECT_ID, OBJECT_TYPE_ID),
	CONSTRAINT IEM_ICO_AUDIT_LOG_IEM_ICO_REF_OBJECT_TYPE_OBJECT_TYPE_ID_fk
		FOREIGN KEY (OBJECT_TYPE_ID) REFERENCES IEM_ICO_REF_OBJECT_TYPE (OBJECT_TYPE_ID)
			ON UPDATE CASCADE
)
	COLLATE = utf8mb4_unicode_ci;

CREATE INDEX IF NOT EXISTS IEM_ICO_AUDIT_LOG_OBJECT_TYPE_ID_OBJECT_ID_index
	ON IEM_ICO_AUDIT_LOG (OBJECT_TYPE_ID, OBJECT_ID);

CREATE TABLE IF NOT EXISTS IEM_ICO_REF_PROCESS
(
	PROCESS_ID   INT AUTO_INCREMENT
		PRIMARY KEY,
	PROCESS_NAME VARCHAR(255) NULL,
	UUID         VARCHAR(255) NOT NULL,
	PM_ID        INT          NULL,
	NOTE         VARCHAR(255) NULL
)
	CHARSET = utf8mb4;

CREATE TABLE IF NOT EXISTS IEM_ICO_REF_PROGRAM
(
	PROGRAM_ID   INT AUTO_INCREMENT
		PRIMARY KEY,
	CODE         VARCHAR(16) CHARSET latin1                              NULL,
	LC_CODE      VARCHAR(16) CHARSET latin1                              NULL,
	NAME         VARCHAR(64) CHARSET latin1                              NULL,
	DESCRIPTION  VARCHAR(1000) CHARSET latin1                            NULL,
	ORDER_BY     INT                                                     NULL,
	CREATED_BY   VARCHAR(255) CHARSET latin1 DEFAULT 'SYSTEM'            NOT NULL,
	DATE_CREATED DATETIME                    DEFAULT CURRENT_TIMESTAMP() NOT NULL,
	IS_ACTIVE    BIT                         DEFAULT b'1'                NOT NULL,
	CONSTRAINT IEM_ICO_REF_PROGRAM_LC_CODE_uindex
		UNIQUE (LC_CODE)
)
	COLLATE = utf8mb4_unicode_ci;

INSERT IGNORE INTO Appian.IEM_ICO_REF_OBJECT_TYPE (OBJECT_TYPE_ID, CODE, LC_CODE, NAME, DESCRIPTION, TABLE_NAME, ORDER_BY, CREATED_BY, DATE_CREATED, IS_ACTIVE) VALUES (1, 'SYSTEM', 'system', 'System', null, 'IEM_ICO_AUDIT_LOG', 0, 'SYSTEM', '2024-12-18 19:46:22', true);

