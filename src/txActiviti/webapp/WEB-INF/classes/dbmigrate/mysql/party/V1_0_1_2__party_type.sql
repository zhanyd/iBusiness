
CREATE TABLE PARTY_TYPE(
        ID BIGINT auto_increment,
        NAME VARCHAR(50),
        SCOPE_ID VARCHAR(50),
		TYPE INT,
		REF VARCHAR(50),
        CONSTRAINT PK_PARTY_TYPE PRIMARY KEY(ID)
) engine=innodb;

CREATE TABLE PARTY_ENTITY(
        ID BIGINT auto_increment,
        TYPE_ID BIGINT,
        NAME VARCHAR(100),
	REF VARCHAR(100),
	SCOPE_ID VARCHAR(50),
        CONSTRAINT PK_PARTY_ENTITY PRIMARY KEY(ID),
        CONSTRAINT FK_PARTY_ENTITY_TYPE FOREIGN KEY(TYPE_ID) REFERENCES PARTY_TYPE(ID)
) engine=innodb;

CREATE INDEX I_PARTY_ENTITY_REFERENCE_TYPE ON PARTY_ENTITY(REF, TYPE_ID);

CREATE INDEX I_PARTY_ENTITY_NAME ON PARTY_ENTITY(NAME);

CREATE TABLE PARTY_STRUCT_TYPE(
        ID BIGINT auto_increment,
        NAME VARCHAR(50),
		REF VARCHAR(50),
		SCOPE_ID VARCHAR(50),
		PRIORITY INT,
        CONSTRAINT PK_PARTY_STRUCT_TYPE PRIMARY KEY(ID)
) engine=innodb;

CREATE TABLE PARTY_STRUCT_RULE(
        ID BIGINT auto_increment,
        STRUCT_TYPE_ID BIGINT NOT NULL,
        PARENT_TYPE_ID BIGINT NULL,
		CHILD_TYPE_ID BIGINT NOT NULL,
		SCOPE_ID VARCHAR(50),
		CONSTRAINT PK_PARTY_STRUCT_RULE PRIMARY KEY(ID)
) engine=innodb;

ALTER TABLE PARTY_STRUCT_RULE ADD FOREIGN KEY FK_PARTY_STRUCT_RULE_TYPE(STRUCT_TYPE_ID) REFERENCES PARTY_STRUCT_TYPE(ID);
ALTER TABLE PARTY_STRUCT_RULE ADD FOREIGN KEY FK_PARTY_STRUCT_RULE_TYPE_PARENT(PARENT_TYPE_ID) REFERENCES PARTY_TYPE(ID);
ALTER TABLE PARTY_STRUCT_RULE ADD FOREIGN KEY FK_PARTY_STRUCT_RULE_TYPE_CHILD(CHILD_TYPE_ID) REFERENCES PARTY_TYPE(ID);

CREATE TABLE PARTY_STRUCT(
        ID BIGINT PRIMARY KEY auto_increment,
        STRUCT_TYPE_ID BIGINT NOT NULL,
        PARENT_ENTITY_ID BIGINT NULL,
        CHILD_ENTITY_ID BIGINT NOT NULL,
		PRIORITY INTEGER,
		SCOPE_ID VARCHAR(50),
        PART_TIME INT,
        LINK INT,
        ADMIN INT,
        CONSTRAINT FK_PARTY_STRUCT_TYPE FOREIGN KEY(STRUCT_TYPE_ID) REFERENCES PARTY_STRUCT_TYPE(ID),
        CONSTRAINT FK_PARTY_STRUCT_PARENT FOREIGN KEY(PARENT_ENTITY_ID) REFERENCES PARTY_ENTITY(ID),
        CONSTRAINT FK_PARTY_STRUCT_CHILD FOREIGN KEY(CHILD_ENTITY_ID) REFERENCES PARTY_ENTITY(ID)
) engine=innodb;

