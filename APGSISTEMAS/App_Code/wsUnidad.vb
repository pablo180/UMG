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

' Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente.
<System.Web.Script.Services.ScriptService()>
<WebService(Namespace:="http://tempuri.org/")>
<WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()>
Public Class wsUnidad
    Inherits System.Web.Services.WebService
    Dim datos As New datos()
    Dim MyDB As New MyDB
    Public Class CambiaPass
        Public StrRetorna As String = "0"
    End Class

    Public Class ClassCatalogoClientes
        Public IdEstado As Integer
        Public codigo As String
        Public Descripcion As String

        Public Estado As String
    End Class
    <WebMethod(EnableSession:=True)>
    Public Function CatalogoClientes(ByVal IdCliente As Integer) As List(Of [ClassCatalogoClientes])
        Dim result As List(Of [ClassCatalogoClientes]) = New List(Of ClassCatalogoClientes)()
        Dim consulta As String
        Using conexion As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
            Try
                conexion.Open()

                consulta = "SELECT idUnidad, descripcion, Estado FROM unidad;;"
                Dim cmd As New MySqlCommand(consulta, conexion)
                Dim reader As MySqlDataReader = cmd.ExecuteReader
                While reader.Read
                    Dim elemento As New ClassCatalogoClientes
                    With elemento

                        .codigo = reader("idUnidad")
                        If Not IsDBNull(reader("descripcion")) Then
                            .Descripcion = reader("descripcion")
                        Else
                            .Descripcion = ""
                        End If


                        If Not IsDBNull(reader("Estado")) Then
                            If (reader("Estado") = 1) Then
                                .Estado = "Alta"
                            Else
                                .Estado = "Baja"
                            End If

                        Else
                            .Estado = ""
                        End If

                        If Not IsDBNull(reader("Estado")) Then

                            .IdEstado = reader("Estado")
                        Else
                            .IdEstado = ""
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

    Public Class ClassGuardarCliente
        Public StrError As String = "0"
        Public IdVehiculo As Integer
    End Class
    <WebMethod()>
    Public Function GuardarCliente(ByVal Descripcion As String, ByVal Estatus As Integer) As List(Of ClassGuardarCliente)
        Dim result As List(Of ClassGuardarCliente) = New List(Of ClassGuardarCliente)
        Try
            Dim IdVehiculo As Integer = MyDB.MyInsertIdentity("INSERT INTO `unidad` (`descripcion`, `Estado`) VALUES ('" & Descripcion & "', '" & Estatus & "');")
            Dim elemento As New ClassGuardarCliente
            elemento.StrError = "0"
            elemento.IdVehiculo = IdVehiculo
            result.Add(elemento)
        Catch ex As Exception
            Dim elemento As New ClassGuardarCliente
            elemento.StrError = ex.Message
            result.Add(elemento)
        Finally
        End Try
        Return result
    End Function

    Public Class ClassEditarCliente
        Public StrError As String = "0"
    End Class
    <WebMethod()>
    Public Function EditarCliente(ByVal Id As Integer, ByVal Descripcion As String, ByVal Estatus As Integer) As List(Of ClassEditarCliente)
        Dim result As List(Of ClassEditarCliente) = New List(Of ClassEditarCliente)
        Using conexion As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
            conexion.Open()
            Try
                Dim ct As String = "UPDATE `unidad` SET `descripcion`='" & Descripcion & "', `Estado`='" & Estatus & "'  WHERE `idUnidad`='" & Id & "';"
                Dim command As New MySqlCommand
                command.Connection = conexion
                command.CommandText = ct
                command.ExecuteNonQuery()

                Dim elemento As New ClassEditarCliente
                elemento.StrError = "0"
                result.Add(elemento)
            Catch ex As Exception
                Dim elemento As New ClassEditarCliente
                elemento.StrError = ex.Message
                result.Add(elemento)
            Finally
            End Try
            conexion.Close()
        End Using
        Return result
    End Function
End Class