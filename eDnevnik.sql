USE master
IF EXISTS(select * from sys.databases where name='eDnevnik')
DROP DATABASE eDnevnik
CREATE DATABASE eDnevnik

USE [eDnevnik]



/****** Object:  Table [dbo].[godine] ******/

CREATE TABLE dbo.Godine
(
	GodinaID int IDENTITY NOT NULL,
	GodinaSkolovanja int NOT NULL,
	SkolskaGodina int NOT NULL
)
GO

ALTER TABLE dbo.Godine
ADD CONSTRAINT [PK_godine] PRIMARY KEY (GodinaID)
GO

ALTER TABLE dbo.Godine 
ADD CONSTRAINT Chk_GodinaSkolovanja 
CHECK (GodinaSkolovanja BETWEEN 1 AND 5)

ALTER TABLE dbo.Godine 
ADD CONSTRAINT UC_GodinaSkolovanja_SkolskaGodina UNIQUE (GodinaSkolovanja, SkolskaGodina)
GO


/****** Object:  Table [dbo].[profesori] ******/

CREATE TABLE dbo.Profesori
(
	ProfesorID int IDENTITY NOT NULL,
	ImeProfesora nvarchar(50) NOT NULL,
	Email nvarchar(255) NOT NULL,
	KontaktTelefon nvarchar(50) NOT NULL,
	LoginSifra nvarchar(max) NOT NULL,
	Admin bit NOT NULL
)

ALTER TABLE dbo.Profesori
ADD CONSTRAINT [PK_Profesori] PRIMARY KEY (ProfesorID)
GO


/****** Object:  Table [dbo].[predmeti] ******/

CREATE TABLE dbo.Predmeti
(
	PredmetID int IDENTITY NOT NULL,
	Redosled int NOT NULL,
	NazivPredmeta nvarchar(100) NOT NULL,
	Godina int NOT NULL
)

ALTER TABLE dbo.Predmeti
ADD CONSTRAINT [PK_Predmeti] PRIMARY KEY (PredmetID)
GO



/****** Object:  Table [dbo].[odeljenja] ******/

CREATE TABLE dbo.Odeljenja
(
	OdeljenjeID int IDENTITY NOT NULL,
	BrojOdeljenja int NOT NULL,
	GodinaID int NOT NULL,
	RazredniID int NULL
)

ALTER TABLE dbo.Odeljenja 
ADD CONSTRAINT [PK_Odeljenja] PRIMARY KEY (OdeljenjeID)
GO

ALTER TABLE dbo.Odeljenja 
ADD CONSTRAINT [FK_Odeljenja_Godine] FOREIGN KEY (GodinaID)
REFERENCES dbo.Godine (GodinaID)
GO

ALTER TABLE dbo.Odeljenja 
ADD CONSTRAINT [FK_Odeljenja_Profesori] FOREIGN KEY (RazredniID)
REFERENCES dbo.Profesori (ProfesorID)
GO

ALTER TABLE dbo.Odeljenja 
ADD CONSTRAINT UC_BrojOdeljenja_GodinaID UNIQUE (BrojOdeljenja, GodinaID)
GO


/****** Object:  Table [dbo].[ucenici] ******/

CREATE TABLE dbo.Ucenici
(
	MaticniBroj nvarchar(10) NOT NULL,
	Ime nvarchar(50) NOT NULL,
	Prezime nvarchar(50) NOT NULL,
	JMBG nvarchar(13) NOT NULL,
	OdeljenjeID int NOT NULL,
	DatumRodjenja date NOT NULL,
	MestoRodjenja nvarchar(50) NOT NULL,
	OpstinaRodjenja nvarchar(50) NOT NULL,
	DrzavaRodjenja nvarchar(50) NOT NULL,
	KontaktTelefonUcenika nvarchar(50) NULL,
	EmailUcenika nvarchar(255) NULL,
	ImeOca nvarchar(50) NOT NULL,
	PrezimeOca nvarchar(50) NOT NULL,
	KontaktTelefonOca nvarchar(50) NULL,
	EmailOca nvarchar(255) NULL,
	ImeMajke nvarchar(50) NOT NULL,
	PrezimeMajke nvarchar(50) NOT NULL,
	KontaktTelefonMajke nvarchar(50) NULL,
	EmailMajke nvarchar(255) NULL,
	LoginSifra nvarchar(max) NOT NULL
)
GO

ALTER TABLE dbo.Ucenici
ADD CONSTRAINT [PK_Ucenici] PRIMARY KEY (MaticniBroj)
GO

ALTER TABLE dbo.Ucenici 
ADD CONSTRAINT [FK_Ucenici_Odeljenja] FOREIGN KEY (OdeljenjeID)
REFERENCES dbo.Odeljenja (OdeljenjeID)
GO


