Imports System.Web
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports MySql.Data.MySqlClient
'Imports System.Web.Script.Serialization
'Imports System.Web.Script.Services
' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
<System.Web.Script.Services.ScriptService()> _
<WebService(Namespace:="http://tempuri.org/")> _
<WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Public Class wsCRM
    Inherits System.Web.Services.WebService
    Dim datos As New datos
    <WebMethod(Description:="Excepciones<br><b>0</b>:Exito<br><b>1</b>:ErrorInterno<br><b>2</b>:EmpleadoNoEncontrado<br><b>3</b>:GeoreFerenciaErronea<br><b>4</b>:FechaDeNuevaVisitaIncorrecta<br><b>5</b>:LLaveIncorrecta <br> <b>Formato de Fecha y Hora:</b> YYYY-mm-dd hh:mm:ss")> _
    Public Function VisitasDeEmpleados(ByVal Llave As String, ByVal Tipo As Integer, ByVal IdVisita As Integer, ByVal IdEmpleado As Integer, ByVal IdCliente As Integer, ByVal NombreCliente As String, ByVal IdProyecto As Integer, ByVal NombreProyecto As String, ByVal FechaHoraLlegada As String, ByVal FechaHoraSalida As String, ByVal Latitud As Double, ByVal Longitud As Double, ByVal Direccion As String) As Integer
        'VisitsByEmployees
        Dim retuns As Integer = 0
        Dim LlaveInterna As String = "00BA9777F36QPLIFB4632XEDF"
        If Llave = LlaveInterna Then
            If FechaHoraLlegada <= FechaHoraSalida Then
                If Tipo = 0 And FechaHoraLlegada < DateTime.Now Then
                    retuns = 4
                Else
                    Using conexion As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
                        conexion.Open()
                        Dim comando As New MySqlCommand
                        Dim transaccion As MySqlTransaction
                        transaccion = conexion.BeginTransaction
                        comando.Connection = conexion
                        comando.Transaction = transaccion
                        Try
                            If Not datos.ExisteDato("SELECT * FROM clientes WHERE Id=" & IdCliente) Then
                                comando.CommandType = Data.CommandType.Text
                                Dim InsertProveedor As String = "INSERT INTO clientes (Id, Nombre) VALUES ('" & IdCliente & "','" & NombreCliente & "');"
                                comando.CommandText = InsertProveedor
                                comando.ExecuteNonQuery()
                            End If

                            If Not datos.ExisteDato("SELECT * FROM proyecto WHERE Id=" & IdProyecto & " and IdCliente=" & IdCliente) Then
                                comando.CommandType = Data.CommandType.Text
                                Dim InsertProveedor As String = "INSERT INTO proyecto (Id, IdCliente,Nombre) VALUES ('" & IdProyecto & "','" & IdCliente & "','" & NombreProyecto & "');"
                                comando.CommandText = InsertProveedor
                                comando.ExecuteNonQuery()
                            End If
                            transaccion.Commit()
                        Catch ex As Exception
                            transaccion.Rollback()
                            retuns = 1
                        End Try
                    End Using
                End If
            Else
                retuns = 4
            End If
        Else
            retuns = 5
        End If
        '---Returns
        '---OK: 0
        '---Error Interno: 1
        '---Empleado No Encontrado: 2
        '---Georeferencias Erroneas: 3
        '---Fecha de Nueva Visita Incorrecta: 4

        Return retuns
    End Function
End Class