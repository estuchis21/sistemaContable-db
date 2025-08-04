CREATE PROCEDURE selectAsientoPorId
    @id_asiento INT,
    @id_operacion INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM Operaciones
    WHERE id_operacion = @id_operacion
      AND id_asiento = @id_asiento;
END
GO