/****** Object:  Table [dbo].[ocene] ******/

CREATE TABLE dbo.TipOcene
(
	TipOcene nvarchar(50) NOT NULL
)
GO

ALTER TABLE dbo.TipOcene
ADD CONSTRAINT [PK_TipOcene] PRIMARY KEY (TipOcene)



/****** Object:  Table [dbo].[ocene] ******/

CREATE TABLE dbo.Ocene
(
	OcenaID int IDENTITY NOT NULL,
	TipOcene nvarchar(50) NOT NULL,
	Ocena int NOT NULL,
	OpisOcene nvarchar(50) NOT NULL,
	DatumOcene date NOT NULL,
	MaticniBroj nvarchar(10) NOT NULL,
	ProfesorID int NOT NULL,
	PredmetID int NOT NULL
)

ALTER TABLE dbo.Ocene
ADD CONSTRAINT [PK_ocene] PRIMARY KEY (OcenaID)
GO

ALTER TABLE dbo.Ocene 
ADD CONSTRAINT [FK_Ocene_Predmeti] FOREIGN KEY (PredmetID)
REFERENCES dbo.Predmeti (PredmetID)
GO

ALTER TABLE dbo.Ocene 
ADD CONSTRAINT [FK_Ocene_Profesori] FOREIGN KEY (ProfesorID)
REFERENCES dbo.Profesori (ProfesorID)
GO

ALTER TABLE dbo.Ocene 
ADD CONSTRAINT [FK_Ocene_Ucenici] FOREIGN KEY (MaticniBroj)
REFERENCES dbo.Ucenici (MaticniBroj)
GO

ALTER TABLE dbo.Ocene 
ADD CONSTRAINT [FK_Ocene_TipOcene] FOREIGN KEY (TipOcene)
REFERENCES dbo.TipOcene (TipOcene)
GO


/****** Object:  Table [dbo].[dodeljeniprofesori] ******/

CREATE TABLE dbo.DodeljeniProfesori
(
	ProfesorID int NOT NULL,
	PredmetID int NOT NULL,
	OdeljenjeID int NOT NULL
)
GO

ALTER TABLE dbo.DodeljeniProfesori 
ADD CONSTRAINT [FK_DodeljeniProfesori_Odeljenja] FOREIGN KEY (OdeljenjeID)
REFERENCES dbo.Odeljenja (OdeljenjeID)
GO

ALTER TABLE dbo.DodeljeniProfesori  
ADD CONSTRAINT [FK_DodeljeniProfesori_Predmeti] FOREIGN KEY (PredmetID)
REFERENCES dbo.Predmeti (PredmetID)
GO

ALTER TABLE dbo.DodeljeniProfesori 
ADD CONSTRAINT [FK_DodeljeniProfesori_Profesori] FOREIGN KEY (ProfesorID)
REFERENCES dbo.Profesori (ProfesorID)
GO


/****** Object:  Table [dbo].[dodeljenipredmeti] ******/

CREATE TABLE dbo.DodeljeniPredmeti
(
	MaticniBroj nvarchar(10) NOT NULL,
	PredmetID int NOT NULL
)
GO

ALTER TABLE dbo.DodeljeniPredmeti
ADD CONSTRAINT [FK_DodeljeniPredmeti_Ucenici] FOREIGN KEY (MaticniBroj)
REFERENCES dbo.Ucenici (MaticniBroj)
GO

ALTER TABLE dbo.DodeljeniPredmeti
ADD CONSTRAINT [FK_DodeljeniPredmeti_Predmeti] FOREIGN KEY (PredmetID)
REFERENCES dbo.Predmeti (PredmetID)
GO


/****** Object:  Table [dbo].[arhivaocena] ******/

CREATE TABLE dbo.LogOcena
(
	LogID int IDENTITY NOT NULL,
	OcenaID int NOT NULL,
	TipOcene nvarchar(50) NOT NULL,
	Ocena int NOT NULL,
	OpisOcene nvarchar(50) NOT NULL,
	DatumOcene date NOT NULL,
	MaticniBroj nvarchar(10) NOT NULL,
	ProfesorID int NOT NULL,
	PredmetID int NOT NULL
)
GO

ALTER TABLE dbo.LogOcena
ADD CONSTRAINT [PK_LogOcena] PRIMARY KEY (LogID)
GO

ALTER TABLE dbo.LogOcena
ADD CONSTRAINT [FK_LogOcena_Ocene] FOREIGN KEY (OcenaID)
REFERENCES dbo.Ocene (OcenaID)
GO


/****** Object:  Table [dbo].[sesijekorisnika] ******/

