CREATE TABLE EmpresaTelefono
(
    IdUsuario INT         NOT NULL,
    Telefono  VARCHAR(15) NOT NULL,
    CONSTRAINT PK_EmpresaTelefono PRIMARY KEY (IdUsuario, Telefono),
    CONSTRAINT FK_EmpresaTelefono_Empresa
        FOREIGN KEY (IdUsuario) REFERENCES Empresa (IdUsuario)
            ON DELETE CASCADE,
    CONSTRAINT CK_EmpresaTelefono_Formato
        CHECK (Telefono LIKE '[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]'
            OR Telefono LIKE '+[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
            OR Telefono LIKE '+[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
);
GO
