Imports System
Imports System.Web
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports System.Data
Imports MySql.Data.MySqlClient

Imports System.Data.OleDb
Imports System.IO
Imports System.Configuration
Imports System.Xml
Imports System.Xml.XmlNode
Imports System.Xml.XmlReader
Imports System.Xml.Serialization

Imports iTextSharp.text
Imports iTextSharp.text.pdf
Imports iTextSharp.text.html
Imports iTextSharp.text.html.simpleparser
' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
<System.Web.Script.Services.ScriptService()> _
<WebService(Namespace:="http://tempuri.org/")> _
<WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Public Class WebService
    Inherits System.Web.Services.WebService
    Dim datos As New datos()
    Dim MyDB As New MyDB
    Public Class CambiaPass
        Public StrRetorna As String = "0"
    End Class
    <WebMethod(EnableSession:=True)> _
    Public Function CambiasPassword(ByVal PassAntiguo As String, ByVal PassNuevo As String, ByVal ConfirmaPassNuevo As String) As List(Of [CambiaPass])
        Dim result As List(Of [CambiaPass]) = New List(Of CambiaPass)()
        Dim str As String
        Dim Adaptador As New MySqlDataAdapter
        Dim TablaUsuario As New DataTable
        Using conexion As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
            Try
                Dim Elementos As New CambiaPass
                If PassNuevo = ConfirmaPassNuevo Then
                    conexion.Open()
                    Dim comando As MySqlCommand
                    comando = conexion.CreateCommand
                    comando.CommandType = Data.CommandType.Text
                    comando.CommandText = "select username, FirstName, LastName, company, imagen from userw where username = '" & Context.Request.Cookies("UserSettings")("user") & "' and password = aes_encrypt('" & PassAntiguo & "', 'gentrac'); "
                    Adaptador.SelectCommand = comando
                    Adaptador.Fill(TablaUsuario)
                    If TablaUsuario.Rows.Count > 0 Then
                        comando.CommandType = Data.CommandType.Text
                        str = "UPDATE userw SET password = aes_encrypt('" & PassNuevo & "', 'gentrac') where username='" & Context.Request.Cookies("UserSettings")("user") & "' and password = aes_encrypt('" & PassAntiguo & "', 'gentrac')"
                        comando.CommandText = str
                        comando.ExecuteNonQuery()
                        Elementos.StrRetorna = "1"
                    Else
                        Elementos.StrRetorna = "La Contraseña Anterior Es Incorrecta."
                    End If
                Else
                    Elementos.StrRetorna = "Las Contraseñas No Coinciden."
                End If
                result.Add(Elementos)
            Catch ex As Exception
                Dim Elementos As New CambiaPass
                Elementos.StrRetorna = ex.Message
                result.Add(Elementos)
            Finally
                conexion.Close()
            End Try
        End Using
        Return result
    End Function
    Public Class ClassMenu
        Public StrError As Integer = "0"
        Public Page As Integer
    End Class
    <WebMethod(EnableSession:=True)> _
    Public Function MostrarMenu() As List(Of [ClassMenu])
        Dim result As List(Of [ClassMenu]) = New List(Of ClassMenu)()
        Dim consulta As String
        Using conexion As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
            Try
                conexion.Open()
                consulta = "select idacce from userd where idrol=(select nrol from userw where ID='" & Context.Request.Cookies("UserSettings")("IdUser") & "' limit 1) and acceso=1;"
                Dim cmd As New MySqlCommand(consulta, conexion)
                Dim reader As MySqlDataReader = cmd.ExecuteReader()
                While reader.Read
                    Dim Elementos As New ClassMenu
                    Elementos.StrError = 1
                    Elementos.Page = reader("idacce")
                    result.Add(Elementos)
                End While
            Catch ex As Exception
                Dim Elementos As New ClassMenu
                Elementos.StrError = ex.Message
                result.Add(Elementos)
            Finally
                conexion.Close()
            End Try
        End Using
        Return result
    End Function
    Public Class ClassProducto
        Public StrError As String = "0"
        Public Producto As String
    End Class
    <WebMethod(EnableSession:=True)> _
    Public Function BuscarProducto(ByVal producto As String) As List(Of [ClassProducto])
        Dim result As List(Of [ClassProducto]) = New List(Of ClassProducto)()
        Dim consulta As String
        Using conexion As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
            Try
                conexion.Open()
                consulta = "select codigo, descripcion from inventario where codigo like '%" & producto & "%' or descripcion like '%" & producto & "%' limit 15;"
                Dim cmd As New MySqlCommand(consulta, conexion)
                Dim reader As MySqlDataReader = cmd.ExecuteReader()
                While reader.Read
                    Dim Elementos As New ClassProducto
                    Elementos.Producto = reader("codigo") & ", " & reader("descripcion")
                    result.Add(Elementos)
                End While
            Catch ex As Exception
                Dim Elementos As New ClassProducto
                Elementos.StrError = ex.Message
                result.Add(Elementos)
            Finally
                conexion.Close()
            End Try
        End Using
        Return result
    End Function
    Public Class ClassProveedor
        Public StrError As String = "0"
        Public Nit As String
        Public Nombre As String
    End Class
    <WebMethod(EnableSession:=True)> _
    Public Function BuscarProveedorNit(ByVal nit As String) As List(Of [ClassProveedor])
        Dim result As List(Of [ClassProveedor]) = New List(Of ClassProveedor)()
        Dim consulta As String
        Using conexion As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
            Try
                conexion.Open()
                consulta = "select nit,Nombre from proveedores where nit='" & nit & "';"
                Dim cmd As New MySqlCommand(consulta, conexion)
                Dim reader As MySqlDataReader = cmd.ExecuteReader()
                While reader.Read
                    Dim Elementos As New ClassProveedor
                    Elementos.Nit = reader("nit")
                    Elementos.Nombre = reader("Nombre")
                    result.Add(Elementos)
                End While
            Catch ex As Exception
                Dim Elementos As New ClassProveedor
                Elementos.StrError = ex.Message
                result.Add(Elementos)
            Finally
                conexion.Close()
            End Try
        End Using
        Return result
    End Function
    Public Class ClassFacturaViaticos
        Public StrError As String = "0"
        Public correlativo As String = "0"
    End Class
    Public Class ClassRecibeDetalleFactura
        Public codigo As String
        Public descripcion As String
        Public cantidad As String
        Public precioUnidad As String
        Public total As String
        Public vehiculo As String
    End Class
    <WebMethod(EnableSession:=True)> _
    Public Function GuardarFacturaViaticos(ByVal Versatec As Integer, ByVal FechaFactura As String, ByVal TipoDocumento As String, ByVal OrdenTrabajo As String, ByVal NitProveedor As String, ByVal NombreProveedor As String, ByVal SerieFactura As String, ByVal NumeroFactura As String, ByVal Observacion As String, ByVal Detalle As List(Of ClassRecibeDetalleFactura)) As List(Of [ClassFacturaViaticos])
        Dim result As List(Of [ClassFacturaViaticos]) = New List(Of ClassFacturaViaticos)()
        Dim MySQLInsert As String
        Using conexion As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
            conexion.Open()
            Dim comando As New MySqlCommand
            Dim transaccion As MySqlTransaction
            transaccion = conexion.BeginTransaction
            comando.Connection = conexion
            comando.Transaction = transaccion
            Try
                If Not datos.ExisteDato("select nit, nombre from proveedores where nit='" & NitProveedor & "';") Then
                    comando.CommandType = Data.CommandType.Text
                    Dim InsertProveedor As String = "INSERT INTO proveedores (nit, Nombre, Direccion, telefono) VALUES ('" & NitProveedor & "','" & NombreProveedor & "',' ', '00000000')"
                    comando.CommandText = InsertProveedor
                    comando.ExecuteNonQuery()
                End If
                Dim Vehiculo As Integer = MyDB.MySelectOneParameter("select id from _vehiculos where npiloto=" & Context.Request.Cookies("UserSettings")("IdPersonal") & " limit 1", "id")
                Dim Departamento As Integer = MyDB.MySelectOneParameter("select idArea from personal where idEmpleado=" & Context.Request.Cookies("UserSettings")("IdPersonal") & " limit 1", "idArea")
                comando.CommandType = Data.CommandType.Text
                Dim fecha As Array = FechaFactura.Split("-")
                FechaFactura = fecha(2) & fecha(1) & fecha(0)
                MySQLInsert = "INSERT INTO facturacion (id_borrar, fecha, usuario, serie, nofac, departamento, provedor, comprador, recibe, descrip, tipo_fac, descuento, status, nempresa, tipo_doc, retencion, tipo_pago, Vehiculo, OrdenTrabajo, Liquidado, Versatec)VALUES" _
                            + "(1, '" & FechaFactura & "', '" & Context.Request.Cookies("UserSettings")("user") & "', '" & SerieFactura & "', '" & NumeroFactura & "','" & Departamento & "', '" & NitProveedor & "', '" & Context.Request.Cookies("UserSettings")("IdPersonal") & "','" & Context.Request.Cookies("UserSettings")("IdPersonal") & "','" & Observacion & "', 1, 0, 1, 23, '" & TipoDocumento & "', 0, 1, '" & Vehiculo & "','" & OrdenTrabajo & "'," & Versatec & "," & Versatec & ")"
                comando.CommandText = MySQLInsert
                comando.ExecuteNonQuery()
                comando.CommandText = "SELECT @@IDENTITY"
                Dim correlativo As Integer = comando.ExecuteScalar
                Dim count As Integer = 0
                Dim InsertDetalle As String = "INSERT INTO facturaciond (codigo, total, precioU, usuario, cantidad, correlativo, nit_proveedor, serie_fac, num_fac, Estado, CargaInventario) VALUES"
                Dim CodVehiculo As String = "N/A"
                Dim totalFactura As Double = 0
                For Each items In Detalle
                    If CodVehiculo = "N/A" Then
                        CodVehiculo = items.vehiculo
                    End If
                    If count = 0 Then
                        InsertDetalle += "('" & items.codigo & "','" & items.total & "', '" & items.precioUnidad & "', '" & Context.Request.Cookies("UserSettings")("user") & "', '" & items.cantidad & "', '" & correlativo & "', '" & NitProveedor & "', '" & SerieFactura & "', '" & NumeroFactura & "',1,1)"
                    Else
                        InsertDetalle += ",('" & items.codigo & "','" & items.total & "', '" & items.precioUnidad & "', '" & Context.Request.Cookies("UserSettings")("user") & "', '" & items.cantidad & "', '" & correlativo & "', '" & NitProveedor & "', '" & SerieFactura & "', '" & NumeroFactura & "',1,1)"
                    End If
                    totalFactura = totalFactura + items.total
                    count += 1
                Next
                comando.CommandText = InsertDetalle
                comando.ExecuteNonQuery()
                If CodVehiculo <> "N/A" Then
                    Dim IdVehiculo As Integer = MyDB.MySelectOneParameter("select id from _vehiculos where codigo='" & CodVehiculo & "'", "id")
                    Dim MySQLupdate As String = "UPDATE facturacion SET Vehiculo = " & IdVehiculo & " WHERE corre=" & correlativo
                    comando.CommandText = MySQLupdate
                    comando.ExecuteNonQuery()
                End If
                If Versatec = 1 Then
                    MyDB.MyInsertsTrasaction("INSERT INTO liquidacion (usuario,Fecha,Anticipo,TotalGastos,SaldoCargo,SaldoFavor,Correlativo) VALUES ('" & Context.Request.Cookies("UserSettings")("user") & "', '" & FechaFactura & "',0,'" & totalFactura & "',0,0,0)", "INSERT INTO liquidaciondetalle (Correlativo,IdFactura,TotalFact,IdLiquidacion) VALUES (0,'" & correlativo & "','" & totalFactura & "', {id})")
                End If
                Dim Elementos As New ClassFacturaViaticos
                Elementos.StrError = "0"
                Elementos.correlativo = correlativo
                result.Add(Elementos)
                transaccion.Commit()
            Catch ex As Exception
                Dim Elementos As New ClassFacturaViaticos
                Elementos.StrError = ex.Message
                result.Add(Elementos)
                transaccion.Dispose()
            Finally
                conexion.Close()
            End Try
        End Using
        Return result
    End Function
    Public Class ClassGastosMensuales
        Public StrError As String = "0"
        Public Fecha As String
        Public Cantidad As String
        Public CantidadGalones As String
        Public TotalGasolina As String
        Public kilometros As String
        Public Nombre As String
        Public Total As String
        Public sumatotal As String
        Public RendimientoKmt As String
        Public CostoKilometro As String
        Public Costo As String
    End Class
    <WebMethod(EnableSession:=True)> _
    Public Function GastosMensuales(ByVal Departamento As String, ByVal FechaInicio As String, ByVal FechaFin As String) As List(Of [ClassGastosMensuales])
        Dim result As List(Of [ClassGastosMensuales]) = New List(Of ClassGastosMensuales)()
        Dim consulta As String
        Using conexion As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
            Try
                conexion.Open()
                'consulta = "select MesFormato(Month(fac.fecha)) Fecha,round(sum(f.cantidad), 2) Cantidad,'REPUESTOS Y MANO DE OBRA' Nombre,round(sum(f.total), 2) Total from facturaciond f inner join (select c.id, c.nombre, i.codigo from inventario i inner join clasificacion c ON i.clasifi = c.id) c ON f.codigo = c.codigo inner join facturacion fac ON fac.corre = f.correlativo where year(fac.fecha) = '" & Year & "' and (departamento = '" & Departamento & "' or '0' = '" & Departamento & "') and f.codigo not in ('DIESEL','GASOLINASUPER','GASOLINAREGULAR')  group by month(fac.fecha);"
                consulta = "select MesFormato(Month(fac.fecha)) Fecha,round(sum(f.cantidad), 2) Cantidad,'REPUESTOS Y MANO DE OBRA' Nombre,round(sum(f.total), 2) Total from facturaciond f inner join (select c.id, c.nombre, i.codigo from inventario i inner join clasificacion c ON i.clasifi = c.id) c ON f.codigo = c.codigo inner join facturacion fac ON fac.corre = f.correlativo where (fac.fecha between '" & FechaInicio & "' and '" & FechaFin & "') and (departamento = '" & Departamento & "' or '0' = '" & Departamento & "') and f.codigo not in ('DIESEL','GASOLINASUPER','GASOLINAREGULAR')  group by month(fac.fecha) order by fac.fecha asc;"

                Dim cmd As New MySqlCommand(consulta, conexion)
                Dim reader As MySqlDataReader = cmd.ExecuteReader()
                While reader.Read
                    Dim Elementos As New ClassGastosMensuales
                    Elementos.Fecha = reader("Fecha")
                    Elementos.Cantidad = reader("Cantidad")
                    'Elementos.CantidadGalones = MyDB.MySelectOneParameter("Select round(sum(f.cantidad), 2) Cantidad from facturaciond f inner join (select c.id, c.nombre, i.codigo from inventario i inner join clasificacion c ON i.clasifi = c.id) c ON f.codigo = c.codigo inner join facturacion fac ON fac.corre = f.correlativo where year(fac.fecha) = '" & Year & "' and (departamento = '" & Departamento & "' or '0' = '" & Departamento & "') and f.codigo in ('DIESEL','GASOLINASUPER','GASOLINAREGULAR') and MesFormato(Month(fac.fecha))= '" & Elementos.Fecha & "'  group by month(fac.fecha)", "Cantidad")
                    'Elementos.kilometros = MyDB.MySelectOneParameter("select ROUND(sum(Distancia),2) as kilometros from actividaddiairiavehiculo inner join (select id, departamento from _vehiculos)vh on IdVehiculo=vh.id where year(fecha) = '" & Year & "' and (vh.departamento = '" & Departamento & "' or '0' = '" & Departamento & "') and MesFormato(Month(fecha))= '" & Elementos.Fecha & "'  group by month(fecha)", "kilometros")

                    Elementos.CantidadGalones = MyDB.MySelectOneParameter("Select round(sum(f.cantidad), 2) Cantidad from facturaciond f inner join (select c.id, c.nombre, i.codigo from inventario i inner join clasificacion c ON i.clasifi = c.id) c ON f.codigo = c.codigo inner join facturacion fac ON fac.corre = f.correlativo where (fac.fecha between '" & FechaInicio & "' and '" & FechaFin & "') and (departamento = '" & Departamento & "' or '0' = '" & Departamento & "') and f.codigo in ('DIESEL','GASOLINASUPER','GASOLINAREGULAR') and MesFormato(Month(fac.fecha))= '" & Elementos.Fecha & "'  group by month(fac.fecha)", "Cantidad")
                    Elementos.kilometros = MyDB.MySelectOneParameter("select ROUND(sum(Distancia),2) as kilometros from actividaddiairiavehiculo inner join (select id, departamento from _vehiculos)vh on IdVehiculo=vh.id where (fecha between '" & FechaInicio & "' and '" & FechaFin & "') and (vh.departamento = '" & Departamento & "' or '0' = '" & Departamento & "') and MesFormato(Month(fecha))= '" & Elementos.Fecha & "'  group by month(fecha)", "kilometros")


                    Elementos.Nombre = reader("Nombre")
                    Elementos.Total = reader("Total")
                    'Elementos.TotalGasolina = MyDB.MySelectOneParameter("select round(sum(f.total), 2) TotalGasolina from facturaciond f inner join (select c.id, c.nombre, i.codigo from inventario i inner join clasificacion c ON i.clasifi = c.id) c ON f.codigo = c.codigo inner join facturacion fac ON fac.corre = f.correlativo where year(fac.fecha) = '" & Year & "' and (departamento = '" & Departamento & "' or '0' = '" & Departamento & "') and f.codigo in ('DIESEL','GASOLINASUPER','GASOLINAREGULAR') and MesFormato(Month(fac.fecha))= '" & Elementos.Fecha & "'  group by month(fac.fecha)", "TotalGasolina")
                    Elementos.TotalGasolina = MyDB.MySelectOneParameter("select round(sum(f.total), 2) TotalGasolina from facturaciond f inner join (select c.id, c.nombre, i.codigo from inventario i inner join clasificacion c ON i.clasifi = c.id) c ON f.codigo = c.codigo inner join facturacion fac ON fac.corre = f.correlativo where (fac.fecha between '" & FechaInicio & "' and '" & FechaFin & "') and (departamento = '" & Departamento & "' or '0' = '" & Departamento & "') and f.codigo in ('DIESEL','GASOLINASUPER','GASOLINAREGULAR') and MesFormato(Month(fac.fecha))= '" & Elementos.Fecha & "'  group by month(fac.fecha)", "TotalGasolina")

                    Elementos.RendimientoKmt = FormatNumber((Elementos.kilometros / (Elementos.CantidadGalones)), 3)

                    If Elementos.CantidadGalones = 0 Then
                        Elementos.RendimientoKmt = 0
                    End If
                    'Elementos.sumatotal = MyDB.MySelectOneParameter("select round(sum(f.total), 2) TotalGasolina from facturaciond f inner join (select c.id, c.nombre, i.codigo from inventario i inner join clasificacion c ON i.clasifi = c.id) c ON f.codigo = c.codigo inner join facturacion fac ON fac.corre = f.correlativo where year(fac.fecha) = '" & Year & "' and (departamento = '" & Departamento & "' or '0' = '" & Departamento & "') and MesFormato(Month(fac.fecha))= '" & Elementos.Fecha & "'  group by month(fac.fecha)", "TotalGasolina")
                    Elementos.sumatotal = MyDB.MySelectOneParameter("select round(sum(f.total), 2) TotalGasolina from facturaciond f inner join (select c.id, c.nombre, i.codigo from inventario i inner join clasificacion c ON i.clasifi = c.id) c ON f.codigo = c.codigo inner join facturacion fac ON fac.corre = f.correlativo where (fac.fecha between '" & FechaInicio & "' and '" & FechaFin & "') and (departamento = '" & Departamento & "' or '0' = '" & Departamento & "') and MesFormato(Month(fac.fecha))= '" & Elementos.Fecha & "'  group by month(fac.fecha)", "TotalGasolina")

                    Elementos.CostoKilometro = FormatNumber((Elementos.sumatotal / Elementos.kilometros), 3)

                    If Elementos.kilometros = 0 Then
                        Elementos.CostoKilometro = 0
                    End If


                    result.Add(Elementos)
                End While
            Catch ex As Exception
                Dim Elementos As New ClassGastosMensuales
                Elementos.StrError = ex.Message
                result.Add(Elementos)
            Finally
                conexion.Close()
            End Try
        End Using
        Return result
    End Function
    Public Function RetornaMesNumero(ByVal Mes As String) As Integer
        Dim retorna As Integer
        Select Case Mes
            Case "ENERO" : retorna = 1
            Case "FEBRERO" : retorna = 2
            Case "MARZO" : retorna = 3
            Case "ABRIL" : retorna = 4
            Case "MAYO" : retorna = 5
            Case "JUNIO" : retorna = 6
            Case "JULIO" : retorna = 7
            Case "AGOSTO" : retorna = 8
            Case "SEPTIEMBRE" : retorna = 9
            Case "OCTUBRE" : retorna = 10
            Case "NOVIEMBRE" : retorna = 11
            Case "DICIEMBRE" : retorna = 12
        End Select
        Return retorna
    End Function
    Public Class ClassGastosPorClasificacion
        Public StrError As String = "0"
        Public IdNombre As String
        Public Id2 As String = "0"
        Public Fecha As String
        Public Cantidad As String
        Public Nombre As String
        Public Total As String
        Public Porcent As String
        Public TotalT As String
    End Class
    <WebMethod(EnableSession:=True)> _
    Public Function GastosPorClasificacion(ByVal Departamento As String, ByVal Mes As String, ByVal FechaInicio As String, ByVal FechaFin As String) As List(Of [ClassGastosPorClasificacion])
        Dim result As List(Of [ClassGastosPorClasificacion]) = New List(Of ClassGastosPorClasificacion)()
        Dim consulta As String
        Mes = RetornaMesNumero(Mes)
        Using conexion As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
            Try
                conexion.Open()
                consulta = "select c.id, MesFormato(month(fc.fecha)) fecha,round(sum(f.cantidad), 2) Cantidad,c.nombre Nombre,round(sum(f.total), 2) Total from facturaciond f inner join (select c.id, c.nombre, i.codigo from inventario i inner join clasificacion c ON i.clasifi = c.id) c ON f.codigo = c.codigo  inner join (select * from facturacion where (fecha between '" & FechaInicio & "' and '" & FechaFin & "') and month(fecha)='" & Mes & "' and (departamento='" & Departamento & "' or '0'='" & Departamento & "') ) fc on fc.corre=f.correlativo group by c.id order by Total desc;"
                Dim cmd As New MySqlCommand(consulta, conexion)
                Dim reader As MySqlDataReader = cmd.ExecuteReader()
                While reader.Read
                    Dim Elementos As New ClassGastosPorClasificacion
                    Elementos.IdNombre = reader("id")
                    Elementos.Fecha = reader("fecha")
                    Elementos.Cantidad = reader("Cantidad")
                    Elementos.Nombre = reader("Nombre")
                    Elementos.Total = reader("Total")
                    Elementos.TotalT = MyDB.MySelectOneParameter("select round(sum(f.total), 2) Total from facturaciond f inner join (select c.id, c.nombre, i.codigo from inventario i inner join clasificacion c ON i.clasifi = c.id) c ON f.codigo = c.codigo  inner join (select * from facturacion where (fecha between '" & FechaInicio & "' and '" & FechaFin & "') and month(fecha)='" & Mes & "' and (departamento='" & Departamento & "' or '0'='" & Departamento & "') ) fc on fc.corre=f.correlativo order by Total desc;", "Total")
                    Elementos.Porcent = Format(((reader("Total") * 100) / Elementos.TotalT), "##,##0.00")

                    result.Add(Elementos)
                End While
            Catch ex As Exception
                Dim Elementos As New ClassGastosPorClasificacion
                Elementos.StrError = ex.Message
                result.Add(Elementos)
            Finally
                conexion.Close()
            End Try
        End Using
        Return result
    End Function
    <WebMethod(EnableSession:=True)> _
    Public Function GastosPorSubClasificacion(ByVal Departamento As String, ByVal Mes As String, ByVal idClasificacion As String, ByVal FechaInicio As String, ByVal FechaFin As String) As List(Of [ClassGastosPorClasificacion])
        Dim result As List(Of [ClassGastosPorClasificacion]) = New List(Of ClassGastosPorClasificacion)()
        Dim consulta As String
        Mes = RetornaMesNumero(Mes)
        Using conexion As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
            Try
                conexion.Open()
                consulta = "select c.id,c.id2, MesFormato(month(fac.fecha)) fecha,round(sum(f.cantidad),2) Cantidad, c.nombre Nombre,round(sum(f.total),2) Total from facturaciond f inner join (select c.id,c.id2,c.descripcion nombre,i.codigo from inventario i inner join subclasificacion c on i.subclasi=c.id and i.clasifi='" & idClasificacion & "') c on f.codigo=c.codigo inner join (select * from facturacion where (fecha between '" & FechaInicio & "' and '" & FechaFin & "') and month(fecha)=" & Mes & " and (departamento='" & Departamento & "' or '0'='" & Departamento & "') ) fac on fac.corre=f.correlativo group by c.id order by Total desc;"
                Dim cmd As New MySqlCommand(consulta, conexion)
                Dim reader As MySqlDataReader = cmd.ExecuteReader()
                While reader.Read
                    Dim Elementos As New ClassGastosPorClasificacion
                    Elementos.IdNombre = reader("id")
                    Elementos.Id2 = reader("id2")
                    Elementos.Fecha = reader("fecha")
                    Elementos.Cantidad = reader("Cantidad")
                    Elementos.Nombre = reader("Nombre")
                    Elementos.Total = reader("Total")
                    Elementos.TotalT = MyDB.MySelectOneParameter("select round(sum(f.total),2) Total from facturaciond f inner join (select c.id,c.id2,c.descripcion nombre,i.codigo from inventario i inner join subclasificacion c on i.subclasi=c.id and i.clasifi='" & idClasificacion & "') c on f.codigo=c.codigo inner join (select * from facturacion where (fecha between '" & FechaInicio & "' and '" & FechaFin & "') and month(fecha)=" & Mes & " and (departamento='" & Departamento & "' or '0'='" & Departamento & "') ) fac on fac.corre=f.correlativo order by Total desc;", "Total")
                    Elementos.Porcent = Format(((reader("Total") * 100) / Elementos.TotalT), "##,##0.00")
                    result.Add(Elementos)
                End While
            Catch ex As Exception
                Dim Elementos As New ClassGastosPorClasificacion
                Elementos.StrError = ex.Message
                result.Add(Elementos)
            Finally
                conexion.Close()
            End Try
        End Using
        Return result
    End Function
    Public Class ClassDetalleGastos
        Public StrError As String = "0"
        Public Fecha As String
        Public Vehiculo As String
        Public Codigo As String
        Public Descripcion As String
        Public Cantidad As String
        Public Precio As String
        Public Total As String
    End Class
    <WebMethod(EnableSession:=True)> _
    Public Function DetalleGastos(ByVal Departamento As String, ByVal Mes As String, ByVal idClasificacion As String, ByVal idSubClasificacion As String, ByVal FechaInicio As String, ByVal FechaFin As String) As List(Of [ClassDetalleGastos])
        Dim result As List(Of [ClassDetalleGastos]) = New List(Of ClassDetalleGastos)()
        Dim consulta As String
        Mes = RetornaMesNumero(Mes)
        Using conexion As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
            Try
                conexion.Open()
                consulta = "select fac.fecha Fecha,FnBuscaVehiculo(fac.Vehiculo) Vehiculo,i.codigo Codigo,i.descripcion Descripcion,round(d.cantidad,2) Cantidad, round(d.precioU) Precio,round(d.total,2) Total from inventario i inner join facturaciond d on i.codigo=d.codigo inner join (select  fecha,corre,Vehiculo from facturacion where (fecha between '" & FechaInicio & "' and '" & FechaFin & "') and month(fecha) = '" & Mes & "' and (departamento = '" & Departamento & "' or '0' = '" & Departamento & "')) fac on fac.corre=d.correlativo where i.subclasi='" & idSubClasificacion & "' and i.clasifi='" & idClasificacion & "';"
                Dim cmd As New MySqlCommand(consulta, conexion)
                Dim reader As MySqlDataReader = cmd.ExecuteReader()
                While reader.Read
                    Dim Elementos As New ClassDetalleGastos
                    Elementos.Fecha = reader("Fecha")
                    Elementos.Vehiculo = reader("Vehiculo")
                    Elementos.Codigo = reader("Codigo")
                    Elementos.Descripcion = reader("Descripcion")
                    Elementos.Cantidad = reader("Cantidad")
                    Elementos.Precio = reader("Precio")
                    Elementos.Total = reader("Total")
                    result.Add(Elementos)
                End While
            Catch ex As Exception
                Dim Elementos As New ClassDetalleGastos
                Elementos.StrError = ex.Message
                result.Add(Elementos)
            Finally
                conexion.Close()
            End Try
        End Using
        Return result
    End Function
    Public Class ClassRecorridoMensual
        Public StrError As String = "0"
        Public Dia As String
        Public Vehiculo As String
        Public Recorrido As String
    End Class
    <WebMethod(EnableSession:=True)> _
    Public Function RecorridoMensual(ByVal Departamento As String, ByVal Mes As String, ByVal FechaInicio As String, ByVal FechaFin As String) As List(Of [ClassRecorridoMensual])
        Dim result As List(Of [ClassRecorridoMensual]) = New List(Of ClassRecorridoMensual)()
        Dim consulta As String
        Using conexion As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
            Try
                conexion.Open()
                consulta = "select  veh.codigo Vehiculo,day(fecha) Dia,kmant KmAnterior,kmi Km,(kmi - kmant) Recorrido from ikms ik inner join (select id,codigo from _vehiculos where (departamento = '" & Departamento & "' or '0' = '" & Departamento & "')) veh ON veh.id = ik.Vehiculo where (fecha between '" & FechaInicio & "' and '" & FechaFin & "') and month(fecha) = " & Mes & " group by Vehiculo , fecha order by vehiculo , fecha asc;"
                Dim cmd As New MySqlCommand(consulta, conexion)
                Dim reader As MySqlDataReader = cmd.ExecuteReader()
                While reader.Read
                    Dim Elementos As New ClassRecorridoMensual
                    Elementos.Dia = reader("Dia")
                    Elementos.Vehiculo = reader("Vehiculo")
                    Elementos.Recorrido = Math.Round(reader("Recorrido"))
                    result.Add(Elementos)
                End While
            Catch ex As Exception
                Dim Elementos As New ClassRecorridoMensual
                Elementos.StrError = ex.Message
                result.Add(Elementos)
            Finally
                conexion.Close()
            End Try
        End Using
        Return result
    End Function
    Public Class ClassReservacionVehiculo
        Public StrError As String = "0"
    End Class
    Public Class ClassRecibeDestinoReservacion
        Public Dest As String
    End Class
    <WebMethod(EnableSession:=True)> _
    Public Function GuardarReservacionVehiculo(ByVal Correo As String, ByVal TipoVehiculo As String, ByVal Destino As List(Of ClassRecibeDestinoReservacion), ByVal FechaInicio As String, ByVal FechaFin As String, ByVal Alerta As String, ByVal Observaciones As String, ByVal LugarViaje As String) As List(Of [ClassReservacionVehiculo])
        Dim result As List(Of [ClassReservacionVehiculo]) = New List(Of ClassReservacionVehiculo)()
        Dim MysqlUPDATE As String
        Dim IdEmpleado As String = Context.Request.Cookies("UserSettings")("IdPersonal")
        Dim Ecorreo As Boolean = False
        Using conexion As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
            conexion.Open()
            Dim comando As New MySqlCommand
            Dim transaccion As MySqlTransaction
            transaccion = conexion.BeginTransaction
            comando.Connection = conexion
            comando.Transaction = transaccion
            Try
                Dim cmd As New MySqlCommand("select Id from reservacionvehiculo where ('" & FechaInicio & "' between FechaInicio and fechaFin) and IdEmpleado=" & IdEmpleado & " and Estado<>2 and Estado<>4 limit 1;", conexion)
                Dim reader As MySqlDataReader = cmd.ExecuteReader()
                reader.Read()
                If Not reader.HasRows Then
                    cmd.Dispose()
                    reader.Close()
                    comando.CommandType = Data.CommandType.Text
                    MysqlUPDATE = "UPDATE personal SET correo='" & Replace(Correo, ";", ",") & "' WHERE idEmpleado='" & IdEmpleado & "';"
                    comando.CommandText = MysqlUPDATE
                    comando.ExecuteNonQuery()
                    comando.CommandType = Data.CommandType.Text
                    Dim InsertReservacion As String = "INSERT INTO ReservacionVehiculo (IdEmpleado, IdTipoVehiculo,LugarViaje,FechaInicio, FechaFin, TodoElDia, Alerta, Observacion, Estado) VALUES ('" & IdEmpleado & "','" & TipoVehiculo & "','" & LugarViaje & "','" & FechaInicio & "','" & FechaFin & "',0,'" & Alerta & "','" & Observaciones & "',0);"
                    comando.CommandText = InsertReservacion
                    comando.ExecuteNonQuery()
                    comando.CommandText = "SELECT @@IDENTITY"
                    Dim correlativo As Integer = comando.ExecuteScalar
                    Dim InsertDestinos As String = "INSERT INTO destinoreservacionvehiculo (IdReservacion, Destino) VALUES"
                    Dim count As Integer = 0
                    Dim StrDestinos As String = ""
                    For Each items In Destino
                        If count = 0 Then
                            InsertDestinos += "(" & correlativo & ",'" & items.Dest & "')"
                            StrDestinos += items.Dest
                        Else
                            InsertDestinos += ",(" & correlativo & ",'" & items.Dest & "')"
                            StrDestinos += "<br >" & items.Dest
                        End If
                        count += 1
                    Next
                    comando.CommandText = InsertDestinos
                    comando.ExecuteNonQuery()
                    Dim consulta As String
                    consulta = "select p.nombre Nombre, t.tipo_vehiculo TipoVehiculo from reservacionvehiculo r inner join personal p on r.IdEmpleado=p.idEmpleado inner join tipo_vehiculo t on r.IdTipoVehiculo=t.id_tipo_vehiculo  where r.Id=" & correlativo
                    Dim cm As New MySqlCommand(consulta, conexion)
                    Dim read As MySqlDataReader = cm.ExecuteReader()
                    Dim _Empleado As String = ""
                    Dim _TipoVehiculo As String = ""
                    While read.Read
                        _Empleado = read("Nombre")
                        _TipoVehiculo = read("TipoVehiculo")
                    End While
                    read.Close()
                    Dim cuerpoMensaje As String = "<br>Reservación de vehiculo Para " _
                                               & FechaInicio.ToString _
                                               & "<br> <br><table><thead><tr bgcolor='#429bff'><th>Empleado</th><th>Destino</th><th>Fecha Inicio</th><th>Fecha Fin</th><th>Tipo Vehiculo</th><th>Obervacion</th></tr></thead><tbody><tr><td>" & _Empleado & "</td><td>" & StrDestinos & "</td><td>" & FechaInicio & "</td><td>" & FechaFin & "</td><td>" & _TipoVehiculo & "</td><td>" & Observaciones & "</td><tr></tbody></table>"
                    Ecorreo = EnviarCorreo("viniciogarrido@grupo-genera.com, juliosecaida@grupo-genera.com, guillermoandres@grupo-genera.com", "Reservación de Vehiculo", cuerpoMensaje)
                    Dim Elementos As New ClassReservacionVehiculo
                    If Not Ecorreo Then
                        transaccion.Dispose()
                        Elementos.StrError = "Porfavor Intentar De Nuevo."
                        result.Add(Elementos)
                    Else
                        Elementos.StrError = "0"
                        result.Add(Elementos)
                        transaccion.Commit()
                    End If
                Else
                    cmd.Dispose()
                    reader.Close()
                    Dim Elementos As New ClassReservacionVehiculo
                    Elementos.StrError = "Error, Ya tiene Una Reservacion Para esta fecha"
                    result.Add(Elementos)
                End If
            Catch ex As Exception
                transaccion.Rollback()
                Dim Elementos As New ClassReservacionVehiculo
                Elementos.StrError = ex.Message
                result.Add(Elementos)

            Finally
                conexion.Close()
            End Try
        End Using
        Return result
    End Function
    Public Class ClassReservacionesVehiculos
        Public StrError As String = "0"
        Public id As Integer
        Public title As String
        Public allDay As Boolean
        Public start As String
        Public ends As String
        Public status As String
        Public destino As List(Of ClassDestinosReservacion)
        Public tipoVehiculo As String
        Public observacion As String
        Public UsuarioAutoriza As String
        Public color As String
        Public vehiculo As String
        Public FechaEntrega As String
        Public FechaDevolucion As String
        Public HoraEntrega As String
        Public HoraDevolucion As String
        Public FechaReservacion As String
        Public HoraReservacion As String
        Public FechaAutorizacion As String
        Public HoraAutorizacion As String
        Public TiempoRespuesta As String
        Public FechaAsignacion As String
        Public HoraAsignacion As String
    End Class
    Public Class ClassDestinosReservacion
        Public IdReservacion As Integer
        Public Destino As String
    End Class
    <WebMethod(EnableSession:=True)> _
    Public Function ReservacionesVehiculos(ByVal Id As String, ByVal Estado As String) As List(Of [ClassReservacionesVehiculos])
        Dim result As List(Of [ClassReservacionesVehiculos]) = New List(Of ClassReservacionesVehiculos)()
        Dim consulta As String
        Using conexion As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
            Try
                conexion.Open()
                Dim SqlEstado As String = ""
                If Estado <> "2" Then
                    SqlEstado = "and res.Estado!=2"
                End If
                Dim SqlEstado4 As String = ""
                If Estado <> "4" Then
                    SqlEstado4 = "and res.Estado!=4"
                End If
                If Context.Request.Cookies("UserSettings")("Flota") = "0" Then
                    consulta = "select FnBuscaVehiculo(res.IdVehiculo) Vehiculo,res.Id,res.IdTipoReservacion,res.IdEmpleado,per.nombre Nombre, res.Encargado,tip.tipo_vehiculo TipoVehiculo,CAST(res.FechaInicio as char) FechaInicio,cast(res.FechaFin as char) FechaFin,res.TodoElDia,res.Alerta,res.Observacion,res.Estado,res.UsuarioAutoriza, SUBSTRING(CAST(res.FechaEntrega as char),1,10) FechaEntrega,SUBSTRING(CAST(res.FechaEntrega as char),12,8) HoraEntrega, SUBSTRING(CAST(res.FechaDevolucion as char),1,10) FechaDevolucion,SUBSTRING(CAST(res.FechaDevolucion as char),12,8) HoraDevolucion     ,SUBSTRING(CAST(res.FechaReservacion as char),1,10) FechaReservacion,SUBSTRING(CAST(res.FechaReservacion as char),12,8) HoraReservacion, SUBSTRING(CAST(res.FechaAutorizacion as char),1,10) FechaAutorizacion,SUBSTRING(CAST(res.FechaAutorizacion as char),12,8) HoraAutorizacion  , SUBSTRING(CAST(res.FechaRecepcion as char),1,10) FechaRecepcion,SUBSTRING(CAST(res.FechaRecepcion as char),12,8) HoraRecepcion    from reservacionvehiculo res inner join personal per on res.idEmpleado=per.idEmpleado inner join tipo_vehiculo tip on res.IdTipoVehiculo=tip.id_tipo_vehiculo and res.FechaInicio>DATE_SUB(now(), INTERVAL 4 MONTH) and (res.id=" & Id & " or 0=" & Id & ") and (res.Estado='" & Estado & "' or '%'='" & Estado & "') " & SqlEstado & " " & SqlEstado4 & ";"
                Else
                    consulta = "select FnBuscaVehiculo(res.IdVehiculo) Vehiculo,res.Id,res.IdTipoReservacion,res.IdEmpleado,per.nombre Nombre, res.Encargado,tip.tipo_vehiculo TipoVehiculo,CAST(res.FechaInicio as char) FechaInicio,cast(res.FechaFin as char) FechaFin,res.TodoElDia,res.Alerta,res.Observacion,res.Estado,res.UsuarioAutoriza , SUBSTRING(CAST(res.FechaEntrega as char),1,10) FechaEntrega,SUBSTRING(CAST(res.FechaEntrega as char),12,8) HoraEntrega, SUBSTRING(CAST(res.FechaDevolucion as char),1,10) FechaDevolucion,SUBSTRING(CAST(res.FechaDevolucion as char),12,8) HoraDevolucion    ,SUBSTRING(CAST(res.FechaReservacion as char),1,10) FechaReservacion,SUBSTRING(CAST(res.FechaReservacion as char),12,8) HoraReservacion, SUBSTRING(CAST(res.FechaAutorizacion as char),1,10) FechaAutorizacion,SUBSTRING(CAST(res.FechaAutorizacion as char),12,8) HoraAutorizacion  , SUBSTRING(CAST(res.FechaRecepcion as char),1,10) FechaRecepcion,SUBSTRING(CAST(res.FechaRecepcion as char),12,8) HoraRecepcion    from reservacionvehiculo res inner join (select idEmpleado,nombre from personal where idArea in(" & Context.Request.Cookies("UserSettings")("Flota") & ")) per on res.idEmpleado=per.idEmpleado inner join tipo_vehiculo tip on res.IdTipoVehiculo=tip.id_tipo_vehiculo and res.FechaInicio>DATE_SUB(now(), INTERVAL 4 MONTH) and (res.id=" & Id & " or 0=" & Id & ") and (res.Estado='" & Estado & "' or '%'='" & Estado & "') " & SqlEstado & " " & SqlEstado4 & ";"
                End If
                Dim cmd As New MySqlCommand(consulta, conexion)
                Dim reader As MySqlDataReader = cmd.ExecuteReader()
                While reader.Read
                    Dim Elementos As New ClassReservacionesVehiculos
                    Elementos.id = reader("Id")
                    If reader("IdTipoReservacion") = 2 Then
                        Elementos.title = reader("Encargado")
                    Else
                        Elementos.title = reader("Nombre")
                    End If
                    Elementos.allDay = reader("TodoElDia")
                    Elementos.tipoVehiculo = reader("TipoVehiculo")
                    Elementos.start = reader("FechaInicio").ToString()
                    Elementos.ends = reader("FechaFin").ToString()
                    Elementos.status = reader("Estado")
                    Elementos.vehiculo = reader("Vehiculo")

                    If Not IsDBNull(reader("FechaEntrega")) Then
                        Elementos.FechaEntrega = reader("FechaEntrega").ToString()
                    Else
                        Elementos.FechaEntrega = "No Disponible"
                    End If
                    If Not IsDBNull(reader("FechaDevolucion")) Then
                        Elementos.FechaDevolucion = reader("FechaDevolucion").ToString()
                    Else
                        Elementos.FechaDevolucion = "No Disponible"
                    End If
                    If Not IsDBNull(reader("HoraEntrega")) Then
                        Elementos.HoraEntrega = reader("HoraEntrega").ToString()
                    Else
                        Elementos.HoraEntrega = "No Disponible"
                    End If
                    If Not IsDBNull(reader("HoraDevolucion")) Then
                        Elementos.HoraDevolucion = reader("HoraDevolucion").ToString()
                    Else
                        Elementos.HoraDevolucion = "No Disponible"
                    End If



                    If Not IsDBNull(reader("FechaReservacion")) Then
                        Elementos.FechaReservacion = reader("FechaReservacion").ToString()
                    Else
                        Elementos.FechaReservacion = "No Disponible"
                    End If
                    If Not IsDBNull(reader("FechaAutorizacion")) Then
                        Elementos.FechaAutorizacion = reader("FechaAutorizacion").ToString()
                    Else
                        Elementos.FechaAutorizacion = "No Disponible"
                    End If
                    If Not IsDBNull(reader("HoraReservacion")) Then
                        Elementos.HoraReservacion = reader("HoraReservacion").ToString()
                    Else
                        Elementos.HoraReservacion = "No Disponible"
                    End If
                    If Not IsDBNull(reader("HoraAutorizacion")) Then
                        Elementos.HoraAutorizacion = reader("HoraAutorizacion").ToString()
                    Else
                        Elementos.HoraAutorizacion = "No Disponible"
                    End If

                    If Not IsDBNull(reader("FechaRecepcion")) Then
                        Elementos.FechaAsignacion = reader("FechaRecepcion").ToString()
                    Else
                        Elementos.FechaAsignacion = "No Disponible"
                    End If
                    If Not IsDBNull(reader("HoraRecepcion")) Then
                        Elementos.HoraAsignacion = reader("HoraRecepcion").ToString()
                    Else
                        Elementos.HoraAsignacion = "No Disponible"
                    End If

                    If reader("Estado") = 0 Then
                        Elementos.color = "#cc0202"
                    ElseIf reader("Estado") = 1 Then
                        Elementos.color = "green"
                    ElseIf reader("Estado") = 2 Then
                        Elementos.color = "gray"
                    ElseIf reader("Estado") = 3 Then
                        Elementos.color = "#428BCA"
                    ElseIf reader("Estado") = 4 Then
                        Elementos.color = "#1f598a"
                    ElseIf reader("Estado") = 1 Then
                        Elementos.color = "#065180"
                    End If
                    Using conn As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
                        conn.Open()
                        Dim AddDestinos As List(Of [ClassDestinosReservacion]) = New List(Of ClassDestinosReservacion)()
                        consulta = "select IdReservacion, Destino from DestinoReservacionVehiculo where IdReservacion=" & reader("Id")
                        Dim command As New MySqlCommand(consulta, conn)
                        Dim read As MySqlDataReader = command.ExecuteReader()
                        While read.Read
                            Dim ListDestino As New ClassDestinosReservacion
                            ListDestino.IdReservacion = read("IdReservacion")
                            ListDestino.Destino = read("Destino")
                            AddDestinos.Add(ListDestino)
                        End While
                        read.Close()
                        Elementos.destino = AddDestinos
                        conn.Close()
                    End Using

                    Elementos.observacion = reader("Observacion")
                    If Not IsDBNull(reader("UsuarioAutoriza")) Then
                        Elementos.UsuarioAutoriza = reader("UsuarioAutoriza")
                    End If
                    result.Add(Elementos)
                End While
            Catch ex As Exception
                Dim Elementos As New ClassReservacionesVehiculos
                Elementos.StrError = ex.Message
                result.Add(Elementos)
            Finally
                conexion.Close()
            End Try
        End Using
        Return result
    End Function
    <WebMethod(EnableSession:=True)> _
    Public Function ReservacionesVehiculosEmpleado(ByVal Id As String, ByVal Estado As String) As List(Of [ClassReservacionesVehiculos])
        Dim result As List(Of [ClassReservacionesVehiculos]) = New List(Of ClassReservacionesVehiculos)()
        Dim consulta As String
        Dim IdEmpleado As String = Context.Request.Cookies("UserSettings")("IdPersonal")
        Using conexion As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
            Try
                conexion.Open()
                consulta = "select FnBuscaVehiculo(res.IdVehiculo) Vehiculo,res.Id,res.IdEmpleado,per.nombre Nombre,tip.tipo_vehiculo TipoVehiculo,CAST(res.FechaInicio as char) FechaInicio,cast(res.FechaFin as char) FechaFin,res.TodoElDia,res.Alerta,res.Observacion,res.Estado,res.UsuarioAutoriza from reservacionvehiculo res inner join personal per on res.idEmpleado=per.idEmpleado inner join tipo_vehiculo tip on res.IdTipoVehiculo=tip.id_tipo_vehiculo and res.FechaInicio>DATE_SUB(now(), INTERVAL 3 MONTH) and (res.idEmpleado=" & IdEmpleado & " or 0=" & IdEmpleado & ") and (res.id=" & Id & " or 0=" & Id & ") and (res.Estado='" & Estado & "' or '%'='" & Estado & "');"
                Dim cmd As New MySqlCommand(consulta, conexion)
                Dim reader As MySqlDataReader = cmd.ExecuteReader()
                While reader.Read
                    Dim Elementos As New ClassReservacionesVehiculos
                    Elementos.id = reader("Id")
                    Elementos.title = reader("Nombre")
                    Elementos.allDay = reader("TodoElDia")
                    Elementos.tipoVehiculo = reader("TipoVehiculo")
                    Elementos.start = reader("FechaInicio").ToString()
                    Elementos.ends = reader("FechaFin").ToString()
                    Elementos.status = reader("Estado")
                    Elementos.vehiculo = reader("Vehiculo")
                    If reader("Estado") = 0 Then
                        Elementos.color = "#cc0202"
                    ElseIf reader("Estado") = 1 Then
                        Elementos.color = "green"
                    ElseIf reader("Estado") = 2 Then
                        Elementos.color = "gray"
                    ElseIf reader("Estado") = 3 Then
                        Elementos.color = "#428BCA"
                    ElseIf reader("Estado") = 4 Then
                        Elementos.color = "#1f598a"
                    ElseIf reader("Estado") = 1 Then
                        Elementos.color = "#065180"
                    End If
                    Using conn As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
                        conn.Open()
                        Dim AddDestinos As List(Of [ClassDestinosReservacion]) = New List(Of ClassDestinosReservacion)()
                        consulta = "select IdReservacion, Destino from DestinoReservacionVehiculo where IdReservacion=" & reader("Id")
                        Dim command As New MySqlCommand(consulta, conn)
                        Dim read As MySqlDataReader = command.ExecuteReader()
                        While read.Read
                            Dim ListDestino As New ClassDestinosReservacion
                            ListDestino.IdReservacion = read("IdReservacion")
                            ListDestino.Destino = read("Destino")
                            AddDestinos.Add(ListDestino)
                        End While
                        read.Close()
                        Elementos.destino = AddDestinos
                        conn.Close()
                    End Using
                    Elementos.observacion = reader("Observacion")
                    If Not IsDBNull(reader("UsuarioAutoriza")) Then
                        Elementos.UsuarioAutoriza = reader("UsuarioAutoriza")
                    End If
                    result.Add(Elementos)
                End While
            Catch ex As Exception
                Dim Elementos As New ClassReservacionesVehiculos
                Elementos.StrError = ex.Message
                result.Add(Elementos)
            Finally
                conexion.Close()
            End Try
        End Using
        Return result
    End Function
    Public Class ClassAprobarReservacion
        Public StrError As String = "0"
    End Class
    <WebMethod(EnableSession:=True)> _
    Public Function AprobarReservacion(ByVal Id As String, ByVal IdVehiculo As String, ByVal Observacion As String) As List(Of [ClassAprobarReservacion])
        Dim result As List(Of [ClassAprobarReservacion]) = New List(Of ClassAprobarReservacion)()
        Dim MysqlUPDATE As String
        Dim Usuario As String = Context.Request.Cookies("UserSettings")("user")
        Using conexion As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
            conexion.Open()
            Dim comando As New MySqlCommand
            Dim transaccion As MySqlTransaction
            transaccion = conexion.BeginTransaction
            comando.Connection = conexion
            comando.Transaction = transaccion
            Try
                Dim cmd As New MySqlCommand("select Id from reservacionvehiculo where (((select FechaInicio from reservacionvehiculo where id=" & Id & ") between date_sub(FechaInicio, interval 0 hour) and date_sub(fechaFin,interval 0 hour)) or ((select FechaFin from reservacionvehiculo where id=" & Id & ") between date_sub(FechaInicio, interval 0 hour) and date_sub(fechaFin,interval 0 hour))) and IdVehiculo=" & IdVehiculo & " and IdVehiculo!=484 and Estado<>2 and Estado<>4 limit 1;", conexion)
                Dim reader As MySqlDataReader = cmd.ExecuteReader()
                Dim Respuesta As String
                Dim Estado As Integer
                Dim mensaje As String
                reader.Read()
                If Not reader.HasRows Then
                    cmd.Dispose()
                    reader.Close()

                    comando.CommandType = Data.CommandType.Text
                    If IdVehiculo = "484" Then
                        Observacion = "ESTIMADO USUARIO:Acusamos de recibida su solicitud, estamos coordinando de acuerdo a programación para su asignación, le estaremos notificando pronto al respecto ADMINISTRACIÓN DE FLOTA"
                        Respuesta = "PENDIENTE"

                        MysqlUPDATE = "UPDATE reservacionvehiculo SET UsuarioAutoriza='" & Usuario & "',Estado=0, IdVehiculo=" & IdVehiculo & ",ObservacionAprobacion='" & Observacion & "',ResRespuesta='" & Respuesta & "' where id=" & Id & ";"

                        'MysqlUPDATE = "UPDATE reservacionvehiculo SET UsuarioAutoriza='" & Usuario & "',ObservacionAprobacion='" & Observacion & "',ResRespuesta='" & Respuesta & "' where id=" & Id & ";"
                        mensaje = "Su Reservacion esta pendiente correspondiente a la fecha solicitada:"
                    Else
                        Respuesta = "SI"
                        Estado = 1
                        MysqlUPDATE = "UPDATE reservacionvehiculo SET UsuarioAutoriza='" & Usuario & "',Estado=" & Estado & ", IdVehiculo=" & IdVehiculo & ",ObservacionAprobacion='" & Observacion & "',ResRespuesta='" & Respuesta & "' where id=" & Id & ";"
                        mensaje = "Se Ha Aprobado Su Reservacion para"
                    End If

                    comando.CommandText = MysqlUPDATE
                    comando.ExecuteNonQuery()
                    Dim command As New MySqlCommand("select res.Id,FechaInicio,FechaFin,Observacion,Correo, veh.codigo Vehiculo from reservacionvehiculo res inner join personal per on res.idEmpleado=per.IdEmpleado inner join _vehiculos veh on res.IdVehiculo=veh.Id where res.id=" & Id & ";", conexion)
                    Dim readers As MySqlDataReader = command.ExecuteReader()
                    readers.Read()
                    Dim StrDestino As String = ""
                    Using conn As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
                        conn.Open()
                        Dim consulta As String = "select IdReservacion, Destino from DestinoReservacionVehiculo where IdReservacion=" & readers("Id")
                        Dim comm As New MySqlCommand(consulta, conn)
                        Dim dread As MySqlDataReader = comm.ExecuteReader()
                        Dim cont As Integer = 0
                        While dread.Read
                            If cont = 0 Then
                                StrDestino = dread("Destino")
                            Else
                                StrDestino += "<br>" & dread("Destino")
                            End If
                        End While
                        dread.Close()
                        conn.Close()
                    End Using
                    Dim cuerpoMensaje As String = "<br>" & mensaje & " " _
                                                & readers("FechaInicio").ToString _
                                                & "<br> <br><table><thead><tr bgcolor='#429bff'><th>Vehiculo</th><th>Destino</th><th>Fecha Inicio</th><th>Fecha Fin</th><th>Obervacion</th></tr></thead><tbody><tr><td>" & readers("Vehiculo") & "</td><td>" & StrDestino & "</td><td>" & readers("FechaInicio") & "</td><td>" & readers("FechaFin") & "</td><td>" & readers("Observacion") & "</td><tr></tbody></table>"
                    If Observacion <> "" Then
                        cuerpoMensaje += "<br><br> " & Observacion
                    End If

                    cuerpoMensaje += "<br><br><i><font size='0.8'>Aprobado Por: " & Context.Request.Cookies("UserSettings")("user") & "</font></i>"
                    Dim Correo = EnviarCorreo(readers("Correo"), "Reservacion Aprobada", cuerpoMensaje)
                    command.Dispose()
                    readers.Close()

                    If Correo = True Then
                        Dim Elementos As New ClassAprobarReservacion
                        Elementos.StrError = "0"
                        result.Add(Elementos)
                        transaccion.Commit()
                    Else
                        transaccion.Dispose()
                        Dim Elementos As New ClassAprobarReservacion
                        Elementos.StrError = "Ha Ocurrido Un Error Interno, Favor Intentar de Nuevo."
                        result.Add(Elementos)
                    End If

                Else
                    cmd.Dispose()
                    reader.Close()
                    Dim Elementos As New ClassAprobarReservacion
                    Elementos.StrError = "El Vehiculo No Esta Disponible Para Esa Fecha."
                    result.Add(Elementos)
                End If

            Catch ex As Exception
                transaccion.Dispose()
                Dim Elementos As New ClassAprobarReservacion
                Elementos.StrError = ex.Message
                result.Add(Elementos)

            Finally
                conexion.Close()
            End Try
        End Using
        Return result
    End Function
    <WebMethod(EnableSession:=True)> _
    Public Function EnviarCorreo(ByVal Destinatario As String, ByVal Asunto As String, ByVal CuerpoMensaje As String) As Boolean
        Dim result As Boolean = False
        Dim _Message As New System.Net.Mail.MailMessage()
        Dim _SMTP As New System.Net.Mail.SmtpClient

        'CONFIGURACIÓN DEL STMP
        '_SMTP.Credentials = New System.Net.NetworkCredential("cuenta de correo", "contraseña")
        _SMTP.Credentials = New System.Net.NetworkCredential("notificaciones@grupo-genera.com", "systemsnot")
        _SMTP.Host = "smtp.emailsrvr.com"
        _SMTP.Port = 25
        _SMTP.EnableSsl = False
        '_SMTP.DeliveryMethod = Net.Mail.SmtpDeliveryMethod.Network

        ' CONFIGURACION DEL MENSAJE
        _Message.[To].Add(Destinatario) 'Cuenta de Correo al que se le quiere enviar el e-mail
        _Message.CC.Add("notificaciones@grupo-genera.com") 'Cuenta de Correo al que se le quiere enviar el e-mail
        _Message.From = New System.Net.Mail.MailAddress("notificaciones@grupo-genera.com", "Notificaciones", System.Text.Encoding.UTF8) 'Quien lo envía
        _Message.Subject = Replace(Asunto, ";", "") 'Sujeto del e-mail
        _Message.SubjectEncoding = System.Text.Encoding.UTF8 'Codificacion
        _Message.Body = CuerpoMensaje 'contenido del mail
        _Message.BodyEncoding = System.Text.Encoding.UTF8
        _Message.Priority = System.Net.Mail.MailPriority.High
        _Message.IsBodyHtml = True

        'ENVIO
        Try
            _SMTP.Send(_Message)
            result = True
        Catch ex As System.Net.Mail.SmtpException
            'MsgBox(ex.Message)
            result = False
        End Try
        Return result
    End Function
    Public Class ClassEntregaReservacion
        Public StrError As String = "0"
    End Class
    <WebMethod(EnableSession:=True)> _
    Public Function EntregaReservacion(ByVal Id As Integer) As List(Of [ClassEntregaReservacion])
        Dim result As List(Of [ClassEntregaReservacion]) = New List(Of ClassEntregaReservacion)()
        Dim MysqlUPDATE As String
        Dim Usuario As String = Context.Request.Cookies("UserSettings")("user")
        Using conexion As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
            conexion.Open()
            Dim comando As New MySqlCommand
            Dim transaccion As MySqlTransaction
            transaccion = conexion.BeginTransaction
            comando.Connection = conexion
            comando.Transaction = transaccion
            Try
                Dim cmd As New MySqlCommand("SELECT res.Id,res.IdTipoReservacion,per.nombre NombreEmpleado, res.Encargado,res.IdEmpleado,tip.tipo_vehiculo TipoVehiculo,cast(concat(day(res.FechaInicio),'/',month(res.FechaInicio),'/',year(res.FechaInicio),' ',hour(res.FechaInicio),':',minute(res.FechaInicio),':',second(res.FechaInicio)) as char) FechaInicio,cast(concat(day(res.FechaFin),'/',month(res.FechaFin),'/',year(res.FechaFin),' ',hour(res.FechaFin),':',minute(res.FechaFin),':',second(res.FechaFin)) as char) FechaFin,res.TodoElDia,res.Alerta,res.Observacion,res.Estado,res.UsuarioAutoriza,veh.codigo, res.IdVehiculo FROM reservacionvehiculo res inner join _vehiculos veh on veh.Id= res.IdVehiculo inner join tipo_vehiculo tip on res.IdTipoVehiculo=tip.id_tipo_vehiculo inner join personal per on res.IdEmpleado=per.idEmpleado WHERE res.Id=" & Id & ";", conexion)
                Dim reader As MySqlDataReader = cmd.ExecuteReader()
                reader.Read()
                If reader.HasRows Then

                    Dim streamWriter As System.IO.StreamWriter = New System.IO.StreamWriter(Server.MapPath("~/ReservacionAprobada.txt"), False, System.Text.Encoding.UTF8)
                    streamWriter.WriteLine("")
                    streamWriter.WriteLine("#FechaEmision#" & Now)
                    If reader("IdTipoReservacion") = 2 Then
                        streamWriter.WriteLine("#Empleado#" & reader("Encargado"))
                    Else
                        streamWriter.WriteLine("#Empleado#" & reader("NombreEmpleado"))
                    End If
                    streamWriter.WriteLine("#UnidadCodigo#" & reader("codigo"))
                    streamWriter.WriteLine("#DescUnidad#" & reader("TipoVehiculo"))
                    streamWriter.WriteLine("#FechaInicio#" & reader("FechaInicio"))
                    streamWriter.WriteLine("#FechaFin#" & reader("FechaFin"))
                    Dim StrDestino As String = ""
                    Using conn As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
                        conn.Open()
                        Dim consulta As String = "select IdReservacion, Destino from DestinoReservacionVehiculo where IdReservacion=" & reader("Id")
                        Dim command As New MySqlCommand(consulta, conn)
                        Dim read As MySqlDataReader = command.ExecuteReader()
                        Dim cont As Integer = 0
                        While read.Read
                            If cont = 0 Then
                                StrDestino = read("Destino")
                            Else
                                StrDestino += " / " & read("Destino")
                            End If
                        End While
                        read.Close()
                        conn.Close()
                    End Using
                    streamWriter.WriteLine("#Destino#" & StrDestino)
                    streamWriter.WriteLine("#Obser#" & reader("Observacion"))
                    streamWriter.WriteLine("#CodigoBarra#" & Format(reader("IdVehiculo"), "0000") & Format(reader("IdEmpleado"), "000") & Format(reader("Id"), "0000"))
                    streamWriter.Close()
                    cmd.Dispose()
                    reader.Close()
                    comando.CommandType = Data.CommandType.Text
                    MysqlUPDATE = "UPDATE reservacionvehiculo SET UsuarioEntrega='" & Usuario & "',Estado=3 where id=" & Id & ";"
                    comando.CommandText = MysqlUPDATE
                    comando.ExecuteNonQuery()
                    transaccion.Commit()
                    Dim Elementos As New ClassEntregaReservacion
                    Elementos.StrError = "0"
                    result.Add(Elementos)

                Else
                    cmd.Dispose()
                    reader.Close()
                    Dim Elementos As New ClassEntregaReservacion
                    Elementos.StrError = "Numero de Reservacion no Existe."
                    result.Add(Elementos)
                End If
            Catch ex As Exception
                'transaccion.Dispose()
                Dim Elementos As New ClassEntregaReservacion
                Elementos.StrError = "..." & ex.Message
                result.Add(Elementos)
            Finally
                conexion.Close()
            End Try
        End Using
        Return result
    End Function
    Public Class ClassRecibirReservacion
        Public StrError As String = "0"
    End Class
    <WebMethod(EnableSession:=True)> _
    Public Function RecibirReservacion(ByVal Id As String) As List(Of [ClassRecibirReservacion])
        Dim result As List(Of [ClassRecibirReservacion]) = New List(Of ClassRecibirReservacion)()
        Dim MysqlUPDATE As String, MysqlINSERT As String
        Dim Usuario As String = Context.Request.Cookies("UserSettings")("user")
        Using conexion As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
            conexion.Open()
            Dim comando As New MySqlCommand
            Dim transaccion As MySqlTransaction
            transaccion = conexion.BeginTransaction
            comando.Connection = conexion
            comando.Transaction = transaccion
            Try
                comando.CommandType = Data.CommandType.Text
                MysqlUPDATE = "UPDATE reservacionvehiculo SET UsuarioRecibe='" & Usuario & "',Estado=4 where id='" & Id & "';"
                comando.CommandText = MysqlUPDATE
                comando.ExecuteNonQuery()
                Dim GPSCodigo As String = ""
                Dim GPSFechaInicio As String = ""
                Dim GPSFechaFin As String = ""
                Using conn As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
                    conn.Open()
                    Dim consulta As String = "SELECT v.codigo Codigo,cast(replace(r.FechaInicio,'-','/') as char) FechaInicio,cast(replace(r.FechaFin,'-','/') as char) FechaFin,cast(replace(r.FechaEntrega,'-','/') as char) FechaEntrega,cast(replace(r.FechaDevolucion,'-','/') as char) FechaDevolucion, (case when (TIMESTAMPDIFF(second,FechaInicio, FechaFin) >= TIMESTAMPDIFF(second,FechaEntrega, FechaDevolucion)) then 1 else 2 end )as FechaMayor FROM reservacionvehiculo r inner join _vehiculos v on r.IdVehiculo=v.Id where r.Id=" & Id
                    Dim comm As New MySqlCommand(consulta, conn)
                    Dim read As MySqlDataReader = comm.ExecuteReader()
                    Dim cont As Integer = 0
                    read.Read()
                    If read.HasRows Then
                        GPSCodigo = read("Codigo")
                        If read("FechaMayor") = 1 Or (IsDBNull(read("FechaEntrega")) Or IsDBNull(read("FechaDevolucion"))) Then
                            GPSFechaInicio = read("FechaInicio")
                            GPSFechaFin = read("FechaFin")
                        Else
                            GPSFechaInicio = read("FechaEntrega")
                            GPSFechaFin = read("FechaDevolucion")
                        End If
                    End If
                    read.Close()
                    conn.Close()
                End Using
                Dim m_xmld As XmlDocument
                Dim m_nodelist As XmlNodeList
                Dim m_node As XmlNode
                m_xmld = New XmlDocument()
                Dim consume As New GpsSolutions.wsReports
                Dim GPSResult = consume.GetDistanceDataRangeByPlate("gentrac", "flota2014", GPSCodigo, GPSFechaInicio, GPSFechaFin)
                Dim xr As XmlReader = XmlReader.Create(New StringReader(GPSResult.OuterXml))
                m_xmld.Load(xr)
                m_nodelist = m_xmld.SelectNodes("space/Response/Plate")
                For Each m_node In m_nodelist
                    Dim mCodigo = m_node.Attributes.GetNamedItem("id").Value
                    If mCodigo = GPSCodigo Then
                        If m_node.SelectNodes("ITEM").Count >= 1 Then
                            Dim i As Integer = 0
                            While i <= Val(m_node.SelectNodes("ITEM").Count - 1)
                                Dim Fecha = Split(m_node.ChildNodes.Item(i).SelectSingleNode("DATE").InnerText.Replace("_", "/").Replace("date", "").Replace("/", "-"), " ")
                                Dim Odometro = Convert.ToDouble(m_node.ChildNodes.Item(i).SelectSingleNode("ODOMETER").InnerText)
                                comando.CommandType = Data.CommandType.Text
                                MysqlINSERT = "INSERT INTO recorridoreservacionvehiculo (IdReservacionVehiculo, Fecha, Km, Tiempo) VALUES (" & Id & ", '" & Fecha(0) & "', '" & Odometro & "',0)"
                                comando.CommandText = MysqlINSERT
                                comando.ExecuteNonQuery()
                                i = i + 1
                            End While
                        Else
                            Dim Fecha = Split(m_node.SelectSingleNode("DATE").InnerText.Replace("_", "/").Replace("date", "").Replace("/", "-"), " ")
                            Dim Odometro = Convert.ToDouble(m_node.SelectSingleNode("ODOMETER").InnerText)
                            comando.CommandType = Data.CommandType.Text
                            MysqlINSERT = "INSERT INTO recorridoreservacionvehiculo (IdReservacionVehiculo, Fecha, Km, Tiempo) VALUES (" & Id & ", '" & Fecha(0) & "', '" & Odometro & "',0)"
                            comando.CommandText = MysqlINSERT
                            comando.ExecuteNonQuery()
                        End If
                    End If
                Next
                transaccion.Commit()
                Dim Elementos As New ClassRecibirReservacion
                Elementos.StrError = "0"
                result.Add(Elementos)
            Catch ex As Exception
                transaccion.Dispose()
                Dim Elementos As New ClassRecibirReservacion
                Elementos.StrError = ex.Message
                result.Add(Elementos)
            Finally
                conexion.Close()
            End Try
        End Using
        Return result
    End Function
    Public Class ClassBuscarLiquidaciones
        Public StrError As String = "0"
        Public IdLiquidacion As String
        Public Usuario As String
        Public Fecha As String
        Public Anticipo As String
        Public TotalGastos As String
        Public SaldoCargo As String
        Public SaldoFavor As String
        Public Correlativo As String
    End Class
    <WebMethod(EnableSession:=True)> _
    Public Function BuscarLiquidaciones(ByVal FechaInicio As String, ByVal FechaFin As String) As List(Of [ClassBuscarLiquidaciones])
        Dim result As List(Of [ClassBuscarLiquidaciones]) = New List(Of ClassBuscarLiquidaciones)()
        Dim consulta As String
        Using conexion As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
            Try
                conexion.Open()
                consulta = "select IdLiquidacion, FnEmpleadoPorUsuario(usuario) usuario, Fecha,Anticipo,TotalGastos, SaldoCargo, SaldoFavor,correlativo from liquidacion where fecha between '" & FechaInicio & "' and '" & FechaFin & "';"
                Dim cmd As New MySqlCommand(consulta, conexion)
                Dim reader As MySqlDataReader = cmd.ExecuteReader()
                While reader.Read
                    Dim Elementos As New ClassBuscarLiquidaciones
                    Elementos.IdLiquidacion = reader("IdLiquidacion")
                    Elementos.Usuario = reader("usuario")
                    Elementos.Fecha = reader("Fecha")
                    Elementos.Anticipo = reader("Anticipo")
                    Elementos.TotalGastos = reader("TotalGastos")
                    Elementos.SaldoCargo = reader("SaldoCargo")
                    Elementos.SaldoFavor = reader("SaldoFavor")
                    Elementos.Correlativo = reader("correlativo")
                    result.Add(Elementos)
                End While
            Catch ex As Exception
                Dim Elementos As New ClassBuscarLiquidaciones
                Elementos.StrError = ex.Message
                result.Add(Elementos)
            Finally
                conexion.Close()
            End Try
        End Using
        Return result
    End Function
    Public Class ClassBuscarLiquidacionesFacturas
        Public StrError As String = "0"
        Public IdFactura As String
        Public FPQ As String = "0"
        Public Fecha As String
        Public Nit As String
        Public NombreProveedor As String
        Public Serie As String
        Public NumeroFactura As String
        Public FacturaBien As String = "0"
        Public FacturaServicio As String = "0"
        Public Combustible As String = "0"
        Public IDP As String = "0"
        Public Base As String = "0"
        Public IVA As String = "0"
    End Class
    <WebMethod(EnableSession:=True)> _
    Public Function BuscarLiquidacionesFactura(ByVal IdLiquidacion As String) As List(Of [ClassBuscarLiquidacionesFacturas])
        Dim result As List(Of [ClassBuscarLiquidacionesFacturas]) = New List(Of ClassBuscarLiquidacionesFacturas)()
        Dim consulta As String
        Using conexion As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
            Session("IdLiquidacion") = IdLiquidacion
            Try
                conexion.Open()
                consulta = "select liq.IdFactura,liq.TotalFact TotalFact,fac.fecha Fecha,fac.provedor Nit,prov.nombre NombreProveedor, fac.serie Serie, fac.nofac NumeroFactura,fac.OrdenTrabajo,tip.codigo CodigoDocumento, tip.nombre TipoDocumento  from liquidaciondetalle liq  inner join facturacion fac on liq.IdFactura=fac.corre inner join tipodefactura tip on fac.tipo_doc=tip.id inner join proveedores prov on fac.provedor = prov.nit where liq.IdLiquidacion=" & IdLiquidacion & " group by liq.IdFactura"
                Dim cmd As New MySqlCommand(consulta, conexion)
                Dim reader As MySqlDataReader = cmd.ExecuteReader()
                While reader.Read
                    Dim Elementos As New ClassBuscarLiquidacionesFacturas
                    Elementos.IdFactura = reader("IdFactura")
                    Elementos.Fecha = reader("Fecha")
                    Elementos.Nit = reader("Nit")
                    Elementos.Serie = reader("Serie")
                    Elementos.NumeroFactura = reader("NumeroFactura")
                    Elementos.NombreProveedor = reader("NombreProveedor")
                    If Trim(reader("CodigoDocumento")) = "FPQ" Then
                        Elementos.FPQ = reader("TotalFact")
                    Else
                        Using conn As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
                            Try
                                conn.Open()
                                consulta = "select f.codigo,sum(f.total) total,f.precioU,f.cantidad, i.tpro,i.clasifi,i.subclasi from facturaciond f inner join inventario i on f.codigo=i.codigo where f.correlativo=" & reader("IdFactura") & " order by i.clasifi,i.tpro;"
                                Dim command As New MySqlCommand(consulta, conn)
                                Dim cursor As MySqlDataReader = command.ExecuteReader()
                                While cursor.Read
                                    If cursor("clasifi") = 59 Then
                                        Elementos.Combustible = cursor("total")
                                        If cursor("subclasi") = 243 Then '---DIESEL = 243
                                            Elementos.IDP = 1.3 * Val(cursor("cantidad"))
                                        ElseIf cursor("subclasi") = 244 Then '---REGULAR = 244
                                            Elementos.IDP = 4.6 * Val(cursor("cantidad"))
                                        ElseIf cursor("subclasi") = 245 Then '---SUPER = 245
                                            Elementos.IDP = 4.7 * Val(cursor("cantidad"))
                                        End If
                                        Dim subtotal, Provision As Decimal
                                        subtotal = cursor("total") - Elementos.IDP
                                        Provision = subtotal / 1.12
                                        Elementos.IVA = Provision * 0.12
                                        Elementos.Base = Elementos.Combustible - Elementos.IDP - Elementos.IVA
                                    Else
                                        If cursor("tpro") = 1 Then
                                            Elementos.FacturaBien = cursor("total")
                                        ElseIf cursor("tpro") = 2 Then
                                            Elementos.FacturaServicio = cursor("total")
                                        End If
                                        Dim Provision As Decimal
                                        Provision = cursor("total") / 1.12
                                        Elementos.IVA = Provision * 0.12
                                        Elementos.Base = cursor("taotal") - Elementos.IVA
                                    End If
                                End While
                            Catch ex As Exception
                            Finally
                                conn.Close()
                            End Try
                        End Using
                    End If
                    result.Add(Elementos)
                End While
            Catch ex As Exception
                Dim Elementos As New ClassBuscarLiquidacionesFacturas
                Elementos.StrError = ex.Message
                result.Add(Elementos)
            Finally
                conexion.Close()
            End Try
        End Using
        Return result
    End Function
    Public Class ClassContabilizacion
        Public StrError As String = "0"
        Public Cuenta1 As String = ""
        Public Cuenta2 As String = ""
        Public Cuenta3 As String = ""
        Public Valor As String = ""
        Public Descripcion As String = ""
    End Class
    <WebMethod(EnableSession:=True)> _
    Public Function Contabilizacion(ByVal IdLiquidacion As String) As List(Of [ClassContabilizacion])
        Dim result As List(Of [ClassContabilizacion]) = New List(Of ClassContabilizacion)()
        Dim consulta As String
        Dim CuentaContableEmp As String = ""
        Using conexion As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
            Try
                conexion.Open()
                consulta = "select l.usuario,DATE_FORMAT(l.Fecha,'%d%m%y') FechaAl,l.TotalGastos,ld.IdFactura from liquidacion l inner join liquidaciondetalle ld on l.IdLiquidacion=ld.IdLiquidacion where l.IdLiquidacion=" & IdLiquidacion & " limit 1;"
                Dim cmd As New MySqlCommand(consulta, conexion)
                Dim reader As MySqlDataReader = cmd.ExecuteReader()
                reader.Read()
                If reader.HasRows Then
                    Dim Elementos As New ClassContabilizacion
                    Elementos.Valor = -reader("TotalGastos")
                    Using conn As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
                        Try
                            conn.Open()
                            consulta = "select per.nombre NombreEmpleado, per.CuentaContable, per.idArea IdArea from userw us inner join personal per on us.IdPersonal=per.IdEmpleado where username='" & reader("usuario") & "' limit 1;"
                            Dim command As New MySqlCommand(consulta, conn)
                            Dim cursor As MySqlDataReader = command.ExecuteReader()
                            cursor.Read()
                            If cursor.HasRows Then
                                CuentaContableEmp = cursor("CuentaContable")
                                If cursor("IdArea") = 6 Then
                                    If MyDB.MySelectOneParameter("Select Versatec From facturacion where correlativo=" & reader("IdFactura"), "Versatec") = 1 Then
                                        Elementos.Cuenta1 = "21026"
                                        Elementos.Descripcion = "Liq. Versatec Al " & reader("FechaAl")
                                    Else
                                        Elementos.Cuenta1 = "16010"
                                        Elementos.Cuenta2 = "00047"
                                        Elementos.Cuenta3 = cursor("CuentaContable")
                                        Elementos.Descripcion = "Liq. Viaticos Al " & reader("FechaAl")
                                    End If
                                Else
                                    If MyDB.MySelectOneParameter("Select Versatec From facturacion where corre=" & reader("IdFactura"), "Versatec") = 1 Then
                                        Elementos.Cuenta1 = "21026"
                                        Elementos.Descripcion = "Liq. Versatec Al " & reader("FechaAl")
                                    Else
                                        Elementos.Cuenta1 = "16010"
                                        Elementos.Cuenta2 = "'00000'"
                                        Elementos.Cuenta3 = cursor("CuentaContable")
                                        Elementos.Descripcion = "Liq. Viaticos Al " & reader("FechaAl")
                                    End If
                                End If

                            End If
                            cursor.Close()
                        Catch ex As Exception
                        Finally
                            conn.Close()
                        End Try
                    End Using
                    result.Add(Elementos)
                End If
                reader.Close()
                consulta = "select fac.fecha,dep.CuentaContable,liqd.TotalFact,fac.tipo_doc,fac.OrdenTrabajo,FnBuscaVehiculo(fac.vehiculo) Vehiculo,fac.vehiculo IdVehiculo,facd.codigo,facd.cantidad,inv.clasifi,inv.subclasi,facd.total TotalFacd from liquidaciondetalle liqd inner join facturacion fac on fac.corre=liqd.IdFactura inner join facturaciond facd on facd.correlativo=fac.corre inner join inventario inv on inv.codigo=facd.codigo inner join departamentos dep on fac.departamento=dep.id where liqd.IdLiquidacion=" & IdLiquidacion
                cmd = New MySqlCommand(consulta, conexion)
                reader = cmd.ExecuteReader()
                Dim cuentaContableDep As String = ""
                Dim Vehiculo As String = ""
                Dim CContableVehiculo As String = ""
                Dim DepartamentoVehiculo As String = ""
                Dim OrdenTrabajo As String = ""
                Dim Base = 0.0, BaseCombustible = 0.0, BaseRecibo = 0.0, Retencion = 0.0, IDP = 0.0, IVA As Double = 0
                Dim tipodoc As Integer
                While reader.Read
                    If Not IsDBNull(reader("CuentaContable")) Then
                        cuentaContableDep = reader("CuentaContable")
                    Else
                        cuentaContableDep = 0
                    End If

                    Vehiculo = reader("Vehiculo")
                    CContableVehiculo = MyDB.MySelectOneParameter("Select ccontable from _vehiculos where Id=" & reader("IdVehiculo"), "ccontable")
                    DepartamentoVehiculo = MyDB.MySelectOneParameter("Select departamento from _vehiculos where Id=" & reader("IdVehiculo"), "departamento")
                    If Not IsDBNull(reader("OrdenTrabajo")) Then
                        OrdenTrabajo = reader("OrdenTrabajo")
                    End If
                    tipodoc = reader("tipo_doc")
                    If reader("tipo_doc") = 1 Or reader("tipo_doc") = 2 Or reader("tipo_doc") = 3 Then
                        If reader("clasifi") = 59 Then
                            Dim _IDP As Double = 0
                            If reader("subclasi") = 243 Then '--DIESEL = 243
                                IDP += 1.3 * Val(reader("cantidad"))
                                _IDP = 1.3 * Val(reader("cantidad"))
                            ElseIf reader("subclasi") = 244 Then '--REGULAR = 244
                                IDP += 4.6 * Val(reader("cantidad"))
                                _IDP = 4.6 * Val(reader("cantidad"))
                            ElseIf reader("subclasi") = 245 Then '---SUPER = 245
                                IDP += 4.7 * Val(reader("cantidad"))
                                _IDP = 4.7 * Val(reader("cantidad"))
                            End If
                            Dim subtotal, Provision As Decimal
                            subtotal = reader("TotalFacd") - _IDP
                            Provision = subtotal / 1.12
                            IVA += Provision * 0.12
                            BaseCombustible += reader("TotalFacd") - _IDP - (Provision * 0.12)
                        Else
                            Dim Provision As Decimal
                            Provision = reader("TotalFacd") / 1.12
                            IVA += Provision * 0.12
                            Base += (reader("TotalFacd") * 1) - (Provision * 0.12)
                        End If
                    ElseIf reader("tipo_doc") = 11 And reader("tipo_doc") = 4 Then
                        Retencion += reader("TotalFacd") * 0.05
                        BaseRecibo += reader("TotalFacd") - (reader("TotalFacd") * 0.05)
                    ElseIf reader("tipo_doc") = 12 Then
                        Base = reader("TotalFacd")
                    End If

                End While
                reader.Close()
                If Val(BaseCombustible) > 0 Then
                    Dim Elementos As New ClassContabilizacion
                    If OrdenTrabajo = "" Then
                        If DepartamentoVehiculo = 39 Or DepartamentoVehiculo = 40 Then
                            Elementos.Cuenta1 = "16085"
                        Else
                            Elementos.Cuenta1 = cuentaContableDep.ToString
                        End If
                        Elementos.Cuenta2 = "'060'"
                        Elementos.Cuenta3 = CContableVehiculo.ToString
                    Else
                        Elementos.Cuenta1 = "13750"
                        Elementos.Cuenta2 = "'01"
                        Elementos.Cuenta3 = ""
                    End If
                    Elementos.Valor = Math.Round(BaseCombustible, 2)
                    If Vehiculo <> "0" And Vehiculo <> "" Then
                        Elementos.Descripcion = "GASTOS VEHICULOS UNIDAD " & Vehiculo
                    Else
                        Elementos.Descripcion = "GASTOS VEHICULOS"
                    End If
                    result.Add(Elementos)
                End If
                If Val(IDP) > 0 Then
                    Dim Elementos As New ClassContabilizacion
                    If DepartamentoVehiculo = 39 Or DepartamentoVehiculo = 40 Then
                        Elementos.Cuenta1 = "16085"
                    Else
                        Elementos.Cuenta1 = cuentaContableDep.ToString
                    End If
                    Elementos.Cuenta2 = "'060'"
                    Elementos.Cuenta3 = CContableVehiculo.ToString
                    Elementos.Valor = Math.Round(IDP, 2)
                    If Vehiculo <> "0" And Vehiculo <> "" Then
                        Elementos.Descripcion = "UNIDAD " & Vehiculo & " IDP"
                    Else
                        Elementos.Descripcion = "IDP"
                    End If
                    result.Add(Elementos)
                End If
                If Val(Base) > 0 Then
                    Dim Elementos As New ClassContabilizacion
                    If tipodoc = 12 Then
                        If OrdenTrabajo = "" Then
                            If DepartamentoVehiculo = 39 Or DepartamentoVehiculo = 40 Then
                                Elementos.Cuenta1 = "16085"
                            Else

                                Elementos.Cuenta1 = cuentaContableDep
                            End If
                            Elementos.Cuenta2 = "'052'"
                            Elementos.Cuenta3 = CuentaContableEmp
                            Elementos.Descripcion = "VIAJES Y AGASAJOS EN $"
                        Else
                            Elementos.Cuenta1 = "13750"
                            Elementos.Cuenta2 = "'01'"
                            Elementos.Cuenta3 = ""
                            Elementos.Descripcion = "VIAJES Y AGASAJOS OT." & OrdenTrabajo & " EN $"
                        End If
                    Else
                        If OrdenTrabajo = "" Then
                            If DepartamentoVehiculo = 39 Or DepartamentoVehiculo = 40 Then
                                Elementos.Cuenta1 = "16085"
                            Else
                                Elementos.Cuenta1 = cuentaContableDep
                            End If
                            Elementos.Cuenta2 = "'050'"
                            Elementos.Cuenta3 = CuentaContableEmp
                            Elementos.Descripcion = "VIAJES Y AGASAJOS"
                        Else
                            Elementos.Cuenta1 = "13750"
                            Elementos.Cuenta2 = "'01'"
                            Elementos.Cuenta3 = ""
                            Elementos.Descripcion = "VIAJES Y AGASAJOS OT." & OrdenTrabajo
                        End If
                    End If

                    Elementos.Valor = Math.Round(Base, 2)
                    result.Add(Elementos)
                End If
                If Val(IVA) > 0 Then
                    Dim Elementos As New ClassContabilizacion
                    Elementos.Cuenta1 = "12076"
                    Elementos.Cuenta2 = ""
                    Elementos.Cuenta3 = ""
                    Elementos.Valor = Math.Round(IVA, 2)
                    Elementos.Descripcion = "IVA"
                    result.Add(Elementos)
                End If
                If Val(BaseRecibo) > 0 Then
                    Dim Elementos As New ClassContabilizacion
                    If OrdenTrabajo = "" Then
                        If DepartamentoVehiculo = 39 Or DepartamentoVehiculo = 40 Then
                            Elementos.Cuenta1 = "16085"
                        Else
                            Elementos.Cuenta1 = cuentaContableDep
                        End If
                        Elementos.Cuenta2 = "'050'"
                        Elementos.Cuenta3 = CuentaContableEmp
                        Elementos.Descripcion = "LIQUIDACION DE COMPRAS."
                    Else
                        Elementos.Cuenta1 = "13750"
                        Elementos.Cuenta2 = "'01'"
                        Elementos.Cuenta3 = ""
                        Elementos.Descripcion = "LIQUIDACION DE COMPRAS. OT. " & OrdenTrabajo
                    End If
                    Elementos.Valor = Math.Round(BaseRecibo, 2)

                    result.Add(Elementos)
                End If
                If Val(Retencion) > 0 Then
                    Dim Elementos As New ClassContabilizacion
                    Elementos.Cuenta1 = "16070"
                    Elementos.Cuenta2 = ""
                    Elementos.Cuenta3 = ""
                    Elementos.Valor = Math.Round(Retencion, 2)
                    Elementos.Descripcion = "ISR RETENIDO"
                    result.Add(Elementos)
                End If
            Catch ex As Exception
                Dim Elementos As New ClassContabilizacion
                Elementos.StrError = ex.Message
                result.Add(Elementos)
            Finally
                conexion.Close()
            End Try
        End Using
        Return result
    End Function
    Public Class ClassCancelarReservacion
        Public StrError As String = "0"
    End Class
    <WebMethod(EnableSession:=True)> _
    Public Function CancelarReservacion(ByVal Id As String) As List(Of [ClassCancelarReservacion])
        Dim result As List(Of [ClassCancelarReservacion]) = New List(Of ClassCancelarReservacion)()
        Dim MysqlUPDATE As String
        Dim Usuario As String = Context.Request.Cookies("UserSettings")("user")
        Using conexion As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
            conexion.Open()
            Dim comando As New MySqlCommand
            Dim transaccion As MySqlTransaction
            transaccion = conexion.BeginTransaction
            comando.Connection = conexion
            comando.Transaction = transaccion
            Try
                comando.CommandType = Data.CommandType.Text
                MysqlUPDATE = "UPDATE reservacionvehiculo SET Estado=2, UsuarioCancela='" & Context.Request.Cookies("UserSettings")("user") & "',ResRespuesta='NO' where id=" & Id & ";"
                comando.CommandText = MysqlUPDATE
                comando.ExecuteNonQuery()
                transaccion.Commit()
                Dim Elementos As New ClassCancelarReservacion
                Elementos.StrError = "0"
                result.Add(Elementos)
            Catch ex As Exception
                transaccion.Dispose()
                Dim Elementos As New ClassCancelarReservacion
                Elementos.StrError = ex.Message
                result.Add(Elementos)
            Finally
                conexion.Close()
            End Try
        End Using
        Return result
    End Function
    Public Class ClassVehiculosReservacion
        Public StrError As String = "0"
        Public Id As String
        Public Codigo As String
        Public Empresa As String
    End Class
    <WebMethod(EnableSession:=True)> _
    Public Function CargarVehiculosReservacion(ByVal Id As String) As List(Of [ClassVehiculosReservacion])
        Dim result As List(Of [ClassVehiculosReservacion]) = New List(Of ClassVehiculosReservacion)()
        Dim consulta As String
        Using conexion As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
            Try
                conexion.Open()
                consulta = "select Id,IdVehiculo, cast(FechaInicio as char) FechaInicio, cast(FechaFin as char) FechaFin, IdEmpleado from reservacionvehiculo where Id=" & Id
                Dim cmd As New MySqlCommand(consulta, conexion)
                Dim reader As MySqlDataReader = cmd.ExecuteReader()
                Dim FechaInicio As String = ""
                While reader.Read
                    FechaInicio = reader("FechaInicio")
                End While
                reader.Close()
                consulta = "select veh.Id, concat(veh.codigo, ' / ', t.tipo_vehiculo) Codigo, (case veh.departamento when 6 then 'MOBIL' else 'GENTRAC' end) Empresa, veh.Descripcion from _vehiculos veh inner join tipo_vehiculo t on veh.tveh=t.id_tipo_vehiculo where veh.status=true and veh.Pool=true and not veh.Id IN(select IdVehiculo from reservacionvehiculo where ('" & FechaInicio & "' between FechaInicio and FechaFin) and Estado<>2 and Estado<>4 and IdVehiculo!=484) order by Empresa, t.tipo_vehiculo;"
                cmd = New MySqlCommand(consulta, conexion)
                reader = cmd.ExecuteReader()
                While reader.Read
                    Dim Elementos As New ClassVehiculosReservacion
                    Elementos.Id = reader("Id")
                    If Not IsDBNull(reader("Descripcion")) Then
                        Elementos.Codigo = reader("Codigo") & "(" & reader("Descripcion") & ")"
                    Else
                        Elementos.Codigo = reader("Codigo")
                    End If
                    Elementos.Empresa = reader("Empresa")
                    result.Add(Elementos)
                End While
                reader.Close()
            Catch ex As Exception
                Dim Elementos As New ClassVehiculosReservacion
                Elementos.StrError = ex.Message
                result.Add(Elementos)
            Finally
                conexion.Close()
            End Try
        End Using
        Return result
    End Function
    Public Class ClassUbicacionVehiculo
        Public StrError As String = "0"
        Public Id As String
        Public Descripcion As String
    End Class
    <WebMethod(EnableSession:=True)> _
    Public Function UbicacionVehiculo() As List(Of [ClassUbicacionVehiculo])
        Dim result As List(Of [ClassUbicacionVehiculo]) = New List(Of ClassUbicacionVehiculo)()
        Dim consulta As String
        Using conexion As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
            Try
                conexion.Open()
                consulta = "select IdUbicacionVehiculo, Descripcion from ubicacionvehiculo;"
                Dim cmd As New MySqlCommand(consulta, conexion)
                Dim reader As MySqlDataReader = cmd.ExecuteReader()
                While reader.Read
                    Dim Elementos As New ClassUbicacionVehiculo
                    Elementos.Id = reader("IdUbicacionVehiculo")
                    Elementos.Descripcion = reader("Descripcion")

                    result.Add(Elementos)
                End While
            Catch ex As Exception
                Dim Elementos As New ClassUbicacionVehiculo
                Elementos.StrError = ex.Message
                result.Add(Elementos)
            Finally
                conexion.Close()
            End Try
        End Using
        Return result
    End Function
    Public Class ClassDetalleUbicacionVehiculo
        Public StrError As String = "0"
        Public Id As Integer
        Public Codigo As String
        Public Pool As Boolean
        Public IdUbicacion As Integer
    End Class
    <WebMethod(EnableSession:=True)> _
    Public Function DetalleUbicacionVehiculo() As List(Of [ClassDetalleUbicacionVehiculo])
        Dim result As List(Of [ClassDetalleUbicacionVehiculo]) = New List(Of ClassDetalleUbicacionVehiculo)()
        Dim consulta As String
        Using conexion As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
            Try
                conexion.Open()
                consulta = "select Id, codigo Codigo, Pool, IdUbicacionVehiculo from _vehiculos;"
                Dim cmd As New MySqlCommand(consulta, conexion)
                Dim reader As MySqlDataReader = cmd.ExecuteReader()
                While reader.Read
                    Dim Elementos As New ClassDetalleUbicacionVehiculo
                    Elementos.Id = reader("Id")
                    Elementos.Codigo = reader("Codigo")
                    Elementos.Pool = reader("Pool")
                    Elementos.IdUbicacion = reader("IdUbicacionVehiculo")
                    result.Add(Elementos)
                End While
            Catch ex As Exception
                Dim Elementos As New ClassDetalleUbicacionVehiculo
                Elementos.StrError = ex.Message
                result.Add(Elementos)
            Finally
                conexion.Close()
            End Try
        End Using
        Return result
    End Function
    <WebMethod(EnableSession:=True)> _
    Public Function CalendarioVehiculo(ByVal IdVehiculo As Integer) As List(Of [ClassReservacionesVehiculos])
        Dim result As List(Of [ClassReservacionesVehiculos]) = New List(Of ClassReservacionesVehiculos)()
        Dim consulta As String
        Using conexion As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
            Try
                conexion.Open()
                consulta = "select FnBuscaVehiculo(res.IdVehiculo) Vehiculo,res.Id,res.IdEmpleado,per.nombre Nombre,tip.tipo_vehiculo TipoVehiculo,CAST(res.FechaInicio as char) FechaInicio,cast(res.FechaFin as char) FechaFin,res.TodoElDia,res.Alerta,res.Observacion,res.Estado,res.UsuarioAutoriza, SUBSTRING(CAST(res.FechaEntrega as char),1,10) FechaEntrega,SUBSTRING(CAST(res.FechaEntrega as char),12,8) HoraEntrega, SUBSTRING(CAST(res.FechaDevolucion as char),1,10) FechaDevolucion,SUBSTRING(CAST(res.FechaDevolucion as char),12,8) HoraDevolucion from reservacionvehiculo res inner join personal per on res.idEmpleado=per.idEmpleado inner join tipo_vehiculo tip on res.IdTipoVehiculo=tip.id_tipo_vehiculo and res.FechaInicio>DATE_SUB(now(), INTERVAL 3 MONTH) and (res.IdVehiculo=" & IdVehiculo & " or 0=" & IdVehiculo & ");"
                Dim cmd As New MySqlCommand(consulta, conexion)
                Dim reader As MySqlDataReader = cmd.ExecuteReader()
                While reader.Read
                    Dim Elementos As New ClassReservacionesVehiculos
                    Elementos.id = reader("Id")
                    Elementos.title = reader("Nombre")
                    Elementos.allDay = reader("TodoElDia")
                    Elementos.tipoVehiculo = reader("TipoVehiculo")
                    Elementos.start = reader("FechaInicio").ToString()
                    Elementos.ends = reader("FechaFin").ToString()
                    Elementos.status = reader("Estado")
                    Elementos.vehiculo = reader("Vehiculo")

                    If Not IsDBNull(reader("FechaEntrega")) Then
                        Elementos.FechaEntrega = reader("FechaEntrega").ToString()
                    Else
                        Elementos.FechaEntrega = "No Disponible"
                    End If
                    If Not IsDBNull(reader("FechaDevolucion")) Then
                        Elementos.FechaDevolucion = reader("FechaDevolucion").ToString()
                    Else
                        Elementos.FechaDevolucion = "No Disponible"
                    End If
                    If Not IsDBNull(reader("HoraEntrega")) Then
                        Elementos.HoraEntrega = reader("HoraEntrega").ToString()
                    Else
                        Elementos.HoraEntrega = "No Disponible"
                    End If
                    If Not IsDBNull(reader("HoraDevolucion")) Then
                        Elementos.HoraDevolucion = reader("HoraDevolucion").ToString()
                    Else
                        Elementos.HoraDevolucion = "No Disponible"
                    End If
                    If reader("Estado") = 0 Then
                        Elementos.color = "#cc0202"
                    ElseIf reader("Estado") = 1 Then
                        Elementos.color = "green"
                    ElseIf reader("Estado") = 2 Then
                        Elementos.color = "gray"
                    ElseIf reader("Estado") = 3 Then
                        Elementos.color = "#428BCA"
                    ElseIf reader("Estado") = 4 Then
                        Elementos.color = "#1f598a"
                    ElseIf reader("Estado") = 1 Then
                        Elementos.color = "#065180"
                    End If
                    Using conn As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
                        conn.Open()
                        Dim AddDestinos As List(Of [ClassDestinosReservacion]) = New List(Of ClassDestinosReservacion)()
                        consulta = "select IdReservacion, Destino from DestinoReservacionVehiculo where IdReservacion=" & reader("Id")
                        Dim command As New MySqlCommand(consulta, conn)
                        Dim read As MySqlDataReader = command.ExecuteReader()
                        While read.Read
                            Dim ListDestino As New ClassDestinosReservacion
                            ListDestino.IdReservacion = read("IdReservacion")
                            ListDestino.Destino = read("Destino")
                            AddDestinos.Add(ListDestino)
                        End While
                        read.Close()
                        Elementos.destino = AddDestinos
                        conn.Close()
                    End Using

                    Elementos.observacion = reader("Observacion")
                    If Not IsDBNull(reader("UsuarioAutoriza")) Then
                        Elementos.UsuarioAutoriza = reader("UsuarioAutoriza")
                    End If
                    result.Add(Elementos)
                End While
            Catch ex As Exception
                Dim Elementos As New ClassReservacionesVehiculos
                Elementos.StrError = ex.Message
                result.Add(Elementos)
            Finally
                conexion.Close()
            End Try
        End Using
        Return result
    End Function

    <WebMethod(EnableSession:=True)> _
    Public Function ReImprimirReservacion(ByVal Id As String) As List(Of [ClassEntregaReservacion])
        Dim result As List(Of [ClassEntregaReservacion]) = New List(Of ClassEntregaReservacion)()
        Dim MysqlUPDATE As String
        Dim Usuario As String = Context.Request.Cookies("UserSettings")("user")
        Using conexion As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
            conexion.Open()
            Dim comando As New MySqlCommand
            Dim transaccion As MySqlTransaction
            transaccion = conexion.BeginTransaction
            comando.Connection = conexion
            comando.Transaction = transaccion
            Try
                Dim cmd As New MySqlCommand("SELECT res.Id,per.nombre NombreEmpleado,res.IdEmpleado,tip.tipo_vehiculo TipoVehiculo,cast(concat(day(res.FechaInicio),'/',month(res.FechaInicio),'/',year(res.FechaInicio),' ',hour(res.FechaInicio),':',minute(res.FechaInicio),':',second(res.FechaInicio)) as char) FechaInicio,cast(concat(day(res.FechaFin),'/',month(res.FechaFin),'/',year(res.FechaFin),' ',hour(res.FechaFin),':',minute(res.FechaFin),':',second(res.FechaFin)) as char) FechaFin,res.TodoElDia,res.Alerta,res.Observacion,res.Estado,res.UsuarioAutoriza,veh.codigo, res.IdVehiculo FROM reservacionvehiculo res inner join _vehiculos veh on veh.Id= res.IdVehiculo inner join tipo_vehiculo tip on res.IdTipoVehiculo=tip.id_tipo_vehiculo inner join personal per on res.IdEmpleado=per.idEmpleado WHERE res.Id=" & Id & ";", conexion)
                Dim reader As MySqlDataReader = cmd.ExecuteReader()
                reader.Read()
                If reader.HasRows Then
                    Dim streamWriter As System.IO.StreamWriter = New System.IO.StreamWriter(Server.MapPath("~/ReservacionAprobada.txt"), False, System.Text.Encoding.UTF8)
                    streamWriter.WriteLine("")
                    streamWriter.WriteLine("#FechaEmision#" & Now)
                    streamWriter.WriteLine("#Empleado#" & reader("NombreEmpleado"))
                    streamWriter.WriteLine("#UnidadCodigo#" & reader("codigo"))
                    streamWriter.WriteLine("#DescUnidad#" & reader("TipoVehiculo"))
                    streamWriter.WriteLine("#FechaInicio#" & reader("FechaInicio"))
                    streamWriter.WriteLine("#FechaFin#" & reader("FechaFin"))
                    Dim StrDestino As String = ""
                    Using conn As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
                        conn.Open()
                        Dim consulta As String = "select IdReservacion, Destino from DestinoReservacionVehiculo where IdReservacion=" & reader("Id")
                        Dim command As New MySqlCommand(consulta, conn)
                        Dim read As MySqlDataReader = command.ExecuteReader()
                        Dim cont As Integer = 0
                        While read.Read
                            If cont = 0 Then
                                StrDestino = read("Destino")
                            Else
                                StrDestino += " / " & read("Destino")
                            End If
                        End While
                        read.Close()
                        conn.Close()
                    End Using
                    streamWriter.WriteLine("#Destino#" & StrDestino)
                    streamWriter.WriteLine("#Obser#" & reader("Observacion"))
                    streamWriter.WriteLine("#CodigoBarra#" & Format(reader("IdVehiculo"), "0000") & Format(reader("IdEmpleado"), "000") & Format(reader("Id"), "0000"))
                    streamWriter.Close()
                    cmd.Dispose()
                    reader.Close()
                    Dim Elementos As New ClassEntregaReservacion
                    Elementos.StrError = "0"
                    result.Add(Elementos)

                Else
                    cmd.Dispose()
                    reader.Close()
                    Dim Elementos As New ClassEntregaReservacion
                    Elementos.StrError = "Numero de Reservacion no Existe."
                    result.Add(Elementos)
                End If
            Catch ex As Exception
                'transaccion.Dispose()
                Dim Elementos As New ClassEntregaReservacion
                Elementos.StrError = "..." & ex.Message
                result.Add(Elementos)
            Finally
                conexion.Close()
            End Try
        End Using
        Return result
    End Function
    Public Class ClassBuscarDatosReservacion
        Public StrError As String = "0"
        Public nombre As String
        Public unidad As String
        Public fechainicio As String
        Public fechafin As String
    End Class
    <WebMethod(EnableSession:=True)> _
    Public Function BuscarReservacionesDetalle(ByVal Fecha As String, ByVal id As Integer, ByVal dia As Integer) As List(Of [ClassBuscarDatosReservacion])
        Dim result As List(Of [ClassBuscarDatosReservacion]) = New List(Of ClassBuscarDatosReservacion)()
        Dim Cn As New datos
        Dim dt As DataTable
        Dim dias, fechas As New ArrayList
        Dim consulta As String

        Using conexion As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
            Try

                Dim newdate3 As DateTime = Date.Parse(Fecha.ToString, System.Globalization.CultureInfo.CreateSpecificCulture("en-au"))
                Dim Fecha3 = Year(newdate3) & "/" & Month(newdate3) & "/" & Day(newdate3)
                consulta = "select distinct v.id, v.codigo, p.nombre,r.fechainicio,r.fechafin from reservacionvehiculo r join personal p on r.idempleado = p.idempleado join _vehiculos V on r.idvehiculo = V.id where v.id= '" & id & "' and '" & dia & "' between day(r.fechainicio) and day(r.fechafin) and (month(r.fechainicio) = '" & Month(newdate3) & "' or month(r.fechafin) = '" & Month(newdate3) & "' ) and (year(r.fechainicio) = '" & Year(newdate3) & "' or year(r.fechafin) = '" & Year(newdate3) & "') and r.Estado!=2 order by r.fechainicio,r.fechafin;"
                dt = Cn.Datos(consulta)

                For i As Integer = 0 To dt.Rows.Count - 1
                    Dim Elementos As New ClassBuscarDatosReservacion
                    Elementos.nombre = dt.Rows(i).Item("nombre")
                    Elementos.unidad = dt.Rows(i).Item("codigo")
                    Elementos.fechainicio = dt.Rows(i).Item("fechainicio")
                    Elementos.fechafin = dt.Rows(i).Item("fechafin")
                    result.Add(Elementos)
                Next

            Catch ex As Exception
                Dim Elementos As New ClassBuscarDatosReservacion
                Elementos.StrError = ex.Message
                result.Add(Elementos)
            Finally
                conexion.Close()
            End Try
        End Using
        Return result
    End Function
    Public Class cllenarUnidades
        Public idUnidad As String
        Public nomUnidad As String
        Public strError As String
    End Class
    <WebMethod(EnableSession:=True)> _
    Public Function llenarUnidades(ByVal depto As Integer) As List(Of cllenarUnidades)
        Dim result As List(Of cllenarUnidades) = New List(Of cllenarUnidades)()
        Try
            Dim str As String
            Dim dt As DataTable
            str = "select v.codigo,v.id from facturacion as f inner join _vehiculos as v on v.id = f.Vehiculo " & _
                "where (f.departamento = " & depto & " or 0 = " & depto & ") group by v.codigo,v.id;"
            dt = datos.Datos(str)
            For i = 0 To dt.Rows.Count - 1
                Dim elemento As New cllenarUnidades
                elemento.idUnidad = dt.Rows(i).Item("id").ToString
                elemento.nomUnidad = dt.Rows(i).Item("codigo").ToString
                result.Add(elemento)
            Next
        Catch ex As Exception
            Dim elemento As New cllenarUnidades
            elemento.strError = "..." & ex.Message
            result.Add(elemento)
        End Try
        Return result
    End Function
    Public Class detalleCostos
        Public doc As String
        Public fecha As String
        Public unidad As String
        Public codigo As String
        Public clasif As String
        Public subcla As String
        Public desc As String
        Public cant As String
        Public precio As String
        Public total As String
        Public strError As String
    End Class
    <WebMethod(EnableSession:=True)> _
    Public Function llenarDetalle(ByVal depto As Integer, ByVal unidad As String, ByVal fechaIni As String, ByVal fechaFin As String) As List(Of detalleCostos)
        Dim result As List(Of detalleCostos) = New List(Of detalleCostos)()
        Try
            Dim str As String
            Dim dt As DataTable
            Dim dat, dat2 As Date
            dat = fechaIni
            dat2 = fechaFin
            str = "select DATE_FORMAT(f.fecha,'%d/%m/%Y') fecha, v.codigo,fd.codigo as coda,fd.precioU,fd.cantidad,fd.total, a.descripcion," & _
                " cl.descripcion as cla,sc.descripcion as subcla,concat(f.serie , '-' , f.nofac) as numFac from facturacion as f inner join _vehiculos as v on v.id = f.vehiculo" & _
                " inner join departamentos as d on d.id = f.departamento inner join facturaciond as fd on" & _
                " fd.correlativo = f.corre inner join inventario as a on a.codigo = fd.codigo inner join" & _
                " clasificacion as cl on cl.Id = a.clasifi inner join subclasificacion as sc on sc.id = a.subclasi" & _
                " and cl.id = sc.id2 where (f.departamento = " & depto & " or 0=" & depto & ") and (v.id = '" & unidad & _
                "' or ''='" & unidad & "' or 0=" & Val(unidad) & ") and f.fecha between '" & dat.ToString("yyyy-MM-dd") & "' and '" & dat2.ToString("yyyy-MM-dd") & "';"
            dt = datos.Datos(str)
            For Each Row As DataRow In dt.Rows
                Dim elemento As New detalleCostos
                elemento.doc = Row("numFac")
                elemento.fecha = Row("fecha")
                elemento.unidad = Row("codigo")
                elemento.codigo = Row("coda")
                elemento.precio = Row("precioU")
                elemento.total = Row("total")
                elemento.clasif = Row("cla")
                elemento.subcla = Row("subcla")
                elemento.desc = Row("descripcion")
                elemento.cant = Row("cantidad")
                result.Add(elemento)
            Next
        Catch ex As Exception
            Dim elemento As New detalleCostos
            elemento.strError = "...." & ex.Message
            result.Add(elemento)
        End Try
        Return result
    End Function

    <WebMethod(EnableSession:=True)> _
    Public Function crearPDF(ByVal factura As String) As Boolean
        Dim result As Boolean = False
        Try
            Dim str As String
            Dim dt, dt2 As DataTable
            Dim cn As New datos
            str = "select * from V_Enc_Factura where concat(serie,'-',nofac) = '" & factura & "';"
            dt = cn.Datos(str)
            Dim sw As New StringWriter()
            Dim hw As New HtmlTextWriter(sw)
            Dim image As iTextSharp.text.Image
            Dim parrafo As New Paragraph

            'style to format numbers to string
            Dim style As String = "<style>.textmode{mso-number-format:\@;}</style>"
            Dim sr As New StringReader(sw.ToString())

            Dim pdfDoc As New Document(PageSize.LETTER, 30.0F, 30.0F, 90.0F, 30.0F)
            Dim htmlparser As New HTMLWorker(pdfDoc)
            PdfWriter.GetInstance(pdfDoc, New FileStream(Server.MapPath("~/reporte/ReporteFactura.pdf"), FileMode.Create))
            If pdfDoc.IsOpen Then
                pdfDoc.Close()
            End If
            pdfDoc.Open()


            'pdfDoc.Add(New Paragraph("SALDO"))
            image = iTextSharp.text.Image.GetInstance(Server.MapPath("~/images/logoGentrac.jpg")) 'Dirección a la imagen que se hace referencia
            'image.SetAbsolutePosition(50, 700) 'Posición en el eje cartesiano
            image.ScaleAbsoluteWidth(150) 'Ancho de la imagen
            image.ScaleAbsoluteHeight(75) 'Altura de la imagen
            'pdfDoc.Add(image) ' Agrega la imagen al documento

            Dim table As New PdfPTable(3)
            Dim tablaI As New PdfPTable(2)
            Dim cell As PdfPCell
            Dim widths As Integer()
            Dim fuente As New Font(Font.HELVETICA, 9.0F, Font.BOLD, Color.BLACK)
            Dim fuente1 As New Font(Font.HELVETICA, 12.0F, Font.BOLD, Color.BLACK)
            Dim fuente2 As New Font(Font.HELVETICA, 9.0F, Font.NORMAL, Color.BLACK)

            widths = New Integer() {1.0F, 1.0F, 1.0F}
            table.SetWidths(widths)
            table.WidthPercentage = 100
            table.SpacingBefore = 15

            cell = New PdfPCell(image)
            cell.BorderWidth = 0
            cell.HorizontalAlignment = 1
            table.AddCell(cell)

            tablaI = New PdfPTable(1)
            widths = New Integer() {1.0F}
            tablaI.SetWidths(widths)

            cell = New PdfPCell(New Phrase(Trim(dt.Rows(0).Item("nomEmpsa").ToString), fuente1))
            cell.BorderWidth = 0
            cell.HorizontalAlignment = 1
            tablaI.AddCell(cell)

            cell = New PdfPCell(New Phrase(Trim(dt.Rows(0).Item("direccion").ToString), fuente2))
            cell.BorderWidth = 0
            cell.HorizontalAlignment = 1
            tablaI.AddCell(cell)

            cell = New PdfPCell(tablaI)
            cell.HorizontalAlignment = 1
            cell.BorderWidth = 0
            table.AddCell(cell)

            tablaI = New PdfPTable(2)
            widths = New Integer() {1.0F, 1.0F}
            tablaI.SetWidths(widths)

            cell = New PdfPCell(New Phrase("INGRESO", fuente))
            cell.BorderWidth = 0
            cell.Colspan = 2
            cell.HorizontalAlignment = 1
            tablaI.AddCell(cell)

            cell = New PdfPCell(New Phrase("SERIE", fuente))
            cell.BorderWidth = 0
            cell.HorizontalAlignment = 1
            tablaI.AddCell(cell)

            cell = New PdfPCell(New Phrase("No", fuente))
            cell.BorderWidth = 0
            cell.HorizontalAlignment = 1
            tablaI.AddCell(cell)

            cell = New PdfPCell(New Phrase(Trim(dt.Rows(0).Item("serie").ToString()), fuente))
            cell.BorderWidth = 0
            cell.HorizontalAlignment = 1
            tablaI.AddCell(cell)

            cell = New PdfPCell(New Phrase(Trim(dt.Rows(0).Item("nofac").ToString()), fuente))
            cell.BorderWidth = 0
            cell.HorizontalAlignment = 1
            tablaI.AddCell(cell)

            cell = New PdfPCell(New Phrase("Fecha: ", fuente))
            cell.BorderWidth = 0
            cell.HorizontalAlignment = 1
            tablaI.AddCell(cell)

            Dim d As Date = dt.Rows(0).Item("fecha")

            cell = New PdfPCell(New Phrase(d.ToString("dd-MM-yyyy"), fuente))
            cell.BorderWidth = 0
            cell.Colspan = 2
            cell.HorizontalAlignment = 1
            tablaI.AddCell(cell)

            cell = New PdfPCell(New Phrase("Fecha de Operacion: ", fuente))
            cell.BorderWidth = 0
            cell.HorizontalAlignment = 1
            tablaI.AddCell(cell)

            d = dt.Rows(0).Item("fecha_operacion")
            cell = New PdfPCell(New Phrase(Trim(d.ToString("dd-MM-yyyy")), fuente))
            cell.BorderWidth = 0
            cell.HorizontalAlignment = 1
            tablaI.AddCell(cell)

            cell = New PdfPCell(tablaI)
            cell.BorderWidth = 1
            cell.HorizontalAlignment = 1
            table.AddCell(cell)

            table.AddCell(tablaI)
            pdfDoc.Add(table)

            tablaI = New PdfPTable(2)
            widths = New Integer() {3.0F, 6.0F}
            tablaI.SetWidths(widths)

            table = New PdfPTable(3)
            widths = New Integer() {1.0F, 1.0F, 1.0F}
            table.SetWidths(widths)
            table.WidthPercentage = 100
            table.SpacingBefore = 15

            cell = New PdfPCell(New Phrase("Comprador: ", fuente))
            cell.BorderWidth = 0
            cell.HorizontalAlignment = 0
            tablaI.AddCell(cell)

            cell = New PdfPCell(New Phrase(Trim(dt.Rows(0).Item("nomPer").ToString()), fuente))
            cell.BorderWidth = 0
            cell.HorizontalAlignment = 0
            tablaI.AddCell(cell)

            cell = New PdfPCell(New Phrase("Operador: ", fuente))
            cell.BorderWidth = 0
            cell.HorizontalAlignment = 0
            tablaI.AddCell(cell)

            cell = New PdfPCell(New Phrase(Trim(dt.Rows(0).Item("operador").ToString), fuente))
            cell.BorderWidth = 0
            cell.HorizontalAlignment = 0
            tablaI.AddCell(cell)

            cell = New PdfPCell(New Phrase("Proveedor: ", fuente))
            cell.BorderWidth = 0
            cell.HorizontalAlignment = 0
            tablaI.AddCell(cell)

            cell = New PdfPCell(New Phrase(dt.Rows(0).Item("nomPro").ToString, fuente))
            cell.BorderWidth = 0
            cell.HorizontalAlignment = 0
            tablaI.AddCell(cell)

            table.AddCell(tablaI)

            tablaI = New PdfPTable(2)
            widths = New Integer() {4.0F, 6.0F}
            tablaI.SetWidths(widths)

            cell = New PdfPCell(New Phrase("Nit: ", fuente))
            cell.BorderWidth = 0
            cell.HorizontalAlignment = 0
            tablaI.AddCell(cell)

            cell = New PdfPCell(New Phrase(Trim(dt.Rows(0).Item("provedor").ToString()), fuente))
            cell.BorderWidth = 0
            cell.HorizontalAlignment = 0
            tablaI.AddCell(cell)

            cell = New PdfPCell(New Phrase("Departamento: ", fuente))
            cell.BorderWidth = 0
            cell.HorizontalAlignment = 0
            tablaI.AddCell(cell)

            cell = New PdfPCell(New Phrase(Trim(dt.Rows(0).Item("descripcion").ToString()), fuente))
            cell.BorderWidth = 0
            cell.HorizontalAlignment = 0
            tablaI.AddCell(cell)

            table.AddCell(tablaI)

            tablaI = New PdfPTable(2)
            widths = New Integer() {3.0F, 6.0F}
            tablaI.SetWidths(widths)

            cell = New PdfPCell(New Phrase("Recibe: ", fuente))
            cell.BorderWidth = 0
            cell.HorizontalAlignment = 1
            tablaI.AddCell(cell)

            cell = New PdfPCell(New Phrase(Trim(dt.Rows(0).Item("nomPer").ToString()), fuente))
            cell.BorderWidth = 0
            cell.HorizontalAlignment = 1
            tablaI.AddCell(cell)

            table.AddCell(tablaI)
            pdfDoc.Add(table)


            table = New PdfPTable(5)
            widths = New Integer() {1.0F, 2.0F, 5.0F, 2.0F, 2.0F}
            table.SetWidths(widths)
            table.WidthPercentage = 100
            table.SpacingBefore = 15

            cell = New PdfPCell(New Phrase("CANT.", fuente))
            cell.BackgroundColor = New Color(124, 134, 133)
            cell.BorderWidth = 1
            cell.HorizontalAlignment = 1
            table.AddCell(cell)

            cell = New PdfPCell(New Phrase("CODIGO", fuente))
            cell.BackgroundColor = New Color(124, 134, 133)
            cell.BorderWidth = 1
            cell.HorizontalAlignment = 1
            table.AddCell(cell)

            cell = New PdfPCell(New Phrase("ARTICULO", fuente))
            cell.BackgroundColor = New Color(124, 134, 133)
            cell.BorderWidth = 1
            cell.HorizontalAlignment = 1
            table.AddCell(cell)

            cell = New PdfPCell(New Phrase("P/U", fuente))
            cell.BackgroundColor = New Color(124, 134, 133)
            cell.BorderWidth = 1
            cell.HorizontalAlignment = 1
            table.AddCell(cell)

            cell = New PdfPCell(New Phrase("SUB-TOTAL", fuente))
            cell.BackgroundColor = New Color(124, 134, 133)
            cell.BorderWidth = 1
            cell.HorizontalAlignment = 1
            table.AddCell(cell)
            Dim tota As Double

            dt2 = cn.Datos("select * from v_det_factura where idEnc = " & Trim(dt.Rows(0).Item("corre").ToString()))
            If dt2.Rows.Count > 0 Then
                For i As Integer = 0 To dt2.Rows.Count - 1

                    cell = New PdfPCell(New Phrase(dt2.Rows(i).Item("cantidad").ToString, fuente2))
                    If (Not (i Mod 2) = 0) And i > 0 Then
                        cell.BackgroundColor = New Color(155, 164, 252)
                    End If
                    cell.BorderWidth = 0
                    cell.HorizontalAlignment = 1
                    table.AddCell(cell)

                    cell = New PdfPCell(New Phrase(dt2.Rows(i).Item("codigo").ToString, fuente2))
                    If (Not (i Mod 2) = 0) And i > 0 Then
                        cell.BackgroundColor = New Color(155, 164, 252)
                    End If
                    cell.BorderWidth = 0
                    cell.HorizontalAlignment = 0
                    table.AddCell(cell)

                    cell = New PdfPCell(New Phrase(dt2.Rows(i).Item("artic").ToString, fuente2))
                    If (Not (i Mod 2) = 0) And i > 0 Then
                        cell.BackgroundColor = New Color(155, 164, 252)
                    End If
                    cell.BorderWidth = 0
                    cell.HorizontalAlignment = 0
                    table.AddCell(cell)

                    cell = New PdfPCell(New Phrase(dt2.Rows(i).Item("precioU").ToString, fuente2))
                    If (Not (i Mod 2) = 0) And i > 0 Then
                        cell.BackgroundColor = New Color(155, 164, 252)
                    End If
                    cell.BorderWidth = 0
                    cell.HorizontalAlignment = 2
                    table.AddCell(cell)

                    cell = New PdfPCell(New Phrase(dt2.Rows(i).Item("total").ToString, fuente2))
                    If (Not (i Mod 2) = 0) And i > 0 Then
                        cell.BackgroundColor = New Color(155, 164, 252)
                    End If
                    cell.BorderWidth = 0
                    cell.HorizontalAlignment = 2
                    table.AddCell(cell)

                    tota += Val(dt2.Rows(i).Item("total"))
                Next
                cell = New PdfPCell(New Phrase("---ULTIMA LINEA---", fuente1))
                cell.BorderWidth = 0
                cell.Colspan = 2
                cell.HorizontalAlignment = 1
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase(""))
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 0
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase(""))
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 0
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase(""))
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 0
                table.AddCell(cell)
                'fin linea
                cell = New PdfPCell(New Phrase(""))
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 0
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase(""))
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 1
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase(""))
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 0
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase(""))
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 0
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase(""))
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 0
                table.AddCell(cell)
                'fin linea
                cell = New PdfPCell(New Phrase("", fuente))
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 0
                cell.Colspan = 2
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase(""))
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 0
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase("TOTAL:"))
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 0
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase(tota.ToString("C")))
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 2
                table.AddCell(cell)
            End If
            pdfDoc.Add(table)

            pdfDoc.Close()
            result = True
        Catch ex As Exception
            'MsgBox(ex.Message)
            result = False
        End Try
        Return result
    End Function
    Public Class ClassReporteEjecutivoUnidadData
        Public Fecha As Integer
        Public Valor As String
        Public Parametro As Boolean = True
    End Class
    Public Class ClassReporteEjecutivoUnidad
        Public IdVehiculo As Integer
        Public Departamento As String
        Public Unidad As String
        Public Piloto As String
        Public Data As New List(Of ClassReporteEjecutivoUnidadData)
        Public Mediana As String
        Public Moda As String
        Public Frecuencia As String
        Public Promedio As String
        Public Total As String

    End Class
    Public Class ClassReporteEjecutivo
        Public StrError As String = "0"
        Public Dias As Integer
        Public Unidad As New List(Of ClassReporteEjecutivoUnidad)
    End Class
    <WebMethod(EnableSession:=True)> _
    Public Function ReporteEjecutivo(ByVal Departamento As Integer, ByVal Year As Integer, ByVal Mes As Integer, ByVal Opcion As Integer, ByVal Filtro As Integer, ByVal Valor As String, ByVal Vehiculo As String) As List(Of [ClassReporteEjecutivo])
        Dim result As List(Of [ClassReporteEjecutivo]) = New List(Of ClassReporteEjecutivo)()
        Dim consulta As String
        Using conexion As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
            Try
                conexion.Open()
                Dim Fecha As New Date(Year, Mes, 1)
                Dim dias = Fecha.AddMonths(1).AddDays(-1)
                Dim Elementos As New ClassReporteEjecutivo
                Elementos.Dias = dias.Day
                Dim Complemento As String = ""
                Dim Total As String = ""
                If Opcion = 1 Then
                    Complemento = ",sec_to_time(avg(time_to_sec(HoraInicio))) Promedio "
                    Total = ",FORMAT(sum((Distancia)),2) Total "
                ElseIf Opcion = 2 Then
                    Complemento = ",sec_to_time(avg(time_to_sec(HoraFin))) Promedio "
                    Total = ",FORMAT(sum((Distancia)),2) Total "
                ElseIf Opcion = 3 Then
                    Complemento = ",FORMAT(avg(MaximaVelocidad),2) Promedio "
                    Total = ",FORMAT(avg(MaximaVelocidad),2) Total  "
                ElseIf Opcion = 4 Then
                    Complemento = ",FORMAT(avg(Distancia),2) Promedio "
                    Total = ",FORMAT(sum((Distancia)),2) Total "
                ElseIf Opcion = 5 Then
                    Complemento = ",sec_to_time(avg(time_to_sec(MotorEncendido))) Promedio "
                    Total = ",FORMAT(sum((Distancia)),2) Total  "
                End If
                If Vehiculo = 0 Then
                    consulta = "select dp.descripcion Departamento,v.codigo Codigo, adc.IdVehiculo, adc.Piloto " & Complemento & "" & Total & " from actividaddiairiavehiculo adc inner join _vehiculos v on adc.IdVehiculo=v.id and (v.departamento=" & Departamento & " or 0=" & Departamento & ") inner join departamentos dp on v.departamento=dp.id where year(adc.Fecha)='" & Year & "' and month(adc.Fecha)=" & Mes & " group by adc.IdVehiculo;"
                Else
                    consulta = "select dp.descripcion Departamento,v.codigo Codigo, adc.IdVehiculo, adc.Piloto " & Complemento & "" & Total & " from actividaddiairiavehiculo adc inner join _vehiculos v on adc.IdVehiculo=v.id and (v.departamento=" & Departamento & " or 0=" & Departamento & ") inner join departamentos dp on v.departamento=dp.id where adc.IdVehiculo=" & Vehiculo & " and year(adc.Fecha)='" & Year & "' and month(adc.Fecha)=" & Mes & " group by adc.IdVehiculo;"

                End If

                Dim cmd As New MySqlCommand(consulta, conexion)
                Dim reader As MySqlDataReader = cmd.ExecuteReader()
                Dim res As List(Of [ClassReporteEjecutivoUnidad]) = New List(Of ClassReporteEjecutivoUnidad)()
                While reader.Read
                    Dim Elemento As New ClassReporteEjecutivoUnidad
                    Elemento.IdVehiculo = reader("IdVehiculo")
                    Elemento.Departamento = reader("Departamento")
                    Elemento.Unidad = reader("Codigo")
                    Elemento.Piloto = reader("Piloto").ToString()


                    Elemento.Total = reader("Total")


                    Using conn As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
                        conn.Open()
                        Dim StrValor As String = ""
                        If Opcion = 1 Then
                            StrValor = ",cast(time_format(concat(hour(adc.HoraInicio),':', minute(adc.HoraInicio)), '%H:%i') as char) Valor "
                        ElseIf Opcion = 2 Then
                            StrValor = ",cast(time_format(concat(hour(adc.HoraFin),':', minute(adc.HoraFin)), '%H:%i') as char) Valor"
                        ElseIf Opcion = 3 Then
                            StrValor = ",adc.MaximaVelocidad Valor"
                        ElseIf Opcion = 4 Then
                            StrValor = ",adc.Distancia Valor"
                        ElseIf Opcion = 5 Then
                            StrValor = ",cast(time_format(concat(hour(adc.MotorEncendido),':', minute(adc.MotorEncendido)), '%H:%i') as char) Valor"
                        End If

                        Dim SQLDetalle As String = "select cast(day(adc.Fecha) as char) Fecha " & StrValor & " from actividaddiairiavehiculo adc where IdVehiculo=" & reader("IdVehiculo") & " and year(adc.Fecha)='" & Year & "' and month(adc.Fecha)=" & Mes & " order by Valor;"
                        Dim command As New MySqlCommand(SQLDetalle, conn)
                        Dim read As MySqlDataReader = command.ExecuteReader()
                        Dim rest As List(Of [ClassReporteEjecutivoUnidadData]) = New List(Of ClassReporteEjecutivoUnidadData)()
                        Dim cont As Integer = 0
                        Dim valores(0) As String
                        While read.Read
                            Dim Ele As New ClassReporteEjecutivoUnidadData
                            Ele.Fecha = read("Fecha").ToString()
                            Ele.Valor = read("Valor").ToString()
                            Select Case Filtro
                                Case 1
                                    ' Dim seconds As Integer = TimeSpan.Parse(Ele.Valor).TotalSeconds
                                    If Opcion = 1 Or Opcion = 2 Then
                                        Dim seconds As Integer = TimeSpan.Parse(Ele.Valor).TotalSeconds
                                        Dim secondValor As Integer = TimeSpan.Parse(Valor).TotalSeconds
                                        If Val(seconds) < Val(secondValor) Then
                                            Ele.Parametro = False
                                        End If
                                    Else
                                        If Val(Ele.Valor) < Val(Valor) Then
                                            Ele.Parametro = False
                                        End If
                                    End If
                                Case 2
                                    If Opcion = 1 Or Opcion = 2 Then
                                        Dim seconds As Integer = TimeSpan.Parse(Ele.Valor).TotalSeconds
                                        Dim secondValor As Integer = TimeSpan.Parse(Valor).TotalSeconds
                                        If Val(seconds) <= Val(Valor) Then
                                            Ele.Parametro = False
                                        End If
                                    Else
                                        If Val(Ele.Valor) <= Val(Valor) Then
                                            Ele.Parametro = False
                                        End If
                                    End If
                                Case 3
                                    If Opcion = 1 Or Opcion = 2 Then
                                        Dim seconds As Integer = TimeSpan.Parse(Ele.Valor).TotalSeconds
                                        Dim secondValor As Integer = TimeSpan.Parse(Valor).TotalSeconds
                                        If Val(seconds) = Val(secondValor) Then
                                            Ele.Parametro = False
                                        End If
                                    Else
                                        If Val(Ele.Valor) = Val(Valor) Then
                                            Ele.Parametro = False
                                        End If
                                    End If
                                Case 4
                                    If Opcion = 1 Or Opcion = 2 Then
                                        Dim seconds As Integer = TimeSpan.Parse(Ele.Valor).TotalSeconds
                                        Dim secondValor As Integer = TimeSpan.Parse(Valor).TotalSeconds
                                        If Val(seconds) >= Val(secondValor) Then
                                            Ele.Parametro = False
                                        End If
                                    Else
                                        If Val(Ele.Valor) >= Val(Valor) Then
                                            Ele.Parametro = False
                                        End If
                                    End If
                                Case 5
                                    If Opcion = 1 Or Opcion = 2 Then
                                        Dim seconds As Integer = TimeSpan.Parse(Ele.Valor).TotalSeconds
                                        Dim secondValor As Integer = TimeSpan.Parse(Valor).TotalSeconds
                                        If Val(seconds) > Val(secondValor) Then
                                            Ele.Parametro = False
                                        End If
                                    Else
                                        If Val(Ele.Valor) > Val(Valor) Then
                                            Ele.Parametro = False
                                        End If
                                    End If
                                Case 6
                                    If Opcion = 1 Or Opcion = 2 Then
                                        Dim seconds As Integer = TimeSpan.Parse(Ele.Valor).TotalSeconds
                                        Dim secondValor As Integer = TimeSpan.Parse(Valor).TotalSeconds
                                        If Val(seconds) <> Val(secondValor) Then
                                            Ele.Parametro = False
                                        End If
                                    Else
                                        If Val(Ele.Valor) <> Val(Valor) Then
                                            Ele.Parametro = False
                                        End If
                                    End If
                            End Select
                            cont = cont + 1
                            Array.Resize(valores, cont + 1)
                            valores(cont) = read("Valor").ToString()
                            rest.Add(Ele)
                        End While
                        If cont Mod 2 = 0 Then
                            Dim int As Integer
                            int = (cont / 2)
                            If Opcion = 4 Or Opcion = 3 Then
                                Elemento.Mediana = (Val(valores(int)) + Val(valores(int + 1))) / 2
                            Else
                                Dim da As DateTime = Convert.ToDateTime(valores(int)).AddHours(Split(valores(int + 1), ":")(0)).AddMinutes(Split(valores(int + 1), ":")(1))
                                Dim i As Integer
                                Dim t = Math.DivRem(Convert.ToInt32((Hour(da) + Minute(da))), 2, i)
                                Dim _hora = Hour(da) / 2
                                Dim _Minuto = Minute(da) / 2
                                Elemento.Mediana = da.AddHours(-_hora).AddMinutes(-_Minuto).ToString("hh:mm")
                            End If
                        Else
                            Dim int As Integer
                            int = (cont / 2) + 0.5
                            Elemento.Mediana = valores(int)
                        End If
                        Using con As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
                            con.Open()
                            If Opcion = 1 Then
                                StrValor = "cast(time_format(concat(hour(HoraInicio),':', minute(HoraInicio)), '%H:%i') as char) Moda "
                            ElseIf Opcion = 2 Then
                                StrValor = "cast(time_format(concat(hour(HoraFin),':', minute(HoraFin)), '%H:%i') as char) Moda"
                            ElseIf Opcion = 3 Then
                                StrValor = "MaximaVelocidad Moda"
                            ElseIf Opcion = 4 Then
                                StrValor = "Distancia Moda"
                            ElseIf Opcion = 5 Then
                                StrValor = "cast(time_format(concat(hour(MotorEncendido),':', minute(MotorEncendido)), '%H:%i') as char) Moda"
                            End If
                            Dim Str As String = "select " & StrValor & ", count(Id) Frecuencia from actividaddiairiavehiculo where IdVehiculo=" & reader("IdVehiculo") & " and year(Fecha)='" & Year & "' and month(Fecha)=" & Mes & " group by Moda order by Frecuencia desc limit 1;"
                            Dim comm As New MySqlCommand(Str, con)
                            Dim reads As MySqlDataReader = comm.ExecuteReader()
                            reads.Read()
                            If reads.HasRows Then
                                Elemento.Frecuencia = reads("Frecuencia")
                                If Convert.ToInt32(reads("Frecuencia")) > 1 Then
                                    Elemento.Moda = reads("Moda")
                                Else
                                    Elemento.Moda = "No Definida"
                                End If


                            End If
                        End Using
                        Using con As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
                            con.Open()
                            If Opcion = 1 Then
                                StrValor = "time_format(sec_to_time(AVG(TIME_TO_SEC(HoraInicio))), '%H:%i') AS promedio "
                            ElseIf Opcion = 2 Then
                                StrValor = "time_format(sec_to_time(AVG(TIME_TO_SEC(HoraFin))), '%H:%i') AS promedio"
                            ElseIf Opcion = 3 Then
                                StrValor = "format(avg(MaximaVelocidad),2) AS promedio"
                            ElseIf Opcion = 4 Then
                                StrValor = "format(avg(Distancia),2) AS promedio"
                            ElseIf Opcion = 5 Then
                                StrValor = "time_format(sec_to_time(AVG(TIME_TO_SEC(MotorEncendido))), '%H:%i') AS promedio"
                            End If
                            Dim Str As String = "select " & StrValor & " from actividaddiairiavehiculo where IdVehiculo=" & reader("IdVehiculo") & " and year(Fecha)='" & Year & "' and month(Fecha)=" & Mes & " limit 1;"
                            Dim comm As New MySqlCommand(Str, con)
                            Dim reads As MySqlDataReader = comm.ExecuteReader()
                            reads.Read()
                            If reads.HasRows Then
                                Elemento.Promedio = reads("promedio")
                            End If
                        End Using
                        Elemento.Data = rest
                        conn.Close()
                    End Using
                    res.Add(Elemento)
                End While
                Elementos.Unidad = res
                result.Add(Elementos)
            Catch ex As Exception
                Dim Elementos As New ClassReporteEjecutivo
                Elementos.StrError = ex.Message
                result.Add(Elementos)
            Finally
                conexion.Close()
            End Try
        End Using
        Return result
    End Function
    Public Class ClassReservacionOT
        Public StrError As String = "0"
        Public Clasificacion As String
        Public Servicio As String
        Public Descripcion As String
        Public Tiempo As String
        Public Estado As String
        Public IdOT As Integer
    End Class

    <WebMethod(EnableSession:=True)> _
    Public Function BuscarReservacionOT(ByVal IdOT As Integer) As List(Of [ClassReservacionOT])
        Dim result As List(Of [ClassReservacionOT]) = New List(Of ClassReservacionOT)()
        Dim Cn As New datos
        Dim dt As DataTable
        Dim dias, fechas As New ArrayList
        Dim consulta As String
        Using conexion As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
            Try
                consulta = "select od.id,tfa.pieza,tfa.descripcion,od.Description,od.tiempo,od.estado,od.fechaCierre,od.descripcionCierre from ordenesd od inner join tfallas tfa on od.codigo=tfa.Id where estado='ABIERTO' and od.id2=" & IdOT
                dt = Cn.Datos(consulta)
                For i As Integer = 0 To dt.Rows.Count - 1
                    Dim Elementos As New ClassReservacionOT
                    Elementos.Clasificacion = dt.Rows(i).Item("pieza")
                    Elementos.Servicio = dt.Rows(i).Item("descripcion")
                    Elementos.Descripcion = dt.Rows(i).Item("Description")
                    Elementos.Tiempo = dt.Rows(i).Item("tiempo")
                    Elementos.Estado = dt.Rows(i).Item("estado")
                    Elementos.IdOT = dt.Rows(i).Item("id")
                    result.Add(Elementos)
                Next
            Catch ex As Exception
                Dim Elementos As New ClassReservacionOT
                Elementos.StrError = ex.Message
                result.Add(Elementos)
            Finally
                conexion.Close()
            End Try
        End Using
        Return result
    End Function
    Public Class ClassCerrarOT
        Public StrError As String = "0"
    End Class
    <WebMethod(EnableSession:=True)> _
    Public Function CerrarOT(ByVal IdOT As String, ByVal Kilometraje As String, ByVal descripcionCierre As String) As List(Of [ClassCerrarOT])
        Dim result As List(Of [ClassCerrarOT]) = New List(Of ClassCerrarOT)()
        Using conexion As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
            conexion.Open()
            Dim comando As New MySqlCommand
            Dim transaccion As MySqlTransaction
            transaccion = conexion.BeginTransaction
            comando.Connection = conexion
            comando.Transaction = transaccion
            Try
                Dim cmd As New MySqlCommand("select od.Id,od.Id2,od.Description,od.estado,o.vehiculo,od.codigo from ordenesd od inner join ordenes o on o.id=od.Id2 where od.Id=" & IdOT & " limit 1;", conexion)
                Dim reader As MySqlDataReader = cmd.ExecuteReader()
                reader.Read()
                Dim IdVehiculo As Integer
                Dim IdOrden As Integer
                If reader.HasRows Then
                    IdVehiculo = reader("vehiculo")
                    IdOrden = reader("Id2")
                    Dim IdCodigo As Integer = reader("codigo")
                    cmd.Dispose()
                    reader.Close()
                    Dim MysqlUPDATE As String = ""
                    comando.CommandType = Data.CommandType.Text
                    MysqlUPDATE = "UPDATE ordenesd set estado='CERRADO', fechaCierre=now(),descripcionCierre='" & descripcionCierre & "' where Id = " & IdOT
                    MyDB.MyCommand("UPDATE vehiculoservicio SET StatusServicio=0 WHERE IdVehiculo=" & IdVehiculo & " LIMIT 1;")
                    comando.CommandText = MysqlUPDATE
                    comando.ExecuteNonQuery()
                    If IdCodigo = 1 Or IdCodigo = 2 Or IdCodigo = 3 Then
                        comando.CommandType = Data.CommandType.Text
                        MysqlUPDATE = "INSERT INTO vehiculoservicio (IdVehiculo, UltimoServicioMotor, FechaServicioMotor)VALUES(" & IdVehiculo & ", '" & Kilometraje & "', concat(year(now()), '-',month(now()),'-',day(now()))) ON DUPLICATE KEY UPDATE  UltimoServicioMotor  = '" & Kilometraje & "', FechaServicioMotor = concat(year(now()), '-',month(now()),'-',day(now()))"
                        comando.CommandText = MysqlUPDATE
                        comando.ExecuteNonQuery()
                    ElseIf IdCodigo = 4 Or IdCodigo = 5 Or IdCodigo = 6 Then
                        comando.CommandType = Data.CommandType.Text
                        MysqlUPDATE = "INSERT INTO vehiculoservicio (IdVehiculo, UltimoServicioTransmision, FechaServicioTransmision)VALUES(" & IdVehiculo & ", '" & Kilometraje & "', concat(year(now()), '-',month(now()),'-',day(now()))) ON DUPLICATE KEY UPDATE  UltimoServicioTransmision  = '" & Kilometraje & "', FechaServicioTransmision = concat(year(now()), '-',month(now()),'-',day(now()))"
                        comando.CommandText = MysqlUPDATE
                        comando.ExecuteNonQuery()
                    ElseIf IdCodigo = 7 Or IdCodigo = 8 Or IdCodigo = 9 Then
                        comando.CommandType = Data.CommandType.Text
                        MysqlUPDATE = "INSERT INTO vehiculoservicio (IdVehiculo, UltimoServicioDiferencial, FechaServicioDiferencial)VALUES(" & IdVehiculo & ", '" & Kilometraje & "', concat(year(now()), '-',month(now()),'-',day(now()))) ON DUPLICATE KEY UPDATE  UltimoServicioDiferencial  = '" & Kilometraje & "', FechaServicioDiferencial = concat(year(now()), '-',month(now()),'-',day(now()))"
                        comando.CommandText = MysqlUPDATE
                        comando.ExecuteNonQuery()
                    End If
                    Dim comm As New MySqlCommand("select count(id2) Cantidad from ordenesd where estado='ABIERTO' and id2=" & IdOrden, conexion)
                    Dim cursor As MySqlDataReader = comm.ExecuteReader()
                    cursor.Read()
                    If cursor.HasRows Then
                        Dim OtCantidad = cursor("Cantidad")
                        comm.Dispose()
                        cursor.Close()
                        If OtCantidad = 0 Then
                            comando.CommandType = Data.CommandType.Text
                            MysqlUPDATE = "UPDATE ReservacionVehiculo set Estado=4 where IdOrdenTrabajo = " & IdOrden
                            comando.CommandText = MysqlUPDATE
                            comando.ExecuteNonQuery()
                        End If
                    End If
                    transaccion.Commit()
                    Dim Elementos As New ClassCerrarOT
                    Elementos.StrError = "0"
                    result.Add(Elementos)
                Else
                    cmd.Dispose()
                    reader.Close()
                    Dim Elementos As New ClassCerrarOT
                    Elementos.StrError = "Error, Orden de Trabajo No Existe"
                    result.Add(Elementos)
                End If
            Catch ex As Exception
                Dim Elementos As New ClassCerrarOT
                Elementos.StrError = ex.Message
                result.Add(Elementos)
                transaccion.Rollback()
            Finally
                conexion.Close()
            End Try
        End Using
        Return result
    End Function
    Public Class ClassDetalleMantenimiento
        Public StrError As String = "0"
        Public Id As Integer
        Public Codigo As String
        Public Kilometraje As Double
        Public DiferenciaMotor As Double
        Public DiferenciaTransmision As Double
        Public DiferenciaDiferencial As Double
        Public ClassMotor As String
        Public ClassTransmision As String
        Public ClassDiferencial As String
    End Class
    <WebMethod(EnableSession:=True)> _
    Public Function DetalleDetalleMantenimiento(ByVal q As String) As List(Of [ClassDetalleMantenimiento])
        Dim result As List(Of [ClassDetalleMantenimiento]) = New List(Of ClassDetalleMantenimiento)()
        Dim consulta As String
        Using conexion As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
            Try
                conexion.Open()
                If q <> "0" Then
                    consulta = "select v.Id,v.codigo,v.kma,vs.ServicioMotorIntervalo,(v.kma -vs.UltimoServicioMotor) DiferenciaMotor,vs.ServicioTransmisionIntervalo,(v.kma - vs.UltimoServicioTransmision) DiferenciaTransmision,vs.ServicioDiferencialIntervalo,(v.kma - vs.UltimoServicioDiferencial) DiferenciaDiferencial from vehiculoservicio vs inner join (select * from _vehiculos where departamento=" & q & ") v on vs.IdVehiculo=v.Id where v.status=1 ;"
                Else
                    consulta = "select v.Id,v.codigo,v.kma,vs.ServicioMotorIntervalo,(v.kma -vs.UltimoServicioMotor) DiferenciaMotor,vs.ServicioTransmisionIntervalo,(v.kma - vs.UltimoServicioTransmision) DiferenciaTransmision,vs.ServicioDiferencialIntervalo,(v.kma - vs.UltimoServicioDiferencial) DiferenciaDiferencial from vehiculoservicio vs inner join _vehiculos v on vs.IdVehiculo=v.Id where v.status=1;"
                End If

                Dim cmd As New MySqlCommand(consulta, conexion)
                Dim reader As MySqlDataReader = cmd.ExecuteReader()
                While reader.Read
                    Dim Elementos As New ClassDetalleMantenimiento
                    Elementos.Id = reader("Id")
                    Elementos.Codigo = Convert.ToString(reader("codigo"))
                    If Not IsDBNull(reader("kma")) Then
                        Elementos.Kilometraje = Math.Round(Convert.ToDouble(reader("kma")), 2)
                        If reader("DiferenciaMotor") <= (Convert.ToDouble(reader("ServicioMotorIntervalo")) * 0.6) Then
                            Elementos.ClassMotor = "btn-success"
                        ElseIf (reader("DiferenciaMotor") > (Convert.ToDouble(reader("ServicioMotorIntervalo")) * 0.6)) AndAlso (reader("DiferenciaMotor") <= (reader("ServicioMotorIntervalo") * 0.8)) Then
                            Elementos.ClassMotor = "btn-warning"
                        ElseIf reader("DiferenciaMotor") > (Convert.ToDouble(reader("ServicioMotorIntervalo")) * 0.8) Then
                            Elementos.ClassMotor = "btn-danger"
                        End If

                        If reader("DiferenciaTransmision") <= (Convert.ToDouble(reader("ServicioTransmisionIntervalo")) * 0.9) Then
                            Elementos.ClassTransmision = "btn-success"
                        ElseIf (reader("DiferenciaTransmision") > (Convert.ToDouble(reader("ServicioTransmisionIntervalo")) * 0.9)) AndAlso (reader("DiferenciaTransmision") <= (reader("ServicioTransmisionIntervalo") * 0.95)) Then
                            Elementos.ClassTransmision = "btn-warning"
                        ElseIf Convert.ToDouble(reader("DiferenciaTransmision")) > (Convert.ToDouble(reader("ServicioTransmisionIntervalo")) * 0.95) Then
                            Elementos.ClassTransmision = "btn-danger"
                        End If

                        If reader("DiferenciaDiferencial") <= (reader("ServicioDiferencialIntervalo") * 0.9) Then
                            Elementos.ClassDiferencial = "btn-success"
                        ElseIf (reader("DiferenciaDiferencial") > (reader("ServicioDiferencialIntervalo") * 0.9)) And (reader("DiferenciaDiferencial") <= (reader("ServicioDiferencialIntervalo") * 0.95)) Then
                            Elementos.ClassDiferencial = "btn-warning"
                        ElseIf reader("DiferenciaDiferencial") > (reader("ServicioDiferencialIntervalo") * 0.95) Then
                            Elementos.ClassDiferencial = "btn-danger"
                        End If
                        Elementos.DiferenciaMotor = Math.Round(Convert.ToDouble(reader("DiferenciaMotor")), 2)
                        Elementos.DiferenciaTransmision = Math.Round(Convert.ToDouble(reader("DiferenciaTransmision")), 2)
                        Elementos.DiferenciaDiferencial = Math.Round(Convert.ToDouble(reader("DiferenciaDiferencial")), 2)
                    End If
                    result.Add(Elementos)
                End While
            Catch ex As Exception
                Dim Elementos As New ClassDetalleMantenimiento
                Elementos.StrError = ex.Message
                result.Add(Elementos)
            Finally
                conexion.Close()
            End Try
        End Using
        Return result
    End Function
    Public Class ClassArrayServicioMotor
        Public Servicio As String
        Public Observacion As String
    End Class
    <WebMethod(EnableSession:=True)> _
    Public Function GuardarReservaMantenimiento(ByVal IdVehiculo As Integer, ByVal Fecha As String, ByVal FechaInicio As String, ByVal FechaFin As String, ByVal Encargado As String, ByVal Destino As String, ByVal Descripcion As String, ByVal Servicio As List(Of [ClassArrayServicioMotor])) As List(Of [ClassReservacionVehiculo])
        Dim result As List(Of [ClassReservacionVehiculo]) = New List(Of ClassReservacionVehiculo)()
        Dim IdEmpleado As String = Context.Request.Cookies("UserSettings")("IdPersonal")
        Dim Ecorreo As Boolean = False
        Using conexion As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
            conexion.Open()
            Dim comando As New MySqlCommand
            Dim transaccion As MySqlTransaction
            transaccion = conexion.BeginTransaction
            comando.Connection = conexion
            comando.Transaction = transaccion
            Try
                Dim cmd As New MySqlCommand("select Id from reservacionvehiculo where ('" & FechaInicio & "' between FechaInicio and fechaFin) and IdVehiculo=" & IdVehiculo & " and Estado<>2 and Estado<>3 and Estado<>1 and Estado<>4;", conexion)
                Dim reader As MySqlDataReader = cmd.ExecuteReader()
                reader.Read()
                If Not reader.HasRows Then
                    cmd.Dispose()
                    reader.Close()
                    comando.CommandType = Data.CommandType.Text
                    Dim InsertOrden As String = "insert into ordenes (fecha, usuario, Descripcion,kmi,vehiculo,nempresa) values ('" & Fecha & "', '" & Context.Request.Cookies("UserSettings")("user") & "','" & Descripcion & "',0,'" & IdVehiculo & "',23);"
                    comando.CommandText = InsertOrden
                    comando.ExecuteNonQuery()
                    comando.CommandText = "SELECT @@IDENTITY"
                    Dim IdOrden As Integer = comando.ExecuteScalar
                    Dim count As Integer = 0
                    Dim InsertOrdenDetalle As String = "insert into ordenesd (codigo,Description,username,id2,tecnico,tiempo,estado) VALUES"
                    For Each items In Servicio
                        If count = 0 Then
                            InsertOrdenDetalle += "('" & items.Servicio & "','" & items.Observacion & "', '" & Context.Request.Cookies("UserSettings")("user") & "', '" & IdOrden & "', 1, '00:00', 'ABIERTO')"
                        Else
                            InsertOrdenDetalle += ",('" & items.Servicio & "','" & items.Observacion & "', '" & Context.Request.Cookies("UserSettings")("user") & "', '" & IdOrden & "', 1, '00:00', 'ABIERTO')"
                        End If
                        count += 1
                    Next
                    comando.CommandText = InsertOrdenDetalle
                    comando.ExecuteNonQuery()
                    comando.CommandType = Data.CommandType.Text
                    Dim InsertReservacion As String = "INSERT INTO ReservacionVehiculo (IdTipoReservacion,IdOrdenTrabajo, IdEmpleado, IdTipoVehiculo,LugarViaje,FechaInicio, FechaFin, TodoElDia, Alerta, Observacion, Estado, IdVehiculo, Encargado) VALUES (2," & IdOrden & ",'" & IdEmpleado & "',0,'CIUDAD','" & FechaInicio & "','" & FechaFin & "',0,'0','',1," & IdVehiculo & ", '" & Encargado & "');"
                    MyDB.MyCommand("UPDATE vehiculoservicio SET StatusServicio=1 WHERE IdVehiculoServicio='" & IdVehiculo & "';")

                    comando.CommandText = InsertReservacion
                    comando.ExecuteNonQuery()
                    comando.CommandText = "SELECT @@IDENTITY"
                    Dim correlativo As Integer = comando.ExecuteScalar
                    Dim InsertDestinos As String = "INSERT INTO destinoreservacionvehiculo (IdReservacion, Destino) VALUES (" & correlativo & ",'" & Destino & "');"
                    comando.CommandText = InsertDestinos
                    comando.ExecuteNonQuery()
                    Dim Elementos As New ClassReservacionVehiculo
                    Elementos.StrError = "0"
                    result.Add(Elementos)
                    transaccion.Commit()
                Else
                    cmd.Dispose()
                    reader.Close()
                    Dim Elementos As New ClassReservacionVehiculo
                    Elementos.StrError = "Error, Ya tiene Una Reservacion Para esta fecha"
                    result.Add(Elementos)
                End If
            Catch ex As Exception
                transaccion.Rollback()
                Dim Elementos As New ClassReservacionVehiculo
                Elementos.StrError = ex.Message
                result.Add(Elementos)
            Finally
                conexion.Close()
            End Try
        End Using
        Return result
    End Function
    Public Class ClassBuscarReservacion
        Public StrError As String = "0"
        Public Unidad As New ArrayList
        Public diasmes As Integer
    End Class
    <WebMethod(EnableSession:=True)> _
    Public Function BuscarReservaciones(ByVal Fecha As String) As List(Of [ClassBuscarReservacion])
        Dim result As List(Of [ClassBuscarReservacion]) = New List(Of ClassBuscarReservacion)()
        Dim Cn As New datos
        Dim dt, dt1, dt2 As DataTable
        Dim dias, fechas As New ArrayList
        Dim consulta, codigo, mes1, consulta1, consulta2 As String
        Dim cantidaddias As Integer
        Using conexion As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
            Try
                Dim Elementos As New ClassBuscarReservacion
                Dim newdate3 As DateTime = Date.Parse(Fecha.ToString, System.Globalization.CultureInfo.CreateSpecificCulture("en-au"))
                Dim Fecha3 = Year(newdate3) & "/" & Month(newdate3) & "/" & Day(newdate3)
                Dim fechafin As DateTime = Convert.ToDateTime(Fecha).AddMonths(1).AddDays(-1)
                cantidaddias = Day(fechafin)
                If Month(newdate3) = 1 Then
                    mes1 = "ENERO"
                ElseIf Month(newdate3) = 3 Then
                    mes1 = "MARZO"
                ElseIf Month(newdate3) = 5 Then
                    mes1 = "MAYO"
                ElseIf Month(newdate3) = 7 Then
                    mes1 = "JULIO"
                ElseIf Month(newdate3) = 8 Then
                    mes1 = "AGOSTO"
                ElseIf Month(newdate3) = 10 Then
                    mes1 = "OCTUBRE"
                ElseIf Month(newdate3) = 12 Then
                    mes1 = "DICIEMBRE"
                ElseIf Month(newdate3) = 4 Then
                    mes1 = "ABRIL"
                ElseIf Month(newdate3) = 6 Then
                    mes1 = "JUNIO"
                ElseIf Month(newdate3) = 9 Then
                    mes1 = "SEPTIEMBRE"
                ElseIf Month(newdate3) = 11 Then
                    mes1 = "NOVIEMBRE"
                ElseIf Month(newdate3) = 2 Then
                    mes1 = "FEBRERO"
                End If
                consulta = "select distinct v.id,v.codigo from reservacionvehiculo r join personal p on r.idempleado = p.idempleado join _vehiculos V on r.idvehiculo = V.id where (month(r.fechainicio) = '" & Month(newdate3) & "' and year(r.fechainicio)= '" & Year(newdate3) & "') or (month(r.fechafin) = '" & Month(newdate3) & "' and year(r.fechafin)= '" & Year(newdate3) & "')  order by v.codigo asc;"
                dt = Cn.Datos(consulta)
                Dim unidad As New ArrayList
                For i As Integer = 0 To dt.Rows.Count - 1
                    Dim data As New ArrayList
                    consulta1 = "select IdOrdenTrabajo,IdTipoReservacion,Estado,idvehiculo,day(fechainicio) as inicio, day(fechafin) as fin, month(fechainicio) as mesinicio, month(fechafin) as mesfin  from reservacionvehiculo  where idvehiculo='" & dt.Rows(i).Item("id") & "' and ((month(fechainicio) = '" & Month(newdate3) & "' and year(fechainicio)= '" & Year(newdate3) & "') or (month(fechafin) = '" & Month(newdate3) & "' and year(fechafin)= '" & Year(newdate3) & "')) and Estado!=2;"
                    dt1 = Cn.Datos(consulta1)
                    For j As Integer = 0 To dt1.Rows.Count - 1
                        Dim IdOrdenTrabajo As Integer = 0
                        If Not IsDBNull(dt1.Rows(j).Item("IdOrdenTrabajo")) Then
                            IdOrdenTrabajo = dt1.Rows(j).Item("IdOrdenTrabajo")
                        End If
                        If (dt1.Rows(j).Item("mesfin") = Month(newdate3)) And (dt1.Rows(j).Item("mesinicio") = Month(newdate3)) Then
                            data.Add({dt1.Rows(j).Item("inicio"), dt1.Rows(j).Item("fin"), dt1.Rows(j).Item("IdTipoReservacion"), IdOrdenTrabajo, dt1.Rows(j).Item("Estado")})
                        ElseIf dt1.Rows(j).Item("mesfin") > Month(newdate3) Then
                            data.Add({dt1.Rows(j).Item("inicio"), cantidaddias, dt1.Rows(j).Item("IdTipoReservacion"), IdOrdenTrabajo, dt1.Rows(j).Item("Estado")})
                        ElseIf dt1.Rows(j).Item("mesinicio") < Month(newdate3) Then
                            data.Add({1, dt1.Rows(j).Item("fin"), dt1.Rows(j).Item("IdTipoReservacion"), IdOrdenTrabajo, dt1.Rows(j).Item("Estado")})
                        End If
                    Next
                    unidad.Add({dt.Rows(i).Item("id"), dt.Rows(i).Item("codigo"), data})
                Next
                Elementos.diasmes = cantidaddias
                Elementos.Unidad = unidad
                result.Add(Elementos)
            Catch ex As Exception
                Dim Elementos As New ClassBuscarReservacion
                Elementos.StrError = ex.Message
                result.Add(Elementos)
            Finally
                conexion.Close()
            End Try
        End Using
        Return result
    End Function
    <WebMethod(EnableSession:=True)> _
    Public Function OrdenesDeTrabajo(ByVal IdVehiculo As Integer) As List(Of [ClassDetalleMantenimiento])
        Dim result As List(Of [ClassDetalleMantenimiento]) = New List(Of ClassDetalleMantenimiento)()
        Dim consulta As String
        Using conexion As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
            Try
                conexion.Open()
                consulta = "select v.Id,v.codigo,v.kma,vs.ServicioMotorIntervalo,(v.kma -vs.UltimoServicioMotor) DiferenciaMotor,vs.ServicioTransmisionIntervalo,(v.kma - vs.UltimoServicioTransmision) DiferenciaTransmision,vs.ServicioDiferencialIntervalo,(v.kma - vs.UltimoServicioDiferencial) DiferenciaDiferencial from vehiculoservicio vs inner join _vehiculos v on vs.IdVehiculo=v.Id;"
                Dim cmd As New MySqlCommand(consulta, conexion)
                Dim reader As MySqlDataReader = cmd.ExecuteReader()
                While reader.Read
                    Dim Elementos As New ClassDetalleMantenimiento
                    Elementos.Id = reader("Id")
                    Elementos.Codigo = Convert.ToString(reader("codigo"))
                    If Not IsDBNull(reader("kma")) Then
                        Elementos.Kilometraje = Convert.ToDouble(reader("kma"))
                        If reader("DiferenciaMotor") <= (Convert.ToDouble(reader("ServicioMotorIntervalo")) * 0.6) Then
                            Elementos.ClassMotor = "btn-success"
                        ElseIf (reader("DiferenciaMotor") > (Convert.ToDouble(reader("ServicioMotorIntervalo")) * 0.6)) AndAlso (reader("DiferenciaMotor") <= (reader("ServicioMotorIntervalo") * 0.8)) Then
                            Elementos.ClassMotor = "btn-warning"
                        ElseIf reader("DiferenciaMotor") > (Convert.ToDouble(reader("ServicioMotorIntervalo")) * 0.8) Then
                            Elementos.ClassMotor = "btn-danger"
                        End If

                        If reader("DiferenciaTransmision") <= (Convert.ToDouble(reader("ServicioTransmisionIntervalo")) * 0.9) Then
                            Elementos.ClassTransmision = "btn-success"
                        ElseIf (reader("DiferenciaTransmision") > (Convert.ToDouble(reader("ServicioTransmisionIntervalo")) * 0.9)) AndAlso (reader("DiferenciaTransmision") <= (reader("ServicioTransmisionIntervalo") * 0.95)) Then
                            Elementos.ClassTransmision = "btn-warning"
                        ElseIf Convert.ToDouble(reader("DiferenciaTransmision")) > (Convert.ToDouble(reader("ServicioTransmisionIntervalo")) * 0.95) Then
                            Elementos.ClassTransmision = "btn-danger"
                        End If

                        If reader("DiferenciaDiferencial") <= (reader("ServicioDiferencialIntervalo") * 0.9) Then
                            Elementos.ClassDiferencial = "btn-success"
                        ElseIf (reader("DiferenciaDiferencial") > (reader("ServicioDiferencialIntervalo") * 0.9)) And (reader("DiferenciaDiferencial") <= (reader("ServicioDiferencialIntervalo") * 0.95)) Then
                            Elementos.ClassDiferencial = "btn-warning"
                        ElseIf reader("DiferenciaDiferencial") > (reader("ServicioDiferencialIntervalo") * 0.95) Then
                            Elementos.ClassDiferencial = "btn-danger"
                        End If
                        Elementos.DiferenciaMotor = Convert.ToDouble(reader("DiferenciaMotor"))
                        Elementos.DiferenciaTransmision = Convert.ToDouble(reader("DiferenciaTransmision"))
                        Elementos.DiferenciaDiferencial = Convert.ToDouble(reader("DiferenciaDiferencial"))
                    End If
                    result.Add(Elementos)
                End While
            Catch ex As Exception
                Dim Elementos As New ClassDetalleMantenimiento
                Elementos.StrError = ex.Message
                result.Add(Elementos)
            Finally
                conexion.Close()
            End Try
        End Using
        Return result
    End Function
    Public Class ClassPorcentajeDepartamento
        Public StrError As String = "0"
        Public IdDepartamento As Integer
        Public Descripcion As String
        Public Minutos As Integer
        Public FechaInicio As String
        Public FechaFin As String
        Public Cantidad As Integer
    End Class
    <WebMethod(EnableSession:=True)> _
    Public Function PorcentajeDepartamento(ByVal FechaInicio As String, ByVal FechaFin As String) As List(Of [ClassPorcentajeDepartamento])
        Dim result As List(Of [ClassPorcentajeDepartamento]) = New List(Of ClassPorcentajeDepartamento)()
        Dim consulta As String
        Using conexion As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
            Try
                conexion.Open()
                consulta = "select d.id IdDepartamento,d.descripcion Descripcion,sum(TIMESTAMPDIFF(MINUTE, r.FechaInicio, r.FechaFin)) Minutos,sum(TIMESTAMPDIFF(MINUTE, r.FechaEntrega, r.FechaDevolucion)) MinutosReales, count(r.Id) Cantidad from reservacionvehiculo r inner join Personal p on r.IdEmpleado=p.idEmpleado inner join departamentos d on p.idArea=d.id where r.Estado!=2 and r.FechaInicio between '" & FechaInicio & "' and '" & FechaFin & "' group by p.idArea order by Minutos desc;"
                Dim cmd As New MySqlCommand(consulta, conexion)
                Dim reader As MySqlDataReader = cmd.ExecuteReader()
                While reader.Read
                    If reader("IdDepartamento") = 39 Or reader("IdDepartamento") = 40 Then
                    Else
                        Dim Elementos As New ClassPorcentajeDepartamento
                        Elementos.IdDepartamento = reader("IdDepartamento")
                        Elementos.Descripcion = reader("Descripcion")
                        If Not IsDBNull(reader("MinutosReales")) Then
                            If reader("MinutosReales") >= reader("Minutos") Then
                                Elementos.Minutos = reader("MinutosReales")
                            Else
                                Elementos.Minutos = reader("Minutos")
                            End If
                        Else
                            Elementos.Minutos = reader("Minutos")
                        End If
                        Elementos.Cantidad = reader("Cantidad")
                        Elementos.FechaInicio = FechaInicio
                        Elementos.FechaFin = FechaFin
                        result.Add(Elementos)
                    End If
                End While
            Catch ex As Exception
                Dim Elementos As New ClassPorcentajeDepartamento
                Elementos.StrError = ex.Message
                result.Add(Elementos)
            Finally
                conexion.Close()
            End Try
        End Using
        Return result
    End Function
    Public Class ClassPorcentajePorDepartamento
        Public StrError As String = "0"
        Public IdEmpleado As Integer
        Public Nombre As String
        Public Minutos As Integer
        Public Cantidad As Integer
    End Class
    <WebMethod(EnableSession:=True)> _
    Public Function PorcentajePorDepartamento(ByVal FechaInicio As String, ByVal FechaFin As String, ByVal IdDepartamento As Integer) As List(Of [ClassPorcentajePorDepartamento])
        Dim result As List(Of [ClassPorcentajePorDepartamento]) = New List(Of ClassPorcentajePorDepartamento)()
        Dim consulta As String
        Using conexion As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
            Try
                conexion.Open()
                consulta = "select p.IdEmpleado IdEmpleado,p.nombre Nombre,sum(TIMESTAMPDIFF(minute, r.FechaInicio, r.FechaFin)) Minutos,sum(TIMESTAMPDIFF(MINUTE, r.FechaEntrega, r.FechaDevolucion)) MinutosReales, count(r.Id) Cantidad from reservacionvehiculo r inner join Personal p on r.IdEmpleado=p.idEmpleado where r.Estado!=2 and r.FechaInicio between '" & FechaInicio & "' and '" & FechaFin & "' and p.idArea=" & IdDepartamento & " group by p.IdEmpleado order by Minutos desc;"
                Dim cmd As New MySqlCommand(consulta, conexion)
                Dim reader As MySqlDataReader = cmd.ExecuteReader()
                While reader.Read
                    Dim Elementos As New ClassPorcentajePorDepartamento
                    Elementos.IdEmpleado = reader("IdEmpleado")
                    Elementos.Nombre = reader("Nombre")
                    If Not IsDBNull(reader("MinutosReales")) Then
                        If reader("MinutosReales") >= reader("Minutos") Then
                            Elementos.Minutos = reader("MinutosReales")
                        Else
                            Elementos.Minutos = reader("Minutos")
                        End If
                    Else
                        Elementos.Minutos = reader("Minutos")
                    End If
                    Elementos.Cantidad = reader("Cantidad")
                    result.Add(Elementos)
                End While
            Catch ex As Exception
                Dim Elementos As New ClassPorcentajePorDepartamento
                Elementos.StrError = ex.Message
                result.Add(Elementos)
            Finally
                conexion.Close()
            End Try
        End Using
        Return result
    End Function
    Public Class ClassPorMarca
        Public StrError As String = "0"
        Public Marca As String
        Public Linea As String
        Public Modelo As Integer
        Public TipoVehiculo As String
        Public IdTipoVehiculo As String
        'Public TotalCantidad As Double
        Public TotalGastos As Double
        Public KmRecorrido As Double
        Public CostoxKm As Double
    End Class
    <WebMethod(EnableSession:=True)> _
    Public Function PorMarca(ByVal FechaInicio As String, ByVal FechaFinal As String, ByVal Departamento As String, ByVal ModeloInicial As String, ByVal ModeloFinal As String) As List(Of [ClassPorMarca])
        Dim result As List(Of [ClassPorMarca]) = New List(Of ClassPorMarca)()
        Dim consulta As String
        Using conexion As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
            Try
                conexion.Open()

                If Departamento = "0" Then
                    consulta = "select tp.id_tipo_vehiculo,tp.tipo_vehiculo,v.marca,v.linea,v.modelo, sum(fd.cantidad) TotalCantidad, sum(fd.total) TotalGasto from facturacion f inner join facturaciond fd on f.corre=fd.correlativo  inner join _vehiculos v on v.id=f.Vehiculo inner join tipo_vehiculo tp on tp.id_tipo_vehiculo=v.tveh where f.fecha between '" & FechaInicio & "' and '" & FechaFinal & "' and v.modelo between '" & ModeloInicial & "' and '" & ModeloFinal & "' group by tp.tipo_vehiculo ;"
                Else
                    consulta = "select tp.id_tipo_vehiculo,tp.tipo_vehiculo,v.marca,v.linea,v.modelo, sum(fd.cantidad) TotalCantidad, sum(fd.total) TotalGasto from facturacion f inner join facturaciond fd on f.corre=fd.correlativo  inner join _vehiculos v on v.id=f.Vehiculo inner join tipo_vehiculo tp on tp.id_tipo_vehiculo=v.tveh where f.fecha between '" & FechaInicio & "' and '" & FechaFinal & "' and v.departamento = '" & Departamento & "' and v.modelo between '" & ModeloInicial & "' and '" & ModeloFinal & "'  group by tp.tipo_vehiculo ;"

                End If

                Dim cmd As New MySqlCommand(consulta, conexion)
                Dim reader As MySqlDataReader = cmd.ExecuteReader()
                While reader.Read
                    Dim Elementos As New ClassPorMarca
                    Elementos.Marca = reader("marca")
                    Elementos.Linea = reader("linea")
                    Elementos.Modelo = reader("modelo")
                    Elementos.TipoVehiculo = reader("tipo_vehiculo")
                    Elementos.IdTipoVehiculo = reader("id_tipo_vehiculo")
                    Elementos.TotalGastos = Math.Round(reader("TotalGasto"), 2)
                    Using conn As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
                        Try
                            conn.Open()
                            Dim Sql As String
                            If Departamento = "0" Then
                                Sql = "select sum(Distancia) KmRecorridos from actividaddiairiavehiculo where IdVehiculo IN(select Id from _vehiculos where tveh='" & reader("id_tipo_vehiculo") & "' and modelo between '" & ModeloInicial & "' and '" & ModeloFinal & "') and fecha between '" & FechaInicio & "' and '" & FechaFinal & "';"
                            Else
                                Sql = "select sum(Distancia) KmRecorridos from actividaddiairiavehiculo where IdVehiculo IN(select Id from _vehiculos where tveh='" & reader("id_tipo_vehiculo") & "' and departamento = '" & Departamento & "' and modelo between '" & ModeloInicial & "' and '" & ModeloFinal & "') and fecha between '" & FechaInicio & "' and '" & FechaFinal & "';"

                            End If



                            Dim command As New MySqlCommand(Sql, conn)
                            Dim cursor As MySqlDataReader = command.ExecuteReader()
                            cursor.Read()
                            If cursor.HasRows Then
                                If Not IsDBNull(cursor("KmRecorridos")) Then
                                    Elementos.KmRecorrido = Math.Round(cursor("KmRecorridos"), 0)
                                Else
                                    Elementos.KmRecorrido = 0
                                End If
                            Else
                                Elementos.KmRecorrido = 0
                            End If
                        Catch ex As Exception
                            Elementos.StrError = ex.Message
                        Finally
                            conn.Close()
                        End Try
                    End Using
                    If Val(Elementos.KmRecorrido) > 0 Then
                        Elementos.CostoxKm = Math.Round((Elementos.TotalGastos / Elementos.KmRecorrido), 2)
                    Else
                        Elementos.CostoxKm = 0
                    End If

                    result.Add(Elementos)
                End While
            Catch ex As Exception
                Dim Elementos As New ClassPorMarca
                Elementos.StrError = ex.Message
                result.Add(Elementos)
            Finally
                conexion.Close()
            End Try
        End Using
        Return result
    End Function
    Public Class ClassLlenarModeloPorMarca
        Public StrError As String = "0"
        Public Modelo As Integer
    End Class
    <WebMethod(EnableSession:=True)> _
    Public Function LlenarModeloPorMarca(ByVal Marca As String) As List(Of [ClassLlenarModeloPorMarca])
        Dim result As List(Of [ClassLlenarModeloPorMarca]) = New List(Of ClassLlenarModeloPorMarca)()
        Dim consulta As String
        Using conexion As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
            Try
                conexion.Open()
                consulta = "SELECT modelo FROM _vehiculos where marca='" & Marca & "' group by modelo;"
                Dim cmd As New MySqlCommand(consulta, conexion)
                Dim reader As MySqlDataReader = cmd.ExecuteReader()
                While reader.Read
                    Dim Elementos As New ClassLlenarModeloPorMarca
                    Elementos.Modelo = reader("modelo")
                    result.Add(Elementos)
                End While
            Catch ex As Exception
                Dim Elementos As New ClassLlenarModeloPorMarca
                Elementos.StrError = ex.Message
                result.Add(Elementos)
            Finally
                conexion.Close()
            End Try
        End Using
        Return result
    End Function
    Public Class ClassLlenarLineaPorMarca
        Public StrError As String = "0"
        Public Linea As String
    End Class
    <WebMethod(EnableSession:=True)> _
    Public Function LlenarLineaPorMarca(ByVal Marca As String) As List(Of [ClassLlenarLineaPorMarca])
        Dim result As List(Of [ClassLlenarLineaPorMarca]) = New List(Of ClassLlenarLineaPorMarca)()
        Dim consulta As String
        Using conexion As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
            Try
                conexion.Open()
                consulta = "SELECT linea FROM _vehiculos where marca='" & Marca & "' group by linea;"
                Dim cmd As New MySqlCommand(consulta, conexion)
                Dim reader As MySqlDataReader = cmd.ExecuteReader()
                While reader.Read
                    Dim Elementos As New ClassLlenarLineaPorMarca
                    Elementos.Linea = reader("linea")
                    result.Add(Elementos)
                End While
            Catch ex As Exception
                Dim Elementos As New ClassLlenarLineaPorMarca
                Elementos.StrError = ex.Message
                result.Add(Elementos)
            Finally
                conexion.Close()
            End Try
        End Using
        Return result
    End Function
    Public Class ClassPorMarcaLineaModelo
        Public StrError As String = "0"
        Public Codigo As String
        Public Marca As String
        Public Linea As String
        Public Modelo As Integer
        Public TotalGastos As Double
        Public KmRecorrido As Double
        Public CostoxKm As Double
        Public ConsumoCombustible As Double
        Public CantidadGalones As Double
        Public KmxGalon As Double
        Public Rendimiento As Double
        Public color As String = "#78ccf7"
        Public color2 As String = "#0026FF"
        Public color3 As String = "#FC0B0B"
        Public color4 As String = "#E6F605"

        Public TipoVH As Integer
        Public Vehiculo As String
    End Class
    <WebMethod(EnableSession:=True)> _
    Public Function PorMarcaLineaModelo(ByVal FechaInicio As String, ByVal FechaFinal As String, ByVal TipoVehiculo As String, ByVal Departamento As String, ByVal ModeloInicial As String, ByVal ModeloFinal As String) As List(Of [ClassPorMarcaLineaModelo])
        Dim result As List(Of [ClassPorMarcaLineaModelo]) = New List(Of ClassPorMarcaLineaModelo)()
        Dim consulta As String
        Using conexion As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
            Try
                conexion.Open()
                Dim addStringLinea As String = ""
                Dim addStringModelo As String = ""
                If Departamento = "0" Then
                    consulta = "select v.id,v.codigo,v.marca,v.linea,v.modelo, sum(fd.cantidad) TotalCantidad, sum(fd.total) TotalGasto,v.tveh from facturacion f inner join facturaciond fd on f.corre=fd.correlativo  inner join _vehiculos v on v.id=f.Vehiculo where f.fecha between '" & FechaInicio & "' and '" & FechaFinal & "' and v.tveh='" & TipoVehiculo & "' and v.modelo between '" & ModeloInicial & "' and '" & ModeloFinal & "' group by v.marca;"
                Else
                    consulta = "select v.id,v.codigo,v.marca,v.linea,v.modelo, sum(fd.cantidad) TotalCantidad, sum(fd.total) TotalGasto,v.tveh from facturacion f inner join facturaciond fd on f.corre=fd.correlativo  inner join _vehiculos v on v.id=f.Vehiculo where f.fecha between '" & FechaInicio & "' and '" & FechaFinal & "' and v.tveh='" & TipoVehiculo & "' and v.departamento = '" & Departamento & "' and v.modelo between '" & ModeloInicial & "' and '" & ModeloFinal & "' group by v.marca;"

                End If

                Dim cmd As New MySqlCommand(consulta, conexion)
                Dim reader As MySqlDataReader = cmd.ExecuteReader()
                While reader.Read
                    Dim Elementos As New ClassPorMarcaLineaModelo
                    Elementos.Codigo = reader("codigo")
                    Elementos.Marca = reader("marca")
                    Elementos.Linea = reader("linea")
                    Elementos.Modelo = reader("modelo")
                    Elementos.TipoVH = reader("tveh")

                    Elementos.TotalGastos = Math.Round(reader("TotalGasto"), 2)
                    Using conn As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
                        Try
                            conn.Open()
                            Dim Sql As String
                            If Departamento = "0" Then
                                Sql = "select sum(Distancia) KmRecorridos from actividaddiairiavehiculo where IdVehiculo IN(select Id from _vehiculos where marca='" & reader("marca") & "' and tveh='" & TipoVehiculo & "' and modelo between '" & ModeloInicial & "' and '" & ModeloFinal & "') and fecha between '" & FechaInicio & "' and '" & FechaFinal & "'"
                            Else
                                Sql = "select sum(Distancia) KmRecorridos from actividaddiairiavehiculo where IdVehiculo IN(select Id from _vehiculos where marca='" & reader("marca") & "' and tveh='" & TipoVehiculo & "' and departamento = '" & Departamento & "' and modelo between '" & ModeloInicial & "' and '" & ModeloFinal & "') and fecha between '" & FechaInicio & "' and '" & FechaFinal & "'"

                            End If



                            Dim command As New MySqlCommand(Sql, conn)
                            Dim cursor As MySqlDataReader = command.ExecuteReader()
                            cursor.Read()
                            If cursor.HasRows Then
                                If Not IsDBNull(cursor("KmRecorridos")) Then
                                    Elementos.KmRecorrido = Math.Round(cursor("KmRecorridos"), 0)
                                Else
                                    Elementos.KmRecorrido = 0
                                End If
                            Else
                                Elementos.KmRecorrido = 0
                            End If
                        Catch ex As Exception
                            Elementos.StrError = ex.Message
                        Finally
                            conn.Close()
                        End Try
                    End Using
                    If Elementos.KmRecorrido > 0 Then
                        Elementos.CostoxKm = Math.Round((Elementos.TotalGastos / Elementos.KmRecorrido), 2)
                    Else
                        Elementos.CostoxKm = 0
                    End If
                    Using conn As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
                        Try
                            conn.Open()




                            Dim sql As String



                            If Departamento = "0" Then
                                sql = "select sum(fd.total) ConsumoCombustible, sum(fd.cantidad) CantidadGalones from facturacion f inner join facturaciond fd on f.corre=fd.correlativo inner join inventario i on i.codigo=fd.codigo inner join _vehiculos v on v.id=f.Vehiculo where i.clasifi=59 and f.Vehiculo IN(select Id from _vehiculos where marca='" & reader("marca") & "' and tveh='" & TipoVehiculo & "' and modelo between '" & ModeloInicial & "' and '" & ModeloFinal & "') and fecha between '" & FechaInicio & "' and '" & FechaFinal & "'"
                            Else
                                sql = "select sum(fd.total) ConsumoCombustible, sum(fd.cantidad) CantidadGalones from facturacion f inner join facturaciond fd on f.corre=fd.correlativo inner join inventario i on i.codigo=fd.codigo inner join _vehiculos v on v.id=f.Vehiculo where i.clasifi=59 and f.Vehiculo IN(select Id from _vehiculos where marca='" & reader("marca") & "' and tveh='" & TipoVehiculo & "' and departamento = '" & Departamento & "' and modelo between '" & ModeloInicial & "' and '" & ModeloFinal & "') and fecha between '" & FechaInicio & "' and '" & FechaFinal & "'"

                            End If

                            Dim command As New MySqlCommand(sql, conn)
                            Dim cursor As MySqlDataReader = command.ExecuteReader()
                            While cursor.Read
                                If Not IsDBNull(cursor("ConsumoCombustible")) Then
                                    Elementos.ConsumoCombustible = Math.Round(cursor("ConsumoCombustible"), 2)
                                Else
                                    Elementos.ConsumoCombustible = 0
                                End If
                                If Elementos.KmRecorrido > 0 Then
                                    Elementos.Rendimiento = Math.Round((Elementos.ConsumoCombustible / Elementos.KmRecorrido), 2)
                                Else
                                    Elementos.Rendimiento = 0
                                End If
                                If Not IsDBNull(cursor("CantidadGalones")) Then
                                    Elementos.CantidadGalones = Math.Round(cursor("CantidadGalones"), 2)
                                Else
                                    Elementos.CantidadGalones = 0
                                End If
                                If Val(Elementos.CantidadGalones) > 0 And Elementos.KmRecorrido > 0 Then
                                    Elementos.KmxGalon = Math.Round((Elementos.KmRecorrido / Elementos.CantidadGalones), 2)
                                Else
                                    Elementos.KmxGalon = 0
                                End If
                            End While
                        Catch ex As Exception
                            Elementos.StrError = ex.Message
                        Finally
                            conn.Close()
                        End Try
                    End Using
                    result.Add(Elementos)
                End While
            Catch ex As Exception
                Dim Elementos As New ClassPorMarcaLineaModelo
                Elementos.StrError = ex.Message
                result.Add(Elementos)
            Finally
                conexion.Close()
            End Try
        End Using
        Return result
    End Function

    <WebMethod(EnableSession:=True)> _
    Public Function PorModelo(ByVal FechaInicio As String, ByVal FechaFinal As String, ByVal marca As String, ByVal TipoVH As String, ByVal Departamento As String, ByVal ModeloInicial As String, ByVal ModeloFinal As String) As List(Of [ClassPorMarcaLineaModelo])
        Dim result As List(Of [ClassPorMarcaLineaModelo]) = New List(Of ClassPorMarcaLineaModelo)()
        Dim consulta As String
        Using conexion As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
            Try
                conexion.Open()
                Dim addStringLinea As String = ""
                Dim addStringModelo As String = ""

                If Departamento = "0" Then
                    consulta = "select v.id,v.codigo,v.marca,v.linea,v.modelo, sum(fd.cantidad) TotalCantidad, sum(fd.total) TotalGasto,v.tveh from facturacion f inner join facturaciond fd on f.corre=fd.correlativo  inner join _vehiculos v on v.id=f.Vehiculo where f.fecha between '" & FechaInicio & "' and '" & FechaFinal & "' and v.marca='" & marca & "' and v.tveh='" & TipoVH & "' and v.modelo between '" & ModeloInicial & "' and '" & ModeloFinal & "' group by v.modelo;"
                Else
                    consulta = "select v.id,v.codigo,v.marca,v.linea,v.modelo, sum(fd.cantidad) TotalCantidad, sum(fd.total) TotalGasto,v.tveh from facturacion f inner join facturaciond fd on f.corre=fd.correlativo  inner join _vehiculos v on v.id=f.Vehiculo where f.fecha between '" & FechaInicio & "' and '" & FechaFinal & "' and v.marca='" & marca & "' and v.tveh='" & TipoVH & "' and v.departamento = '" & Departamento & "' and v.modelo between '" & ModeloInicial & "' and '" & ModeloFinal & "' group by v.modelo;"

                End If

                Dim cmd As New MySqlCommand(consulta, conexion)
                Dim reader As MySqlDataReader = cmd.ExecuteReader()
                While reader.Read
                    Dim Elementos As New ClassPorMarcaLineaModelo
                    Elementos.Codigo = reader("codigo")
                    Elementos.Marca = reader("marca")
                    Elementos.Linea = reader("linea")
                    Elementos.Modelo = reader("modelo")
                    Elementos.TipoVH = reader("tveh")
                    Elementos.TotalGastos = Math.Round(reader("TotalGasto"), 2)
                    Using conn As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
                        Try
                            conn.Open()
                            Dim Sql As String
                            If Departamento = "0" Then
                                Sql = "select sum(Distancia) KmRecorridos from actividaddiairiavehiculo where IdVehiculo IN(select Id from _vehiculos where modelo='" & reader("modelo") & "' and marca='" & marca & "' and tveh='" & TipoVH & "' and modelo between '" & ModeloInicial & "' and '" & ModeloFinal & "') and fecha between '" & FechaInicio & "' and '" & FechaFinal & "'"
                            Else
                                Sql = "select sum(Distancia) KmRecorridos from actividaddiairiavehiculo where IdVehiculo IN(select Id from _vehiculos where modelo='" & reader("modelo") & "' and marca='" & marca & "' and tveh='" & TipoVH & "' and departamento = '" & Departamento & "' and modelo between '" & ModeloInicial & "' and '" & ModeloFinal & "') and fecha between '" & FechaInicio & "' and '" & FechaFinal & "'"

                            End If


                            Dim command As New MySqlCommand(Sql, conn)
                            Dim cursor As MySqlDataReader = command.ExecuteReader()
                            cursor.Read()
                            If cursor.HasRows Then
                                If Not IsDBNull(cursor("KmRecorridos")) Then
                                    Elementos.KmRecorrido = Math.Round(cursor("KmRecorridos"), 0)
                                Else
                                    Elementos.KmRecorrido = 0
                                End If
                            Else
                                Elementos.KmRecorrido = 0
                            End If
                        Catch ex As Exception
                            Elementos.StrError = ex.Message
                        Finally
                            conn.Close()
                        End Try
                    End Using
                    If Elementos.KmRecorrido > 0 Then
                        Elementos.CostoxKm = Math.Round((Elementos.TotalGastos / Elementos.KmRecorrido), 2)
                    Else
                        Elementos.CostoxKm = 0
                    End If
                    Using conn As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
                        Try
                            conn.Open()


                            Dim Sql As String
                            If Departamento = "0" Then
                                Sql = "select sum(fd.total) ConsumoCombustible, sum(fd.cantidad) CantidadGalones from facturacion f inner join facturaciond fd on f.corre=fd.correlativo inner join inventario i on i.codigo=fd.codigo inner join _vehiculos v on v.id=f.Vehiculo where i.clasifi=59 and f.Vehiculo IN(select Id from _vehiculos where modelo='" & reader("modelo") & "' and marca='" & marca & "' and tveh='" & TipoVH & "' and modelo between '" & ModeloInicial & "' and '" & ModeloFinal & "') and fecha between '" & FechaInicio & "' and '" & FechaFinal & "'"
                            Else
                                Sql = "select sum(fd.total) ConsumoCombustible, sum(fd.cantidad) CantidadGalones from facturacion f inner join facturaciond fd on f.corre=fd.correlativo inner join inventario i on i.codigo=fd.codigo inner join _vehiculos v on v.id=f.Vehiculo where i.clasifi=59 and f.Vehiculo IN(select Id from _vehiculos where modelo='" & reader("modelo") & "' and marca='" & marca & "' and tveh='" & TipoVH & "' and departamento = '" & Departamento & "' and modelo between '" & ModeloInicial & "' and '" & ModeloFinal & "') and fecha between '" & FechaInicio & "' and '" & FechaFinal & "'"

                            End If


                            Dim command As New MySqlCommand(Sql, conn)
                            Dim cursor As MySqlDataReader = command.ExecuteReader()
                            While cursor.Read
                                If Not IsDBNull(cursor("ConsumoCombustible")) Then
                                    Elementos.ConsumoCombustible = Math.Round(cursor("ConsumoCombustible"), 2)
                                Else
                                    Elementos.ConsumoCombustible = 0
                                End If
                                If Elementos.KmRecorrido > 0 Then
                                    Elementos.Rendimiento = Math.Round((Elementos.ConsumoCombustible / Elementos.KmRecorrido), 2)
                                Else
                                    Elementos.Rendimiento = 0
                                End If
                                If Not IsDBNull(cursor("CantidadGalones")) Then
                                    Elementos.CantidadGalones = Math.Round(cursor("CantidadGalones"), 2)
                                Else
                                    Elementos.CantidadGalones = 0
                                End If
                                If Val(Elementos.CantidadGalones) > 0 And Elementos.KmRecorrido > 0 Then
                                    Elementos.KmxGalon = Math.Round((Elementos.KmRecorrido / Elementos.CantidadGalones), 2)
                                Else
                                    Elementos.KmxGalon = 0
                                End If
                            End While
                        Catch ex As Exception
                            Elementos.StrError = ex.Message
                        Finally
                            conn.Close()
                        End Try
                    End Using
                    result.Add(Elementos)
                End While
            Catch ex As Exception
                Dim Elementos As New ClassPorMarcaLineaModelo
                Elementos.StrError = ex.Message
                result.Add(Elementos)
            Finally
                conexion.Close()
            End Try
        End Using
        Return result
    End Function

    <WebMethod(EnableSession:=True)> _
    Public Function PorVehiculo(ByVal FechaInicio As String, ByVal FechaFinal As String, ByVal marca As String, ByVal TipoVH As String, ByVal Modelo As String, ByVal Departamento As String, ByVal ModeloInicial As String, ByVal ModeloFinal As String) As List(Of [ClassPorMarcaLineaModelo])
        Dim result As List(Of [ClassPorMarcaLineaModelo]) = New List(Of ClassPorMarcaLineaModelo)()
        Dim consulta As String
        Using conexion As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
            Try
                conexion.Open()
                Dim addStringLinea As String = ""
                Dim addStringModelo As String = ""
                If Departamento = "0" Then
                    consulta = "select v.codigo,v.id,v.codigo,v.marca,v.linea,v.modelo, sum(fd.cantidad) TotalCantidad, sum(fd.total) TotalGasto from facturacion f inner join facturaciond fd on f.corre=fd.correlativo  inner join _vehiculos v on v.id=f.Vehiculo where f.fecha between '" & FechaInicio & "' and '" & FechaFinal & "' and v.marca='" & marca & "' and v.tveh='" & TipoVH & "' and v.modelo='" & Modelo & "' and v.modelo between '" & ModeloInicial & "' and '" & ModeloFinal & "' group by v.codigo ;"
                Else
                    consulta = "select v.codigo,v.id,v.codigo,v.marca,v.linea,v.modelo, sum(fd.cantidad) TotalCantidad, sum(fd.total) TotalGasto from facturacion f inner join facturaciond fd on f.corre=fd.correlativo  inner join _vehiculos v on v.id=f.Vehiculo where f.fecha between '" & FechaInicio & "' and '" & FechaFinal & "' and v.marca='" & marca & "' and v.tveh='" & TipoVH & "' and v.modelo='" & Modelo & "' and v.departamento = '" & Departamento & "' and v.modelo between '" & ModeloInicial & "' and '" & ModeloFinal & "' group by v.codigo ;"

                End If

                Dim cmd As New MySqlCommand(consulta, conexion)
                Dim reader As MySqlDataReader = cmd.ExecuteReader()
                While reader.Read
                    Dim Elementos As New ClassPorMarcaLineaModelo
                    Elementos.Codigo = reader("codigo")
                    Elementos.Marca = reader("marca")
                    Elementos.Linea = reader("linea")
                    Elementos.Modelo = reader("modelo")
                    Elementos.Vehiculo = reader("codigo")
                    Elementos.TotalGastos = Math.Round(reader("TotalGasto"), 2)
                    Using conn As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
                        Try
                            conn.Open()
                            Dim Sql As String

                            If Departamento = "0" Then
                                Sql = "select sum(Distancia) KmRecorridos from actividaddiairiavehiculo where IdVehiculo IN(select Id from _vehiculos where modelo='" & Modelo & "' and marca='" & marca & "' and tveh='" & TipoVH & "' and codigo='" & reader("codigo") & "' and modelo between '" & ModeloInicial & "' and '" & ModeloFinal & "') and fecha between '" & FechaInicio & "' and '" & FechaFinal & "'"
                            Else
                                Sql = "select sum(Distancia) KmRecorridos from actividaddiairiavehiculo where IdVehiculo IN(select Id from _vehiculos where modelo='" & Modelo & "' and marca='" & marca & "' and tveh='" & TipoVH & "' and codigo='" & reader("codigo") & "' and departamento = '" & Departamento & "' and modelo between '" & ModeloInicial & "' and '" & ModeloFinal & "') and fecha between '" & FechaInicio & "' and '" & FechaFinal & "'"

                            End If
                            Dim command As New MySqlCommand(Sql, conn)
                            Dim cursor As MySqlDataReader = command.ExecuteReader()
                            cursor.Read()
                            If cursor.HasRows Then
                                If Not IsDBNull(cursor("KmRecorridos")) Then
                                    Elementos.KmRecorrido = Math.Round(cursor("KmRecorridos"), 0)
                                Else
                                    Elementos.KmRecorrido = 0
                                End If
                            Else
                                Elementos.KmRecorrido = 0
                            End If
                        Catch ex As Exception
                            Elementos.StrError = ex.Message
                        Finally
                            conn.Close()
                        End Try
                    End Using
                    If Elementos.KmRecorrido > 0 Then
                        Elementos.CostoxKm = Math.Round((Elementos.TotalGastos / Elementos.KmRecorrido), 2)
                    Else
                        Elementos.CostoxKm = 0
                    End If
                    Using conn As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
                        Try
                            conn.Open()
                            Dim Sql As String = "select sum(fd.total) ConsumoCombustible, sum(fd.cantidad) CantidadGalones from facturacion f inner join facturaciond fd on f.corre=fd.correlativo inner join inventario i on i.codigo=fd.codigo where i.clasifi=59 and f.Vehiculo=" & reader("id") & " and f.fecha between '" & FechaInicio & "' and '" & FechaFinal & "';"
                            Dim command As New MySqlCommand(Sql, conn)
                            Dim cursor As MySqlDataReader = command.ExecuteReader()
                            While cursor.Read
                                If Not IsDBNull(cursor("ConsumoCombustible")) Then
                                    Elementos.ConsumoCombustible = Math.Round(cursor("ConsumoCombustible"), 2)
                                Else
                                    Elementos.ConsumoCombustible = 0
                                End If
                                If Elementos.KmRecorrido > 0 Then
                                    Elementos.Rendimiento = Math.Round((Elementos.ConsumoCombustible / Elementos.KmRecorrido), 2)
                                Else
                                    Elementos.Rendimiento = 0
                                End If
                                If Not IsDBNull(cursor("CantidadGalones")) Then
                                    Elementos.CantidadGalones = Math.Round(cursor("CantidadGalones"), 2)
                                Else
                                    Elementos.CantidadGalones = 0
                                End If
                                If Val(Elementos.CantidadGalones) > 0 And Elementos.KmRecorrido > 0 Then
                                    Elementos.KmxGalon = Math.Round((Elementos.KmRecorrido / Elementos.CantidadGalones), 2)
                                Else
                                    Elementos.KmxGalon = 0
                                End If
                            End While
                        Catch ex As Exception
                            Elementos.StrError = ex.Message
                        Finally
                            conn.Close()
                        End Try
                    End Using
                    result.Add(Elementos)
                End While
            Catch ex As Exception
                Dim Elementos As New ClassPorMarcaLineaModelo
                Elementos.StrError = ex.Message
                result.Add(Elementos)
            Finally
                conexion.Close()
            End Try
        End Using
        Return result
    End Function
    Public Class ClassRecibosDeViaticos
        Public StrError As String = "0"
        Public FechaLiquidacion As String
        Public FechaFactura As String
        Public Serie As String
        Public NoFactura As Integer
        Public IdLiquidacion As Integer
        Public CuentaContable As String
        Public Nombre As String
        Public Codigo As String
        Public Total As Double
    End Class
    <WebMethod(EnableSession:=True)> _
    Public Function RecibosDeViaticos(ByVal FechaInicio As String, ByVal FechaFin As String) As List(Of [ClassRecibosDeViaticos])
        Dim result As List(Of [ClassRecibosDeViaticos]) = New List(Of ClassRecibosDeViaticos)()
        Dim consulta As String
        Using conexion As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
            Try
                conexion.Open()
                FechaInicio = Split(FechaInicio, "-")(2) & Split(FechaInicio, "-")(1) & Split(FechaInicio, "-")(0)
                FechaFin = Split(FechaFin, "-")(2) & Split(FechaFin, "-")(1) & Split(FechaFin, "-")(0)

                consulta = "select l.Fecha FechaLiquidacion,f.serie,f.nofac,f.fecha FechaFactura,ld.IdLiquidacion,p.nombre,fd.codigo,fd.total, p.CuentaContable from liquidacion l inner join liquidaciondetalle ld on l.IdLiquidacion=ld.IdLiquidacion inner join facturacion f on ld.IdFactura=f.corre inner join  facturaciond fd on f.corre=fd.correlativo inner join personal p on f.comprador=p.idEmpleado where f.tipo_doc=11 and l.Fecha between '" & FechaInicio & "' and '" & FechaFin & "';"
                Dim MyReader As DataTable = MyDB.MySelect(consulta)
                For Each reader As DataRow In MyReader.Rows
                    Dim Elementos As New ClassRecibosDeViaticos
                    Elementos.FechaLiquidacion = reader("FechaLiquidacion")
                    Elementos.FechaFactura = reader("FechaFactura")
                    Elementos.Serie = reader("serie")
                    Elementos.NoFactura = reader("nofac")
                    Elementos.IdLiquidacion = reader("IdLiquidacion")
                    Elementos.Nombre = reader("nombre")
                    Elementos.Codigo = reader("codigo")
                    Elementos.Total = Math.Round(reader("total"), 6)
                    If Not reader("CuentaContable") Is DBNull.Value Then
                        Elementos.CuentaContable = reader("CuentaContable")
                    Else
                        Elementos.CuentaContable = "00000"
                    End If

                    result.Add(Elementos)
                Next
            Catch ex As Exception
                Dim Elementos As New ClassRecibosDeViaticos
                Elementos.StrError = ex.Message
                result.Add(Elementos)
            Finally
                conexion.Close()
            End Try
        End Using
        Return result
    End Function
    Public Class ClassReporteEjecutivoAnual
        Public StrError As String = "0"
        Public Mes As String
        Public Cantidad As Double
    End Class
    <WebMethod(EnableSession:=True)> _
    Public Function ReporteEjecutivoAnual(ByVal Departamento As Integer, ByVal Year As Integer, ByVal Opcion As Integer, ByVal Filtro As Integer, ByVal Valor As String) As List(Of [ClassReporteEjecutivoAnual])
        Dim result As List(Of [ClassReporteEjecutivoAnual]) = New List(Of ClassReporteEjecutivoAnual)()
        Dim consulta As String
        Using conexion As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
            Try
                conexion.Open()
                Dim Operador As String = ""
                Select Case Filtro
                    Case 1
                        Operador = "<"
                    Case 2
                        Operador = "<="
                    Case 3
                        Operador = "="
                    Case 4
                        Operador = ">="
                    Case 5
                        Operador = ">"
                    Case 6
                        Operador = "<>"
                End Select
                Dim Complemento As String = ""
                If Opcion = 1 Then
                    Complemento = " AND ad.HoraInicio " & Operador & " '" & Valor & "'"
                ElseIf Opcion = 2 Then
                    Complemento = "AND ad.HoraFin " & Operador & " '" & Valor & "'"
                ElseIf Opcion = 3 Then
                    Complemento = "AND ad.MaximaVelocidad " & Operador & " '" & Valor & "'"
                ElseIf Opcion = 4 Then
                    Complemento = "AND ad.Distancia " & Operador & " '" & Valor & "'"
                ElseIf Opcion = 5 Then
                    Complemento = "AND ad.MotorEncendido " & Operador & " '" & Valor & "'"
                End If
                '-----------------------
                If Departamento <> 0 Then
                    consulta = "select MesFormato(Month(ad.Fecha)) Mes,count(ad.Id) Cantidad from actividaddiairiavehiculo ad inner join _vehiculos v on v.id=ad.IdVehiculo where v.departamento='" & Departamento & "' AND year(ad.Fecha) = 2014 " & Complemento & " group by month(ad.Fecha);"
                Else
                    consulta = "select MesFormato(Month(ad.Fecha)) Mes,count(ad.Id) Cantidad from actividaddiairiavehiculo ad where year(ad.Fecha) = 2014 " & Complemento & " group by month(ad.Fecha);"
                End If
                Dim cmd As New MySqlCommand(consulta, conexion)
                Dim reader As MySqlDataReader = cmd.ExecuteReader()
                While reader.Read
                    Dim Elemento As New ClassReporteEjecutivoAnual
                    With Elemento
                        .Mes = reader("Mes")
                        .Cantidad = reader("Cantidad")
                        .StrError = "0"
                    End With
                    result.Add(Elemento)
                End While
            Catch ex As Exception
                Dim Elementos As New ClassReporteEjecutivoAnual
                Elementos.StrError = ex.Message
                result.Add(Elementos)
            Finally
                conexion.Close()
            End Try
        End Using
        Return result
    End Function
    Public Class ClassCatalogoVehiculos
        Public Id As Integer
        Public codigo As String
        Public placa As String
        Public kma As Integer
        Public marca As String
        Public linea As String
        Public modelo As String
        Public idtipovehiculo As Integer
        Public tipo As String
        Public iddepartamento As Integer
        Public departamento As String
        Public contable As String
        Public status As Boolean
        Public cllantas As Integer
        Public repuesto As Integer
        Public pool As Boolean
        Public poolv As Integer
        Public usuario As String
        Public Correo As String
    End Class
    <WebMethod(EnableSession:=True)> _
    Public Function CatalogoVehiculos(ByVal IdVehiculo As Integer) As List(Of [ClassCatalogoVehiculos])
        Dim result As List(Of [ClassCatalogoVehiculos]) = New List(Of ClassCatalogoVehiculos)()
        Dim consulta As String
        Using conexion As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
            Try
                conexion.Open()
                Dim ver As String = ""
                If IdVehiculo <> 0 Then
                    ver = " where v.id=" & IdVehiculo & " limit 1"
                End If
                consulta = "SELECT v.Id, v.codigo, v.placa, v.kma, v.marca,v.linea,v.modelo,tv.tipo_vehiculo,d.descripcion as departamento, v.ccontable, v.status, v.cllantas, v.cllantasrepuesto,  v.Pool, v.tveh IdTipoVehiculo, v.departamento IdDepartamento, v.npiloto, v.CorreoEncargado  FROM _vehiculos v inner join tipo_vehiculo tv on v.tveh=tv.id_tipo_vehiculo inner join departamentos d on v.departamento=d.id " & ver
                Dim cmd As New MySqlCommand(consulta, conexion)
                Dim reader As MySqlDataReader = cmd.ExecuteReader
                While reader.Read
                    Dim elemento As New ClassCatalogoVehiculos
                    With elemento
                        .Id = reader("Id")
                        .codigo = reader("codigo")
                        If Not IsDBNull(reader("placa")) Then
                            .placa = reader("placa")
                        Else
                            .placa = ""
                        End If
                        If Not IsDBNull(reader("kma")) Then
                            .kma = reader("kma")
                        Else
                            .kma = 0
                        End If
                        If Not IsDBNull(reader("marca")) Then
                            .marca = reader("marca")
                        Else
                            .marca = ""
                        End If
                        If Not IsDBNull(reader("linea")) Then
                            .linea = reader("linea")
                        Else
                            .linea = ""
                        End If
                        If Not IsDBNull(reader("modelo")) Then
                            .modelo = reader("modelo")
                        Else
                            .modelo = ""
                        End If

                        If Not IsDBNull(reader("tipo_vehiculo")) Then
                            .idtipovehiculo = reader("IdTipoVehiculo")
                            .tipo = reader("tipo_vehiculo")
                        Else
                            .tipo = ""
                            .idtipovehiculo = 0
                        End If

                        If Not IsDBNull(reader("departamento")) Then
                            .iddepartamento = reader("IdDepartamento")
                            .departamento = reader("departamento")
                        Else
                            .iddepartamento = 0
                            .departamento = ""
                        End If
                        If Not IsDBNull(reader("ccontable")) Then
                            .contable = reader("ccontable")
                        Else
                            .contable = 0
                        End If
                        If Not IsDBNull(reader("status")) Then
                            .status = reader("status")
                        Else
                            .status = False
                        End If
                        If Not IsDBNull(reader("cllantas")) Then
                            .cllantas = reader("cllantas")
                        Else
                            .cllantas = ""
                        End If
                        If Not IsDBNull(reader("Pool")) Then
                            .pool = reader("Pool")
                            .poolv = reader("Pool")
                        Else
                            .pool = False
                            .poolv = 0
                        End If
                        If Not IsDBNull(reader("npiloto")) Then
                            .usuario = reader("npiloto")
                        Else
                            .usuario = 0
                        End If
                        If Not IsDBNull(reader("CorreoEncargado")) Then
                            .Correo = reader("CorreoEncargado")
                        Else
                            .Correo = 0
                        End If
                     


                    End With
                    result.Add(elemento)
                End While
            Finally
                conexion.Close()
            End Try
        End Using
        Return result
    End Function

    <WebMethod(EnableSession:=True)> _
    Public Function InfoVehiculo(ByVal IdVehiculo As String) As List(Of [ClassCatalogoVehiculos])
        Dim result As List(Of [ClassCatalogoVehiculos]) = New List(Of ClassCatalogoVehiculos)()
        Dim consulta As String
        Using conexion As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
            Try
                conexion.Open()




                consulta = "SELECT v.Id, v.codigo, v.placa, v.kma, v.marca,v.linea,v.modelo,tv.tipo_vehiculo,d.descripcion as departamento, v.ccontable, v.status, v.cllantas, v.cllantasrepuesto,  v.Pool, v.tveh IdTipoVehiculo, v.departamento IdDepartamento, v.npiloto, v.CorreoEncargado  FROM _vehiculos v inner join tipo_vehiculo tv on v.tveh=tv.id_tipo_vehiculo inner join departamentos d on v.departamento=d.id  where v.codigo like '%" & IdVehiculo & "%' limit 1"
                Dim cmd As New MySqlCommand(consulta, conexion)
                Dim reader As MySqlDataReader = cmd.ExecuteReader
                While reader.Read
                    Dim elemento As New ClassCatalogoVehiculos
                    With elemento
                        .Id = reader("Id")
                        .codigo = reader("codigo")
                        If Not IsDBNull(reader("placa")) Then
                            .placa = reader("placa")
                        Else
                            .placa = ""
                        End If
                        If Not IsDBNull(reader("kma")) Then
                            .kma = reader("kma")
                        Else
                            .kma = 0
                        End If
                        If Not IsDBNull(reader("marca")) Then
                            .marca = reader("marca")
                        Else
                            .marca = ""
                        End If
                        If Not IsDBNull(reader("linea")) Then
                            .linea = reader("linea")
                        Else
                            .linea = ""
                        End If
                        If Not IsDBNull(reader("modelo")) Then
                            .modelo = reader("modelo")
                        Else
                            .modelo = ""
                        End If

                        If Not IsDBNull(reader("tipo_vehiculo")) Then
                            .idtipovehiculo = reader("IdTipoVehiculo")
                            .tipo = reader("tipo_vehiculo")
                        Else
                            .tipo = ""
                            .idtipovehiculo = 0
                        End If

                        If Not IsDBNull(reader("departamento")) Then
                            .iddepartamento = reader("IdDepartamento")
                            .departamento = reader("departamento")
                        Else
                            .iddepartamento = 0
                            .departamento = ""
                        End If
                        If Not IsDBNull(reader("ccontable")) Then
                            .contable = reader("ccontable")
                        Else
                            .contable = 0
                        End If
                        If Not IsDBNull(reader("status")) Then
                            .status = reader("status")
                        Else
                            .status = False
                        End If
                        If Not IsDBNull(reader("cllantas")) Then
                            .cllantas = reader("cllantas")
                        Else
                            .cllantas = ""
                        End If
                        If Not IsDBNull(reader("Pool")) Then
                            .pool = reader("Pool")
                            .poolv = reader("Pool")
                        Else
                            .pool = False
                            .poolv = 0
                        End If
                        If Not IsDBNull(reader("npiloto")) Then
                            .usuario = reader("npiloto")
                        Else
                            .usuario = 0
                        End If
                        If Not IsDBNull(reader("CorreoEncargado")) Then
                            .Correo = reader("CorreoEncargado")
                        Else
                            .Correo = 0
                        End If



                    End With
                    result.Add(elemento)
                End While
            Finally
                conexion.Close()
            End Try
        End Using
        Return result
    End Function
    Public Class ClassGuardar
        Public StrError As String = "0"
    End Class
    <WebMethod()> _
    Public Function ActualizarVehiculo(ByVal Id As Integer, ByVal codigo As String, ByVal placa As String, ByVal kma As Integer, ByVal marca As String, ByVal linea As String, ByVal modelo As String, ByVal tipo As String, ByVal departamento As String, ByVal contable As String, ByVal status As Boolean, ByVal cllantas As Integer, ByVal repuesto As Integer, ByVal pool As Boolean, ByVal Usuario As String, ByVal CorreoEncargado As String) As List(Of ClassGuardar)
        Dim result As List(Of ClassGuardar) = New List(Of ClassGuardar)
        Using conexion As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
            conexion.Open()
            Try
                Dim ct As String = "UPDATE _vehiculos  SET codigo='" & codigo & "', placa='" & placa & "', kma='" & kma & "', marca='" & marca & "', linea='" & linea & "', modelo='" & modelo & "', tveh=" & tipo & ", departamento ='" & departamento & "', ccontable='" & contable & "', status=" & status & ", cllantas='" & cllantas & "', cllantasrepuesto='" & repuesto & "',  Pool=" & pool & ",  npiloto=" & Usuario & ",  CorreoEncargado='" & CorreoEncargado & "' WHERE Id='" & Id & "';"
                Dim command As New MySqlCommand
                command.Connection = conexion
                command.CommandText = ct
                command.ExecuteNonQuery()

                Dim elemento As New ClassGuardar
                elemento.StrError = "0"
                result.Add(elemento)
            Catch ex As Exception
                Dim elemento As New ClassGuardar
                elemento.StrError = ex.Message
                result.Add(elemento)
            Finally
            End Try
            conexion.Close()
        End Using
        Return result
    End Function
    Public Class ClassGuardarVehiculo
        Public StrError As String = "0"
        Public IdVehiculo As Integer
    End Class
    <WebMethod()> _
    Public Function GuardarVehiculo(ByVal codigo As String, ByVal placa As String, ByVal kma As Integer, ByVal marca As String, ByVal linea As String, ByVal modelo As String, ByVal tipo As String, ByVal departamento As String, ByVal contable As String, ByVal status As Boolean, ByVal cllantas As Integer, ByVal repuesto As Integer, ByVal pool As Boolean) As List(Of ClassGuardarVehiculo)
        Dim result As List(Of ClassGuardarVehiculo) = New List(Of ClassGuardarVehiculo)
        Try
            Dim IdVehiculo As Integer = MyDB.MyInsertIdentity("INSERT INTO _vehiculos (codigo, placa, kma, marca, linea, modelo, tveh, departamento, ccontable, status, cllantas, cllantasrepuesto, dllantas, Pool) VALUES ('" & codigo & "','" & placa & "','" & kma & "','" & marca & "','" & linea & "','" & modelo & "'," & tipo & ",'" & departamento & "','" & contable & "'," & status & ",'" & cllantas & "','" & repuesto & "',9," & pool & ");")
            Dim elemento As New ClassGuardarVehiculo
            elemento.StrError = "0"
            elemento.IdVehiculo = IdVehiculo
            result.Add(elemento)
        Catch ex As Exception
            Dim elemento As New ClassGuardarVehiculo
            elemento.StrError = ex.Message
            result.Add(elemento)
        Finally
        End Try
        Return result
    End Function
    Public Class ClassReporteUtilizacion
        Public Cantidad As Integer
        Public Fecha As String
        Public CantidadVehiculos As Integer
        Public utilizacion As Integer

    End Class
    <WebMethod(EnableSession:=True)> _
    Public Function ReporteUtilizacion(ByVal FechaIni As String, ByVal FechaFin As String) As List(Of ClassReporteUtilizacion)
        Dim result As List(Of ClassReporteUtilizacion) = New List(Of ClassReporteUtilizacion)()
        Dim consulta As String
        Using conexion As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
            Try
                conexion.Open()
                consulta = "select count(rv.id) Cantidad, concat(MesFormato(month(rv.FechaEntrega)), '-', year(rv.FechaEntrega)) AS Fecha, month(rv.FechaEntrega) Mes from reservacionvehiculo rv inner join (select IdEmpleado from personal where idArea not in(39,40)) per on per.IdEmpleado=rv.IdEmpleado where rv.FechaEntrega BETWEEN '" & FechaIni & "' AND '" & FechaFin & "' and rv.estado!=2 group by year(rv.FechaEntrega),month(rv.FechaEntrega);"



                Dim cmd As New MySqlCommand(consulta, conexion)
                Dim reader As MySqlDataReader = cmd.ExecuteReader
                Dim par As Boolean = False
                While reader.Read
                    Dim dtVehiculos = MyDB.MySelect("select rv.Id from reservacionvehiculo rv inner join (select IdEmpleado from personal where idArea not in(39,40)) per on per.IdEmpleado=rv.IdEmpleado where rv.FechaEntrega between '" & FechaIni & "' and '" & FechaFin & "' and Month(rv.FechaEntrega)=" & reader("Mes") & " group by rv.IdVehiculo;")
                    Dim CantidadVehiculos = dtVehiculos.Rows.Count
                    Dim utilizacion = Convert.ToInt32(reader("Cantidad")) / CantidadVehiculos
                    Dim elemento As New ClassReporteUtilizacion
                    With elemento
                        .CantidadVehiculos = CantidadVehiculos
                        .utilizacion = utilizacion
                        If Not IsDBNull(reader("Cantidad")) Then
                            .Cantidad = reader("Cantidad")
                        Else
                            .Cantidad = ""
                        End If
                        If Not IsDBNull(reader("Fecha")) Then
                            If par = False Then
                                .Fecha = reader("Fecha")
                                par = True
                            Else
                                .Fecha = " " & reader("Fecha")
                                par = False
                            End If

                        Else
                            .Fecha = ""
                        End If
                    End With
                    result.Add(elemento)
                End While
            Finally
                conexion.Close()
            End Try
        End Using
        Return result
    End Function
    Public Class ClassReporteUtilizacionLinea
        Public CantidadLi As Integer
        Public Departamento As String
        Public Porcentaje As Integer
    End Class
    <WebMethod(EnableSession:=True)> _
    Public Function ReporteUtilizacionLineas(ByVal FechaIni As String, ByVal FechaFin As String) As List(Of ClassReporteUtilizacionLinea)
        Dim result As List(Of ClassReporteUtilizacionLinea) = New List(Of ClassReporteUtilizacionLinea)()
        Try
            Dim dtConsulta As DataTable = MyDB.MySelect("select d.descripcion Departamento, count(rv.Id) Cantidad from reservacionvehiculo rv inner join (select IdEmpleado, IdArea from personal where idArea not in(39,40)) p on rv.IdEmpleado=p.Idempleado inner join departamentos d on p.IdArea=d.id where rv.FechaEntrega between '" & FechaIni & "' and '" & FechaFin & "' and rv.Estado!=2 group by p.IdArea order by Cantidad desc limit 5;")
            Dim CantidadTotal As Integer = MyDB.MySelectOneParameter("select count(rv.Id) CantidadTotal from reservacionvehiculo rv inner join (select IdEmpleado, IdArea from personal where idArea not in(39,40)) p on rv.IdEmpleado=p.Idempleado inner join departamentos d on p.IdArea=d.id where rv.FechaEntrega between '" & FechaIni & "' and '" & FechaFin & "' and rv.Estado!=2;", "CantidadTotal")
            For Each reader As DataRow In dtConsulta.Rows
                Dim elemento As New ClassReporteUtilizacionLinea
                With elemento
                    .CantidadLi = reader("Cantidad")
                    .Porcentaje = (reader("Cantidad") * 100) / CantidadTotal
                    .Departamento = reader("Departamento")
                End With
                result.Add(elemento)
            Next
        Finally
        End Try
        Return result
    End Function

    Public Class ClassDetalleUsoVisitas
        Public StrError As String = "0"
        Public Ubicacion As String
        Public TiempoTL As String
        Public TiempoSL As Integer
        Public FechaInicio As String
        Public FechaIniciod As String
        Public FechaInicioT As String
        Public FechaFinT As String
        Public vehiculo As String
        Public Rubros As String


    End Class
    <WebMethod(EnableSession:=True)> _
    Public Function DetalleUsoVisitas(ByVal FechaInicio As String, ByVal FechaFin As String, ByVal CodVehiculo As String, ByVal Rubro As String, ByVal Cantidad As Integer) As List(Of [ClassDetalleUsoVisitas])
        Dim result As List(Of [ClassDetalleUsoVisitas]) = New List(Of ClassDetalleUsoVisitas)()
        Dim consulta As String
        'ByVal FechaInicio As String, ByVal FechaFin As String, ByVal Codigo As String
        Using conexion As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
            Try
                conexion.Open()
                If Rubro = "Visitas" Then
                    consulta = "select vh.codigo,p.IdVehiculo,  DAYNAME(LEFT((p.FechaInicio),10)) AS FechaInicio, LEFT((p.FechaInicio),10) AS FechaIniciod, p.FechaFin ,p.Ubicacion as Ubicacion, SEC_TO_TIME(sum(time_to_sec(p.Tiempo)))  as TiempoT, (sum(time_to_sec(p.Tiempo)))  as TiempoS  from parada p inner join(select id, codigo from _vehiculos)vh on p.IdVehiculo=vh.id where ('" & FechaInicio & "' <= LEFT((FechaInicio),10) AND LEFT((FechaFin),10) <= '" & FechaFin & "') and p.Ubicacion NOT LIKE '%gentrac%' and p.Ubicacion NOT LIKE '%MOBIL%' and p.Ubicacion NOT LIKE'%c.%' and p.Ubicacion NOT LIKE'%t.%' and vh.codigo = '" & CodVehiculo & "'and p.Segundos < 14400 and (WEEKDAY(p.FechaInicio) !=5 or WEEKDAY(p.FechaInicio) !=6) group by p.Ubicacion order by TiempoS desc limit " & Cantidad & ";"
                ElseIf Rubro = "VisitasNocturno" Then
                    consulta = "select vh.codigo,p.IdVehiculo,  DAYNAME(LEFT((p.FechaInicio),10)) AS FechaInicio, LEFT((p.FechaInicio),10) AS FechaIniciod, p.FechaFin ,p.Ubicacion as Ubicacion, SEC_TO_TIME(sum(time_to_sec(p.Tiempo)))  as TiempoT, (sum(time_to_sec(p.Tiempo)))  as TiempoS  from parada p inner join(select id, codigo from _vehiculos)vh on p.IdVehiculo=vh.id where ('" & FechaInicio & "' <= LEFT((FechaInicio),10) AND LEFT((FechaFin),10) <= '" & FechaFin & "') and p.Ubicacion NOT LIKE '%gentrac%' and p.Ubicacion NOT LIKE '%MOBIL%' and p.Ubicacion NOT LIKE'%c.%' and p.Ubicacion NOT LIKE'%t.%' and vh.codigo = '" & CodVehiculo & "'and p.Segundos >= 14400 and WEEKDAY(p.FechaInicio) !=5 and WEEKDAY(p.FechaInicio) !=6 group by p.Ubicacion order by TiempoS desc limit " & Cantidad & ";"
                ElseIf Rubro = "VisitasFinS" Then
                    consulta = "select vh.codigo,p.IdVehiculo,  DAYNAME(LEFT((p.FechaInicio),10)) AS FechaInicio, LEFT((p.FechaInicio),10) AS FechaIniciod, p.FechaFin ,p.Ubicacion as Ubicacion, SEC_TO_TIME(sum(time_to_sec(p.Tiempo)))  as TiempoT, (sum(time_to_sec(p.Tiempo)))  as TiempoS  from parada p inner join(select id, codigo from _vehiculos)vh on p.IdVehiculo=vh.id where ('" & FechaInicio & "' <= LEFT((FechaInicio),10) AND LEFT((FechaFin),10) <= '" & FechaFin & "') and p.Ubicacion NOT LIKE'gentrac' and p.Ubicacion NOT LIKE'%c.%' and p.Ubicacion NOT LIKE'%t.%' and vh.codigo = '" & CodVehiculo & "'and (WEEKDAY(p.FechaInicio) =5 or WEEKDAY(p.FechaInicio) =6) group by p.Ubicacion order by TiempoS desc limit " & Cantidad & ";"
                ElseIf Rubro = "Apagado" Then
                    consulta = "select vh.codigo,p.IdVehiculo, DAYNAME(LEFT((p.FechaInicio),10)) AS FechaInicio, LEFT((p.FechaInicio),10) AS FechaIniciod, p.FechaFin ,p.Ubicacion as Ubicacion, SEC_TO_TIME(sum(time_to_sec(p.Tiempo)))  as TiempoT, (sum(time_to_sec(p.Tiempo)))  as TiempoS  from parada p inner join(select id, codigo from _vehiculos)vh on p.IdVehiculo=vh.id where ('" & FechaInicio & "' <= LEFT((FechaInicio),10) AND LEFT((FechaFin),10) <= '" & FechaFin & "') and p.Ubicacion LIKE'%c.%' and vh.codigo ='" & CodVehiculo & "'and p.Segundos < 14400 and (WEEKDAY(p.FechaInicio) !=5 or WEEKDAY(p.FechaInicio) !=6) group by LEFT((p.FechaInicio),10) order by LEFT((p.FechaInicio),10) desc;"
                ElseIf Rubro = "ApagadoNocturno" Then
                    consulta = "select vh.codigo,p.IdVehiculo,DAYNAME(LEFT((p.FechaInicio),10)) AS FechaInicio, LEFT((p.FechaInicio),10) AS FechaIniciod, p.FechaFin ,p.Ubicacion as Ubicacion, SEC_TO_TIME(sum(time_to_sec(p.Tiempo)))  as TiempoT, (sum(time_to_sec(p.Tiempo)))  as TiempoS  from parada p inner join(select id, codigo from _vehiculos)vh on p.IdVehiculo=vh.id where ('" & FechaInicio & "' <= LEFT((FechaInicio),10) AND LEFT((FechaFin),10) <= '" & FechaFin & "') and p.Ubicacion LIKE'%c.%' and vh.codigo ='" & CodVehiculo & "'and p.Segundos >= 14400 and (WEEKDAY(p.FechaInicio) !=5 or WEEKDAY(p.FechaInicio) !=6) group by LEFT((p.FechaInicio),10) order by LEFT((p.FechaInicio),10) desc;"
                ElseIf Rubro = "ApagadoFinS" Then
                    consulta = "select vh.codigo,p.IdVehiculo, DAYNAME(LEFT((p.FechaInicio),10)) AS FechaInicio, LEFT((p.FechaInicio),10) AS FechaIniciod, p.FechaFin ,p.Ubicacion as Ubicacion, SEC_TO_TIME(sum(time_to_sec(p.Tiempo)))  as TiempoT, (sum(time_to_sec(p.Tiempo)))  as TiempoS  from parada p inner join(select id, codigo from _vehiculos)vh on p.IdVehiculo=vh.id where ('" & FechaInicio & "' <= LEFT((FechaInicio),10) AND LEFT((FechaFin),10) <= '" & FechaFin & "') and p.Ubicacion LIKE'%c.%' and vh.codigo ='" & CodVehiculo & "'and (WEEKDAY(p.FechaInicio) =5 or WEEKDAY(p.FechaInicio) =6) group by LEFT((p.FechaInicio),10) order by LEFT((p.FechaInicio),10) desc;"
                ElseIf Rubro = "Gentrac_Mobil" Then
                    consulta = "select vh.codigo,p.IdVehiculo, DAYNAME(LEFT((p.FechaInicio),10)) AS FechaInicio, LEFT((p.FechaInicio),10) AS FechaIniciod, p.FechaFin ,p.Ubicacion as Ubicacion, SEC_TO_TIME(sum(time_to_sec(p.Tiempo)))  as TiempoT, (sum(time_to_sec(p.Tiempo)))  as TiempoS  from parada p inner join(select id, codigo from _vehiculos)vh on p.IdVehiculo=vh.id where ('" & FechaInicio & "' <= LEFT((FechaInicio),10) AND LEFT((FechaFin),10) <= '" & FechaFin & "') and (p.Ubicacion LIKE '%gentrac%' or p.Ubicacion LIKE '%MOBIL%') and vh.codigo = '" & CodVehiculo & "'and (WEEKDAY(p.FechaInicio) !=5 or WEEKDAY(p.FechaInicio) !=6) group by LEFT((p.FechaInicio),10) order by LEFT((p.FechaInicio),10) desc;"
                ElseIf Rubro = "Gentrac_MobilFin" Then
                    consulta = "select vh.codigo,p.IdVehiculo, DAYNAME(LEFT((p.FechaInicio),10)) AS FechaInicio, LEFT((p.FechaInicio),10) AS FechaIniciod, p.FechaFin ,p.Ubicacion as Ubicacion, SEC_TO_TIME(sum(time_to_sec(p.Tiempo)))  as TiempoT, (sum(time_to_sec(p.Tiempo)))  as TiempoS  from parada p inner join(select id, codigo from _vehiculos)vh on p.IdVehiculo=vh.id where ('" & FechaInicio & "' <= LEFT((FechaInicio),10) AND LEFT((FechaFin),10) <= '" & FechaFin & "') and (p.Ubicacion LIKE '%gentrac%' or p.Ubicacion LIKE '%MOBIL%') and vh.codigo = '" & CodVehiculo & "'and (WEEKDAY(p.FechaInicio) =5 or WEEKDAY(p.FechaInicio) =6) group by LEFT((p.FechaInicio),10) order by LEFT((p.FechaInicio),10) desc;"
                ElseIf Rubro = "Taller" Then
                    consulta = "select vh.codigo,p.IdVehiculo, DAYNAME(LEFT((p.FechaInicio),10)) AS FechaInicio, LEFT((p.FechaInicio),10) AS FechaIniciod, p.FechaFin ,p.Ubicacion as Ubicacion, SEC_TO_TIME(sum(time_to_sec(p.Tiempo)))  as TiempoT, (sum(time_to_sec(p.Tiempo)))  as TiempoS  from parada p inner join(select id, codigo from _vehiculos)vh on p.IdVehiculo=vh.id where ('" & FechaInicio & "' <= LEFT((FechaInicio),10) AND LEFT((FechaFin),10) <= '" & FechaFin & "') and p.Ubicacion LIKE'%t.%' and vh.codigo ='" & CodVehiculo & "'and p.Segundos < 14400 and (WEEKDAY(p.FechaInicio) !=5 or WEEKDAY(p.FechaInicio) !=6) group by LEFT((p.FechaInicio),10) order by p.FechaInicio desc;"
                End If

                Dim cmd As New MySqlCommand(consulta, conexion)
                Dim reader As MySqlDataReader = cmd.ExecuteReader()
                While reader.Read


                    Dim Elementos As New ClassDetalleUsoVisitas
                    If Not IsDBNull(reader("Ubicacion")) Then
                        Elementos.Ubicacion = reader("Ubicacion")
                    Else
                        Elementos.Ubicacion = ""
                    End If
                    If Not IsDBNull(reader("TiempoT")) Then
                        Elementos.TiempoTL = (Convert.ToString(reader("TiempoT")))
                    Else
                        Elementos.TiempoTL = ""
                    End If

                    If Not IsDBNull(reader("TiempoS")) Then
                        Elementos.TiempoSL = reader("TiempoS")
                    Else
                        Elementos.TiempoSL = 0
                    End If
                    If Not IsDBNull(reader("codigo")) Then
                        Elementos.vehiculo = reader("codigo")
                    Else
                        Elementos.vehiculo = 0
                    End If

                    If Not IsDBNull(reader("FechaInicio")) Then

                        If reader("FechaInicio") = "Monday" Then
                            Elementos.FechaInicio = "Lunes"

                        ElseIf reader("FechaInicio") = "Tuesday" Then
                            Elementos.FechaInicio = "Martes"
                        ElseIf reader("FechaInicio") = "Wednesday" Then
                            Elementos.FechaInicio = "Miercoles "
                        ElseIf reader("FechaInicio") = "Thursday" Then
                            Elementos.FechaInicio = "Jueves"
                        ElseIf reader("FechaInicio") = "Friday" Then
                            Elementos.FechaInicio = "Viernes"
                        ElseIf reader("FechaInicio") = "Saturday" Then
                            Elementos.FechaInicio = "Sabado"
                        ElseIf reader("FechaInicio") = "Sunday" Then
                            Elementos.FechaInicio = "Domingo"

                        End If
                    Else
                        Elementos.FechaInicio = ""
                    End If

                    If Not IsDBNull(reader("FechaIniciod")) Then
                        Elementos.FechaIniciod = reader("FechaIniciod")
                    Else
                        Elementos.FechaIniciod = ""
                    End If

                    Elementos.Rubros = Rubro
                    result.Add(Elementos)


                End While
            Catch ex As Exception
                Dim Elementos As New ClassDetalleUsoVisitas
                Elementos.StrError = ex.Message
                result.Add(Elementos)
            Finally
                conexion.Close()
            End Try
        End Using
        Return result
    End Function

    <WebMethod(EnableSession:=True)> _
    Public Function DetalleUsoVisitasDs(ByVal FechaInicio As String, ByVal FechaFin As String, ByVal CodVehiculo As String, ByVal Rubro As String, ByVal Cantidad As Integer, ByVal Ubicacion As String, ByVal FechaInicioC As String) As List(Of [ClassDetalleUsoVisitas])
        Dim result As List(Of [ClassDetalleUsoVisitas]) = New List(Of ClassDetalleUsoVisitas)()
        Dim consulta As String
        'ByVal FechaInicio As String, ByVal FechaFin As String, ByVal Codigo As String
        Using conexion As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
            Try
                conexion.Open()
                If Rubro = "Visitas" Then
                    consulta = "select vh.codigo,  DAYNAME(LEFT((p.FechaInicio),10)) AS FechaInicio, LEFT((p.FechaInicio),10) AS FechaIniciod, p.FechaInicio as FechaInicioT, p.FechaFin ,p.Ubicacion as Ubicacion, SEC_TO_TIME((time_to_sec(p.Tiempo)))  as TiempoT, ((time_to_sec(p.Tiempo)))  as TiempoS  from parada p inner join(select id, codigo from _vehiculos)vh on p.IdVehiculo=vh.id where ('" & FechaInicio & "' <= LEFT((FechaInicio),10) AND LEFT((FechaFin),10) <= '" & FechaFin & "') and p.Ubicacion NOT LIKE '%gentrac%' and p.Ubicacion NOT LIKE '%MOBIL%' and p.Ubicacion NOT LIKE'%c.%' and p.Ubicacion NOT LIKE'%t.%' and vh.codigo = '" & CodVehiculo & "'and p.Segundos < 14400 and (WEEKDAY(p.FechaInicio) !=5 or WEEKDAY(p.FechaInicio) !=6) and p.Ubicacion = '" & Ubicacion & "' order by TiempoS desc;"
                ElseIf Rubro = "VisitasNocturno" Then
                    consulta = "select vh.codigo,  DAYNAME(LEFT((p.FechaInicio),10)) AS FechaInicio, LEFT((p.FechaInicio),10) AS FechaIniciod, p.FechaInicio as FechaInicioT, p.FechaFin ,p.Ubicacion as Ubicacion, SEC_TO_TIME((time_to_sec(p.Tiempo)))  as TiempoT, ((time_to_sec(p.Tiempo)))  as TiempoS  from parada p inner join(select id, codigo from _vehiculos)vh on p.IdVehiculo=vh.id where ('" & FechaInicio & "' <= LEFT((FechaInicio),10) AND LEFT((FechaFin),10) <= '" & FechaFin & "') and p.Ubicacion NOT LIKE '%gentrac%' and p.Ubicacion NOT LIKE '%MOBIL%' and p.Ubicacion NOT LIKE'%c.%' and p.Ubicacion NOT LIKE'%t.%' and vh.codigo = '" & CodVehiculo & "'and p.Segundos >= 14400 and WEEKDAY(p.FechaInicio) !=5 and WEEKDAY(p.FechaInicio) !=6 and p.Ubicacion = '" & Ubicacion & "'  order by TiempoS desc;"
                ElseIf Rubro = "VisitasFinS" Then
                    consulta = "select vh.codigo,  DAYNAME(LEFT((p.FechaInicio),10)) AS FechaInicio, LEFT((p.FechaInicio),10) AS FechaIniciod, p.FechaInicio as FechaInicioT, p.FechaFin ,p.Ubicacion as Ubicacion, SEC_TO_TIME((time_to_sec(p.Tiempo)))  as TiempoT, ((time_to_sec(p.Tiempo)))  as TiempoS  from parada p inner join(select id, codigo from _vehiculos)vh on p.IdVehiculo=vh.id where ('" & FechaInicio & "' <= LEFT((FechaInicio),10) AND LEFT((FechaFin),10) <= '" & FechaFin & "') and p.Ubicacion NOT LIKE'gentrac' and p.Ubicacion NOT LIKE'%c.%' and p.Ubicacion NOT LIKE'%t.%' and vh.codigo = '" & CodVehiculo & "'and (WEEKDAY(p.FechaInicio) =5 or WEEKDAY(p.FechaInicio) =6) and p.Ubicacion = '" & Ubicacion & "' order by TiempoS desc;"
                ElseIf Rubro = "Apagado" Then
                    consulta = "select vh.codigo, DAYNAME(LEFT((p.FechaInicio),10)) AS FechaInicio, LEFT((p.FechaInicio),10) AS FechaIniciod, p.FechaInicio as FechaInicioT, p.FechaFin ,p.Ubicacion as Ubicacion, SEC_TO_TIME((time_to_sec(p.Tiempo)))  as TiempoT, ((time_to_sec(p.Tiempo)))  as TiempoS  from parada p inner join(select id, codigo from _vehiculos)vh on p.IdVehiculo=vh.id where ('" & FechaInicio & "' <= LEFT((FechaInicio),10) AND LEFT((FechaFin),10) <= '" & FechaFin & "') and p.Ubicacion LIKE'%c.%' and vh.codigo ='" & CodVehiculo & "'and p.Segundos < 14400 and (WEEKDAY(p.FechaInicio) !=5 or WEEKDAY(p.FechaInicio) !=6) and p.Ubicacion = '" & Ubicacion & "' and LEFT((p.FechaInicio),10)='" & FechaInicioC & "' order by LEFT((p.FechaInicio),10) desc;"
                ElseIf Rubro = "ApagadoNocturno" Then
                    consulta = "select vh.codigo,DAYNAME(LEFT((p.FechaInicio),10)) AS FechaInicio, LEFT((p.FechaInicio),10) AS FechaIniciod, p.FechaInicio as FechaInicioT, p.FechaFin ,p.Ubicacion as Ubicacion, SEC_TO_TIME((time_to_sec(p.Tiempo)))  as TiempoT, ((time_to_sec(p.Tiempo)))  as TiempoS  from parada p inner join(select id, codigo from _vehiculos)vh on p.IdVehiculo=vh.id where ('" & FechaInicio & "' <= LEFT((FechaInicio),10) AND LEFT((FechaFin),10) <= '" & FechaFin & "') and p.Ubicacion LIKE'%c.%' and vh.codigo ='" & CodVehiculo & "'and p.Segundos >= 14400 and (WEEKDAY(p.FechaInicio) !=5 or WEEKDAY(p.FechaInicio) !=6) and p.Ubicacion = '" & Ubicacion & "'and LEFT((p.FechaInicio),10)='" & FechaInicioC & "' order by LEFT((p.FechaInicio),10) desc;"
                ElseIf Rubro = "ApagadoFinS" Then
                    consulta = "select vh.codigo, DAYNAME(LEFT((p.FechaInicio),10)) AS FechaInicio, LEFT((p.FechaInicio),10) AS FechaIniciod, p.FechaInicio as FechaInicioT, p.FechaFin ,p.Ubicacion as Ubicacion, SEC_TO_TIME(sum(time_to_sec(p.Tiempo)))  as TiempoT, (sum(time_to_sec(p.Tiempo)))  as TiempoS  from parada p inner join(select id, codigo from _vehiculos)vh on p.IdVehiculo=vh.id where ('" & FechaInicio & "' <= LEFT((FechaInicio),10) AND LEFT((FechaFin),10) <= '" & FechaFin & "') and p.Ubicacion LIKE'%c.%' and vh.codigo ='" & CodVehiculo & "'and (WEEKDAY(p.FechaInicio) =5 or WEEKDAY(p.FechaInicio) =6) and p.Ubicacion = '" & Ubicacion & "'and LEFT((p.FechaInicio),10)='" & FechaInicioC & "' order by LEFT((p.FechaInicio),10) desc;"
                ElseIf Rubro = "Gentrac_Mobil" Then
                    consulta = "select vh.codigo, DAYNAME(LEFT((p.FechaInicio),10)) AS FechaInicio, LEFT((p.FechaInicio),10) AS FechaIniciod, p.FechaInicio as FechaInicioT, p.FechaFin ,p.Ubicacion as Ubicacion, SEC_TO_TIME(sum(time_to_sec(p.Tiempo)))  as TiempoT, (sum(time_to_sec(p.Tiempo)))  as TiempoS  from parada p inner join(select id, codigo from _vehiculos)vh on p.IdVehiculo=vh.id where ('" & FechaInicio & "' <= LEFT((FechaInicio),10) AND LEFT((FechaFin),10) <= '" & FechaFin & "') and (p.Ubicacion LIKE '%gentrac%' or p.Ubicacion LIKE '%MOBIL%') and vh.codigo = '" & CodVehiculo & "'and (WEEKDAY(p.FechaInicio) !=5 or WEEKDAY(p.FechaInicio) !=6) and p.Ubicacion = '" & Ubicacion & "'and LEFT((p.FechaInicio),10)='" & FechaInicioC & "' order by LEFT((p.FechaInicio),10) desc;"
                ElseIf Rubro = "Gentrac_MobilFin" Then
                    consulta = "select vh.codigo, DAYNAME(LEFT((p.FechaInicio),10)) AS FechaInicio, LEFT((p.FechaInicio),10) AS FechaIniciod, p.FechaInicio as FechaInicioT, p.FechaFin ,p.Ubicacion as Ubicacion, SEC_TO_TIME(sum(time_to_sec(p.Tiempo)))  as TiempoT, (sum(time_to_sec(p.Tiempo)))  as TiempoS  from parada p inner join(select id, codigo from _vehiculos)vh on p.IdVehiculo=vh.id where ('" & FechaInicio & "' <= LEFT((FechaInicio),10) AND LEFT((FechaFin),10) <= '" & FechaFin & "') and (p.Ubicacion LIKE '%gentrac%' or p.Ubicacion LIKE '%MOBIL%') and vh.codigo = '" & CodVehiculo & "'and (WEEKDAY(p.FechaInicio) =5 or WEEKDAY(p.FechaInicio) =6) and p.Ubicacion = '" & Ubicacion & "'and LEFT((p.FechaInicio),10)='" & FechaInicioC & "' order by LEFT((p.FechaInicio),10) desc;"
                ElseIf Rubro = "Taller" Then
                    consulta = "select vh.codigo, DAYNAME(LEFT((p.FechaInicio),10)) AS FechaInicio, LEFT((p.FechaInicio),10) AS FechaIniciod, p.FechaInicio as FechaInicioT, p.FechaFin ,p.Ubicacion as Ubicacion, SEC_TO_TIME(sum(time_to_sec(p.Tiempo)))  as TiempoT, (sum(time_to_sec(p.Tiempo)))  as TiempoS  from parada p inner join(select id, codigo from _vehiculos)vh on p.IdVehiculo=vh.id where ('" & FechaInicio & "' <= LEFT((FechaInicio),10) AND LEFT((FechaFin),10) <= '" & FechaFin & "') and p.Ubicacion LIKE'%t.%' and vh.codigo ='" & CodVehiculo & "'and p.Segundos < 14400 and (WEEKDAY(p.FechaInicio) !=5 or WEEKDAY(p.FechaInicio) !=6) and p.Ubicacion = '" & Ubicacion & "'and LEFT((p.FechaInicio),10)='" & FechaInicioC & "' order by p.FechaInicio desc;"
                End If

                Dim cmd As New MySqlCommand(consulta, conexion)
                Dim reader As MySqlDataReader = cmd.ExecuteReader()
                While reader.Read


                    Dim Elementos As New ClassDetalleUsoVisitas
                    If Not IsDBNull(reader("codigo")) Then
                        Elementos.vehiculo = reader("codigo")
                    Else
                        Elementos.vehiculo = 0
                    End If
                    If Not IsDBNull(reader("Ubicacion")) Then
                        Elementos.Ubicacion = reader("Ubicacion")
                    Else
                        Elementos.Ubicacion = ""
                    End If
                    If Not IsDBNull(reader("TiempoT")) Then
                        Elementos.TiempoTL = (Convert.ToString(reader("TiempoT")))
                    Else
                        Elementos.TiempoTL = ""
                    End If

                    If Not IsDBNull(reader("TiempoS")) Then
                        Elementos.TiempoSL = reader("TiempoS")
                    Else
                        Elementos.TiempoSL = 0
                    End If

                    If Not IsDBNull(reader("FechaInicioT")) Then
                        Elementos.FechaInicioT = reader("FechaInicioT")
                    Else
                        Elementos.FechaInicioT = 0
                    End If
                    If Not IsDBNull(reader("FechaFin")) Then
                        Elementos.FechaFinT = reader("FechaFin")
                    Else
                        Elementos.FechaFinT = 0
                    End If

                    If Not IsDBNull(reader("FechaInicio")) Then

                        If reader("FechaInicio") = "Monday" Then
                            Elementos.FechaInicio = "Lunes"

                        ElseIf reader("FechaInicio") = "Tuesday" Then
                            Elementos.FechaInicio = "Martes"
                        ElseIf reader("FechaInicio") = "Wednesday" Then
                            Elementos.FechaInicio = "Miercoles "
                        ElseIf reader("FechaInicio") = "Thursday" Then
                            Elementos.FechaInicio = "Jueves"
                        ElseIf reader("FechaInicio") = "Friday" Then
                            Elementos.FechaInicio = "Viernes"
                        ElseIf reader("FechaInicio") = "Saturday" Then
                            Elementos.FechaInicio = "Sabado"
                        ElseIf reader("FechaInicio") = "Sunday" Then
                            Elementos.FechaInicio = "Domingo"

                        End If
                    Else
                        Elementos.FechaInicio = ""
                    End If

                    If Not IsDBNull(reader("FechaIniciod")) Then
                        Elementos.FechaIniciod = reader("FechaIniciod")
                    Else
                        Elementos.FechaIniciod = ""
                    End If
                    result.Add(Elementos)


                End While
            Catch ex As Exception
                Dim Elementos As New ClassDetalleUsoVisitas
                Elementos.StrError = ex.Message
                result.Add(Elementos)
            Finally
                conexion.Close()
            End Try
        End Using
        Return result
    End Function
    Public Class ClassUtilizacionFlota
        Public StrError As String = "0"
        Public IdVehiculo As Integer
        Public Codigo As String
        Public nombre As String
        Public Gentrac_Mobil As Integer
        Public Gentrac_MobilFin As Integer
        Public Visitas As Integer
        Public VisitasNocturno As Integer
        Public VisitasFinS As Integer
        Public Apagado As Integer
        Public ApagadoNocturno As Integer
        Public ApagadoFinS As Integer
        Public Desplazamiento As Integer
        Public Taller As Integer
        Public HoraG As String
        Public HoraGF As String
        Public HoraV As String
        Public HoraVN As String
        Public HoraVF As String
        Public HoraA As String
        Public HoraAN As String
        Public HoraAF As String
        Public HoraD As String
        Public HoraT As String
    End Class
    <WebMethod(EnableSession:=True)> _
    Public Function UtilizacionFlota(ByVal FechaInicio As String, ByVal FechaFin As String, ByVal Departamento As Integer) As List(Of [ClassUtilizacionFlota])
        Dim result As List(Of [ClassUtilizacionFlota]) = New List(Of ClassUtilizacionFlota)()
        Dim consulta As String

        Using conexion As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
            Try
                conexion.Open()



                If Departamento <= 0 Then
                    consulta = "select Id, codigo,p.nombre from _vehiculos inner join (select idEmpleado, nombre from personal) p on p.idEmpleado=npiloto;"
                Else
                    consulta = "select Id, codigo,p.nombre from _vehiculos inner join (select idEmpleado, nombre from personal) p on p.idEmpleado=npiloto where departamento = '" & Departamento & "';"
                End If

                Dim cmd As New MySqlCommand(consulta, conexion)
                Dim reader As MySqlDataReader = cmd.ExecuteReader()
                While reader.Read


                    Dim Elementos As New ClassUtilizacionFlota
                    If Not IsDBNull(reader("Id")) Then
                        Elementos.IdVehiculo = reader("Id")
                    Else
                        Elementos.IdVehiculo = 0
                    End If
                    If Not IsDBNull(reader("codigo")) Then
                        Elementos.Codigo = reader("codigo")
                    Else
                        Elementos.Codigo = ""
                    End If

                    If Not IsDBNull(reader("nombre")) Then
                        Elementos.nombre = reader("nombre")
                    Else
                        Elementos.nombre = ""
                    End If
                    Elementos.Gentrac_Mobil = MyDB.MySelectOneParameter("select (sum(time_to_sec(p.Tiempo)))  as GENTRAC from parada p inner join(select id, codigo from _vehiculos)vh on p.IdVehiculo=vh.id where ('" & FechaInicio & "' <= LEFT((FechaInicio),10) AND LEFT((FechaFin),10) <= '" & FechaFin & "') and (p.Ubicacion LIKE '%gentrac%' or p.Ubicacion LIKE '%MOBIL%') and vh.codigo = '" & Elementos.Codigo & "'and (WEEKDAY(p.FechaInicio) !=5 or WEEKDAY(p.FechaInicio) !=6)", "GENTRAC")
                    Elementos.Gentrac_MobilFin = MyDB.MySelectOneParameter("select (sum(time_to_sec(p.Tiempo)))  as GENTRAC from parada p inner join(select id, codigo from _vehiculos)vh on p.IdVehiculo=vh.id where ('" & FechaInicio & "' <= LEFT((FechaInicio),10) AND LEFT((FechaFin),10) <= '" & FechaFin & "') and (p.Ubicacion LIKE '%gentrac%' or p.Ubicacion LIKE '%MOBIL%') and vh.codigo = '" & Elementos.Codigo & "'and (WEEKDAY(p.FechaInicio) =5 or WEEKDAY(p.FechaInicio) =6)", "GENTRAC")

                    Elementos.Visitas = MyDB.MySelectOneParameter("select (sum(time_to_sec(p.Tiempo)))  as VISITAS  from parada p inner join(select id, codigo from _vehiculos)vh on p.IdVehiculo=vh.id where ('" & FechaInicio & "' <= LEFT((FechaInicio),10) AND LEFT((FechaFin),10) <= '" & FechaFin & "') and p.Ubicacion NOT LIKE '%gentrac%' and p.Ubicacion NOT LIKE '%MOBIL%' and p.Ubicacion NOT LIKE '%c.%' and p.Ubicacion NOT LIKE '%t.%' and vh.codigo = '" & Elementos.Codigo & "'and p.Segundos < 14400 and (WEEKDAY(p.FechaInicio) !=5 or WEEKDAY(p.FechaInicio) !=6)", "VISITAS")
                    Elementos.VisitasNocturno = MyDB.MySelectOneParameter("select (sum(time_to_sec(p.Tiempo)))  as VISITAS  from parada p inner join(select id, codigo from _vehiculos)vh on p.IdVehiculo=vh.id where ('" & FechaInicio & "' <= LEFT((FechaInicio),10) AND LEFT((FechaFin),10) <= '" & FechaFin & "') and p.Ubicacion NOT LIKE'%gentrac%' and p.Ubicacion NOT LIKE '%MOBIL%' and p.Ubicacion NOT LIKE '%c.%' and p.Ubicacion NOT LIKE '%t.%' and vh.codigo = '" & Elementos.Codigo & "'and p.Segundos >= 14400 and (WEEKDAY(p.FechaInicio) !=5 or WEEKDAY(p.FechaInicio) !=6)", "VISITAS")
                    Elementos.VisitasFinS = MyDB.MySelectOneParameter("select (sum(time_to_sec(p.Tiempo)))  as VISITAS  from parada p inner join(select id, codigo from _vehiculos)vh on p.IdVehiculo=vh.id where ('" & FechaInicio & "' <= LEFT((FechaInicio),10) AND LEFT((FechaFin),10) <= '" & FechaFin & "') and p.Ubicacion NOT LIKE '%gentrac%' and p.Ubicacion NOT LIKE '%MOBIL%' and p.Ubicacion NOT LIKE '%c.%' and p.Ubicacion NOT LIKE '%t.%' and vh.codigo = '" & Elementos.Codigo & "'and (WEEKDAY(p.FechaInicio) =5 or WEEKDAY(p.FechaInicio) =6)", "VISITAS")


                    Elementos.Apagado = MyDB.MySelectOneParameter("select (sum(time_to_sec(p.Tiempo)))  as APAGADO from parada p inner join(select id, codigo from _vehiculos)vh on p.IdVehiculo=vh.id where ('" & FechaInicio & "' <= LEFT((FechaInicio),10) AND LEFT((FechaFin),10) <= '" & FechaFin & "') and p.Ubicacion LIKE'%c.%' and vh.codigo ='" & Elementos.Codigo & "'and p.Segundos < 14400 and (WEEKDAY(p.FechaInicio) !=5 or WEEKDAY(p.FechaInicio) !=6)", "APAGADO")
                    Elementos.ApagadoNocturno = MyDB.MySelectOneParameter("select (sum(time_to_sec(p.Tiempo)))  as APAGADO from parada p inner join(select id, codigo from _vehiculos)vh on p.IdVehiculo=vh.id where ('" & FechaInicio & "' <= LEFT((FechaInicio),10) AND LEFT((FechaFin),10) <= '" & FechaFin & "') and p.Ubicacion LIKE'%c.%' and vh.codigo ='" & Elementos.Codigo & "'and p.Segundos >= 14400 and (WEEKDAY(p.FechaInicio) !=5 or WEEKDAY(p.FechaInicio) !=6)", "APAGADO")
                    Elementos.ApagadoFinS = MyDB.MySelectOneParameter("select (sum(time_to_sec(p.Tiempo)))  as APAGADO from parada p inner join(select id, codigo from _vehiculos)vh on p.IdVehiculo=vh.id where ('" & FechaInicio & "' <= LEFT((FechaInicio),10) AND LEFT((FechaFin),10) <= '" & FechaFin & "') and p.Ubicacion LIKE'%c.%' and vh.codigo ='" & Elementos.Codigo & "'and (WEEKDAY(p.FechaInicio) =5 or WEEKDAY(p.FechaInicio) =6)", "APAGADO")

                    Elementos.Taller = MyDB.MySelectOneParameter("select (sum(time_to_sec(p.Tiempo)))  as APAGADO from parada p inner join(select id, codigo from _vehiculos)vh on p.IdVehiculo=vh.id where ('" & FechaInicio & "' <= LEFT((FechaInicio),10) AND LEFT((FechaFin),10) <= '" & FechaFin & "') and p.Ubicacion LIKE'%t.%' and vh.codigo ='" & Elementos.Codigo & "'", "APAGADO")


                    Elementos.Desplazamiento = MyDB.MySelectOneParameter("select (sum(time_to_sec(p.TiempoActividad)))  as DESPLAZAMIENTO from horastrabajadas p inner join(select id, codigo from _vehiculos)vh on p.IdVehiculo=vh.id where ('" & FechaInicio & "' <= LEFT((FechaInicio),10) AND LEFT((FechaFin),10) <= '" & FechaFin & "') and vh.codigo ='" & Elementos.Codigo & "'", "DESPLAZAMIENTO")

                    Elementos.HoraG = sPasar_Segundos_a_Horas(Elementos.Gentrac_Mobil)
                    Elementos.HoraGF = sPasar_Segundos_a_Horas(Elementos.Gentrac_MobilFin)

                    Elementos.HoraV = sPasar_Segundos_a_Horas(Elementos.Visitas)
                    Elementos.HoraVN = sPasar_Segundos_a_Horas(Elementos.VisitasNocturno)
                    Elementos.HoraVF = sPasar_Segundos_a_Horas(Elementos.VisitasFinS)

                    Elementos.HoraA = sPasar_Segundos_a_Horas(Elementos.Apagado)
                    Elementos.HoraAN = sPasar_Segundos_a_Horas(Elementos.ApagadoNocturno)
                    Elementos.HoraAF = sPasar_Segundos_a_Horas(Elementos.ApagadoFinS)

                    Elementos.HoraD = sPasar_Segundos_a_Horas(Elementos.Desplazamiento)
                    Elementos.HoraT = sPasar_Segundos_a_Horas(Elementos.Taller)

                    result.Add(Elementos)
                End While
            Catch ex As Exception
                Dim Elementos As New ClassUtilizacionFlota
                Elementos.StrError = ex.Message
                result.Add(Elementos)
            Finally
                conexion.Close()
            End Try
        End Using
        Return result
    End Function

    Shared Function sPasar_Segundos_a_Horas(ByVal lSegundos As Object) As String

        Try
            Dim iMinutos As Integer
            Dim iHoras As Integer
            Dim iSegundos As Integer
            Dim lSegundosHora As Integer = 3600

            iHoras = lSegundos \ lSegundosHora
            iMinutos = (lSegundos Mod lSegundosHora) \ 60
            iSegundos = (lSegundos Mod lSegundosHora) Mod 60

            sPasar_Segundos_a_Horas = iHoras & ":" & _
                                      Format(iMinutos, "00")
            sPasar_Segundos_a_Horas = sPasar_Segundos_a_Horas & ":" & _
                                       Format(iSegundos, "00")

        Catch ex As Exception
            sPasar_Segundos_a_Horas = "00:00:00"
        End Try
    End Function
    Public Class ClassDetalleDesplazamiento
        Public IdVehiculo As Integer
        Public Horainicio As String
        Public HoraFin As String
        Public LugarInicio As String
        Public TotalHoras As String
        Public Distancia As String
        Public FechaInicio As String
        Public MaximaVelocidad As Integer
        Public VelocidadMedia As Integer
    End Class

    <WebMethod(EnableSession:=True)> _
    Public Function DetalleDesplazamiento(ByVal FechaInicio As String, ByVal FechaFin As String, ByVal IdVehiculo As String) As List(Of [ClassDetalleDesplazamiento])
        Dim result As List(Of [ClassDetalleDesplazamiento]) = New List(Of ClassDetalleDesplazamiento)()
        Dim consulta As String
        Using conexion As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
            Try
                conexion.Open()

                'consulta = "SELECT IdVehiculo, LEFT((FechaInicio),10) AS FechaInicio, RIGHT((FechaInicio),8) AS HoraInicio, LEFT((FechaFin),10) AS FehcaFin, RIGHT((FechaFin),8) AS HoraFin, LugarInicio, RIGHT((SEC_TO_TIME( SUM( TIME_TO_SEC(TiempoActividad) ) )),8) AS TotalHoras, MAX(MaximaVelocidad) AS , Distancia, VelocidadMedia FROM horastrabajadas where (FechaInicio between '2014-12-02 17:30:00' and'2014-12-03 17:30:00') and (FechaFin between '2014-12-02 17:30:00' and '2014-12-03 17:30:00') and IdVehiculo = 448 group by LugarInicio "
                consulta = "SELECT IdVehiculo, LEFT((FechaInicio),10) AS FechaInicio, RIGHT((FechaInicio),8) AS HoraInicio, LEFT((FechaFin),10) AS FehcaFin, RIGHT((FechaFin),8) AS HoraFin, LugarInicio,LugarFin, SUM((TIME_TO_SEC(TiempoActividad) DIV 60)) AS TotalHoras, MAX(MaximaVelocidad) AS MaximaVelocidad, SUM(Distancia) AS Distancia , MAX(VelocidadMedia) AS VelocidadMedia FROM horastrabajadas inner join (select id, codigo from _vehiculos)vh on vh.id=IdVehiculo where ('" & FechaInicio & "' <= LEFT((FechaInicio),10) AND LEFT((FechaFin),10) <= '" & FechaFin & "') and vh.codigo ='" & IdVehiculo & "' group by LEFT((FechaInicio),10)"




                Dim cmd As New MySqlCommand(consulta, conexion)
                Dim reader As MySqlDataReader = cmd.ExecuteReader


                While reader.Read
                    Dim elemento As New ClassDetalleDesplazamiento
                    Dim Inicio As String
                    Dim ini1 As String = reader("HoraInicio")
                    Inicio = ini1.Substring(0, 2)
                    Dim Fin As String
                    Dim Fin1 As String = reader("HoraFin")
                    Fin = Fin1.Substring(0, 2)
                    With elemento
                        .IdVehiculo = reader("IdVehiculo")

                        If Not IsDBNull(reader("HoraInicio")) Then
                            .Horainicio = Inicio
                        Else
                            .Horainicio = ""
                        End If
                        If Not IsDBNull(reader("HoraFin")) Then
                            .HoraFin = Fin
                        Else
                            .HoraFin = ""
                        End If
                        If Not IsDBNull(reader("LugarFin")) Then
                            .LugarInicio = reader("LugarFin")
                        Else
                            .LugarInicio = ""
                        End If
                        If Not IsDBNull(reader("TotalHoras")) Then
                            .TotalHoras = reader("TotalHoras")

                        End If
                        If Not IsDBNull(reader("Distancia")) Then
                            .Distancia = reader("Distancia") / 1000
                        Else
                            .Distancia = ""
                        End If
                        If Not IsDBNull(reader("MaximaVelocidad")) Then
                            .MaximaVelocidad = reader("MaximaVelocidad")
                        Else
                            .MaximaVelocidad = 0
                        End If
                        If Not IsDBNull(reader("VelocidadMedia")) Then
                            .VelocidadMedia = reader("VelocidadMedia")
                        Else
                            .VelocidadMedia = 0
                        End If

                        If Not IsDBNull(reader("FechaInicio")) Then
                            .FechaInicio = reader("FechaInicio")
                        Else
                            .FechaInicio = ""
                        End If

                    End With
                    result.Add(elemento)
                End While
            Finally
                conexion.Close()
            End Try
        End Using
        Return result
    End Function

    Public Class ClassUtilizacionFlotaTOTAL
        Public StrError As String = "0"
        Public Departamento As String
        Public GENTRAC As Integer
        Public GENTRAC_MOBILFIN As Integer
        Public VISITAS As Integer
        Public VISITAS_NOCTURNO As Integer
        Public VISITAS_FIN_SEMANA As Integer
        Public APAGADO As Integer
        Public APAGADO_NOCTURNO As Integer
        Public APAGADO_FIN As Integer
        Public TALLER As Integer
        Public DESPLAZAMIENTO As Integer
        Public KILOMETROS As Integer

        Public Gentrac_MobilT As Integer
        Public Gentrac_MobilFinT As Integer
        Public VisitasT As Integer
        Public VisitasNocturnoT As Integer
        Public VisitasFinST As Integer
        Public ApagadoT As Integer
        Public ApagadoNocturnoT As Integer
        Public ApagadoFinST As Integer
        Public DesplazamientoT As Integer



        Public HoraG As String
        Public HoraGF As String
        Public HoraV As String
        Public HoraVN As String
        Public HoraVF As String
        Public HoraA As String
        Public HoraAN As String
        Public HoraAF As String
        Public HoraD As String
        Public HoraT As String
    End Class
    <WebMethod(EnableSession:=True)> _
    Public Function UtilizacionFlotaTOTAL(ByVal FechaInicio As String, ByVal FechaFin As String, ByVal Departamento As Integer) As List(Of [ClassUtilizacionFlotaTOTAL])
        Dim result As List(Of [ClassUtilizacionFlotaTOTAL]) = New List(Of ClassUtilizacionFlotaTOTAL)()
        Dim consulta As String

        Using conexion As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
            Try
                conexion.Open()



                If Departamento <= 0 Then
                    consulta = "select RPAD('TOTAL', 5, p.Ubicacion) as Departamento,(sum(time_to_sec(p.Tiempo)))  as GENTRAC, GMF.GENTRAC_MOBILFIN,V.VISITAS, VN.VISITAS_NOCTURNO,VF.VISITAS_FIN_SEMANA, AP.APAGADO,APN.APAGADO_NOCTURNO,APF.APAGADO_FIN, TA.TALLER, DE.DESPLAZAMIENTO, DE.kilometros  from parada p inner join(select id, departamento,pool from _vehiculos)vh on p.IdVehiculo=vh.id inner join(select (sum(time_to_sec(p.Tiempo)))  as GENTRAC_MOBILFIN from parada p inner join(select id, codigo, departamento,pool from _vehiculos)vh on p.IdVehiculo=vh.id where ('" & FechaInicio & "' <= LEFT((FechaInicio),10) AND LEFT((FechaFin),10) <= '" & FechaFin & "') and (p.Ubicacion LIKE '%gentrac%' or p.Ubicacion LIKE '%MOBIL%') and (WEEKDAY(p.FechaInicio) =5 or WEEKDAY(p.FechaInicio) =6) )GMF inner join (select (sum(time_to_sec(p.Tiempo)))  as VISITAS  from parada p inner join(select id, departamento, pool from _vehiculos)vh on p.IdVehiculo=vh.id where  ('" & FechaInicio & "' <= LEFT((FechaInicio),10) AND LEFT((FechaFin),10) <= '" & FechaFin & "') and p.Ubicacion NOT LIKE '%gentrac%' and p.Ubicacion NOT LIKE '%MOBIL%' and p.Ubicacion NOT LIKE '%c.%' and p.Ubicacion NOT LIKE '%t.%' and p.Segundos < 14400 and (WEEKDAY(p.FechaInicio) !=5 or WEEKDAY(p.FechaInicio) !=6))V inner join (select (sum(time_to_sec(p.Tiempo)))  as VISITAS_NOCTURNO  from parada p inner join(select id, departamento,pool from _vehiculos)vh on p.IdVehiculo=vh.id where ('" & FechaInicio & "' <= LEFT((FechaInicio),10) AND LEFT((FechaFin),10) <= '" & FechaFin & "') and p.Ubicacion NOT LIKE'%gentrac%' and p.Ubicacion NOT LIKE '%MOBIL%' and p.Ubicacion NOT LIKE '%c.%' and p.Ubicacion NOT LIKE '%t.%' and p.Segundos >= 14400 and (WEEKDAY(p.FechaInicio) !=5 or WEEKDAY(p.FechaInicio) !=6))VN inner join (select (sum(time_to_sec(p.Tiempo)))  as VISITAS_FIN_SEMANA  from parada p inner join(select id, departamento ,codigo, pool from _vehiculos)vh on p.IdVehiculo=vh.id where ('" & FechaInicio & "' <= LEFT((FechaInicio),10) AND LEFT((FechaFin),10) <= '" & FechaFin & "') and p.Ubicacion NOT LIKE '%gentrac%' and p.Ubicacion NOT LIKE '%MOBIL%' and p.Ubicacion NOT LIKE '%c.%' and p.Ubicacion NOT LIKE '%t.%' and (WEEKDAY(p.FechaInicio) =5 or WEEKDAY(p.FechaInicio) =6))VF inner join (select (sum(time_to_sec(p.Tiempo)))  as APAGADO from parada p inner join(select id, departamento, pool from _vehiculos)vh on p.IdVehiculo=vh.id where ('" & FechaInicio & "' <= LEFT((FechaInicio),10) AND LEFT((FechaFin),10) <= '" & FechaFin & "') and p.Ubicacion LIKE'%c.%' and p.Segundos < 14400 and (WEEKDAY(p.FechaInicio) !=5 or WEEKDAY(p.FechaInicio) !=6))AP inner join (select (sum(time_to_sec(p.Tiempo)))  as APAGADO_NOCTURNO from parada p inner join(select id, departamento,codigo, pool from _vehiculos)vh on p.IdVehiculo=vh.id where ('" & FechaInicio & "' <= LEFT((FechaInicio),10) AND LEFT((FechaFin),10) <= '" & FechaFin & "') and p.Ubicacion LIKE'%c.%' and p.Segundos >= 14400 and (WEEKDAY(p.FechaInicio) !=5 or WEEKDAY(p.FechaInicio) !=6))APN inner join (select (sum(time_to_sec(p.Tiempo)))  as APAGADO_FIN from parada p inner join(select id, departamento, codigo, pool from _vehiculos)vh on p.IdVehiculo=vh.id where  ('" & FechaInicio & "' <= LEFT((FechaInicio),10) AND LEFT((FechaFin),10) <= '" & FechaFin & "') and p.Ubicacion LIKE'%c.%' and (WEEKDAY(p.FechaInicio) =5 or WEEKDAY(p.FechaInicio) =6))APF inner join (select (sum(time_to_sec(p.Tiempo)))  as TALLER from parada p inner join(select id, codigo, departamento, pool from _vehiculos)vh on p.IdVehiculo=vh.id where ('" & FechaInicio & "' <= LEFT((FechaInicio),10) AND LEFT((FechaFin),10) <= '" & FechaFin & "') and p.Ubicacion LIKE'%t.%')TA inner join (select (sum(time_to_sec(p.TiempoActividad)))  as DESPLAZAMIENTO,(sum(distancia)/1000)as Kilometros from horastrabajadas p inner join(select id, codigo, departamento, pool from _vehiculos)vh on p.IdVehiculo=vh.id where ('" & FechaInicio & "' <= LEFT((FechaInicio),10) AND LEFT((FechaFin),10) <= '" & FechaFin & "'))DE where ('" & FechaInicio & "' <= LEFT((FechaInicio),10) AND LEFT((FechaFin),10) <= '" & FechaFin & "') and (p.Ubicacion LIKE '%gentrac%' or p.Ubicacion LIKE '%MOBIL%') and (WEEKDAY(p.FechaInicio) !=5 or WEEKDAY(p.FechaInicio) !=6);"
                Else
                    consulta = "select RPAD('TOTAL', 5, p.Ubicacion) as Departamento,(sum(time_to_sec(p.Tiempo)))  as GENTRAC, GMF.GENTRAC_MOBILFIN,V.VISITAS, VN.VISITAS_NOCTURNO,VF.VISITAS_FIN_SEMANA, AP.APAGADO,APN.APAGADO_NOCTURNO,APF.APAGADO_FIN, TA.TALLER, DE.DESPLAZAMIENTO, DE.kilometros  from parada p inner join(select id, departamento,pool from _vehiculos)vh on p.IdVehiculo=vh.id inner join(select (sum(time_to_sec(p.Tiempo)))  as GENTRAC_MOBILFIN from parada p inner join(select id, codigo, departamento,pool from _vehiculos)vh on p.IdVehiculo=vh.id where ('" & FechaInicio & "' <= LEFT((FechaInicio),10) AND LEFT((FechaFin),10) <= '" & FechaFin & "') and (p.Ubicacion LIKE '%gentrac%' or p.Ubicacion LIKE '%MOBIL%') and vh.departamento = '" & Departamento & "' and (WEEKDAY(p.FechaInicio) =5 or WEEKDAY(p.FechaInicio) =6) )GMF inner join (select (sum(time_to_sec(p.Tiempo)))  as VISITAS  from parada p inner join(select id, departamento, pool from _vehiculos)vh on p.IdVehiculo=vh.id where ('" & FechaInicio & "' <= LEFT((FechaInicio),10) AND LEFT((FechaFin),10) <= '" & FechaFin & "') and p.Ubicacion NOT LIKE '%gentrac%' and p.Ubicacion NOT LIKE '%MOBIL%' and p.Ubicacion NOT LIKE '%c.%' and p.Ubicacion NOT LIKE '%t.%' and vh.departamento = '" & Departamento & "' and p.Segundos < 14400 and (WEEKDAY(p.FechaInicio) !=5 or WEEKDAY(p.FechaInicio) !=6))V inner join (select (sum(time_to_sec(p.Tiempo)))  as VISITAS_NOCTURNO  from parada p inner join(select id, departamento,pool from _vehiculos)vh on p.IdVehiculo=vh.id where ('" & FechaInicio & "' <= LEFT((FechaInicio),10) AND LEFT((FechaFin),10) <= '" & FechaFin & "') and p.Ubicacion NOT LIKE'%gentrac%' and p.Ubicacion NOT LIKE '%MOBIL%' and p.Ubicacion NOT LIKE '%c.%' and p.Ubicacion NOT LIKE '%t.%' and vh.departamento = '" & Departamento & "' and p.Segundos >= 14400 and (WEEKDAY(p.FechaInicio) !=5 or WEEKDAY(p.FechaInicio) !=6))VN inner join (select (sum(time_to_sec(p.Tiempo)))  as VISITAS_FIN_SEMANA  from parada p inner join(select id, departamento ,codigo, pool from _vehiculos)vh on p.IdVehiculo=vh.id where ('" & FechaInicio & "' <= LEFT((FechaInicio),10) AND LEFT((FechaFin),10) <= '" & FechaFin & "') and p.Ubicacion NOT LIKE '%gentrac%' and p.Ubicacion NOT LIKE '%MOBIL%' and p.Ubicacion NOT LIKE '%c.%' and p.Ubicacion NOT LIKE '%t.%' and vh.departamento = '" & Departamento & "' and (WEEKDAY(p.FechaInicio) =5 or WEEKDAY(p.FechaInicio) =6))VF inner join (select (sum(time_to_sec(p.Tiempo)))  as APAGADO from parada p inner join(select id, departamento, pool from _vehiculos)vh on p.IdVehiculo=vh.id where ('" & FechaInicio & "' <= LEFT((FechaInicio),10) AND LEFT((FechaFin),10) <= '" & FechaFin & "') and p.Ubicacion LIKE'%c.%' and vh.departamento = '" & Departamento & "' and p.Segundos < 14400 and (WEEKDAY(p.FechaInicio) !=5 or WEEKDAY(p.FechaInicio) !=6))AP inner join (select (sum(time_to_sec(p.Tiempo)))  as APAGADO_NOCTURNO from parada p inner join(select id, departamento,codigo, pool from _vehiculos)vh on p.IdVehiculo=vh.id where ('" & FechaInicio & "' <= LEFT((FechaInicio),10) AND LEFT((FechaFin),10) <= '" & FechaFin & "') and p.Ubicacion LIKE'%c.%' and vh.departamento = '" & Departamento & "' and p.Segundos >= 14400 and (WEEKDAY(p.FechaInicio) !=5 or WEEKDAY(p.FechaInicio) !=6))APN inner join (select (sum(time_to_sec(p.Tiempo)))  as APAGADO_FIN from parada p inner join(select id, departamento, codigo, pool from _vehiculos)vh on p.IdVehiculo=vh.id where ('" & FechaInicio & "' <= LEFT((FechaInicio),10) AND LEFT((FechaFin),10) <= '" & FechaFin & "') and p.Ubicacion LIKE'%c.%' and vh.departamento = '" & Departamento & "' and (WEEKDAY(p.FechaInicio) =5 or WEEKDAY(p.FechaInicio) =6))APF inner join (select (sum(time_to_sec(p.Tiempo)))  as TALLER from parada p inner join(select id, codigo, departamento, pool from _vehiculos)vh on p.IdVehiculo=vh.id where ('" & FechaInicio & "' <= LEFT((FechaInicio),10) AND LEFT((FechaFin),10) <= '" & FechaFin & "') and p.Ubicacion LIKE'%t.%' and vh.departamento = '" & Departamento & "')TA inner join (select (sum(time_to_sec(p.TiempoActividad)))  as DESPLAZAMIENTO, (sum(distancia)/1000)as Kilometros from horastrabajadas p inner join(select id, codigo, departamento, pool from _vehiculos)vh on p.IdVehiculo=vh.id where ('" & FechaInicio & "' <= LEFT((FechaInicio),10) AND LEFT((FechaFin),10) <= '" & FechaFin & "') and vh.departamento = '" & Departamento & "')DE where ('" & FechaInicio & "' <= LEFT((FechaInicio),10) AND LEFT((FechaFin),10) <= '" & FechaFin & "') and (p.Ubicacion LIKE '%gentrac%' or p.Ubicacion LIKE '%MOBIL%') and vh.departamento = '" & Departamento & "' and (WEEKDAY(p.FechaInicio) !=5 or WEEKDAY(p.FechaInicio) !=6);"
                End If

                Dim cmd As New MySqlCommand(consulta, conexion)
                Dim reader As MySqlDataReader = cmd.ExecuteReader()
                Dim Elementos1 As New ClassUtilizacionFlotaTOTAL

                While reader.Read


                    Dim Elementos As New ClassUtilizacionFlotaTOTAL
                    If Not IsDBNull(reader("Departamento")) Then
                        Elementos.Departamento = reader("Departamento")
                    Else
                        Elementos.Departamento = ""
                    End If
                    If Not IsDBNull(reader("GENTRAC")) Then
                        Elementos.GENTRAC = reader("GENTRAC")
                    Else
                        Elementos.GENTRAC = 0
                    End If

                    If Not IsDBNull(reader("GENTRAC_MOBILFIN")) Then
                        Elementos.GENTRAC_MOBILFIN = reader("GENTRAC_MOBILFIN")
                    Else
                        Elementos.GENTRAC_MOBILFIN = 0
                    End If
                    If Not IsDBNull(reader("VISITAS")) Then
                        Elementos.VISITAS = reader("VISITAS")
                    Else
                        Elementos.VISITAS = 0
                    End If

                    If Not IsDBNull(reader("VISITAS_NOCTURNO")) Then
                        Elementos.VISITAS_NOCTURNO = reader("VISITAS_NOCTURNO")
                    Else
                        Elementos.VISITAS_NOCTURNO = 0
                    End If

                    If Not IsDBNull(reader("APAGADO")) Then
                        Elementos.APAGADO = reader("APAGADO")
                    Else
                        Elementos.APAGADO = 0
                    End If

                    If Not IsDBNull(reader("VISITAS_FIN_SEMANA")) Then
                        Elementos.VISITAS_FIN_SEMANA = reader("VISITAS_FIN_SEMANA")
                    Else
                        Elementos.VISITAS_FIN_SEMANA = 0
                    End If

                    If Not IsDBNull(reader("APAGADO_NOCTURNO")) Then
                        Elementos.APAGADO_NOCTURNO = reader("APAGADO_NOCTURNO")
                    Else
                        Elementos.APAGADO_NOCTURNO = 0
                    End If

                    If Not IsDBNull(reader("APAGADO_FIN")) Then
                        Elementos.APAGADO_FIN = reader("APAGADO_FIN")
                    Else
                        Elementos.APAGADO_FIN = 0
                    End If

                    If Not IsDBNull(reader("TALLER")) Then
                        Elementos.TALLER = reader("TALLER")
                    Else
                        Elementos.TALLER = 0
                    End If

                    If Not IsDBNull(reader("DESPLAZAMIENTO")) Then
                        Elementos.DESPLAZAMIENTO = reader("DESPLAZAMIENTO")
                    Else
                        Elementos.DESPLAZAMIENTO = 0
                    End If

                    If Not IsDBNull(reader("kilometros")) Then
                        Elementos.KILOMETROS = reader("kilometros")
                    Else
                        Elementos.KILOMETROS = 0
                    End If







                    Elementos.HoraG = sPasar_Segundos_a_Horas(Elementos.GENTRAC)
                    Elementos.HoraGF = sPasar_Segundos_a_Horas(Elementos.GENTRAC_MOBILFIN)

                    Elementos.HoraV = sPasar_Segundos_a_Horas(Elementos.VISITAS)
                    Elementos.HoraVN = sPasar_Segundos_a_Horas(Elementos.VISITAS_NOCTURNO)
                    Elementos.HoraVF = sPasar_Segundos_a_Horas(Elementos.VISITAS_FIN_SEMANA)

                    Elementos.HoraA = sPasar_Segundos_a_Horas(Elementos.APAGADO)
                    Elementos.HoraAN = sPasar_Segundos_a_Horas(Elementos.APAGADO_NOCTURNO)
                    Elementos.HoraAF = sPasar_Segundos_a_Horas(Elementos.APAGADO_FIN)

                    Elementos.HoraD = sPasar_Segundos_a_Horas(Elementos.DESPLAZAMIENTO)
                    Elementos.HoraT = sPasar_Segundos_a_Horas(Elementos.TALLER)





                    result.Add(Elementos)
                End While
            Catch ex As Exception
                Dim Elementos As New ClassUtilizacionFlotaTOTAL
                Elementos.StrError = ex.Message
                result.Add(Elementos)
            Finally
                conexion.Close()
            End Try
        End Using
        Return result
    End Function
    Public Class ClassReporteLlantas
        Public StrError As String = "0"
        Public Vehiculo As String
        Public Desgaste As Integer
        Public desgaste1 As String
        Public desgaste2 As String
        Public desgaste3 As String
        Public desgaste4 As String
        Public desgaste5 As String
        Public desgaste6 As String
        Public desgaste7 As String
        Public desgaste8 As String
        Public desgaste9 As String
        Public desgaste10 As String
        Public desgaste11 As String
        Public desgaste12 As String
        Public desgaste13 As String
        Public desgaste14 As String
        Public desgaste15 As String
        Public desgaste16 As String
        Public desgaste17 As String
        Public desgaste18 As String
        Public desgaste19 As String

        Public desgaster1 As String
        Public desgaster2 As String

        Public llantad1 As String
        Public llantad2 As String
        Public llantad3 As String
        Public llantad4 As String
        Public llantad5 As String
        Public llantad6 As String
        Public llantad7 As String
        Public llantad8 As String
        Public llantad9 As String
        Public llantad10 As String
        Public llantad11 As String
        Public llantad12 As String
        Public llantad13 As String
        Public llantad14 As String
        Public llantad15 As String
        Public llantad16 As String
        Public llantad17 As String
        Public llantad18 As String
        Public llantad19 As String

        Public repuestod1 As String
        Public repuestod2 As String
    End Class

    <WebMethod(EnableSession:=True)> _
    Public Function ReporteLlantas(ByVal Departamento As Integer) As List(Of [ClassReporteLlantas])
        Dim result As List(Of [ClassReporteLlantas]) = New List(Of ClassReporteLlantas)()
        Dim consulta As String
        Using conexion As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
            Try
                conexion.Open()

                If Departamento <= 0 Then
                    consulta = "select veh.codigo, vehll.llanta1,vehll.llanta2, vehll.llanta3, vehll.llanta4, vehll.llanta5, vehll.llanta6, vehll.llanta7, vehll.llanta8, vehll.llanta9, vehll.llanta10, vehll.llanta11, vehll.llanta12, vehll.llanta13, vehll.llanta14, vehll.llanta15, vehll.llanta16, vehll.llanta17, vehll.llanta18, vehll.llanta19, vehll.repuesto1, vehll.repuesto2 from vehiculosll vehll inner join _vehiculos veh ON vehll.id_vehiculo = veh.id where veh.status !=0;"
                Else
                    consulta = "select veh.codigo, vehll.llanta1,vehll.llanta2, vehll.llanta3, vehll.llanta4, vehll.llanta5, vehll.llanta6, vehll.llanta7, vehll.llanta8, vehll.llanta9, vehll.llanta10, vehll.llanta11, vehll.llanta12, vehll.llanta13, vehll.llanta14, vehll.llanta15, vehll.llanta16, vehll.llanta17, vehll.llanta18, vehll.llanta19, vehll.repuesto1, vehll.repuesto2 from vehiculosll vehll inner join _vehiculos veh ON vehll.id_vehiculo= veh.id  where veh.departamento = '" & Departamento & "' and veh.status !=0;"
                End If
                Dim cmd As New MySqlCommand(consulta, conexion)
                Dim reader As MySqlDataReader = cmd.ExecuteReader()
                While reader.Read
                    Dim Elementos As New ClassReporteLlantas
                    Elementos.Vehiculo = reader("codigo")
                    Elementos.llantad1 = reader("llanta1")
                    Elementos.desgaste1 = MyDB.MySelectOneParameter("select desgaste from inventarioll where Id = " & Elementos.llantad1, "desgaste")
                    Elementos.llantad2 = reader("llanta2")
                    Elementos.desgaste2 = MyDB.MySelectOneParameter("select desgaste from inventarioll where Id = " & Elementos.llantad2, "desgaste")
                    Elementos.llantad3 = reader("llanta3")
                    Elementos.desgaste3 = MyDB.MySelectOneParameter("select desgaste from inventarioll where Id = " & Elementos.llantad3, "desgaste")
                    Elementos.llantad4 = reader("llanta4")
                    Elementos.desgaste4 = MyDB.MySelectOneParameter("select desgaste from inventarioll where Id = " & Elementos.llantad4, "desgaste")
                    Elementos.llantad5 = reader("llanta5")
                    Elementos.desgaste5 = MyDB.MySelectOneParameter("select desgaste from inventarioll where Id = " & Elementos.llantad5, "desgaste")
                    Elementos.llantad6 = reader("llanta6")
                    Elementos.desgaste6 = MyDB.MySelectOneParameter("select desgaste from inventarioll where Id = " & Elementos.llantad6, "desgaste")
                    Elementos.llantad7 = reader("llanta7")
                    Elementos.desgaste7 = MyDB.MySelectOneParameter("select desgaste from inventarioll where Id = " & Elementos.llantad7, "desgaste")
                    Elementos.llantad8 = reader("llanta8")
                    Elementos.desgaste8 = MyDB.MySelectOneParameter("select desgaste from inventarioll where Id = " & Elementos.llantad8, "desgaste")
                    Elementos.llantad9 = reader("llanta9")
                    Elementos.desgaste9 = MyDB.MySelectOneParameter("select desgaste from inventarioll where Id = " & Elementos.llantad9, "desgaste")
                    Elementos.llantad10 = reader("llanta10")
                    Elementos.desgaste10 = MyDB.MySelectOneParameter("select desgaste from inventarioll where Id = " & Elementos.llantad10, "desgaste")
                    Elementos.llantad11 = reader("llanta11")
                    Elementos.desgaste11 = MyDB.MySelectOneParameter("select desgaste from inventarioll where Id = " & Elementos.llantad11, "desgaste")
                    Elementos.llantad12 = reader("llanta12")
                    Elementos.desgaste12 = MyDB.MySelectOneParameter("select desgaste from inventarioll where Id = " & Elementos.llantad12, "desgaste")
                    Elementos.llantad13 = reader("llanta13")
                    Elementos.desgaste13 = MyDB.MySelectOneParameter("select desgaste from inventarioll where Id = " & Elementos.llantad13, "desgaste")
                    Elementos.llantad14 = reader("llanta14")
                    Elementos.desgaste14 = MyDB.MySelectOneParameter("select desgaste from inventarioll where Id = " & Elementos.llantad14, "desgaste")
                    Elementos.llantad15 = reader("llanta15")
                    Elementos.desgaste15 = MyDB.MySelectOneParameter("select desgaste from inventarioll where Id = " & Elementos.llantad15, "desgaste")
                    Elementos.llantad16 = reader("llanta16")
                    Elementos.desgaste16 = MyDB.MySelectOneParameter("select desgaste from inventarioll where Id = " & Elementos.llantad16, "desgaste")
                    Elementos.llantad17 = reader("llanta17")
                    Elementos.desgaste17 = MyDB.MySelectOneParameter("select desgaste from inventarioll where Id = " & Elementos.llantad17, "desgaste")
                    Elementos.llantad18 = reader("llanta18")
                    Elementos.desgaste18 = MyDB.MySelectOneParameter("select desgaste from inventarioll where Id = " & Elementos.llantad18, "desgaste")
                    Elementos.llantad19 = reader("llanta19")
                    Elementos.desgaste19 = MyDB.MySelectOneParameter("select desgaste from inventarioll where Id = " & Elementos.llantad19, "desgaste")


                    Elementos.repuestod1 = reader("repuesto1")
                    Elementos.desgaster1 = MyDB.MySelectOneParameter("select desgaste from inventarioll where Id = " & reader("repuesto1"), "desgaste")


                    Elementos.repuestod2 = reader("repuesto2")
                    Elementos.desgaster2 = MyDB.MySelectOneParameter("select desgaste from inventarioll where Id = " & reader("repuesto2"), "desgaste")

                    result.Add(Elementos)
                End While
            Catch ex As Exception
                Dim Elementos As New ClassReporteLlantas
                Elementos.StrError = ex.Message
                result.Add(Elementos)
            Finally
                conexion.Close()
            End Try
        End Using
        Return result
    End Function
    Public Class ClassResumenTotalLlantas
        Public StrError As String = "0"
        Public marca As String
        Public total As String
        Public codigo As String
        Public Totalll As String
        Public Porcent As String
        Public kilometraje As String
        Public Desgastado As String
        Public Rentreinta As String
        Public Precio As String
        Public Costoxkilometro As String
        Public color As String
    End Class
    <WebMethod(EnableSession:=True)> _
    Public Function ResumenTotalLlantas(ByVal Departamento As String) As List(Of [ClassResumenTotalLlantas])
        Dim result As List(Of [ClassResumenTotalLlantas]) = New List(Of ClassResumenTotalLlantas)()
        Dim consulta As String
        Using conexion As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
            Try
                conexion.Open()
                If Departamento = 0 Then
                    consulta = "select ma.dmarca as marca, Count(ip.pmarca) AS total , ip.pmarca,sum(ll.kmi) as kmi from inventarioll ll inner join (select codigo, pmarca from inventario)ip on ip.codigo = ll.idcodigo inner join (select Id, dmarca from marcas) ma on ip.pmarca=ma.id where ll.estadoa != 5 group by ip.pmarca order by Count(ip.pmarca) desc ;"
                Else
                    consulta = "select ma.dmarca as marca, Count(ip.pmarca) AS total , ip.pmarca,sum(ll.kmi) as kmi from inventarioll ll inner join (select codigo, pmarca from inventario)ip on ip.codigo = ll.idcodigo inner join (select Id, dmarca from marcas) ma on ip.pmarca=ma.id  inner join _vehiculos vh on vh.id=ll.vehiculo where ll.estadoa != 5 and vh.departamento= " & Departamento & " group by ip.pmarca order by Count(ip.pmarca) desc;"

                End If
                Dim cmd As New MySqlCommand(consulta, conexion)
                Dim reader As MySqlDataReader = cmd.ExecuteReader()
                While reader.Read
                    Dim Elementos As New ClassResumenTotalLlantas
                    If Not IsDBNull(reader("marca")) Then
                        Elementos.marca = reader("marca")
                    Else
                        Elementos.marca = ""
                    End If
                    If Not IsDBNull(reader("total")) Then
                        Elementos.total = reader("total")
                    Else
                        Elementos.total = 0
                    End If
                    If Not IsDBNull(reader("pmarca")) Then
                        Elementos.codigo = reader("pmarca")
                    Else
                        Elementos.codigo = 0
                    End If
                    If Departamento = 0 Then
                        Elementos.Totalll = Convert.ToDouble(MyDB.MySelectOneParameter("Select Count(ip.pmarca) AS total from inventarioll ll inner join (select codigo, pmarca from inventario)ip on ip.codigo = ll.idcodigo inner join (select Id, dmarca from marcas) ma on ip.pmarca=ma.id where ll.estadoa != 5 ", "total"))
                    Else
                        Elementos.Totalll = Convert.ToDouble(MyDB.MySelectOneParameter("Select Count(ip.pmarca) AS total from inventarioll ll inner join (select codigo, pmarca from inventario)ip on ip.codigo = ll.idcodigo inner join (select Id, dmarca from marcas) ma on ip.pmarca=ma.id inner join _vehiculos vh on vh.id=ll.vehiculo where ll.estadoa != 5 ", "total"))

                    End If
                    If Not IsDBNull(reader("kmi")) Then
                        Elementos.kilometraje = Format((reader("kmi")), "##,##0.00")
                    Else
                        Elementos.kilometraje = 0
                    End If
                    If Departamento = 0 Then
                        Elementos.Desgastado = MyDB.MySelectOneParameter("Select ma.dmarca, sum(Treintaidosavosini) as Treinta from inventarioll ll inner join (select codigo, pmarca from inventario)ip on ip.codigo = ll.idcodigo inner join (select Id, dmarca from marcas) ma on ip.pmarca=ma.id where kmi !=0 and ma.dmarca='" & Elementos.marca & "' group by ma.dmarca", "Treinta")

                    Else
                        Elementos.Desgastado = MyDB.MySelectOneParameter("Select ma.dmarca, sum(Treintaidosavosini) as Treinta from inventarioll ll inner join (select codigo, pmarca from inventario)ip on ip.codigo = ll.idcodigo inner join (select Id, dmarca from marcas) ma on ip.pmarca=ma.id inner join _vehiculos vh on vh.id=ll.vehiculo where kmi !=0 and ma.dmarca='" & Elementos.marca & "' and vh.departamento= " & Departamento & "  group by ma.dmarca", "Treinta")

                    End If

                    If Departamento = 0 Then
                        Elementos.Precio = MyDB.MySelectOneParameter("Select ma.dmarca, sum(precio) as Treinta from inventarioll ll inner join (select codigo, pmarca from inventario)ip on ip.codigo = ll.idcodigo inner join (select Id, dmarca from marcas) ma on ip.pmarca=ma.id where kmi !=0 and ma.dmarca='" & Elementos.marca & "' group by ma.dmarca", "Treinta")

                    Else
                        Elementos.Precio = MyDB.MySelectOneParameter("Select ma.dmarca, sum(precio) as Treinta from inventarioll ll inner join (select codigo, pmarca from inventario)ip on ip.codigo = ll.idcodigo inner join (select Id, dmarca from marcas) ma on ip.pmarca=ma.id inner join _vehiculos vh on vh.id=ll.vehiculo where kmi !=0 and ma.dmarca='" & Elementos.marca & "' and vh.departamento= " & Departamento & "  group by ma.dmarca", "Treinta")

                    End If


                    Elementos.Costoxkilometro = Format((Elementos.Precio / Elementos.kilometraje), "##,##0.00")

                    If Elementos.kilometraje = 0 Or Elementos.Desgastado = 0 Then
                        Elementos.Rentreinta = 0
                    Else
                        Elementos.Rentreinta = Convert.ToDouble(Format((Elementos.kilometraje / Elementos.Desgastado), "##,##0.00"))
                    End If


                    Elementos.Porcent = Format(((reader("total") * 100) / Elementos.Totalll), "##,##0.00")
                    result.Add(Elementos)
                End While
            Catch ex As Exception
                Dim Elementos As New ClassResumenTotalLlantas
                Elementos.StrError = ex.Message
                result.Add(Elementos)
            Finally
                conexion.Close()
            End Try
        End Using
        Return result
    End Function
   

    Public Class ClassResumenDesgaste
        Public StrError As String = "0"
        Public MalEstado As Integer
        Public BuenEstado As Integer
        Public RegularEstado As Integer
        Public EstadoLLantas As String
        

    End Class
    <WebMethod(EnableSession:=True)> _
    Public Function ResumenDesgaste(ByVal Departamento As String) As List(Of [ClassResumenDesgaste])
        Dim result As List(Of [ClassResumenDesgaste]) = New List(Of ClassResumenDesgaste)()
        Dim consulta As String

        Using conexion As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
            Try
                conexion.Open()
                'consulta = "select (@Estado:='Mal Estado') as estado, sum(if (desgaste in (0,1,2,3,4),1,0)) as total from inventarioll where estadoa !=5 union  select (@Estado:='En estado Regular') as estado, sum(if (desgaste in (5,6,7),1,0)) as total from inventarioll where estadoa !=5 union  select (@Estado:='Llantas en buen estado') as estado, sum(if (desgaste in (8,9,10,11,12,13,14,15,16,27),1,0)) as total from inventarioll where estadoa !=5;"
                If Departamento = 0 Then
                    consulta = "select RPAD('EstadoLLanntas', 14, idcodigo) as Estado,sum(if (desgaste in (0,1,2,3,4),1,0)) as MalEstado ,RE.RegularEstado,BE.BuenEstado from inventarioll inner join (select  sum(if (desgaste in (5,6,7),1,0)) as RegularEstado  from inventarioll where estadoa !=5)RE inner join (select sum(if (desgaste in (8,9,10,11,12,13,14,15,16,27),1,0)) BuenEstado from inventarioll where estadoa !=5)BE inner join _vehiculos vh on vh.id=vehiculo where estadoa !=5;"

                Else
                    consulta = "select RPAD('EstadoLLanntas', 14, idcodigo) as Estado,sum(if (desgaste in (0,1,2,3,4),1,0)) as MalEstado ,RE.RegularEstado,BE.BuenEstado from inventarioll inner join (select  sum(if (desgaste in (5,6,7),1,0)) as RegularEstado  from inventarioll inner join _vehiculos vh on vh.id=vehiculo where estadoa !=5 and vh.departamento= " & Departamento & ")RE inner join (select sum(if (desgaste in (8,9,10,11,12,13,14,15,16,27),1,0)) BuenEstado from inventarioll inner join _vehiculos vh on vh.id=vehiculo where estadoa !=5 and vh.departamento= " & Departamento & ")BE inner join _vehiculos vh on vh.id=vehiculo where estadoa !=5 and vh.departamento= " & Departamento & ";"

                End If

                Dim cmd As New MySqlCommand(consulta, conexion)
                Dim reader As MySqlDataReader = cmd.ExecuteReader()
                While reader.Read

                    'Vehiculo es de un campo combinado solo son el primer dato de los campos vehiculo,Id y Idbodega
                    Dim Elementos As New ClassResumenDesgaste
                    Elementos.MalEstado = reader("MalEstado")
                    Elementos.RegularEstado = reader("RegularEstado")
                    Elementos.BuenEstado = reader("BuenEstado")
                    Elementos.EstadoLLantas = reader("Estado")

                    result.Add(Elementos)
                End While
            Catch ex As Exception
                Dim Elementos As New ClassResumenDesgaste
                Elementos.StrError = ex.Message
                result.Add(Elementos)
            Finally
                conexion.Close()
            End Try
        End Using
        Return result
    End Function
    Public Class ClassDetalleLlantasTotal
        Public StrError As String = "0"
        Public idllanta As String
        Public cantidad As String
        Public codigos As String
        Public marca As String
        Public Totalll As String
        Public Porcent As String
        Public kilometraje As String
        Public Desgastado As String
        Public Rentreinta As String
        Public Precio As String
        Public Costoxkilometro As String

    End Class
    <WebMethod(EnableSession:=True)> _
    Public Function DetalleLlantasTotal(ByVal codigollanta As String, ByVal Departamento As String) As List(Of [ClassDetalleLlantasTotal])
        Dim result As List(Of [ClassDetalleLlantasTotal]) = New List(Of ClassDetalleLlantasTotal)()
        Dim consulta As String

        Using conexion As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
            Try
                conexion.Open()

                If Departamento = 0 Then
                    consulta = "select ma.dmarca as marca,ll.idcodigo, count(ll.idcodigo) as cantidad, ip.pmarca,sum(ll.kmi) as kmi  from inventarioll ll inner join (select codigo, pmarca from inventario)ip on ip.codigo = ll.idcodigo inner join (select Id, dmarca from marcas) ma on ip.pmarca=ma.id where ll.estadoa != 5 and ip.pmarca ='" & codigollanta & "'  group by ll.idcodigo ;"

                Else
                    consulta = "select ma.dmarca as marca,ll.idcodigo, count(ll.idcodigo) as cantidad, ip.pmarca,sum(ll.kmi) as kmi  from inventarioll ll inner join (select codigo, pmarca from inventario)ip on ip.codigo = ll.idcodigo inner join (select Id, dmarca from marcas) ma on ip.pmarca=ma.id inner join _vehiculos vh on vh.id=ll.vehiculo where ll.estadoa != 5 and ip.pmarca ='" & codigollanta & "' and vh.departamento= " & Departamento & "  group by ll.idcodigo ;"

                End If

                Dim cmd As New MySqlCommand(consulta, conexion)
                Dim reader As MySqlDataReader = cmd.ExecuteReader()
                While reader.Read

                    

                    Dim Elementos As New ClassDetalleLlantasTotal
                    If Not IsDBNull(reader("marca")) Then
                        Elementos.marca = reader("marca")
                    Else
                        Elementos.marca = ""
                    End If
                    If Not IsDBNull(reader("idcodigo")) Then
                        Elementos.idllanta = reader("idcodigo")
                    Else
                        Elementos.idllanta = ""
                    End If
                    If Not IsDBNull(reader("cantidad")) Then
                        Elementos.cantidad = reader("cantidad")
                    Else
                        Elementos.cantidad = ""
                    End If
                    If Not IsDBNull(reader("pmarca")) Then
                        Elementos.codigos = reader("pmarca")
                    Else
                        Elementos.codigos = ""
                    End If

                    If Departamento = 0 Then
                        Elementos.Totalll = Convert.ToDouble(MyDB.MySelectOneParameter("select count(ll.idcodigo) as total from inventarioll ll inner join (select codigo, pmarca from inventario)ip on ip.codigo = ll.idcodigo inner join (select Id, dmarca from marcas) ma on ip.pmarca=ma.id where ll.estadoa != 5 and ip.pmarca ='" & codigollanta & "'  ;", "total"))
                    Else
                        Elementos.Totalll = Convert.ToDouble(MyDB.MySelectOneParameter("select count(ll.idcodigo) as total from inventarioll ll inner join (select codigo, pmarca from inventario)ip on ip.codigo = ll.idcodigo inner join (select Id, dmarca from marcas) ma on ip.pmarca=ma.id inner join _vehiculos vh on vh.id=ll.vehiculo where ll.estadoa != 5 and ip.pmarca ='" & codigollanta & "' and vh.departamento= " & Departamento & "", "total"))

                    End If



                    If Not IsDBNull(reader("kmi")) Then
                        Elementos.kilometraje = Format((reader("kmi")), "##,##0.00")
                    Else
                        Elementos.kilometraje = 0
                    End If
                    If Departamento = 0 Then
                        Elementos.Desgastado = MyDB.MySelectOneParameter("Select ma.dmarca, sum(Treintaidosavosini) as Treinta from inventarioll ll inner join (select codigo, pmarca from inventario)ip on ip.codigo = ll.idcodigo inner join (select Id, dmarca from marcas) ma on ip.pmarca=ma.id where kmi !=0 and ma.dmarca='" & Elementos.marca & "' and ip.codigo ='" & Elementos.idllanta & "' group by ip.codigo", "Treinta")

                    Else
                        Elementos.Desgastado = MyDB.MySelectOneParameter("Select ma.dmarca, sum(Treintaidosavosini) as Treinta from inventarioll ll inner join (select codigo, pmarca from inventario)ip on ip.codigo = ll.idcodigo inner join (select Id, dmarca from marcas) ma on ip.pmarca=ma.id inner join _vehiculos vh on vh.id=ll.vehiculo where kmi !=0 and ma.dmarca='" & Elementos.marca & "' and vh.departamento= " & Departamento & " and ip.codigo ='" & Elementos.idllanta & "' group by ip.codigo", "Treinta")

                    End If

                    If Departamento = 0 Then
                        Elementos.Precio = MyDB.MySelectOneParameter("Select ma.dmarca, sum(precio) as Treinta from inventarioll ll inner join (select codigo, pmarca from inventario)ip on ip.codigo = ll.idcodigo inner join (select Id, dmarca from marcas) ma on ip.pmarca=ma.id where kmi !=0 and ma.dmarca='" & Elementos.marca & "' and ip.codigo ='" & Elementos.idllanta & "' group by ip.codigo", "Treinta")

                    Else
                        Elementos.Precio = MyDB.MySelectOneParameter("Select ma.dmarca, sum(precio) as Treinta from inventarioll ll inner join (select codigo, pmarca from inventario)ip on ip.codigo = ll.idcodigo inner join (select Id, dmarca from marcas) ma on ip.pmarca=ma.id inner join _vehiculos vh on vh.id=ll.vehiculo where kmi !=0 and ma.dmarca='" & Elementos.marca & "' and vh.departamento= " & Departamento & " and ip.codigo ='" & Elementos.idllanta & "' group by ip.codigo", "Treinta")

                    End If


                    Elementos.Costoxkilometro = Format((Elementos.Precio / Elementos.kilometraje), "##,##0.00")

                    If Elementos.kilometraje = 0 Or Elementos.Desgastado = 0 Then
                        Elementos.Rentreinta = 0
                    Else
                        Elementos.Rentreinta = Convert.ToDouble(Format((Elementos.kilometraje / Elementos.Desgastado), "##,##0.00"))
                    End If



                    Elementos.Porcent = Format(((reader("cantidad") * 100) / Elementos.Totalll), "##,##0.00")
                    result.Add(Elementos)
                End While
            Catch ex As Exception
                Dim Elementos As New ClassDetalleLlantasTotal
                Elementos.StrError = ex.Message
                result.Add(Elementos)
            Finally
                conexion.Close()
            End Try
        End Using
        Return result
    End Function


    Public Class ClassDetalleLlantasUnidad
        Public StrError As String = "0"
        Public idllanta As String
        Public cantidad As String
        Public codigos As String
        Public marca As String
        Public Totalll As String
        Public Porcent As String
        Public kilometraje As String
        Public Desgastado As String
        Public Rentreinta As String
        Public Precio As String
        Public Costoxkilometro As String
        Public Vehiculo As String

    End Class
    <WebMethod(EnableSession:=True)> _
    Public Function DetalleLlantasUnidad(ByVal codigollanta As String, ByVal Departamento As String) As List(Of ClassDetalleLlantasUnidad)
        Dim result As List(Of [ClassDetalleLlantasUnidad]) = New List(Of ClassDetalleLlantasUnidad)()
        Dim consulta As String

        Using conexion As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
            Try
                conexion.Open()

                If Departamento = 0 Then
                    consulta = "select vh.codigo as vehiculo, ma.dmarca as marca,ll.idcodigo, count(ll.idcodigo) as cantidad, ip.pmarca,sum(ll.kmi) as kmi  from inventarioll ll inner join (select codigo, pmarca from inventario)ip on ip.codigo = ll.idcodigo inner join (select Id, dmarca from marcas) ma on ip.pmarca=ma.id inner join _vehiculos vh on vh.id=ll.vehiculo where ll.estadoa != 5 and ll.idcodigo ='" & codigollanta & "' group by vh.codigo ;"

                Else
                    consulta = "select ma.dmarca as marca,ll.idcodigo, count(ll.idcodigo) as cantidad, ip.pmarca,sum(ll.kmi) as kmi  from inventarioll ll inner join (select codigo, pmarca from inventario)ip on ip.codigo = ll.idcodigo inner join (select Id, dmarca from marcas) ma on ip.pmarca=ma.id inner join _vehiculos vh on vh.id=ll.vehiculo inner join _vehiculos vh on vh.id=ll.vehiculo where ll.estadoa != 5 and ll.idcodigo ='" & codigollanta & "' and vh.departamento= " & Departamento & " group by vh.codigo;"

                End If

                Dim cmd As New MySqlCommand(consulta, conexion)
                Dim reader As MySqlDataReader = cmd.ExecuteReader()
                While reader.Read



                    Dim Elementos As New ClassDetalleLlantasUnidad

                    If Not IsDBNull(reader("vehiculo")) Then
                        Elementos.Vehiculo = reader("vehiculo")
                    Else
                        Elementos.Vehiculo = ""
                    End If
                    If Not IsDBNull(reader("marca")) Then
                        Elementos.marca = reader("marca")
                    Else
                        Elementos.marca = ""
                    End If
                    If Not IsDBNull(reader("idcodigo")) Then
                        Elementos.idllanta = reader("idcodigo")
                    Else
                        Elementos.idllanta = ""
                    End If
                    If Not IsDBNull(reader("cantidad")) Then
                        Elementos.cantidad = reader("cantidad")
                    Else
                        Elementos.cantidad = ""
                    End If
                    If Not IsDBNull(reader("pmarca")) Then
                        Elementos.codigos = reader("pmarca")
                    Else
                        Elementos.codigos = ""
                    End If

                    If Departamento = 0 Then
                        Elementos.Totalll = Convert.ToDouble(MyDB.MySelectOneParameter("select count(ll.idcodigo) as total from inventarioll ll inner join (select codigo, pmarca from inventario)ip on ip.codigo = ll.idcodigo inner join (select Id, dmarca from marcas) ma on ip.pmarca=ma.id inner join _vehiculos vh on vh.id=ll.vehiculo where ll.estadoa != 5 and ip.codigo='" & Elementos.idllanta & "';", "total"))
                    Else
                        Elementos.Totalll = Convert.ToDouble(MyDB.MySelectOneParameter("select count(ll.idcodigo) as total from inventarioll ll inner join (select codigo, pmarca from inventario)ip on ip.codigo = ll.idcodigo inner join (select Id, dmarca from marcas) ma on ip.pmarca=ma.id inner join _vehiculos vh on vh.id=ll.vehiculo inner join _vehiculos vh on vh.id=ll.vehiculo where ll.estadoa != 5 and ll.idcodigo ='" & codigollanta & "' and vh.departamento= " & Departamento & "", "total"))

                    End If



                    If Not IsDBNull(reader("kmi")) Then
                        Elementos.kilometraje = Format((reader("kmi")), "##,##0.00")
                    Else
                        Elementos.kilometraje = 0
                    End If
                    If Departamento = 0 Then

                        Elementos.Desgastado = MyDB.MySelectOneParameter("Select ip.codigo, vh.codigo,ma.dmarca, sum(Treintaidosavosini) as Treinta from inventarioll ll inner join (select codigo, pmarca from inventario)ip on ip.codigo = ll.idcodigo inner join (select Id, dmarca from marcas) ma on ip.pmarca=ma.id inner join _vehiculos vh on vh.id=ll.vehiculo where kmi !=0 and ip.codigo='" & Elementos.idllanta & "' and vh.codigo='" & Elementos.Vehiculo & "' group by vh.codigo", "Treinta")

                        'Elementos.Desgastado = MyDB.MySelectOneParameter("Select ma.dmarca, sum(Treintaidosavosini) as Treinta from inventarioll ll inner join (select codigo, pmarca from inventario)ip on ip.codigo = ll.idcodigo inner join (select Id, dmarca from marcas) ma on ip.pmarca=ma.id inner join _vehiculos vh on vh.id=ll.vehiculo where kmi !=0 and ip.codigo ='" & Elementos.idllanta & "' group by vh.codigo", "Treinta")

                    Else
                        Elementos.Desgastado = MyDB.MySelectOneParameter("Select ma.dmarca, sum(Treintaidosavosini) as Treinta from inventarioll ll inner join (select codigo, pmarca from inventario)ip on ip.codigo = ll.idcodigo inner join (select Id, dmarca from marcas) ma on ip.pmarca=ma.id inner join _vehiculos vh on vh.id=ll.vehiculo inner join _vehiculos vh on vh.id=ll.vehiculo where kmi !=0  and vh.departamento= " & Departamento & " and ip.codigo ='" & Elementos.idllanta & "' group by vh.codigo", "Treinta")

                    End If

                    If Departamento = 0 Then
                        Elementos.Precio = MyDB.MySelectOneParameter("Select ma.dmarca, sum(precio) as Treinta from inventarioll ll inner join (select codigo, pmarca from inventario)ip on ip.codigo = ll.idcodigo inner join (select Id, dmarca from marcas) ma on ip.pmarca=ma.id inner join _vehiculos vh on vh.id=ll.vehiculo where kmi !=0 and ip.codigo='" & Elementos.idllanta & "' and vh.codigo='" & Elementos.Vehiculo & "' group by vh.codigo", "Treinta")

                    Else
                        Elementos.Precio = MyDB.MySelectOneParameter("Select ma.dmarca, sum(precio) as Treinta from inventarioll ll inner join (select codigo, pmarca from inventario)ip on ip.codigo = ll.idcodigo inner join (select Id, dmarca from marcas) ma on ip.pmarca=ma.id inner join _vehiculos vh on vh.id=ll.vehiculo where kmi !=0 and vh.departamento= " & Departamento & " and ip.codigo='" & Elementos.idllanta & "' and vh.codigo='" & Elementos.Vehiculo & "'  group by vh.codigo", "Treinta")

                    End If


                    Elementos.Costoxkilometro = Format((Elementos.Precio / Elementos.kilometraje), "##,##0.00")

                    If Elementos.kilometraje = 0 Or Elementos.Desgastado = 0 Then
                        Elementos.Rentreinta = 0
                    Else
                        Elementos.Rentreinta = Convert.ToDouble(Format((Elementos.kilometraje / Elementos.Desgastado), "##,##0.00"))
                    End If



                    Elementos.Porcent = Format(((reader("cantidad") * 100) / Elementos.Totalll), "##,##0.00")
                    result.Add(Elementos)
                End While
            Catch ex As Exception
                Dim Elementos As New ClassDetalleLlantasUnidad
                Elementos.StrError = ex.Message
                result.Add(Elementos)
            Finally
                conexion.Close()
            End Try
        End Using
        Return result
    End Function

    Public Class ClassDetalleLlantasMovimientos
        Public StrError As String = "0"
        Public codigo As String
        Public movimiento As String

        Public kmia As String
        Public fecha As String
        Public motivo As String
        Public encargado As String
        Public observaciones As String

    End Class
    <WebMethod(EnableSession:=True)> _
    Public Function DetalleLlantasMovimientos(ByVal idLlanta As String) As List(Of [ClassDetalleLlantasMovimientos])
        Dim result As List(Of [ClassDetalleLlantasMovimientos]) = New List(Of ClassDetalleLlantasMovimientos)()
        Dim consulta As String

        Using conexion As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
            Try
                conexion.Open()
                consulta = "select (select codigo from _vehiculos where id=id_vehiculo) codigo, movimiento, kmia, date(fecha) fecha, motivo, encargado, observaciones from bitacorall where idllanta ='" & idLlanta & "' order by date(fecha) desc limit 10 "

                Dim cmd As New MySqlCommand(consulta, conexion)
                Dim reader As MySqlDataReader = cmd.ExecuteReader()
                While reader.Read


                    Dim Elementos As New ClassDetalleLlantasMovimientos
                    If Not IsDBNull(reader("codigo")) Then
                        Elementos.codigo = reader("codigo")
                    Else
                        Elementos.codigo = 0
                    End If
                    If Not IsDBNull(reader("movimiento")) Then
                        Elementos.movimiento = reader("movimiento")
                    Else
                        Elementos.movimiento = ""
                    End If
                    If Not IsDBNull(reader("kmia")) Then
                        Elementos.kmia = reader("kmia")
                    Else
                        Elementos.kmia = ""
                    End If

                    If Not IsDBNull(reader("fecha")) Then
                        Elementos.fecha = reader("fecha")
                    Else
                        Elementos.fecha = ""
                    End If
                    If Not IsDBNull(reader("motivo")) Then
                        Elementos.motivo = reader("motivo")
                    Else
                        Elementos.motivo = ""
                    End If
                    If Not IsDBNull(reader("encargado")) Then
                        Elementos.encargado = reader("encargado")
                    Else
                        Elementos.encargado = ""
                    End If
                    If Not IsDBNull(reader("observaciones")) Then
                        Elementos.observaciones = reader("observaciones")
                    Else
                        Elementos.observaciones = ""
                    End If
                    result.Add(Elementos)
                End While
            Catch ex As Exception
                Dim Elementos As New ClassDetalleLlantasMovimientos
                Elementos.StrError = ex.Message
                result.Add(Elementos)
            Finally
                conexion.Close()
            End Try
        End Using
        Return result
    End Function

    Public Class ClassDetalleLlantasGenerales
        Public StrError As String = "0"
        Public idcodigo As String
        Public desgaste As String
        Public fecha As String
        Public kilometraje As String
        Public id As Integer
        Public precio As String
        Public renkp As String
        Public kmtXT As String
        Public desgasteant As String
        Public RendXtreinta As String
        Public desgastado As String
     
    End Class
    <WebMethod(EnableSession:=True)> _
    Public Function DetalleLlantasGenerales(ByVal idLlanta As String) As List(Of [ClassDetalleLlantasGenerales])
        Dim result As List(Of [ClassDetalleLlantasGenerales]) = New List(Of ClassDetalleLlantasGenerales)()
        Dim consulta As String
        Dim fecha1 As String
        Dim fecha2 As String
        Using conexion As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
            Try
                conexion.Open()
                If idLlanta = 0 Then
                    consulta = "select id, idcodigo, desgaste,  DATE_FORMAT(DATE(fecha),'%Y-%m-%d') as fecha, ROUND(precio,2) as precio from inventarioll; "
                Else
                    consulta = "select id, idcodigo, desgaste,  DATE_FORMAT(DATE(fecha),'%Y-%m-%d') as fecha, ROUND(precio,2) as precio from inventarioll where id = '" & idLlanta & "'; "

                End If

                Dim cmd As New MySqlCommand(consulta, conexion)
                Dim reader As MySqlDataReader = cmd.ExecuteReader()
                While reader.Read


                    Dim Elementos As New ClassDetalleLlantasGenerales
                    If Not IsDBNull(reader("idcodigo")) Then
                        Elementos.idcodigo = reader("idcodigo")
                    Else
                        Elementos.idcodigo = ""
                    End If
                    If Not IsDBNull(reader("desgaste")) Then
                        Elementos.desgaste = reader("desgaste")
                    Else
                        Elementos.desgaste = ""
                    End If

                    If Not IsDBNull(reader("id")) Then
                        Elementos.id = reader("id")
                    Else
                        Elementos.id = 0
                    End If
                    Elementos.desgasteant = MyDB.MySelectOneParameter("SELECT idllanta,DesgasteActual,max(fecha) FROM dbtransgentrac.bitacorall where movimiento = 'Ingreso a Inventario Nueva' and idllanta=" & Elementos.id & ";", "DesgasteActual")

                    If Elementos.desgasteant = 0 Then
                        Elementos.desgasteant = 14
                    End If



                    fecha1 = MyDB.MySelectOneParameter("select DATE_FORMAT(DATE(fecha),'%Y-%m-%d') as fecha from bitacorall where tipo = 1 and idllanta =" & Elementos.id, "fecha")
                    fecha2 = MyDB.MySelectOneParameter("select DATE_FORMAT(DATE(fecha),'%Y-%m-%d') as fecha from bitacorall where movimiento like '%Precarga%' and idllanta =" & Elementos.id, "fecha")
                    If Not (IsDBNull(fecha1) Or fecha1 = "0") Then
                        Elementos.fecha = fecha1

                    Else

                        If Not (IsDBNull(fecha2) Or fecha2 = "0") Then
                            Elementos.fecha = fecha2

                        Else
                            If Not IsDBNull(reader("fecha")) Then
                                Elementos.fecha = reader("fecha")
                            Else
                                Elementos.fecha = ""
                            End If
                        End If
                    End If







                    If Not IsDBNull(reader("precio")) Then
                        Elementos.precio = reader("precio")
                    Else
                        Elementos.precio = 0
                    End If


                    Elementos.kilometraje = MyDB.MySelectOneParameter("select ROUND(kmt.kilometraje,2) as kilometraje from inventarioll ill inner join (select fecha, Idvehiculo, sum(Distancia) as kilometraje from actividaddiairiavehiculo where fecha between '" & Elementos.fecha & "' and curdate() group by Idvehiculo )kmt on kmt.IdVehiculo=ill.vehiculo where ill.id = " & Elementos.id, "kilometraje")
                    MyDB.MyCommand("UPDATE inventarioll SET kmi='" & Elementos.kilometraje & "' WHERE Id='" & Elementos.id & "';")
                    Elementos.renkp = FormatNumber((Elementos.precio / Elementos.kilometraje), 2)
                    'Elementos.kmtXT = FormatNumber((Elementos.kilometraje / Elementos.desgaste), 2)
                    Elementos.RendXtreinta = FormatNumber((Elementos.kilometraje / (Elementos.desgasteant - Elementos.desgaste)), 2)


                    Elementos.desgastado = (Elementos.desgasteant - Elementos.desgaste)
                    MyDB.MyCommand("UPDATE inventarioll SET Treintaidosavosini='" & Elementos.desgastado & "' WHERE Id='" & Elementos.id & "';")
                    result.Add(Elementos)
                End While
            Catch ex As Exception
                Dim Elementos As New ClassDetalleLlantasGenerales
                Elementos.StrError = ex.Message
                result.Add(Elementos)
            Finally
                conexion.Close()
            End Try
        End Using
        Return result
    End Function

    Public Class ClassDetalleReservacionesUsuarioPool
        Public StrError As String = "0"
        Public Departamento As String
        Public GENTRAC As Integer
        Public GENTRAC_MOBILFIN As Integer
        Public VISITAS As Integer
        Public VISITAS_NOCTURNO As Integer
        Public VISITAS_FIN_SEMANA As Integer
        Public APAGADO As Integer
        Public APAGADO_NOCTURNO As Integer
        Public APAGADO_FIN As Integer
        Public TALLER As Integer
        Public DESPLAZAMIENTO As Integer
        Public KILOMETROS As Integer

        Public Gentrac_MobilT As Integer
        Public Gentrac_MobilFinT As Integer
        Public VisitasT As Integer
        Public VisitasNocturnoT As Integer
        Public VisitasFinST As Integer
        Public ApagadoT As Integer
        Public ApagadoNocturnoT As Integer
        Public ApagadoFinST As Integer
        Public Codigo As String



        Public HoraG As String
        Public HoraGF As String
        Public HoraV As String
        Public HoraVN As String
        Public HoraVF As String
        Public HoraA As String
        Public HoraAN As String
        Public HoraAF As String
        Public HoraD As String
        Public HoraT As String
        Public FechaInicioC As String
        Public FechaFinC As String
    End Class

    <WebMethod(EnableSession:=True)> _
    Public Function DetalleReservacionesUsuarioPool(ByVal IdReservacion As Integer, ByVal IdVehiculo As String) As List(Of [ClassDetalleReservacionesUsuarioPool])
        Dim result As List(Of [ClassDetalleReservacionesUsuarioPool]) = New List(Of ClassDetalleReservacionesUsuarioPool)()
        Dim consulta As String
        Using conexion As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
            Try
                conexion.Open()
                Dim FechaInicio As String = MyDB.MySelectOneParameter("Select DATE_FORMAT((FechaEntrega),'%Y-%m-%d %T') As FechaEntrega  from reservacionvehiculo where Id=" & IdReservacion, "FechaEntrega")

                Dim FechaFin As String = MyDB.MySelectOneParameter("Select DATE_FORMAT((FechaDevolucion),'%Y-%m-%d %T') As FechaDevolucion from reservacionvehiculo where Id=" & IdReservacion, "FechaDevolucion")


                If FechaFin Like "0" Then
                    FechaFin = MyDB.MySelectOneParameter("Select DATE_FORMAT((FechaFin),'%Y-%m-%d %T') As FechaFin from reservacionvehiculo where Id=" & IdReservacion, "FechaFin")
                End If
                'consulta = "SELECT IdVehiculo, LEFT((FechaInicio),10) AS FechaInicio, RIGHT((FechaInicio),8) AS HoraInicio, LEFT((FechaFin),10) AS FehcaFin, RIGHT((FechaFin),8) AS HoraFin, LugarInicio, RIGHT((SEC_TO_TIME( SUM( TIME_TO_SEC(TiempoActividad) ) )),8) AS TotalHoras, MaximaVelocidad, Distancia, VelocidadMedia FROM horastrabajadas where (FechaInicio between '2014-12-02 17:30:00' and'2014-12-03 17:30:00') and (FechaFin between '2014-12-02 17:30:00' and '2014-12-03 17:30:00') and IdVehiculo = 448 group by LugarInicio "
                'consulta = "SELECT IdVehiculo, LEFT((FechaInicio),10) AS FechaInicio, RIGHT((FechaInicio),8) AS HoraInicio, LEFT((FechaFin),10) AS FehcaFin, RIGHT((FechaFin),8) AS HoraFin, LugarInicio,LugarFin, (TIME_TO_SEC(TiempoActividad) DIV 60) AS TotalHoras, MaximaVelocidad, Distancia, VelocidadMedia FROM horastrabajadas inner join (select id, codigo from _vehiculos)vh on vh.id=IdVehiculo  where ('" & FechaInicio & "' <=FechaInicio AND FechaFin <= '" & FechaFin & "') and vh.codigo ='" & IdVehiculo & "'"





                consulta = "select vh.codigo as vehiculo,(sum(time_to_sec(p.Tiempo)))  as GENTRAC, GMF.GENTRAC_MOBILFIN,V.VISITAS, VN.VISITAS_NOCTURNO,VF.VISITAS_FIN_SEMANA, AP.APAGADO,APN.APAGADO_NOCTURNO,APF.APAGADO_FIN, TA.TALLER, DE.DESPLAZAMIENTO, DE.kilometros  from parada p inner join(select id, codigo from _vehiculos)vh on p.IdVehiculo=vh.id inner join(select (sum(time_to_sec(p.Tiempo)))  as GENTRAC_MOBILFIN from parada p inner join(select id, codigo from _vehiculos)vh on p.IdVehiculo=vh.id where ('" & FechaInicio & "' <= FechaInicio AND FechaFin <= '" & FechaFin & "') and (p.Ubicacion LIKE '%gentrac%' or p.Ubicacion LIKE '%MOBIL%') and vh.codigo = '" & IdVehiculo & "' and (WEEKDAY(p.FechaInicio) =5 or WEEKDAY(p.FechaInicio) =6) )GMF inner join (select (sum(time_to_sec(p.Tiempo)))  as VISITAS  from parada p inner join(select id, codigo from _vehiculos)vh on p.IdVehiculo=vh.id where ('" & FechaInicio & "' <= FechaInicio AND FechaFin <= '" & FechaFin & "') and p.Ubicacion NOT LIKE '%gentrac%' and p.Ubicacion NOT LIKE '%MOBIL%' and p.Ubicacion NOT LIKE '%c.%' and p.Ubicacion NOT LIKE '%t.%' and vh.codigo = '" & IdVehiculo & "' and p.Segundos < 14400 and (WEEKDAY(p.FechaInicio) !=5 or WEEKDAY(p.FechaInicio) !=6))V inner join (select (sum(time_to_sec(p.Tiempo)))  as VISITAS_NOCTURNO  from parada p inner join(select id,codigo from _vehiculos)vh on p.IdVehiculo=vh.id where ('" & FechaInicio & "' <= FechaInicio AND FechaFin <= '" & FechaFin & "') and p.Ubicacion NOT LIKE'%gentrac%' and p.Ubicacion NOT LIKE '%MOBIL%' and p.Ubicacion NOT LIKE '%c.%' and p.Ubicacion NOT LIKE '%t.%' and vh.codigo = '" & IdVehiculo & "' and p.Segundos >= 14400 and (WEEKDAY(p.FechaInicio) !=5 or WEEKDAY(p.FechaInicio) !=6))VN inner join (select (sum(time_to_sec(p.Tiempo)))  as VISITAS_FIN_SEMANA  from parada p inner join(select id,codigo from _vehiculos)vh on p.IdVehiculo=vh.id where ('" & FechaInicio & "' <= FechaInicio AND FechaFin <= '" & FechaFin & "') and p.Ubicacion NOT LIKE '%gentrac%' and p.Ubicacion NOT LIKE '%MOBIL%' and p.Ubicacion NOT LIKE '%c.%' and p.Ubicacion NOT LIKE '%t.%' and vh.codigo = '" & IdVehiculo & "' and (WEEKDAY(p.FechaInicio) =5 or WEEKDAY(p.FechaInicio) =6))VF inner join (select (sum(time_to_sec(p.Tiempo)))  as APAGADO from parada p inner join(select id, codigo from _vehiculos)vh on p.IdVehiculo=vh.id where ('" & FechaInicio & "' <= FechaInicio AND FechaFin <= '" & FechaFin & "') and p.Ubicacion LIKE'%c.%' and vh.codigo = '" & IdVehiculo & "' and p.Segundos < 14400 and (WEEKDAY(p.FechaInicio) !=5 or WEEKDAY(p.FechaInicio) !=6))AP inner join (select (sum(time_to_sec(p.Tiempo)))  as APAGADO_NOCTURNO from parada p inner join(select id, codigo from _vehiculos)vh on p.IdVehiculo=vh.id where ('" & FechaInicio & "' <= FechaInicio AND FechaFin <= '" & FechaFin & "') and p.Ubicacion LIKE'%c.%' and vh.codigo = '" & IdVehiculo & "' and p.Segundos >= 14400 and (WEEKDAY(p.FechaInicio) !=5 or WEEKDAY(p.FechaInicio) !=6))APN inner join (select (sum(time_to_sec(p.Tiempo)))  as APAGADO_FIN from parada p inner join(select id, codigo from _vehiculos)vh on p.IdVehiculo=vh.id where ('" & FechaInicio & "' <= FechaInicio AND FechaFin <= '" & FechaFin & "') and p.Ubicacion LIKE'%c.%' and vh.codigo = '" & IdVehiculo & "' and (WEEKDAY(p.FechaInicio) =5 or WEEKDAY(p.FechaInicio) =6))APF inner join (select (sum(time_to_sec(p.Tiempo)))  as TALLER from parada p inner join(select id, codigo from _vehiculos)vh on p.IdVehiculo=vh.id where ('" & FechaInicio & "' <= FechaInicio AND FechaFin <= '" & FechaFin & "') and p.Ubicacion LIKE'%t.%' and vh.codigo = '" & IdVehiculo & "')TA inner join (select (sum(time_to_sec(p.TiempoActividad)))  as DESPLAZAMIENTO, (sum(distancia)/1000)as Kilometros from horastrabajadas p inner join(select id, codigo from _vehiculos)vh on p.IdVehiculo=vh.id where ('" & FechaInicio & "' <= FechaInicio AND FechaFin <= '" & FechaFin & "') and vh.codigo = '" & IdVehiculo & "')DE where ('" & FechaInicio & "' <= FechaInicio AND FechaFin <= '" & FechaFin & "') and (p.Ubicacion LIKE '%gentrac%' or p.Ubicacion LIKE '%MOBIL%') and vh.codigo = '" & IdVehiculo & "' and (WEEKDAY(p.FechaInicio) !=5 or WEEKDAY(p.FechaInicio) !=6);"


                Dim cmd As New MySqlCommand(consulta, conexion)
                Dim reader As MySqlDataReader = cmd.ExecuteReader()
                Dim Elementos1 As New ClassDetalleReservacionesUsuarioPool

                While reader.Read


                    Dim Elementos As New ClassDetalleReservacionesUsuarioPool
                    If Not IsDBNull(reader("vehiculo")) Then
                        Elementos.Codigo = reader("vehiculo")
                    Else
                        Elementos.Codigo = ""
                    End If
                    If Not IsDBNull(reader("GENTRAC")) Then
                        Elementos.GENTRAC = reader("GENTRAC")
                    Else
                        Elementos.GENTRAC = 0
                    End If

                    If Not IsDBNull(reader("GENTRAC_MOBILFIN")) Then
                        Elementos.GENTRAC_MOBILFIN = reader("GENTRAC_MOBILFIN")
                    Else
                        Elementos.GENTRAC_MOBILFIN = 0
                    End If
                    If Not IsDBNull(reader("VISITAS")) Then
                        Elementos.VISITAS = reader("VISITAS")
                    Else
                        Elementos.VISITAS = 0
                    End If

                    If Not IsDBNull(reader("VISITAS_NOCTURNO")) Then
                        Elementos.VISITAS_NOCTURNO = reader("VISITAS_NOCTURNO")
                    Else
                        Elementos.VISITAS_NOCTURNO = 0
                    End If

                    If Not IsDBNull(reader("APAGADO")) Then
                        Elementos.APAGADO = reader("APAGADO")
                    Else
                        Elementos.APAGADO = 0
                    End If

                    If Not IsDBNull(reader("VISITAS_FIN_SEMANA")) Then
                        Elementos.VISITAS_FIN_SEMANA = reader("VISITAS_FIN_SEMANA")
                    Else
                        Elementos.VISITAS_FIN_SEMANA = 0
                    End If

                    If Not IsDBNull(reader("APAGADO_NOCTURNO")) Then
                        Elementos.APAGADO_NOCTURNO = reader("APAGADO_NOCTURNO")
                    Else
                        Elementos.APAGADO_NOCTURNO = 0
                    End If

                    If Not IsDBNull(reader("APAGADO_FIN")) Then
                        Elementos.APAGADO_FIN = reader("APAGADO_FIN")
                    Else
                        Elementos.APAGADO_FIN = 0
                    End If

                    If Not IsDBNull(reader("TALLER")) Then
                        Elementos.TALLER = reader("TALLER")
                    Else
                        Elementos.TALLER = 0
                    End If

                    If Not IsDBNull(reader("DESPLAZAMIENTO")) Then
                        Elementos.DESPLAZAMIENTO = reader("DESPLAZAMIENTO")
                    Else
                        Elementos.DESPLAZAMIENTO = 0
                    End If

                    If Not IsDBNull(reader("kilometros")) Then
                        Elementos.KILOMETROS = reader("kilometros")
                    Else
                        Elementos.KILOMETROS = 0
                    End If
                    Elementos.FechaInicioC = MyDB.MySelectOneParameter("Select DATE_FORMAT((FechaEntrega),'%Y-%m-%d %T') As FechaEntrega  from reservacionvehiculo where Id=" & IdReservacion, "FechaEntrega")
                    Elementos.FechaFinC = MyDB.MySelectOneParameter("Select DATE_FORMAT((FechaDevolucion),'%Y-%m-%d %T') As FechaDevolucion from reservacionvehiculo where Id=" & IdReservacion, "FechaDevolucion")

                    If Elementos.FechaFinC Like "0" Then
                        Elementos.FechaFinC = MyDB.MySelectOneParameter("Select DATE_FORMAT((FechaFin),'%Y-%m-%d %T') As FechaFin from reservacionvehiculo where Id=" & IdReservacion, "FechaFin")
                    End If



                    Elementos.HoraG = sPasar_Segundos_a_Horas(Elementos.GENTRAC)
                    Elementos.HoraGF = sPasar_Segundos_a_Horas(Elementos.GENTRAC_MOBILFIN)

                    Elementos.HoraV = sPasar_Segundos_a_Horas(Elementos.VISITAS)
                    Elementos.HoraVN = sPasar_Segundos_a_Horas(Elementos.VISITAS_NOCTURNO)
                    Elementos.HoraVF = sPasar_Segundos_a_Horas(Elementos.VISITAS_FIN_SEMANA)

                    Elementos.HoraA = sPasar_Segundos_a_Horas(Elementos.APAGADO)
                    Elementos.HoraAN = sPasar_Segundos_a_Horas(Elementos.APAGADO_NOCTURNO)
                    Elementos.HoraAF = sPasar_Segundos_a_Horas(Elementos.APAGADO_FIN)

                    Elementos.HoraD = sPasar_Segundos_a_Horas(Elementos.DESPLAZAMIENTO)
                    Elementos.HoraT = sPasar_Segundos_a_Horas(Elementos.TALLER)





                    result.Add(Elementos)
                End While
            Catch ex As Exception
                Dim Elementos As New ClassDetalleReservacionesUsuarioPool
                Elementos.StrError = ex.Message
                result.Add(Elementos)
            Finally
                conexion.Close()
            End Try
        End Using
        Return result
    End Function
    Public Class ClassDetalleDesplazamientoPool
        Public IdVehiculo As Integer
        Public Horainicio As String
        Public HoraFin As String
        Public LugarInicio As String
        Public TotalHoras As String
        Public Distancia As String
        Public FechaInicio As String
        Public MaximaVelocidad As Integer
        Public VelocidadMedia As Integer
    End Class

    <WebMethod(EnableSession:=True)> _
    Public Function DetalleDesplazamientoPool(ByVal FechaInicio As String, ByVal FechaFin As String, ByVal IdVehiculo As String) As List(Of [ClassDetalleDesplazamientoPool])
        Dim result As List(Of [ClassDetalleDesplazamientoPool]) = New List(Of ClassDetalleDesplazamientoPool)()
        Dim consulta As String
        Using conexion As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
            Try
                conexion.Open()

                'consulta = "SELECT IdVehiculo, LEFT((FechaInicio),10) AS FechaInicio, RIGHT((FechaInicio),8) AS HoraInicio, LEFT((FechaFin),10) AS FehcaFin, RIGHT((FechaFin),8) AS HoraFin, LugarInicio, RIGHT((SEC_TO_TIME( SUM( TIME_TO_SEC(TiempoActividad) ) )),8) AS TotalHoras, MaximaVelocidad, Distancia, VelocidadMedia FROM horastrabajadas where (FechaInicio between '2014-12-02 17:30:00' and'2014-12-03 17:30:00') and (FechaFin between '2014-12-02 17:30:00' and '2014-12-03 17:30:00') and IdVehiculo = 448 group by LugarInicio "
                consulta = "SELECT IdVehiculo, LEFT((FechaInicio),10) AS FechaInicio, RIGHT((FechaInicio),8) AS HoraInicio, LEFT((FechaFin),10) AS FehcaFin, RIGHT((FechaFin),8) AS HoraFin, LugarInicio,LugarFin, SUM((TIME_TO_SEC(TiempoActividad) DIV 60)) AS TotalHoras, MAX(MaximaVelocidad) AS MaximaVelocidad, SUM(Distancia) AS Distancia, MAX(VelocidadMedia) AS VelocidadMedia FROM horastrabajadas inner join (select id, codigo from _vehiculos)vh on vh.id=IdVehiculo where ('" & FechaInicio & "' <= FechaInicio AND FechaFin <= '" & FechaFin & "') and vh.codigo ='" & IdVehiculo & "' group by LEFT((FechaInicio),10)"




                Dim cmd As New MySqlCommand(consulta, conexion)
                Dim reader As MySqlDataReader = cmd.ExecuteReader


                While reader.Read
                    Dim elemento As New ClassDetalleDesplazamientoPool
                    Dim Inicio As String
                    Dim ini1 As String = reader("HoraInicio")
                    Inicio = ini1.Substring(0, 2)
                    Dim Fin As String
                    Dim Fin1 As String = reader("HoraFin")
                    Fin = Fin1.Substring(0, 2)
                    With elemento
                        .IdVehiculo = reader("IdVehiculo")

                        If Not IsDBNull(reader("HoraInicio")) Then
                            .Horainicio = Inicio
                        Else
                            .Horainicio = ""
                        End If
                        If Not IsDBNull(reader("HoraFin")) Then
                            .HoraFin = Fin
                        Else
                            .HoraFin = ""
                        End If
                        If Not IsDBNull(reader("LugarFin")) Then
                            .LugarInicio = reader("LugarFin")
                        Else
                            .LugarInicio = ""
                        End If
                        If Not IsDBNull(reader("TotalHoras")) Then
                            .TotalHoras = reader("TotalHoras")

                        End If
                        If Not IsDBNull(reader("Distancia")) Then
                            .Distancia = reader("Distancia") / 1000
                        Else
                            .Distancia = ""
                        End If
                        If Not IsDBNull(reader("MaximaVelocidad")) Then
                            .MaximaVelocidad = reader("MaximaVelocidad")
                        Else
                            .MaximaVelocidad = 0
                        End If
                        If Not IsDBNull(reader("VelocidadMedia")) Then
                            .VelocidadMedia = reader("VelocidadMedia")
                        Else
                            .VelocidadMedia = 0
                        End If

                        If Not IsDBNull(reader("FechaInicio")) Then
                            .FechaInicio = reader("FechaInicio")
                        Else
                            .FechaInicio = ""
                        End If

                    End With
                    result.Add(elemento)
                End While
            Finally
                conexion.Close()
            End Try
        End Using
        Return result
    End Function

    Public Class ClassDetalleUsoVisitasPool
        Public StrError As String = "0"
        Public Ubicacion As String
        Public TiempoTL As String
        Public TiempoSL As Integer
        Public FechaInicio As String
        Public FechaIniciod As String
        Public FechaInicioT As String
        Public FechaFinT As String


    End Class
    <WebMethod(EnableSession:=True)> _
    Public Function DetalleUsoVisitasPool(ByVal FechaInicio As String, ByVal FechaFin As String, ByVal CodVehiculo As String, ByVal Rubro As String) As List(Of [ClassDetalleUsoVisitasPool])
        Dim result As List(Of [ClassDetalleUsoVisitasPool]) = New List(Of ClassDetalleUsoVisitasPool)()
        Dim consulta As String
        'ByVal FechaInicio As String, ByVal FechaFin As String, ByVal Codigo As String
        Using conexion As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
            Try
                conexion.Open()
                If Rubro Like "VISITAS" Then
                    consulta = "select p.IdVehiculo,  DAYNAME(LEFT((p.FechaInicio),10)) AS FechaInicio, LEFT((p.FechaInicio),10) AS FechaIniciod, p.FechaInicio AS FechaInicioT, MAX(p.FechaFin) AS FechaFin ,p.Ubicacion as Ubicacion, SEC_TO_TIME(sum(time_to_sec(p.Tiempo)))  as TiempoT, (sum(time_to_sec(p.Tiempo)))  as TiempoS  from parada p inner join(select id, codigo from _vehiculos)vh on p.IdVehiculo=vh.id where ('" & FechaInicio & "' <= FechaInicio AND FechaFin <= '" & FechaFin & "') and p.Ubicacion NOT LIKE '%gentrac%' and p.Ubicacion NOT LIKE '%MOBIL%' and p.Ubicacion NOT LIKE'%c.%' and p.Ubicacion NOT LIKE'%t.%' and vh.codigo = '" & CodVehiculo & "'and p.Segundos < 14400 and (WEEKDAY(p.FechaInicio) !=5 or WEEKDAY(p.FechaInicio) !=6) group by p.Ubicacion order by TiempoS desc limit 10;"
                ElseIf Rubro = "VISITAS_NOCTURNO" Then
                    consulta = "select p.IdVehiculo,  DAYNAME(LEFT((p.FechaInicio),10)) AS FechaInicio, LEFT((p.FechaInicio),10) AS FechaIniciod, p.FechaInicio AS FechaInicioT, MAX(p.FechaFin) AS FechaFin ,p.Ubicacion as Ubicacion, SEC_TO_TIME(sum(time_to_sec(p.Tiempo)))  as TiempoT, (sum(time_to_sec(p.Tiempo)))  as TiempoS  from parada p inner join(select id, codigo from _vehiculos)vh on p.IdVehiculo=vh.id where ('" & FechaInicio & "' <= FechaInicio AND FechaFin <= '" & FechaFin & "') and p.Ubicacion NOT LIKE '%gentrac%' and p.Ubicacion NOT LIKE '%MOBIL%' and p.Ubicacion NOT LIKE'%c.%' and p.Ubicacion NOT LIKE'%t.%' and vh.codigo = '" & CodVehiculo & "'and p.Segundos >= 14400 and WEEKDAY(p.FechaInicio) !=5 and WEEKDAY(p.FechaInicio) !=6 group by p.Ubicacion order by TiempoS desc limit 10;"
                ElseIf Rubro = "VISITAS_FIN_SEMANA" Then
                    consulta = "select p.IdVehiculo,  DAYNAME(LEFT((p.FechaInicio),10)) AS FechaInicio, LEFT((p.FechaInicio),10) AS FechaIniciod, p.FechaInicio AS FechaInicioT, MAX(p.FechaFin) AS FechaFin ,p.Ubicacion as Ubicacion, SEC_TO_TIME(sum(time_to_sec(p.Tiempo)))  as TiempoT, (sum(time_to_sec(p.Tiempo)))  as TiempoS  from parada p inner join(select id, codigo from _vehiculos)vh on p.IdVehiculo=vh.id where ('" & FechaInicio & "' <= FechaInicio AND FechaFin <= '" & FechaFin & "') and p.Ubicacion NOT LIKE'gentrac' and p.Ubicacion NOT LIKE'%c.%' and p.Ubicacion NOT LIKE'%t.%' and vh.codigo = '" & CodVehiculo & "'and (WEEKDAY(p.FechaInicio) =5 or WEEKDAY(p.FechaInicio) =6) group by p.Ubicacion order by TiempoS desc limit 10;"
                ElseIf Rubro = "APAGADO" Then
                    consulta = "select p.IdVehiculo, DAYNAME(LEFT((p.FechaInicio),10)) AS FechaInicio, LEFT((p.FechaInicio),10) AS FechaIniciod, MIN(p.FechaInicio) AS FechaInicioT, MAX(p.FechaFin) AS FechaFin ,p.Ubicacion as Ubicacion, SEC_TO_TIME(sum(time_to_sec(p.Tiempo)))  as TiempoT, (sum(time_to_sec(p.Tiempo)))  as TiempoS  from parada p inner join(select id, codigo from _vehiculos)vh on p.IdVehiculo=vh.id where ('" & FechaInicio & "' <= FechaInicio AND FechaFin <= '" & FechaFin & "') and p.Ubicacion LIKE'%c.%' and vh.codigo ='" & CodVehiculo & "'and p.Segundos < 14400 and (WEEKDAY(p.FechaInicio) !=5 or WEEKDAY(p.FechaInicio) !=6) group by LEFT((p.FechaInicio),10) order by LEFT((p.FechaInicio),10) desc limit 10;"
                ElseIf Rubro = "APAGADO_NOCTURNO" Then
                    consulta = "select p.IdVehiculo,DAYNAME(LEFT((p.FechaInicio),10)) AS FechaInicio, LEFT((p.FechaInicio),10) AS FechaIniciod, MIN(p.FechaInicio) AS FechaInicioT, MAX(p.FechaFin) AS FechaFin ,p.Ubicacion as Ubicacion, SEC_TO_TIME(sum(time_to_sec(p.Tiempo)))  as TiempoT, (sum(time_to_sec(p.Tiempo)))  as TiempoS  from parada p inner join(select id, codigo from _vehiculos)vh on p.IdVehiculo=vh.id where ('" & FechaInicio & "' <= FechaInicio AND FechaFin <= '" & FechaFin & "') and p.Ubicacion LIKE'%c.%' and vh.codigo ='" & CodVehiculo & "'and p.Segundos >= 14400 and (WEEKDAY(p.FechaInicio) !=5 or WEEKDAY(p.FechaInicio) !=6) group by LEFT((p.FechaInicio),10) order by LEFT((p.FechaInicio),10) desc limit 10;"
                ElseIf Rubro = "APAGADO_FIN" Then
                    consulta = "select p.IdVehiculo, DAYNAME(LEFT((p.FechaInicio),10)) AS FechaInicio, LEFT((p.FechaInicio),10) AS FechaIniciod, p.FechaInicio AS FechaInicioT, MAX(p.FechaFin) AS FechaFin ,p.Ubicacion as Ubicacion, SEC_TO_TIME(sum(time_to_sec(p.Tiempo)))  as TiempoT, (sum(time_to_sec(p.Tiempo)))  as TiempoS  from parada p inner join(select id, codigo from _vehiculos)vh on p.IdVehiculo=vh.id where ('" & FechaInicio & "' <= FechaInicio AND FechaFin <= '" & FechaFin & "') and p.Ubicacion LIKE'%c.%' and vh.codigo ='" & CodVehiculo & "'and (WEEKDAY(p.FechaInicio) =5 or WEEKDAY(p.FechaInicio) =6) group by p.Ubicacion order by LEFT((p.FechaInicio),10) desc limit 10;"
                ElseIf Rubro = "GENTRAC" Then
                    consulta = "select p.IdVehiculo, DAYNAME(LEFT((p.FechaInicio),10)) AS FechaInicio, LEFT((p.FechaInicio),10) AS FechaIniciod, p.FechaInicio AS FechaInicioT, MAX(p.FechaFin) AS FechaFin ,p.Ubicacion as Ubicacion, SEC_TO_TIME(sum(time_to_sec(p.Tiempo)))  as TiempoT, (sum(time_to_sec(p.Tiempo)))  as TiempoS  from parada p inner join(select id, codigo from _vehiculos)vh on p.IdVehiculo=vh.id where ('" & FechaInicio & "' <= FechaInicio AND FechaFin <= '" & FechaFin & "') and (p.Ubicacion LIKE '%gentrac%' or p.Ubicacion LIKE '%MOBIL%') and vh.codigo = '" & CodVehiculo & "'and (WEEKDAY(p.FechaInicio) !=5 or WEEKDAY(p.FechaInicio) !=6) group by LEFT((p.FechaInicio),10) order by LEFT((p.FechaInicio),10) desc;"
                ElseIf Rubro = "GENTRAC_MOBILFIN" Then
                    consulta = "select p.IdVehiculo, DAYNAME(LEFT((p.FechaInicio),10)) AS FechaInicio, LEFT((p.FechaInicio),10) AS FechaIniciod, p.FechaInicio AS FechaInicioT, MAX(p.FechaFin) AS FechaFin ,p.Ubicacion as Ubicacion, SEC_TO_TIME(sum(time_to_sec(p.Tiempo)))  as TiempoT, (sum(time_to_sec(p.Tiempo)))  as TiempoS  from parada p inner join(select id, codigo from _vehiculos)vh on p.IdVehiculo=vh.id where ('" & FechaInicio & "' <= FechaInicio AND FechaFin <= '" & FechaFin & "') and (p.Ubicacion LIKE '%gentrac%' or p.Ubicacion LIKE '%MOBIL%') and vh.codigo = '" & CodVehiculo & "'and (WEEKDAY(p.FechaInicio) =5 or WEEKDAY(p.FechaInicio) =6) group by LEFT((p.FechaInicio),10) order by LEFT((p.FechaInicio),10) desc;"
                ElseIf Rubro = "TALLER" Then
                    consulta = "select p.IdVehiculo, DAYNAME(LEFT((p.FechaInicio),10)) AS FechaInicio, LEFT((p.FechaInicio),10) AS FechaIniciod,p.FechaInicio AS FechaInicioT, MAX(p.FechaFin) AS FechaFin ,p.Ubicacion as Ubicacion, SEC_TO_TIME(sum(time_to_sec(p.Tiempo)))  as TiempoT, (sum(time_to_sec(p.Tiempo)))  as TiempoS  from parada p inner join(select id, codigo from _vehiculos)vh on p.IdVehiculo=vh.id where ('" & FechaInicio & "' <= FechaInicio AND FechaFin <= '" & FechaFin & "') and p.Ubicacion LIKE'%t.%' and vh.codigo ='" & CodVehiculo & "'and p.Segundos < 14400 and (WEEKDAY(p.FechaInicio) !=5 or WEEKDAY(p.FechaInicio) !=6) group by LEFT((p.FechaInicio),10) order by LEFT((p.FechaInicio),10) desc limit 10;"
                End If

                Dim cmd As New MySqlCommand(consulta, conexion)
                Dim reader As MySqlDataReader = cmd.ExecuteReader()
                While reader.Read


                    Dim Elementos As New ClassDetalleUsoVisitasPool
                    If Not IsDBNull(reader("Ubicacion")) Then
                        Elementos.Ubicacion = reader("Ubicacion")
                    Else
                        Elementos.Ubicacion = ""
                    End If
                    If Not IsDBNull(reader("TiempoT")) Then
                        Elementos.TiempoTL = (Convert.ToString(reader("TiempoT")))
                    Else
                        Elementos.TiempoTL = ""
                    End If

                    If Not IsDBNull(reader("TiempoS")) Then
                        Elementos.TiempoSL = reader("TiempoS")
                    Else
                        Elementos.TiempoSL = 0
                    End If

                    If Not IsDBNull(reader("FechaInicio")) Then

                        If reader("FechaInicio") = "Monday" Then
                            Elementos.FechaInicio = "Lunes"

                        ElseIf reader("FechaInicio") = "Tuesday" Then
                            Elementos.FechaInicio = "Martes"
                        ElseIf reader("FechaInicio") = "Wednesday" Then
                            Elementos.FechaInicio = "Miercoles "
                        ElseIf reader("FechaInicio") = "Thursday" Then
                            Elementos.FechaInicio = "Jueves"
                        ElseIf reader("FechaInicio") = "Friday" Then
                            Elementos.FechaInicio = "Viernes"
                        ElseIf reader("FechaInicio") = "Saturday" Then
                            Elementos.FechaInicio = "Sabado"
                        ElseIf reader("FechaInicio") = "Sunday" Then
                            Elementos.FechaInicio = "Domingo"

                        End If
                    Else
                        Elementos.FechaInicio = ""
                    End If

                    If Not IsDBNull(reader("FechaIniciod")) Then
                        Elementos.FechaIniciod = reader("FechaIniciod")
                    Else
                        Elementos.FechaIniciod = ""
                    End If
                    If Not IsDBNull(reader("FechaInicioT")) Then
                        Elementos.FechaInicioT = reader("FechaInicioT")
                    Else
                        Elementos.FechaInicioT = ""
                    End If
                    If Not IsDBNull(reader("FechaFin")) Then
                        Elementos.FechaFinT = reader("FechaFin")
                    Else
                        Elementos.FechaFinT = ""
                    End If
                    result.Add(Elementos)


                End While
            Catch ex As Exception
                Dim Elementos As New ClassDetalleUsoVisitasPool
                Elementos.StrError = ex.Message
                result.Add(Elementos)
            Finally
                conexion.Close()
            End Try
        End Using
        Return result
    End Function
    Public Class ClassDetalleReservaciones
        Public NoReservacion As Integer
        Public Vehiculo As String
        Public FechaEntrega As String
        Public FechaDevolucion As String
    End Class

    <WebMethod(EnableSession:=True)> _
    Public Function DetalleReservaciones(ByVal FechaInicio As String, ByVal FechaFin As String, ByVal Usuario As Integer) As List(Of [ClassDetalleReservaciones])
        Dim result As List(Of [ClassDetalleReservaciones]) = New List(Of ClassDetalleReservaciones)()
        Dim consulta As String
        Using conexion As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
            Try
                conexion.Open()


                consulta = "select (rs.Id)NumeroReservacion, (vh.codigo)Vehiculo, rs.FechaEntrega, rs.FechaDevolucion,rs.FechaFin from reservacionvehiculo rs inner join (select Id, codigo from _vehiculos )vh on vh.Id=rs.IdVehiculo  where rs.FechaInicio between '" & FechaInicio & "' and '" & FechaFin & "' and IdEmpleado = '" & Usuario & "' and rs.Estado!=2;"
                Dim cmd As New MySqlCommand(consulta, conexion)
                Dim reader As MySqlDataReader = cmd.ExecuteReader
                While reader.Read
                    Dim elemento As New ClassDetalleReservaciones
                    With elemento
                        .NoReservacion = reader("NumeroReservacion")

                        If Not IsDBNull(reader("Vehiculo")) Then
                            .Vehiculo = reader("Vehiculo")
                        Else
                            .Vehiculo = ""
                        End If
                        If Not IsDBNull(reader("FechaEntrega")) Then
                            .FechaEntrega = reader("FechaEntrega")
                        Else
                            .FechaEntrega = ""
                        End If
                        If Not IsDBNull(reader("FechaDevolucion")) Then
                            .FechaDevolucion = reader("FechaDevolucion")
                        Else
                            .FechaDevolucion = reader("FechaFin")
                        End If

                    End With
                    result.Add(elemento)
                End While
            Finally
                conexion.Close()
            End Try
        End Using
        Return result
    End Function

    <WebMethod(EnableSession:=True)> _
    Public Function GuardarFacturaGastos(ByVal FechaFactura As String, ByVal Departamentos As String, ByVal TipoDocumento As String, ByVal OrdenTrabajo As String, ByVal NitProveedor As String, ByVal NombreProveedor As String, ByVal SerieFactura As String, ByVal NumeroFactura As String, ByVal Observacion As String, ByVal Detalle As List(Of ClassRecibeDetalleFactura)) As List(Of [ClassFacturaViaticos])
        Dim result As List(Of [ClassFacturaViaticos]) = New List(Of ClassFacturaViaticos)()
        Dim MySQLInsert As String
        Using conexion As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
            conexion.Open()
            Dim comando As New MySqlCommand
            Dim transaccion As MySqlTransaction

            transaccion = conexion.BeginTransaction
            comando.Connection = conexion
            comando.Transaction = transaccion
            Try
                If Not datos.ExisteDato("select nit, nombre from proveedores where nit='" & NitProveedor & "';") Then
                    comando.CommandType = Data.CommandType.Text
                    Dim InsertProveedor As String = "INSERT INTO proveedores (nit, Nombre, Direccion, telefono) VALUES ('" & NitProveedor & "','" & NombreProveedor & "',' ', '00000000')"
                    comando.CommandText = InsertProveedor
                    comando.ExecuteNonQuery()
                End If
                Dim Vehiculo As Integer = MyDB.MySelectOneParameter("select id from _vehiculos where npiloto=" & Context.Request.Cookies("UserSettings")("IdPersonal") & " limit 1", "id")
                comando.CommandType = Data.CommandType.Text
                Dim fecha As Array = FechaFactura.Split("-")
                FechaFactura = fecha(2) & fecha(1) & fecha(0)
                MySQLInsert = "INSERT INTO facturacion (id_borrar, fecha, usuario, serie, nofac, departamento, provedor, comprador, recibe, descrip, tipo_fac, descuento, status, nempresa, tipo_doc, retencion, tipo_pago, Vehiculo, OrdenTrabajo, Liquidado, Versatec, IdFacMS)VALUES"


                Dim count As Integer = 0
                Dim InsertDetalle As String = "INSERT INTO facturaciond (codigo, total, precioU, usuario, cantidad, correlativo, nit_proveedor, serie_fac, num_fac, Estado, CargaInventario) VALUES"
                Dim CodVehiculo As String = "N/A"
                Dim totalFactura As Double = 0
                Dim IdFacMS As Integer = (MyDB.MySelectOneParameter("select Max(IdFacMS) AS IdFacMS from facturacion limit 1;", "IdFacMS"))
                'comando.CommandText = "SELECT @@IDENTITY"
                Dim correlativo As Integer = (MyDB.MySelectOneParameter("select Max(corre) AS corre from facturacion limit 1;", "corre"))
                For Each items In Detalle
                    If CodVehiculo = "N/A" Then
                        CodVehiculo = items.vehiculo
                    End If
                    Dim Departamento As Integer = MyDB.MySelectOneParameter("select departamento from _vehiculos where codigo like '%" & items.vehiculo & "%' limit 1", "departamento")

                    IdFacMS = IdFacMS + 1
                    correlativo = correlativo + 1
                    Dim IdVehiculo As Integer = MyDB.MySelectOneParameter("select id from _vehiculos where codigo='" & items.vehiculo & "'", "id")
                    If count = 0 Then
                        InsertDetalle += "('" & items.codigo & "','" & items.total & "', '" & items.precioUnidad & "', '" & Context.Request.Cookies("UserSettings")("user") & "', '" & items.cantidad & "', '" & correlativo & "', '" & NitProveedor & "', '" & SerieFactura & "', '" & NumeroFactura & "',1,1)"
                        MySQLInsert += "(1, '" & FechaFactura & "', '" & Context.Request.Cookies("UserSettings")("user") & "', '" & SerieFactura & "', '" & NumeroFactura & "','" & Departamento & "', '" & NitProveedor & "', '" & Context.Request.Cookies("UserSettings")("IdPersonal") & "','" & Context.Request.Cookies("UserSettings")("IdPersonal") & "','" & Observacion & "', 1, 0, 1, 23, '" & TipoDocumento & "', 0, 1, '" & IdVehiculo & "','" & OrdenTrabajo & "',1,1,'" & IdFacMS & "')"

                    Else
                        InsertDetalle += ",('" & items.codigo & "','" & items.total & "', '" & items.precioUnidad & "', '" & Context.Request.Cookies("UserSettings")("user") & "', '" & items.cantidad & "', '" & correlativo & "', '" & NitProveedor & "', '" & SerieFactura & "', '" & NumeroFactura & "',1,1)"
                        MySQLInsert += ",(1, '" & FechaFactura & "', '" & Context.Request.Cookies("UserSettings")("user") & "', '" & SerieFactura & "', '" & NumeroFactura & "','" & Departamento & "', '" & NitProveedor & "', '" & Context.Request.Cookies("UserSettings")("IdPersonal") & "','" & Context.Request.Cookies("UserSettings")("IdPersonal") & "','" & Observacion & "', 1, 0, 1, 23, '" & TipoDocumento & "', 0, 1, '" & IdVehiculo & "','" & OrdenTrabajo & "',1,1,'" & IdFacMS & "')"

                    End If
                    totalFactura = totalFactura + items.total
                    count += 1
                Next
                comando.CommandText = InsertDetalle
                comando.ExecuteNonQuery()
                comando.CommandText = MySQLInsert
                comando.ExecuteNonQuery()


                Dim Elementos As New ClassFacturaViaticos
                Elementos.StrError = "0"
                'Elementos.correlativo = correlativo
                result.Add(Elementos)
                transaccion.Commit()
            Catch ex As Exception
                Dim Elementos As New ClassFacturaViaticos
                Elementos.StrError = ex.Message
                result.Add(Elementos)
                transaccion.Dispose()
            Finally
                conexion.Close()
            End Try
        End Using
        Return result
    End Function

    Public Class DatosExcel
        Public StrError As String = "0"
        Public Codigo As String
        Public Descripcion As String
        Public Cantidad As String
        Public Precio As String
        Public Total As String
        Public Vehiculo As String
    End Class
    <WebMethod(EnableSession:=True)> _
    Public Function Import_To_Grid(ByVal FilePath As String, ByVal Extension As String, ByVal isHDR As String) As List(Of [DatosExcel])
        'FilePath = FilePath.Replace("/", "\")
        Dim result As List(Of [DatosExcel]) = New List(Of DatosExcel)()
        Dim conStr As String = ""
        Select Case Extension
            Case ".xls"
                'Excel 97-03 
                conStr = ConfigurationManager.ConnectionStrings("Excel03ConString").ConnectionString
                Exit Select
            Case ".xlsx"
                'Excel 07 
                conStr = ConfigurationManager.ConnectionStrings("Excel07ConString").ConnectionString
                Exit Select
        End Select
        conStr = String.Format(conStr, FilePath, isHDR)

        Dim connExcel As New OleDbConnection(conStr)
        Dim cmdExcel As New OleDbCommand()
        Dim oda As New OleDbDataAdapter()
        Dim dt As New DataTable()

        cmdExcel.Connection = connExcel

        'Get the name of First Sheet 
        connExcel.Open()
        Dim dtExcelSchema As DataTable
        dtExcelSchema = connExcel.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, Nothing)
        Dim SheetName As String = dtExcelSchema.Rows(0)("TABLE_NAME").ToString()
        connExcel.Close()

        'Read Data from First Sheet 
        Try

            connExcel.Open()
            cmdExcel.CommandText = "SELECT PRODUCTO,DESCRIPCION,CANTIDAD,PRECIO,TOTAL,VEHICULO From [" & SheetName & "]"
            oda.SelectCommand = cmdExcel
            oda.Fill(dt)
            Dim TheDataReader As OleDbDataReader = cmdExcel.ExecuteReader()
            While TheDataReader.Read()
                Dim Elementos As New DatosExcel
                Elementos.Codigo = TheDataReader("PRODUCTO").ToString()
                Elementos.Descripcion = TheDataReader("DESCRIPCION").ToString()
                Elementos.Cantidad = TheDataReader("CANTIDAD").ToString()
                Elementos.Precio = TheDataReader("PRECIO").ToString()
                Elementos.Total = TheDataReader("TOTAL").ToString()
                Elementos.Vehiculo = TheDataReader("VEHICULO").ToString()
                result.Add(Elementos)
            End While


        Catch ex As Exception
            Dim Elementos As New DatosExcel
            Elementos.StrError = ex.Message
            result.Add(Elementos)
        Finally
            connExcel.Close()
        End Try

        Return result

        'Bind Data to GridView 


    End Function
    Public Class ClassCargarDropVehilosDepto
        Public Id As Integer
        Public Vehiculo As String
    End Class

    <WebMethod(EnableSession:=True)> _
    Public Function CargarDropVehilosDepto(ByVal IdDepto As String) As List(Of [ClassCargarDropVehilosDepto])
        Dim result As List(Of [ClassCargarDropVehilosDepto]) = New List(Of ClassCargarDropVehilosDepto)()
        Dim consulta As String
        Using conexion As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
            Try
                conexion.Open()

                If IdDepto = "0" Then
                    consulta = "select Id,codigo from _vehiculos;"
                Else
                    consulta = "select Id,codigo from _vehiculos where departamento=" + IdDepto + ";"

                End If
                Dim cmd As New MySqlCommand(consulta, conexion)
                Dim reader As MySqlDataReader = cmd.ExecuteReader
                While reader.Read
                    Dim elemento As New ClassCargarDropVehilosDepto
                    With elemento
                        .Id = reader("Id")
                        .Vehiculo = reader("codigo")

                    End With
                    result.Add(elemento)
                End While
            Finally
                conexion.Close()
            End Try
        End Using
        Return result
    End Function
    Public Class ClassTopTenRendimientoG
        Public codigo As String
        Public Promedio As String
        Public placa As String
        Public departamento As String

    End Class
    <WebMethod()> _
    Public Function TopRendimientoG(ByVal IdVehiculo As Integer, ByVal FechaIni As String, ByVal FechaFin As String, ByVal Rango As String) As List(Of [ClassTopTenRendimientoG])
        Dim result As List(Of [ClassTopTenRendimientoG]) = New List(Of ClassTopTenRendimientoG)()
        Dim consulta1 As String

        Using conexion As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
            Try
                conexion.Open()
                If IdVehiculo <> 1 Then
                    consulta1 = "select vhs.codigo, rd.IdVehiculo,( sum(rd.Distancia) div rt.tgasolina)Resultado,sum(rd.Distancia)tDistancia,rt.tgasolina,d.descripcion from actividaddiairiavehiculo rd inner join _vehiculos vhs on rd.IdVehiculo=vhs.id inner join departamentos d on d.id=vhs.departamento  inner join (select rv.vehiculo,sum(p.cantidad)tgasolina from facturacion rv inner join (select cantidad, correlativo from facturaciond where codigo in ('DIESEL','GASOLINASUPER','GASOLINAREGULAR','GASOLINAVPOWER')) p on rv.corre=p.correlativo  where rv.fecha between '" & FechaIni & "' and '" & FechaFin & "' group by rv.vehiculo)rt on rt.vehiculo=rd.IdVehiculo where rd.Fecha between '" & FechaIni & "' and '" & FechaFin & "'  group by codigo order by Resultado desc limit " & Rango & ""
                Else
                    consulta1 = "select vhs.codigo, rd.IdVehiculo,( sum(rd.Distancia) div rt.tgasolina)Resultado,sum(rd.Distancia)tDistancia,rt.tgasolina,d.descripcion from actividaddiairiavehiculo rd inner join _vehiculos vhs on rd.IdVehiculo=vhs.id inner join departamentos d on d.id=vhs.departamento  inner join (select rv.vehiculo,sum(p.cantidad)tgasolina from facturacion rv inner join (select cantidad, correlativo from facturaciond where codigo in ('DIESEL','GASOLINASUPER','GASOLINAREGULAR','GASOLINAVPOWER')) p on rv.corre=p.correlativo  where rv.fecha between '" & FechaIni & "' and '" & FechaFin & "' group by rv.vehiculo)rt on rt.vehiculo=rd.IdVehiculo where rd.Fecha between '" & FechaIni & "' and '" & FechaFin & "'  group by codigo order by Resultado asc limit " & Rango & ""
                End If
                Dim cmd As New MySqlCommand(consulta1, conexion)

                Dim reader As MySqlDataReader = cmd.ExecuteReader



                While reader.Read


                    Dim elemento As New ClassTopTenRendimientoG
                    With elemento

                        .Promedio = reader("Resultado")
                        .codigo = reader("codigo")
                        .departamento = reader("descripcion")




                    End With
                    If reader("Resultado") <= 57 Then
                        result.Add(elemento)
                    End If
                End While
            Finally
                conexion.Close()
            End Try
        End Using
        Return result
    End Function

End Class