CREATE TABLE dbo.SesijeKorisnika
(
	SesijeID int IDENTITY NOT NULL,
	VremeLogin datetime NOT NULL,
	VremeLogout datetime NULL,
	ProfesorID int NOT NULL
)
GO

ALTER TABLE dbo.SesijeKorisnika
ADD CONSTRAINT [PK_SesijeKorisnika] PRIMARY KEY (SesijeID)
GO

ALTER TABLE dbo.SesijeKorisnika 
ADD CONSTRAINT [FK_SesijeKorisnika_Profesori] FOREIGN KEY (ProfesorID)
REFERENCES dbo.Profesori (ProfesorID)
GO


/****** Object:  Table [dbo].[arhivaocena] ******/

CREATE TABLE dbo.ArhivaOcena
(
	MaticniBroj nvarchar(10) NOT NULL,
	Ime nvarchar(50) NOT NULL,
	Prezime nvarchar(50) NOT NULL,
	JMBG nvarchar(13) NOT NULL,
	MestoRodjenja nvarchar(50) NOT NULL,
	OpstinaRodjenja nvarchar(50) NOT NULL,
	DrzavaRodjenja nvarchar(50) NOT NULL,
	BrojOdeljenja int NOT NULL,
	GodinaSkolovanja int NOT NULL,
	SkolskaGodina int NOT NULL,
	NazivPredmeta nvarchar(100) NOT NULL,
	Ocena int NOT NULL
)
GO




/**************************** TRIGGERI ****************************/

/***** UPDATE TRIGGER *****/

CREATE TRIGGER dbo.OcenaUPDATE
ON dbo.Ocene
AFTER UPDATE
AS
BEGIN TRY 
	BEGIN TRANSACTION

	DECLARE @OcenaID as int,
			@TipOcene as nvarchar(50),
			@Ocena as int,
			@OpisOcene as nvarchar(50),
			@DatumOcene as datetime,
			@MaticniBroj as nvarchar(10),
			@ProfesorID as int,
			@PredmetID as int
			
    SELECT
			@OcenaID = inserted.OcenaID,
			@TipOcene = inserted.TipOcene,
			@Ocena = inserted.Ocena,
			@OpisOcene = inserted.OpisOcene,
			@DatumOcene = inserted.DatumOcene,
			@MaticniBroj = inserted.MaticniBroj,
			@ProfesorID = inserted.ProfesorID,
			@PredmetID = inserted.PredmetID
    FROM inserted

	INSERT INTO dbo.LogOcena
	(OcenaID, TipOcene, Ocena, OpisOcene, DatumOcene, MaticniBroj, ProfesorID, PredmetID)
	SELECT OcenaID, TipOcene, Ocena, OpisOcene, DatumOcene, MaticniBroj, ProfesorID, PredmetID FROM deleted

	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	RAISERROR ('Nije Proslo', 1, 1)
END CATCH
GO


/***** DELETE TRIGGER *****/

CREATE TRIGGER dbo.OcenaDELETE
ON dbo.Ocene
INSTEAD OF DELETE
AS
BEGIN TRY 
	BEGIN TRANSACTION

	INSERT INTO dbo.LogOcena
	(OcenaID, TipOcene, Ocena, OpisOcene, DatumOcene, MaticniBroj, ProfesorID, PredmetID)
	SELECT OcenaID, TipOcene, Ocena, OpisOcene, DatumOcene, MaticniBroj, ProfesorID, PredmetID FROM deleted

	DELETE FROM dbo.Ocene
	WHERE OcenaID IN (SELECT OcenaID FROM deleted)

	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	RAISERROR ('Nije Proslo', 1, 1)
END CATCH
GO



/**************************** STORED PROCEDURES ****************************/


/***** STORED PROCEDURE ZA OCENE *****/

--- Procedura za unos nove ocene ---
CREATE PROCEDURE dbo.OceneINSERT
(@TipOcene nvarchar(50), @Ocena int, @OpisOcene nvarchar(50), @MaticniBroj int, @ProfesorID int, @PredmetID int)
AS
BEGIN TRY
	INSERT INTO dbo.Ocene
	(TipOcene, Ocena, OpisOcene, DatumOcene, MaticniBroj, ProfesorID, PredmetID)
	VALUES
	(@TipOcene, @Ocena, @OpisOcene, GETDATE(), @MaticniBroj, @ProfesorID, @PredmetID)
END TRY
BEGIN CATCH
	RETURN @@ERROR
END CATCH
GO

