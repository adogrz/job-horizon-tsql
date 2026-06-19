CREATE TABLE RolPrivilegio
(
    IdRol        INT NOT NULL,
    IdPrivilegio INT NOT NULL,
    CONSTRAINT PK_RolPrivilegio PRIMARY KEY (IdRol, IdPrivilegio),
    CONSTRAINT FK_RolPrivilegio_Rol
        FOREIGN KEY (IdRol) REFERENCES Rol (IdRol)
            ON DELETE CASCADE,
    CONSTRAINT FK_RolPrivilegio_Privilegio
        FOREIGN KEY (IdPrivilegio) REFERENCES Privilegio (IdPrivilegio)
);
GO
