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
<WebService(Namespace:="http://tempuri.org/")> _
<WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Public Class wsCategorias
    Inherits System.Web.Services.WebService
    Dim datos As New datos()
    Dim MyDB As New MyDB
    Public Class CambiaPass
        Public StrRetorna As String = "0"
    End Class


    Public Class ClassCatalogoClientes

        Public codigo As String
        Public Descripcion As String
        Public Estado As String
        Public IdEstado As Integer
    End Class
    <WebMethod(EnableSession:=True)>
    Public Function CatalogoClientes(ByVal IdCliente As Integer) As List(Of [ClassCatalogoClientes])
        Dim result As List(Of [ClassCatalogoClientes]) = New List(Of ClassCatalogoClientes)()
        Dim consulta As String
        Using conexion As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
            Try
                conexion.Open()

                If IdCliente = 0 Then
                    consulta = "select idCategorias, Descripcion,Status from categorias"


                Else
                    consulta = "select idCategorias, Descripcion,Status from categorias where idCategorias ='" & IdCliente & "'"

                End If
                Dim cmd As New MySqlCommand(consulta, conexion)
                Dim reader As MySqlDataReader = cmd.ExecuteReader
                While reader.Read
                    Dim elemento As New ClassCatalogoClientes
                    With elemento

                        .codigo = reader("idCategorias")
                        If Not IsDBNull(reader("Descripcion")) Then
                            .Descripcion = reader("Descripcion")
                        Else
                            .Descripcion = ""
                        End If


                        If Not IsDBNull(reader("Status")) Then
                            If (reader("Status") = 1) Then
                                .Estado = "Alta"
                            Else
                                .Estado = "Baja"
                            End If

                        Else
                            .Estado = ""
                        End If

                        If Not IsDBNull(reader("Status")) Then

                            .IdEstado = reader("Status")
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

    Public Class ClassGuardarCategoria
        Public StrError As String = "0"
        Public IdVehiculo As Integer
    End Class
    <WebMethod()>
    Public Function GuardarCategoria(ByVal Nombre As String, ByVal Estatus As Integer) As List(Of ClassGuardarCategoria)
        Dim result As List(Of ClassGuardarCategoria) = New List(Of ClassGuardarCategoria)
        Try
            Dim IdVehiculo As Integer = MyDB.MyInsertIdentity("INSERT INTO `categorias` (`Descripcion`, `Status`) VALUES ('" & Nombre & "', '" & Estatus & "');")
            Dim elemento As New ClassGuardarCategoria
            elemento.StrError = "0"
            elemento.IdVehiculo = IdVehiculo
            result.Add(elemento)
        Catch ex As Exception
            Dim elemento As New ClassGuardarCategoria
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
    Public Function EditarCliente(ByVal Id As Integer, ByVal Nombre As String, ByVal Estatus As Integer) As List(Of ClassEditarCliente)
        Dim result As List(Of ClassEditarCliente) = New List(Of ClassEditarCliente)
        Using conexion As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
            conexion.Open()
            Try
                Dim ct As String = "UPDATE `categorias` SET `Descripcion`='" & Nombre & "', `Status`='" & Estatus & "' WHERE `idCategorias`='" & Id & "';"
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

    Public Class ClassEliminarCategoria
        Public StrError As String = "0"
        Public IdVehiculo As Integer
    End Class
    <WebMethod()>
    Public Function EliminarCategoria(ByVal Id As String) As List(Of ClassEliminarCategoria)
        Dim result As List(Of ClassEliminarCategoria) = New List(Of ClassEliminarCategoria)
        Try
            Dim IdVehiculo As Integer = MyDB.MyInsertIdentity("DELETE FROM `facturacionsat`.`categorias` WHERE `idCategorias`='" & Id & "';")
            Dim elemento As New ClassEliminarCategoria
            elemento.StrError = "0"
            elemento.IdVehiculo = IdVehiculo
            result.Add(elemento)
        Catch ex As Exception
            Dim elemento As New ClassEliminarCategoria
            elemento.StrError = ex.Message
            result.Add(elemento)
        Finally
        End Try
        Return result
    End Function



    Public Class ClassCatalogoProductos

        Public codigo As String
        Public Descripcion As String
        Public Resultado As Integer
    End Class
    <WebMethod(EnableSession:=True)>
    Public Function CatalogoProductos(ByVal IdCatedoria As Integer) As List(Of [ClassCatalogoProductos])
        Dim result As List(Of [ClassCatalogoProductos]) = New List(Of ClassCatalogoProductos)()
        Dim consulta As String
        Using conexion As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
            Try
                conexion.Open()

                consulta = "SELECT Codigo,descripcion FROM producto where idClasificacion = '" & IdCatedoria & "';"
                Dim cmd As New MySqlCommand(consulta, conexion)
                Dim reader As MySqlDataReader = cmd.ExecuteReader
                If reader.HasRows = False Then
                    Dim elemento As New ClassCatalogoProductos
                    elemento.Resultado = 0
                    result.Add(elemento)
                End If
                While reader.Read
                    Dim elemento As New ClassCatalogoProductos
                    With elemento

                        .codigo = reader("Codigo")
                        If Not IsDBNull(reader("descripcion")) Then
                            .Descripcion = reader("descripcion")
                        Else
                            .Descripcion = ""
                        End If

                        If Not IsDBNull(reader("Codigo")) Then
                            .Resultado = 1
                        Else
                            .Resultado = 1
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

End Class