--- Procedura za menjanje ocena ---
CREATE PROCEDURE dbo.OceneUPDATE
(@OcenaID int, @TipOcene nvarchar(50), @Ocena int, @OpisOcene nvarchar(50), @MaticniBroj int, @ProfesorID int, @PredmetID int)
AS
BEGIN TRY
IF EXISTS (SELECT 1 FROM dbo.Ocene WHERE OcenaID = @OcenaID)
	BEGIN
		UPDATE dbo.Ocene
		SET TipOcene = @TipOcene, Ocena = @Ocena, OpisOcene = @OpisOcene, DatumOcene = GETDATE(), MaticniBroj = @MaticniBroj, ProfesorID = @ProfesorID, PredmetID = @PredmetID
		WHERE OcenaID = @OcenaID
		RETURN 0
	END
ELSE
	BEGIN
		RETURN -1
	END
END TRY
BEGIN CATCH
	RETURN @@ERROR
END CATCH
GO

--- Procedura za brisanje ocena ---
CREATE PROCEDURE dbo.OceneDELETE
(@OcenaID int)
AS
BEGIN TRY
IF EXISTS (SELECT 1 FROM dbo.Ocene WHERE OcenaID = @OcenaID)
	BEGIN
		DELETE FROM dbo.Ocene
		WHERE OcenaID = @OcenaID
		RETURN 0
	END
ELSE
	BEGIN
		RETURN -1
	END
END TRY
BEGIN CATCH
	RETURN @@ERROR
END CATCH
GO

--- Procedura za izbor ocene ---

CREATE PROCEDURE dbo.OceneSELECT
(@BrojPoStrani int = 20, @TrenutnaStrana int, @NazivPredmeta nvarchar(50), @ImeUcenika nvarchar(50), @ImeProfesora nvarchar(50), @GodinaSkolovanja int, @OdeljenjeBroj int)
AS
BEGIN TRY
	SELECT U.Ime, U.Prezime, P.NazivPredmeta, O.Ocena, PR.ImeProfesora, O.TipOcene, O.DatumOcene 
	FROM dbo.Ucenici AS U 
	INNER JOIN dbo.Ocene AS O ON U.MaticniBroj = O.MaticniBroj
	INNER JOIN dbo.Predmeti AS P ON O.PredmetID = P.PredmetID
	INNER JOIN dbo.DodeljeniProfesori AS DP ON DP.PredmetID = P.PredmetID
	INNER JOIN dbo.Profesori AS PR ON DP.ProfesorID = PR.ProfesorID
	INNER JOIN dbo.Odeljenja AS OD ON OD.OdeljenjeID = DP.OdeljenjeID
	INNER JOIN dbo.Godine AS G ON G.GodinaID = OD.GodinaID
	WHERE
	(@NazivPredmeta IS NULL OR @NazivPredmeta = P.NazivPredmeta) AND
	(@ImeUcenika IS NULL OR @ImeUcenika = CONCAT(U.Ime, ' ',  U.Prezime) OR @ImeUcenika = CONCAT(U.Prezime, ' ', U.Ime) OR @ImeUcenika = U.Prezime OR @ImeUcenika = U.Ime) AND
	(@ImeProfesora IS NULL OR @ImeProfesora = PR.ImeProfesora) AND
	(@GodinaSkolovanja IS NULL OR @GodinaSkolovanja = G.GodinaSkolovanja) AND
	(@OdeljenjeBroj IS NULL OR @OdeljenjeBroj = OD.BrojOdeljenja)

	ORDER BY P.NazivPredmeta
	OFFSET (@TrenutnaStrana * @BrojPoStrani) ROWS
         FETCH NEXT @BrojPoStrani ROWS ONLY

	RETURN 0
END TRY
BEGIN CATCH
	RETURN @@ERROR
END CATCH
GO


/***** STORE PROCEDURE ZA PROFESORE *****/

--- Procedura za prikaz profesora ---

CREATE PROCEDURE dbo.profesoriPrikazPoID
@ProfesorID int
AS
	BEGIN
	SELECT *
	FROM Profesori
	WHERE ProfesorID = @ProfesorID
	END
GO

CREATE PROCEDURE dbo.PrikazProfesora
AS
	BEGIN
	SELECT *
	FROM Profesori
	END
GO

----------- DODAVANJE I IZMENA PROFESORA ----------

