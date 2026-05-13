Create table logs(
ID INT AUTO_INCREMENT PRIMARY KEY,
    MENSAJE VARCHAR (100),
    FECHA TIMESTAMP DEFAULT current_timestamp
);

DELIMITER //
Create Procedure sp_insertar_pago ( IN p_id_transaccion varchar (50), IN p_codigo_cliente int, in p_forma_pago varchar (20), in p_fecha_pago DATE, in p_total int)

begin
declare v_existe_id_tran varchar(50);

select count(*)
into v_existe_id_tran
from pago where id_transaccion = p_id_transaccion;

if v_existe_id_tran = 0 then

insert into pago (id_transaccion, codigo_cliente, forma_pago, fecha_pago, total)
values (p_id_transaccion, p_codigo_cliente, p_forma_pago, p_fecha_pago, p_total);
CALL sp_insertar_mensaje ('Ejecutado desde Juan');

end if;
end //
DELIMITER ;

Create Procedure sp_insertar_mensaje ( IN p_MENSAJE varchar (100))

begin

insert into logs (MENSAJE)
values (p_MENSAJE);

end //
DELIMITER ;

CREATE EVENT Auditoria_Juan
ON SCHEDULE EVERY 1 minute
DO
CALL  sp_insertar_mensaje ('Ejecutado desde Juan');

CREATE EVENT Auditoria_Juan
ON SCHEDULE EVERY 1 minute
DO
INSERT INTO LOGS(MENSAJE)
    values ('Ejecutado desde evento');