CREATE PROC [dbo].[ProfesorINSERTOrUPDATE]
@ProfesorID int,
@ImeProfesora nvarchar(50),
@Email nvarchar(255),
@KontaktTelefon nvarchar(50),
@LoginSifra nvarchar(max), 
@Admin bit = 0, 
@NazivPredmeta nvarchar(100), 
@BrojOdeljenja int, 
@GodinaSkolovanja int, 
@SkolskaGodina int
AS
BEGIN
IF(@ProfesorID=0)
BEGIN TRY
	INSERT INTO dbo.Profesori
	(ImeProfesora, Email, KontaktTelefon, LoginSifra, Admin)
	VALUES
	(@ImeProfesora, @Email, @KontaktTelefon, @LoginSifra, @Admin)

	INSERT INTO dbo.DodeljeniProfesori
	(ProfesorID, PredmetID, OdeljenjeID)
	VALUES	
	(	@@IDENTITY, 
		(SELECT PredmetID FROM dbo.Predmeti WHERE NazivPredmeta = @NazivPredmeta AND Godina = @GodinaSkolovanja),
		(SELECT OdeljenjeID FROM dbo.Odeljenja
		INNER JOIN dbo.Godine 
		ON dbo.Odeljenja.GodinaID = dbo.Godine.GodinaID 
		WHERE BrojOdeljenja = @BrojOdeljenja AND dbo.Godine.GodinaSkolovanja = @GodinaSkolovanja AND SkolskaGodina = @SkolskaGodina)
	)
END TRY
BEGIN CATCH
	RETURN @@ERROR
END CATCH
ELSE
BEGIN TRY
IF EXISTS (SELECT 1 FROM dbo.Profesori WHERE ProfesorID = @ProfesorID)
	BEGIN
		UPDATE dbo.Profesori
		SET ImeProfesora = @ImeProfesora, Email = @Email, KontaktTelefon = @KontaktTelefon, LoginSifra = @LoginSifra, Admin = @Admin
		WHERE ProfesorID = @ProfesorID
		
		UPDATE dbo.DodeljeniProfesori
		SET PredmetID = (SELECT PredmetID FROM dbo.Predmeti where NazivPredmeta = @NazivPredmeta AND Godina = @GodinaSkolovanja), 
			OdeljenjeID = (SELECT OdeljenjeID FROM dbo.Odeljenja INNER JOIN dbo.Godine ON dbo.Odeljenja.GodinaID = dbo.Godine.GodinaID 
			WHERE BrojOdeljenja = @BrojOdeljenja AND dbo.Godine.GodinaSkolovanja = @GodinaSkolovanja AND SkolskaGodina = @SkolskaGodina)
		WHERE ProfesorID = @ProfesorID
		RETURN 0
	END
ELSE
	BEGIN 
		RETURN -1
	END
END TRY
BEGIN CATCH
	RETURN @@ERROR
END CATCH
END

--- Procedura za dodavanje profesora ---

CREATE PROCEDURE dbo.profesoriINSERT
(@ImeProfesora nvarchar(50), @Email nvarchar(255), @KontaktTelefon nvarchar(50), @LoginSifra nvarchar(max), @Admin bit = 0, @NazivPredmeta nvarchar(100), @BrojOdeljenja int, @GodinaSkolovanja int, @SkolskaGodina int)
AS
BEGIN TRY
	INSERT INTO dbo.Profesori
	(ImeProfesora, Email, KontaktTelefon, LoginSifra, Admin)
	VALUES
	(@ImeProfesora, @Email, @KontaktTelefon, @LoginSifra, @Admin)

	INSERT INTO dbo.DodeljeniProfesori
	(ProfesorID, PredmetID, OdeljenjeID)
	VALUES	
	(	@@IDENTITY, 
		(SELECT PredmetID FROM dbo.Predmeti WHERE NazivPredmeta = @NazivPredmeta AND Godina = @GodinaSkolovanja),
		(SELECT OdeljenjeID FROM dbo.Odeljenja
		INNER JOIN dbo.Godine 
		ON dbo.Odeljenja.GodinaID = dbo.Godine.GodinaID 
		WHERE BrojOdeljenja = @BrojOdeljenja AND dbo.Godine.GodinaSkolovanja = @GodinaSkolovanja AND SkolskaGodina = @SkolskaGodina)
	)
END TRY
BEGIN CATCH
	RETURN @@ERROR
END CATCH
GO


--- Procedura za menjanje profesora ---

alter PROCEDURE dbo.profesoriUPDATE
(@ProfesorID int, @ImeProfesora nvarchar(50), @Email nvarchar(255), @KontaktTelefon nvarchar(50), @LoginSifra nvarchar(max), @Admin bit = 0, @NazivPredmeta nvarchar(100), @BrojOdeljenja int, @GodinaSkolovanja int, @SkolskaGodina int)
AS
BEGIN TRY
IF EXISTS (SELECT 1 FROM dbo.Profesori WHERE ProfesorID = @ProfesorID)
	BEGIN
		UPDATE dbo.Profesori
		SET ImeProfesora = @ImeProfesora, Email = @Email, KontaktTelefon = @KontaktTelefon, LoginSifra = @LoginSifra, Admin = @Admin
		WHERE ProfesorID = @ProfesorID
		
		UPDATE dbo.DodeljeniProfesori
		SET PredmetID = (SELECT PredmetID FROM dbo.Predmeti where NazivPredmeta = @NazivPredmeta AND Godina = @GodinaSkolovanja), 
			OdeljenjeID = (SELECT OdeljenjeID FROM dbo.Odeljenja INNER JOIN dbo.Godine ON dbo.Odeljenja.GodinaID = dbo.Godine.GodinaID 
			WHERE BrojOdeljenja = @BrojOdeljenja AND dbo.Godine.GodinaSkolovanja = @GodinaSkolovanja AND SkolskaGodina = @SkolskaGodina)
		WHERE ProfesorID = @ProfesorID
		RETURN 0
	END
ELSE
	BEGIN 
		RETURN -1
	END
END TRY
BEGIN CATCH
	RETURN @@ERROR
END CATCH
GO

--- Procedura za brisanje profesora ---

CREATE PROCEDURE dbo.profesoriDELETE
(@ProfesorID int)
AS
BEGIN TRY
IF EXISTS (SELECT 1 FROM dbo.Profesori WHERE ProfesorID = @ProfesorID)
	BEGIN
		DELETE FROM dbo.Profesori
		WHERE ProfesorID = @ProfesorID
		RETURN 0
	END
ELSE
	BEGIN
		RETURN -1
	END
END TRY
BEGIN CATCH
	RETURN @@ERROR
END CATCH
GO

--- Procedura za login ---

CREATE PROCEDURE dbo.LoginKorisnika
 (
	@Korisnik nvarchar(255),
	@LoginSifra nvarchar(max),
	@ProfesorID int OUTPUT,
	@Admin bit OUTPUT,
	@MaticniBroj nvarchar(10) OUTPUT
 )
 AS
 BEGIN TRY
	IF EXISTS (SELECT 1 FROM dbo.Profesori WHERE Email = @Korisnik AND LoginSifra = @LoginSifra)
	BEGIN 
		SELECT @ProfesorID = ProfesorID, @Admin = Admin
		FROM dbo.Profesori
		WHERE Email = @Korisnik AND LoginSifra = @LoginSifra
		INSERT INTO dbo.SesijeKorisnika
		(VremeLogin, ProfesorID)
		VALUES 
		(GETDATE(), @ProfesorID)
		RETURN 0
	END
	ELSE
	IF EXISTS (SELECT 1 FROM dbo.Ucenici WHERE JMBG = @Korisnik AND LoginSifra = @LoginSifra)
	BEGIN
		SELECT @MaticniBroj = MaticniBroj
		FROM dbo.Ucenici
		WHERE JMBG = @Korisnik AND LoginSifra = @LoginSifra
		RETURN 0
	END
	ELSE
	BEGIN
		RETURN -1;
	END
END TRY
BEGIN CATCH
	RETURN @@Error
END CATCH
GO



/***** STORED PROCEDURE ZA UCENIKE *****/


--- Procedura za dodavanje ucenika ---

CREATE PROCEDURE dbo.uceniciINSERT
(@MaticniBroj nvarchar(10), @Ime nvarchar(50), @Prezime nvarchar(50), @JMBG nvarchar(50), @BrojOdeljenja int, @GodinaSkolovanja int, @SkolskaGodina int, @DatumRodjenja date, @MestoRodjenja nvarchar(50), @OpstinaRodjenja nvarchar(50), @DrzavaRodjenja nvarchar(50), @KontaktTelefonUcenika nvarchar(50), @EmailUcenika nvarchar(255), @ImeOca nvarchar(50), @PrezimeOca nvarchar(50), @KontaktTelefonOca nvarchar(50), @EmailOca nvarchar(255), @ImeMajke nvarchar(50), @PrezimeMajke nvarchar (50), @KontaktTelefonMajke nvarchar(50), @EmailMajke nvarchar(255), @LoginSifra nvarchar(max), @IzborniPredmet bit)
AS
BEGIN TRY
	INSERT INTO dbo.Ucenici
	(MaticniBroj, Ime, Prezime, JMBG, OdeljenjeID, DatumRodjenja, MestoRodjenja, OpstinaRodjenja, DrzavaRodjenja, KontaktTelefonUcenika, EmailUcenika, ImeOca, PrezimeOca, KontaktTelefonOca, EmailOca, ImeMajke, PrezimeMajke, KontaktTelefonMajke, EmailMajke, LoginSifra)
	VALUES
	(@MaticniBroj, @Ime, @Prezime, @JMBG, (SELECT OdeljenjeID FROM dbo.Odeljenja INNER JOIN dbo.Godine ON dbo.Odeljenja.GodinaID = dbo.Godine.GodinaID WHERE BrojOdeljenja = @BrojOdeljenja AND dbo.Godine.GodinaSkolovanja = @GodinaSkolovanja AND SkolskaGodina = @SkolskaGodina), @DatumRodjenja, @MestoRodjenja, @OpstinaRodjenja, @DrzavaRodjenja, @KontaktTelefonUcenika, @EmailUcenika, @ImeOca, @PrezimeOca, @KontaktTelefonOca, @EmailOca, @ImeMajke, @PrezimeMajke, @KontaktTelefonMajke, @EmailMajke, @LoginSifra)

	IF (@IzborniPredmet = 0)
		INSERT INTO dbo.DodeljeniPredmeti
		(MaticniBroj, PredmetID)
		SELECT @MaticniBroj, PredmetID FROM dbo.Predmeti WHERE NazivPredmeta != N'Matematika'
	ELSE
		INSERT INTO dbo.DodeljeniPredmeti
		(MaticniBroj, PredmetID)
		SELECT @MaticniBroj, PredmetID FROM dbo.Predmeti WHERE NazivPredmeta != N'Engleski'

END TRY
BEGIN CATCH
	RETURN @@ERROR
END CATCH
GO


--- Procedura za menjanje ucenika ---

CREATE PROCEDURE dbo.uceniciUPDATE
(@MaticniBroj int, @Ime nvarchar(50), @Prezime nvarchar(50), @JMBG nvarchar(50), @BrojOdeljenja int, @GodinaSkolovanja int, @SkolskaGodina int, @DatumRodjenja date, @MestoRodjenja nvarchar(50), @OpstinaRodjenja nvarchar(50), @DrzavaRodjenja nvarchar(50), @KontaktTelefonUcenika nvarchar(50), @EmailUcenika nvarchar(255), @ImeOca nvarchar(50), @PrezimeOca nvarchar(50), @KontaktTelefonOca nvarchar(50), @EmailOca nvarchar(255), @ImeMajke nvarchar(50), @PrezimeMajke nvarchar (50), @KontaktTelefonMajke nvarchar(50), @EmailMajke nvarchar(255), @LoginSifra nvarchar(max))
AS
BEGIN TRY
IF EXISTS (SELECT 1 FROM dbo.Ucenici WHERE MaticniBroj = @MaticniBroj)
	BEGIN
		UPDATE dbo.Ucenici
		SET Ime = @Ime, Prezime = @Prezime, JMBG = @JMBG, OdeljenjeID = (SELECT OdeljenjeID FROM dbo.Odeljenja INNER JOIN dbo.Godine ON dbo.Odeljenja.GodinaID = dbo.Godine.GodinaID WHERE BrojOdeljenja = @BrojOdeljenja AND dbo.Godine.GodinaSkolovanja = @GodinaSkolovanja AND SkolskaGodina = @SkolskaGodina), DatumRodjenja = @DatumRodjenja, MestoRodjenja = @MestoRodjenja, OpstinaRodjenja = @OpstinaRodjenja, DrzavaRodjenja = @DrzavaRodjenja, ImeOca = @ImeOca, PrezimeOca = @PrezimeOca, KontaktTelefonOca = @KontaktTelefonOca, EmailOca = @EmailOca, ImeMajke = @ImeMajke, PrezimeMajke = @PrezimeMajke, KontaktTelefonMajke = @KontaktTelefonMajke, EmailMajke = @EmailMajke, LoginSifra = @LoginSifra
		WHERE MaticniBroj = @MaticniBroj
		RETURN 0
	END
ELSE
	BEGIN
		RETURN -1
	END
END TRY
BEGIN CATCH
	RETURN @@ERROR
END CATCH
GO

--- Procedura za brisanje ucenika ---

CREATE PROCEDURE dbo.uceniciDELETE
(@MaticniBroj int)
AS
BEGIN TRY
IF EXISTS (SELECT 1 FROM dbo.Ucenici WHERE MaticniBroj = @MaticniBroj)
	BEGIN
		DELETE FROM dbo.Ucenici
		WHERE MaticniBroj = @MaticniBroj
		RETURN 0
	END
ELSE
	BEGIN
		RETURN -1
	END
END TRY
BEGIN CATCH
	RETURN @@ERROR
END CATCH
GO


/***** STORED PROCEDURE ZA ODELJENJA *****/


--- SP za dodavanje razrednog u odeljenja --- 

CREATE PROCEDURE dbo.odeljenjaUPDATE
(@OdeljenjeID int, @RazredniID int)
AS
BEGIN TRY
IF EXISTS (SELECT 1 FROM dbo.Odeljenja WHERE OdeljenjeID = @OdeljenjeID)
	BEGIN
		UPDATE dbo.Odeljenja
		SET RazredniID = @RazredniID
		WHERE OdeljenjeID = @OdeljenjeID
		RETURN 0
	END
ELSE
	BEGIN 
		RETURN -1
	END
END TRY
BEGIN CATCH
	RETURN @@ERROR
END CATCH
GO

--- SP za selektovanje odeljenja ---

CREATE PROCEDURE dbo.odeljenjaSELECT
(@BrojPoStrani int = 20, @TrenutnaStrana int, @BrojOdeljenja int, @GodinaSkolovanja int, @SkolskaGodina int = year)
AS
BEGIN TRY
	SELECT *
	FROM dbo.Odeljenja  
	INNER JOIN dbo.Godine ON dbo.Odeljenja.GodinaID = dbo.Godine.GodinaID
	WHERE 
  		( (@BrojOdeljenja IS NULL) OR (BrojOdeljenja = @BrojOdeljenja) )  AND
  		( (@GodinaSkolovanja IS NULL) OR (dbo.Godine.GodinaSkolovanja = @GodinaSkolovanja) )  AND
  		( (@SkolskaGodina IS NULL) OR (dbo.Godine.SkolskaGodina = @SkolskaGodina) )

	ORDER BY dbo.Odeljenja.BrojOdeljenja
	OFFSET (@TrenutnaStrana * @BrojPoStrani) ROWS
         FETCH NEXT @BrojPoStrani ROWS ONLY

	RETURN 0
END TRY
BEGIN CATCH
	RETURN @@Error
END CATCH
GO


--- combobox ---

CREATE PROCEDURE dbo.IzborPredmeta
AS
SELECT DISTINCT NazivPredmeta
FROM dbo.Predmeti
ORDER BY NazivPredmeta
GO



/**************************** PUNJENJE TABELA VREDNOSTIMA ****************************/

--- Punjenje tabele Godine ---

DECLARE @PocetnaGodina int = 2010
WHILE @PocetnaGodina < 2100
BEGIN
	DECLARE @GodinaSkolovanja int = 1
	WHILE @GodinaSkolovanja < 5
	BEGIN
		INSERT INTO dbo.Godine
		(GodinaSkolovanja, SkolskaGodina)
		VALUES (@GodinaSkolovanja, @PocetnaGodina)
	SET @GodinaSkolovanja = @GodinaSkolovanja + 1
	END
SET @PocetnaGodina = @PocetnaGodina + 1
END
GO

--- Punjenje tabele Odeljenje ---

DECLARE @GodinaID int = 1
DECLARE @Max int
WHILE @GodinaID < (SELECT COUNT(*) from dbo.Godine)
BEGIN
	DECLARE @BrojOdeljenja int = 1
	WHILE @BrojOdeljenja < 10
	BEGIN
		INSERT INTO dbo.Odeljenja
		(BrojOdeljenja, GodinaID)
		VALUES (@BrojOdeljenja, @GodinaID)
	SET @BrojOdeljenja = @BrojOdeljenja + 1
	END
SET @GodinaID = @GodinaID + 1
END
GO

----------------------------------------------------------------------------------------------------------------------------------------------

--- Punjenje test podacima Profesori ---

DECLARE @Prf NVARCHAR(50) = N'Profa'
DECLARE @Eml NVARCHAR(50) = N'Em'
DECLARE @Br int = 1
WHILE @Br < 30
	BEGIN 
		INSERT INTO dbo.Profesori
		(ImeProfesora , Email , KontaktTelefon, LoginSifra, Admin )
		VALUES
		( (@Prf + CAST(@BR as varchar(2))) , (@Eml + CAST(@BR as varchar(2))) , N'011-202-202' ,  N'neki hash' , 0 )
	SET @Br = @Br + 1
END
GO

--- Punjenje test podacima TipOcena ---

INSERT INTO eDnevnik.dbo.TipOcene
(TipOcene)
VALUES('Usmeni odgovor');

INSERT INTO eDnevnik.dbo.TipOcene
(TipOcene)
VALUES('Pismeni zadatak');

INSERT INTO eDnevnik.dbo.TipOcene
(TipOcene)
VALUES('Kontrolna vezba');

INSERT INTO eDnevnik.dbo.TipOcene
(TipOcene)
VALUES('Aktivnost na casu');

INSERT INTO eDnevnik.dbo.TipOcene
(TipOcene)
VALUES('Drugo');
GO
SELECT * FROM dbo.TipOcene;
GO
SELECT * FROM dbo.Ucenici




